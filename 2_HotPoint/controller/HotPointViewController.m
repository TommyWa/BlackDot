//
//  HotPointViewController.m
//  WYTNews
//
//  Created by Penny&Me on 16/6/21.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "HotPointViewController.h"
#import "HotPointModel.h"
#import "Hot_threePic_Cell.h"
#import "Hot_bigPic_Cell.h"
#import "Hot_onePic_Cell.h"
#import "Hot_noPic_Cell.h"
#import "NewsWebViewController.h"

@interface HotPointViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * urlInfoArray;
}
@property(nonatomic,strong)HotPointUrlModel * urlModel;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)NSInteger count;
@end

@implementation HotPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createTableView];
    [self downloadDataWithURLString:kHotPoint];
    _count = 0;
    
}

-(void)viewWillAppear:(BOOL)animated{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark 初始化数据
- (void)initData{
    _dataArray = [NSMutableArray array];

}

#pragma mark 处理tableView视图
-(void)createTableView{
        self.automaticallyAdjustsScrollViewInsets = NO;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HIGTH-64-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];

        //注册Cell
        [_tableView registerNib:[UINib nibWithNibName:@"Hot_noPic_Cell" bundle:nil] forCellReuseIdentifier:@"NO"];
        [_tableView registerNib:[UINib nibWithNibName:@"Hot_onePic_Cell" bundle:nil] forCellReuseIdentifier:@"ONE"];
        [_tableView registerNib:[UINib nibWithNibName:@"Hot_threePic_Cell" bundle:nil] forCellReuseIdentifier:@"Three"];
        [_tableView registerNib:[UINib nibWithNibName:@"Hot_bigPic_Cell" bundle:nil] forCellReuseIdentifier:@"BIG"];
    
        [self loadFirstPage];
        [self loadMore];

}

//从网络获取数据
- (void)downloadDataWithURLString:(NSString * )urlString{
    
//    [ProgressHUD showOnView:self.view];
    NSDictionary * dict = @{@"_bsize":@"",@"idfa":@"4A1DAB0B-CCFE-4E04-8B5D-E636D304808B",@"_lat":@"0.000000",@"-lng":@"0.000000",@"_net":@"",@"_v":@"",@"_version":@"",@"_udid":@"16765F6F-8E33-44C1-B5E9-ACCACBB7FDD3",@"_uid":@""};
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [ProgressHUD hideAfterSuccessOnView:weakSelf.view];
            NSLog(@"%ld次请求",(long)_count);
            NSLog(@"%@",urlString);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {

            NSDictionary * bigDict = responseObject;
            NSDictionary * dataDict = bigDict[@"data"];

            NSDictionary * infoDict = dataDict[@"info"];
            _urlModel = [[HotPointUrlModel alloc] init];
            [_urlModel setValuesForKeysWithDictionary:infoDict];

            NSArray * articlesArray = dataDict[@"articles"];
            for (NSDictionary * dict in articlesArray) {
                HotPointModel * hpModel = [[HotPointModel alloc] init];
                [hpModel setValuesForKeysWithDictionary:dict];
                [self.dataArray addObject:hpModel];
            }
            _count ++;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView.mj_header endRefreshing];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //数据请求失败
//        [ProgressHUD hideAfterFailOnView:weakSelf.view];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        NSLog(@"热点数据%@",error);
    }];
    
}


-(void)loadFirstPage{
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.urlModel.pre_url) {
            NSString * string = [NSString stringWithFormat:@"%@&_udid=16765F6F-8E33-44C1-B5E9-ACCACBB7FDD3&_uid=",self.urlModel.pre_url];
            [self downloadDataWithURLString:string];

        }else{
            [self downloadDataWithURLString:[NSString stringWithFormat:kHotPre,timeNow]];
        }
        
    }];
    self.tableView.mj_header = header;
}


-(void)loadMore{

    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.urlModel.next_url) {
             NSString * string = [NSString stringWithFormat:@"%@&_udid=16765F6F-8E33-44C1-B5E9-ACCACBB7FDD3&_uid=",self.urlModel.next_url];
            [self downloadDataWithURLString:string];

        }else{
            [self downloadDataWithURLString:[NSString stringWithFormat:kHotNext,timeNow]];
            NSLog(@"暂无精彩文章请稍后再来");
        }
    }];
    
    self.tableView.mj_footer = footer;
}




#pragma mark UITableView 代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HotPointModel * model = self.dataArray[indexPath.row];
    NSString * itemType = model.special_info[@"item_type"];
    NSMutableArray * picArray = [NSMutableArray array];
    for (NSDictionary * picDic in model.thumbnail_medias) {
        thumbnailModel * thModel = [[thumbnailModel alloc] init];
        [thModel setValuesForKeysWithDictionary:picDic];
        [picArray addObject:thModel.m_url];
    }
    
    //根据itemType判断返回CELL类型
    if ([itemType isEqualToString:@"3_b"]) {
        Hot_threePic_Cell * threeCell = [tableView dequeueReusableCellWithIdentifier:@"Three"];
        [threeCell setHModel:model AndImageArray:picArray];
        return threeCell;
    }else if( [itemType isEqualToString:@"1"]){
        Hot_onePic_Cell * oneCell = [tableView dequeueReusableCellWithIdentifier:@"ONE"];
        [oneCell setHModel:model AndImageArray:picArray];
        return oneCell;
    }else if ([itemType isEqualToString:@"1_b"]){
        Hot_bigPic_Cell *bigCell = [tableView dequeueReusableCellWithIdentifier:@"BIG"];
        [bigCell setHModel:model AndImageArry:picArray];
        return bigCell;
    }else if (!itemType){
        Hot_noPic_Cell * noCell = [tableView dequeueReusableCellWithIdentifier:@"NO"];
        [noCell setHModel:model];
        return noCell;
    }
    return [[UITableViewCell alloc] init];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotPointModel * model = self.dataArray[indexPath.row];
    NSString * itemType = model.special_info[@"item_type"];
    if ([itemType isEqualToString:@"3_b"]) {
        return 170;
    }else if( [itemType isEqualToString:@"1"]){
        return 70;
    }else if ([itemType isEqualToString:@"1_b"]){
        return 200;
    }else if (!itemType){
        return 70;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsWebViewController * nvc = [[NewsWebViewController alloc] init];
    HotPointModel * model = self.dataArray[indexPath.row];
    nvc.webUrl = model.weburl;
    nvc.hidesBottomBarWhenPushed = YES;
    
    //设置HTML5来源为weburl，此地址未返回标题栏格式，后期需更改为full_url
    [self.navigationController pushViewController:nvc animated:YES];
    
}


@end
