//
//  ChooseViewController.m
//  MyZaker
//
//  Created by Penny&Me on 16/6/26.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "HomeChooseViewController.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "Const.h"
#import "UIImageView+WebCache.h"
#import "ChooseSonViewController.h"
#import "CategoryChooseCell.h"
#import "allDataModel.h"
@interface HomeChooseViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * searchData;
@property(nonatomic,assign)BOOL isSearching;

@end

@implementation HomeChooseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"频道";
    _dataArray = [NSMutableArray array];
    _searchData = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self downloadData];
}

-(UITableView *)tableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HIGTH-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[CategoryChooseCell class] forCellReuseIdentifier:@"TABLE"];
    }
    return _tableView;
}

-(void)createSearchBar{
    _isSearching = NO;
    UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 75, 20)];
    search.barStyle = UISearchBarStyleMinimal;
    search.placeholder = @"搜索频道";
    search.delegate = self;
    search.showsCancelButton = YES;
    self.navigationItem.titleView = search;
}

#pragma mark 从网络获取数据
- (void)downloadData{
    
    [ProgressHUD show:@"转圈圈加载载"];
    
    __weak typeof(self)weakSelf = self;
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    [manager GET:kAllData parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //数据解析
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary * bigDict = responseObject;
            
            NSArray * categoryArray = bigDict[@"data"][@"datas"];
            
            for (NSDictionary * categoryDic in categoryArray) {
                
                datesArrayModel * model = [[datesArrayModel alloc] init];
                
                [model setValuesForKeysWithDictionary:categoryDic];
                
                if ([model.title isEqualToString:@"生活"] || [model.title isEqualToString:@"本地新闻"]) {
                    
                    NSLog(@"跳过");
                    
                }else{
                    
                    [_dataArray addObject:model];
                }
            }
            //刷新tableView
            [weakSelf.tableView reloadData];
            
            [ProgressHUD dismiss];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //打印错误
        NSLog(@"首页网络错误%@",error);
        [ProgressHUD showError:@"首页数据错误"];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isSearching) {
        return _searchData.count;
    }
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryChooseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TABLE"];
    if (_isSearching) {
        sonsArrayModel * sonModel = self.searchData[indexPath.row];
        [cell setSonsModel:sonModel];
    }else{
        sonsArrayModel * sonModel = self.dataArray[indexPath.row];
        [cell setSonsModel:sonModel];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    datesArrayModel * model = self.dataArray[indexPath.row];
    ChooseSonViewController * svc = [[ChooseSonViewController alloc] init];
    svc.view.backgroundColor = [UIColor whiteColor];
    
    //准备下一个推出界面的数据数组
    for (NSDictionary * dict in model.sons) {
        sonsArrayModel * sModel = [[sonsArrayModel alloc] init];
        [sModel setValuesForKeysWithDictionary:dict];
        if ([model.sons_are_end isEqualToString:@"Y"]) {
            [svc.dataArray addObject:sModel];
        }
    }
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:svc animated:YES];

}
#pragma mark UISearchBar 代理方法

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
        [self filterBySubstring:searchBar.text];
    [searchBar resignFirstResponder];
    [self.tableView reloadData];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    _isSearching = NO;
    [searchBar resignFirstResponder];
    [self.tableView reloadData];
}

- (void) filterBySubstring:(NSString*) subStr{
    for (sonsArrayModel * sModel in _dataArray) {
        if ([sModel.title containsString:subStr]) {
            [_searchData addObject:sModel ];
        }
    }
    _isSearching = YES;
}
@end









