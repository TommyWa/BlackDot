//
//  ZoneCViewController.m
//  MyZaker
//
//  Created by Penny&Me on 16/6/25.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "ZoneDiscvViewController.h"
#import "AFHTTPSessionManager.h"
#import "ZoneDisModel.h"
#import "ZoneDisCell.h"
#import "ZoneDetaiViewController.h"
#import "NewsWebViewController.h"
#import "ZoneBestViewController.h"
@interface  ZoneDiscvViewController()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation ZoneDiscvViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self craetMytableView];
    [self downloadDataWithUrl:kZoneTitle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)craetMytableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -2, WIDTH, HIGTH-64) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
}

//下载数据
- (void)downloadDataWithUrl:(NSString *)url{
    __weak typeof(self)weakSelf = self;
   
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask *  task, id   responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {

            NSDictionary * bigDict = responseObject;
            NSDictionary * dataDict = bigDict[@"data"];
            for (NSDictionary * listDic in dataDict[@"list"]) {
                cellModel * cModel = [[cellModel alloc] init];
                [cModel setValuesForKeysWithDictionary:listDic];
                [self.dataArray addObject:cModel];
            }
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        NSLog(@"发现页面数据请求失败:%@",error);
    }];
}


#pragma mark UITableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * disCellID = @"ass";

    ZoneDisCell * cell = [tableView dequeueReusableCellWithIdentifier:disCellID];
    if (nil == cell) {
        cell = [[ZoneDisCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:disCellID];
    }
    cellModel * cModel = self.dataArray[indexPath.row];
    [cell setCModel:cModel];
       return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    cellModel * model = self.dataArray[indexPath.row];
    ZoneDetaiViewController * dvc = [[ ZoneDetaiViewController alloc] init];
    dvc.view.frame = CGRectMake(0, 64, WIDTH, HIGTH);
    
    dvc.myurl = model.api_url;
    NSLog(@"discusssssssss%@",dvc.myurl);
    dvc.view.backgroundColor = [UIColor brownColor];
    [self.navigationController pushViewController:dvc animated:YES];


    
}




@end
