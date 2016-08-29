//
//  ChooseSonViewController.m
//  MyZaker
//
//  Created by Penny&Me on 16/6/26.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "ChooseSonViewController.h"
#import "AFHTTPSessionManager.h"
#import "ChooseModel.h"
#import "ChooseSonCell.h"
#import "HomePageButtonCell.h"
#import "HomePageDBManager.h"
#import "ColumViewController.h"
#import "allDataModel.h"
@interface ChooseSonViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * searchData;
@property(nonatomic,assign)BOOL isSearching;
@end

@implementation ChooseSonViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分类";
    _dataArray = [NSMutableArray array];
    _sonsArray = [NSMutableArray array];
    _searchData = [NSMutableArray array];


    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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


#pragma mark 懒加载UITableView
-(UITableView *)tableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HIGTH-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[ChooseSonCell class] forCellReuseIdentifier:@"SON"];
    }
    return _tableView;
}

#pragma mark UITableView 代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (_isSearching) {
        return self.searchData.count;
    }
    
    return self.dataArray.count;

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    sonsArrayModel * model = [[sonsArrayModel alloc] init];
    if (_isSearching) {
        model = self.searchData[indexPath.row];
    }else{
        model = self.dataArray[indexPath.row];
    }
    ChooseSonCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SON"];
    cell.textLabel.text = model.title;
    cell.button.tag = indexPath.row + 1000;
    [cell setImageState];//根据数据显示按钮背景图片和状态
    [cell.button addTarget:self action:@selector(buttonisClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ColumViewController * cvc = [[ColumViewController alloc] init];
    sonsArrayModel * sModel  = self.dataArray[indexPath.row];
    cvc.web_url = sModel.api_url;
    self.navigationController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cvc animated:YES];
}

#pragma mark 收藏与取消收藏的按钮方法
- (void)buttonisClick:(UIButton * )button{
    sonsArrayModel * sModel = self.dataArray[button.tag -1000];
    if (button.selected) {
        //已收藏 再次点击取消收藏
        [[HomePageDBManager sharedManager] deleteCollectionItem:sModel];
        [button setBackgroundImage:[UIImage imageNamed:@"ic_radio_button_unchecked_48px"] forState:UIControlStateNormal];
    }else{
        [[HomePageDBManager sharedManager] addCollectionItem:sModel];
        //处理UI
        [button setBackgroundImage:[UIImage imageNamed:@"ic_radio_button_checked_48px"] forState:UIControlStateNormal];
    }
    button.selected = !button.selected;
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self filterBySubstring:searchBar.text];
    [searchBar resignFirstResponder];
    [self.tableView reloadData];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    _isSearching = NO;
    searchBar.text = nil;
    [searchBar resignFirstResponder];
    [self.tableView reloadData];
}

- (void) filterBySubstring:(NSString*) subStr
{
    for (sonsModel * sModel in _dataArray) {
        
        if ([sModel.title containsString:subStr]) {
            [_searchData addObject:sModel ];
        }
    }
    _isSearching = YES;
    
}
@end
