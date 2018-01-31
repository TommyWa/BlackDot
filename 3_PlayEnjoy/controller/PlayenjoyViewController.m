//
//  PlayenjoyViewController.m
//  WYTNews
//
//  Created by Penny&Me on 16/6/21.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "PlayenjoyViewController.h"
#import "AFHTTPSessionManager.h"
#import "Const.h"
#import "EnjoyModel.h"
#import "EnjoyCell.h"
#import "UIImageView+WebCache.h"
#import "NewsWebViewController.h"
#import "MJRefresh.h"
@interface PlayenjoyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,copy)NSString * nextUrl;

@end

@implementation PlayenjoyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self.view addSubview: self.tableView];
    [self downloadDataWithUrl:kPlayEnjoy];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

//懒加载tableView
-(UITableView *)tableView{
    if (nil == _tableView) {
        self.automaticallyAdjustsScrollViewInsets = NO;

        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HIGTH-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = NO;
        
    }
//    [self loadFirstPage];
    [self loadMore];
    return _tableView;
}


//下载数据
- (void)downloadDataWithUrl:(NSString * )url{
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary * bigDict = responseObject;
            NSDictionary * dataDict = bigDict[@"data"];
            _nextUrl = dataDict[@"info"][@"next_url"];
            NSArray * columnsArr = dataDict[@"columns"];
            
            for (NSDictionary * smallDict in columnsArr) {
                
                columnsModel * colModel = [[columnsModel alloc] init];
                
                [colModel setValuesForKeysWithDictionary:smallDict];
                
                [weakSelf.dataArray addObject:colModel];
            }
        }
        [weakSelf.tableView reloadData];
//        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"玩乐界面下载数据失败:%@",error);
//        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
    

}

- (void)loadFirstPage{
    [_dataArray removeAllObjects];
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self downloadDataWithUrl:kPlayEnjoy];
    }];
    _tableView.mj_header = header;
}

//上拉加载更多
- (void)loadMore{
        
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       [self downloadDataWithUrl:_nextUrl];
    }];
    _tableView.mj_footer = footer;

}


#pragma mark UITableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/2-50, 0, 100, 30)];

    columnsModel * cModel = self.dataArray[section];
    [view sd_setImageWithURL:[NSURL URLWithString:cModel.banner[@"url"]]];
     
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    columnsModel * cModel = self.dataArray[section];
    return cModel.items.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"FF";
    EnjoyCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[EnjoyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    columnsModel * model = self.dataArray[indexPath.section];
    
    itemModel * iModel = [[itemModel alloc] init];
    [iModel setValuesForKeysWithDictionary:model.items[indexPath.row]];
    
    picModel * pModel = [[picModel alloc] init];
    [pModel setValuesForKeysWithDictionary:iModel.pic];

    [cell configCellWithPmodel:pModel andImodel:iModel];
    return cell;
}


#pragma mark 选中cell跳转到具体新闻页面

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsWebViewController * nvc = [[NewsWebViewController alloc] init];
    columnsModel * model = self.dataArray[indexPath.section];
    articleModel * aModel = [[articleModel alloc] init];
    [aModel setValuesForKeysWithDictionary:model.items[indexPath.row][@"article"] ];
    nvc.hidesBottomBarWhenPushed = YES;
    nvc.webUrl = aModel.weburl;//设置HTML5来源为weburl，此地址未返回标题栏格式，后期需更改为full_url

    [self.navigationController pushViewController:nvc animated:YES];

    
}




@end
