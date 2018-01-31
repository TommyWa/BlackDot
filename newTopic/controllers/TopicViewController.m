//
//  TopicViewController.m
//  MyZaker
//
//  Created by Penny&Me on 16/7/11.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "TopicViewController.h"
#import "TopicModel.h"
#import "AFHTTPSessionManager.h"
#import "MJRefresh.h"
#import "TopicViewCell.h"
@interface TopicViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray * dataArray;//存放item
@property(nonatomic,strong)NSMutableArray * sectionArray;//存放分组
@property(nonatomic,strong)UITableView * table;
@property(nonatomic,copy)NSString * url;
@property(nonatomic,copy)NSString * nextUrl;
@property(nonatomic,strong)NSIndexPath* inpath;
@end

@implementation TopicViewController
- (void)viewWillAppear:(BOOL)animated{
    //self.hidesBottomBarWhenPushed = NO;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createMyTabelView];
    [self downloadDataWithUrl:_url];
}

- (void)initData{
    _dataArray = [NSMutableArray array];
    _sectionArray = [NSMutableArray array];
    _url = kTopic;
}

- (void)createMyTabelView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HIGTH-64) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    _table.showsHorizontalScrollIndicator = NO;
    _table.separatorStyle = NO;
    _table.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_table];

    [_table registerClass:[TopicViewCell class] forCellReuseIdentifier:@"topic"];
    [self loadFirstPage];
    [self loadMore];
}

- (void)downloadDataWithUrl:(NSString *)url{
    
    [ProgressHUD show];
    
    __weak typeof(self)weakSelf = self;
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        [ProgressHUD dismiss];

        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary * bigDict = responseObject;
            NSDictionary * dataDict = bigDict[@"data"];
            NSArray * listArray = dataDict[@"list"];
            _nextUrl = dataDict[@"next_url"];
            for (NSDictionary * dict in listArray) {
                TopicModel * model = [[TopicModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                NSMutableArray * array = [NSMutableArray array];
                
                for (NSDictionary * smallDict in model.topic_list) {
                    TopicListModel * smallModel = [[TopicListModel alloc] init];
                    [smallModel setValuesForKeysWithDictionary:smallDict];
                    [array addObject:smallModel];
                }
                [_sectionArray addObject:model];
                [_dataArray addObject:array];
            }
            [weakSelf.table reloadData];
            [weakSelf.table.mj_footer endRefreshing];
            [weakSelf.table.mj_header endRefreshing];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //数据请求失败
        [ProgressHUD dismiss];
        [weakSelf.table.mj_header endRefreshing];
        [weakSelf.table.mj_footer endRefreshing];
        NSLog(@"专题数据错误%@",error);
    }];
    
}
-(void)loadFirstPage{
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_dataArray removeAllObjects];
        [self downloadDataWithUrl:_url];
    }];
    self.table.mj_header = header;
}


-(void)loadMore{
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (_nextUrl) {
            [self downloadDataWithUrl:_nextUrl];
        }else{
            NSLog(@"暂无精彩文章请稍后再来");
        }
    }];
    
    self.table.mj_footer = footer;
}


#pragma mark UITableView 代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopicViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"topic"];
    [cell configWithDataArray:_dataArray AndIndexPaht:indexPath];
    [cell setUrlBlock:^(NSString *url, UIViewController *nvc) {
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nvc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 350;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TopicModel * model = _sectionArray[section];
    UILabel * label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    NSDate * today = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CH"];
    formatter.dateFormat = @"yyyyMMdd";
    NSString * dayString = [formatter stringFromDate:today];

    if (dayString.integerValue == model.date.integerValue) {
        label.text = @"今天";
    }else if (dayString.integerValue == model.date.integerValue + 1){
        label.text = @"昨天";
    }else if (dayString.integerValue == model.date.integerValue + 2){
        label.text = @"前天";
    }else{
        NSString * realDate = model.date;

        NSMutableString * mString = [NSMutableString stringWithString:[realDate substringFromIndex:4]];

        [mString insertString:@"月" atIndex:2];
        [mString insertString:@"日" atIndex:5];
    
        label.text = mString;
    }
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}











/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
