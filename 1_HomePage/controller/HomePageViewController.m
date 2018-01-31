//
//  CustomNewsViewController.m
//  WYTNews
//
//  Created by Penny&Me on 16/6/21.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomeTopModel.h"
#import "HomeTopScrollView.h" //顶部视图
#import "HomeChooseViewController.h"
#import "HomePageButtonCell.h"
#import "ColumViewController.h"
#import "NewsWebViewController.h"
#import "HotPointViewController.h"
#import "TopicDetailController.h"

@interface HomePageViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)NSMutableArray * scrollArray;
    
@property(nonatomic,strong)UICollectionView * collectionView;

@property(nonatomic,strong)NSMutableArray * collectonArray;

@property(nonatomic,strong)UIButton * addButton;

@property(nonatomic,assign)BOOL isedited;

@property (nonatomic , strong)HomeTopScrollView * homeScrollView;

@end

@implementation HomePageViewController

#pragma mark 检索数据库来显示已经收藏的数据
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self getTheCollectionDataAndaddButtonFrame];
    
}
    
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initData];
    
    [self downloadTopScrollViewData];//下载并添加顶部滚动栏
    
    [self.view addSubview:self.collectionView];
    
    [self createHomeAddButton];//添加按钮
}

    
    
#pragma mark 初始化子视图
- (UICollectionView *)collectionView{

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UICollectionViewFlowLayout * fly = [[UICollectionViewFlowLayout alloc] init];
    
    fly.minimumInteritemSpacing = 0;
    
    fly.minimumLineSpacing = 0;
    
    fly.itemSize = CGSizeMake(WIDTH/3, WIDTH/3);
    
    if (nil == _collectionView) {
    
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HIGTH - WIDTH/3+10) collectionViewLayout:fly];
        
        _collectionView.contentInset = UIEdgeInsetsMake(200, 0, WIDTH/3, 0);
        
        _collectionView.bounces = NO;
        
        _collectionView.showsVerticalScrollIndicator = NO;
        
        _collectionView.delegate = self;
        
        _collectionView.dataSource = self;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[HomePageButtonCell class] forCellWithReuseIdentifier:@"HomeCollection_Cell"];
    }
    return _collectionView;
}
    
- (HomeTopScrollView *)homeScrollView{
    
    if (nil == _homeScrollView) {
        
        _homeScrollView = [[HomeTopScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH)];
        
        _homeScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _homeScrollView;
}
    

//获取数据库数据，确定添加按钮的frame
- (void)getTheCollectionDataAndaddButtonFrame{
    
    __weak typeof(self)weakSelf = self;
    
    HomePageDBManager * manager = [HomePageDBManager sharedManager];
    
    [manager selectAllFavorites:^(NSArray *array) {
        
        _collectonArray = [NSMutableArray arrayWithArray:array];
        
        [weakSelf.collectionView reloadData];
        
    }];
    
    //根据collectionArray的数量修改_addButton的位置
    NSInteger i = self.collectonArray.count;
    
    NSInteger m = i%3;
    
    NSInteger n = i/3;
    
    CGRect frame = CGRectMake(WIDTH/3*m, WIDTH/3*(n) , WIDTH/3, WIDTH/3);
    
    self.addButton.frame = frame;
}

#pragma mark 初始化数据
- (void)initData{

    _scrollArray = [NSMutableArray array];
    
    _collectonArray = [NSMutableArray array];
}

#pragma mark 获取顶部视图数据
- (void)downloadTopScrollViewData{
    
    self.automaticallyAdjustsScrollViewInsets  = NO;

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    [manager GET:kTopScroll parameters:nil progress:^(NSProgress * downloadProgress) {
        
    } success:^(NSURLSessionDataTask * task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]){
        
            NSDictionary * dict = responseObject;
            
            NSArray * subDictArray = dict[@"data"][@"list"];
            
            for (NSDictionary * smallDict in subDictArray){
            
                HomeTopModel * model = [[HomeTopModel alloc] init];
                
                [model setValuesForKeysWithDictionary:smallDict];
                
                [_scrollArray addObject:model];
            }
            
            HomeTopScrollView * scroll = [[HomeTopScrollView alloc] initWithFrame:CGRectMake(0, -200, WIDTH, 200) AndPicArray:_scrollArray];

            [scroll setBlock:^(NSString *apiUrl, NSString *type) {
                
                if ([type isEqualToString:@"articles"]) {
                  
                    NewsWebViewController  * cvc = [[NewsWebViewController alloc] init];
                  
                    cvc.webUrl = apiUrl;
                   
                    cvc.hidesBottomBarWhenPushed = YES;
                    
                    [self.navigationController pushViewController:cvc animated:YES];
               
                }else if ([type isEqualToString:@"夜读"] ||[type isEqualToString:@"专题"] ||[type isEqualToString:@"top10"]){
                  
                    TopicDetailController * tvc = [[TopicDetailController alloc] init];
                  
                    tvc.url = apiUrl;
                   
                    tvc.hidesBottomBarWhenPushed = YES;
                    
                    [self.navigationController pushViewController:tvc animated:YES];
                }
                
                else{
                    
                    ColumViewController * vc = [[ColumViewController alloc] init];
                    
                    vc.web_url = apiUrl;
                    
                    vc.hidesBottomBarWhenPushed = YES;
                    
                    [self.navigationController pushViewController:vc animated:YES];
                }

            }];
            
            //添加到collectionView头部
            [self.collectionView addSubview:scroll];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"首页滚动下载失败:%@",error);
    }];
}

#pragma mark创建添加内容的button + 号
- (void)createHomeAddButton{
    
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _addButton.layer.borderColor = [[UIColor blackColor] CGColor];
    
    _addButton.layer.borderWidth = 0.5;
    
    UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_add_circle_outline_48px"]];
    image.center = CGPointMake(WIDTH/6, WIDTH/6);
    [_addButton addSubview:image];
    
    UILabel * label = [[UILabel alloc] init];
    label.text = @"添加内容";
    label.frame = CGRectMake(0, WIDTH/3-25, WIDTH/3, 20);
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [_addButton addSubview:label];
    
    [_addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    _addButton.backgroundColor = methemColor;
    [self.collectionView addSubview:_addButton];
}

//实现AddButton功能：
- (void)addButtonAction{
    HomeChooseViewController * zvc = [[HomeChooseViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:zvc animated:YES];

}

#pragma mark 懒加载CollectionView


#pragma mark UICollectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.collectonArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(goToEditing)];

    HomePageButtonCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollection_Cell" forIndexPath:indexPath];
    
    sonsModel * sonModel = self.collectonArray[indexPath.item];
    
    [cell setSonModel:sonModel];
    
    cell.delButton.tag = 500 + indexPath.item;
    
    [cell.delButton addTarget:self action:@selector(deleteCollection:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell addGestureRecognizer:longPress];
    
    

    return cell;
}

- (void)goToEditing{
    NSArray *cellsArr =  [_collectionView visibleCells];
    if (_isedited == NO) {
        for (HomePageButtonCell *cell in cellsArr) {
            cell.delButton.hidden = NO;
        }
        _isedited = YES;
    }
    
}

- (void)deleteCollection:(UIButton *)button{
    sonsArrayModel *model = self.collectonArray[button.tag - 500];
    [[HomePageDBManager sharedManager] deleteCollectionItem:model];
    [self getTheCollectionDataAndaddButtonFrame];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_isedited) {
        NSArray *cellsArr =  [_collectionView visibleCells];
        for (HomePageButtonCell *cell in cellsArr) {
            cell.delButton.hidden = YES;
        }
        _isedited = NO;
    }else{
        sonsArrayModel * model = self.collectonArray[indexPath.row];
        ColumViewController * nvc = [[ColumViewController alloc] init];
        nvc.hidesBottomBarWhenPushed = YES;
        nvc.navigationController.navigationBarHidden = YES;
        nvc.web_url = model.api_url;
        [self.navigationController pushViewController:nvc animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
