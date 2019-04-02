//
//  ColumViewController.m
//  MyZaker
//
//  Created by Penny&Me on 16/7/1.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "ColumViewController.h"
#import "ArticleModel.h"
#import "NewsWebViewController.h"
#import "ColumnHeaderCollectionViewCell.h"

#import "MyLayOut.h"
#import "MyCollectionViewCell.h"
#import "MyCollectionCell.h"

@interface ColumViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView * collection;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)diy * bModel;
@property(nonatomic,strong)UIToolbar * toolBar;
@property(nonatomic,strong)NSMutableArray * tempArray;
@property(nonatomic,copy)NSString * nextUrl;
@property(nonatomic,assign)NSIndexPath * indexPath;
@end

@implementation ColumViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createMytoolBar];
    [self downloadDataWithUrl:self.web_url];
    [self createMyCollectionView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)initData{
    _dataArray = [NSMutableArray array];
    _bModel = [[diy alloc] init];
}
-(void)createMyCollectionView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    //添加自定义LayOut布局
    MyLayOut * fly = [[MyLayOut alloc] init];
    
    //初始化collectionView
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HIGTH-40) collectionViewLayout:fly];
       _collection.backgroundColor = [UIColor whiteColor];
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.pagingEnabled = YES;
    _collection.bounces = NO;
    _collection.showsHorizontalScrollIndicator = NO;
    _collection.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_collection];

    //注册cell
    [_collection registerNib:[UINib nibWithNibName:@"MyCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"xx"];

    //注册头部视图
    [_collection registerClass:[ColumnHeaderCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"oo"];
}

- (void)loadMoreData{
    [_dataArray removeAllObjects];
        [self downloadDataWithUrl:self.nextUrl];

}
//toolBar
-(void )createMytoolBar{
    if (nil == _toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, HIGTH-40, WIDTH, 40)];
        _toolBar.backgroundColor = methemColor;
        _toolBar.barTintColor = methemColor;
        UIButton * button = [FactoryUtil createButtonWithTitle:nil frame:CGRectMake(10 , 5, 30, 30) backImage:[UIImage imageNamed:@"ic_arrow_back_48px"] tatget:self action:@selector(buttonAction)];
        [_toolBar addSubview:button];
        UIButton *freshButton = [FactoryUtil createButtonWithTitle:nil frame:CGRectMake(WIDTH-40, 5, 30, 30) backImage:[UIImage imageNamed:@"ic_refresh_48px"] tatget:self action:@selector(loadMoreData)];
        [_toolBar addSubview:freshButton];
    }
    [self.view addSubview:_toolBar];
}

//添加工具栏按钮
- (void)buttonAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//下载数据
- (void)downloadDataWithUrl:(NSString *)url{
//    [ProgressHUD showOnView:self.view];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    NSDictionary * param = @{@"_appid":@"iphone",@"_bsize":@"640_960",@"_version":@"6.46"};
    [manager GET:url
 parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //数据请求成功开始解析数据
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * bigDict = responseObject;
            NSDictionary * dataDict = bigDict[@"data"];
            NSDictionary * info = dataDict[@"info"];
            _nextUrl = info[@"next_url"];
            for (NSDictionary * pageDic in dataDict[@"ipadconfig"][@"pages"]) {
                pagesModel * pModel = [[pagesModel alloc] init];
                [pModel setValuesForKeysWithDictionary:pageDic];
                //头部logo的地址
                _bModel.bgimage_url = pModel.diy[@"bgimage_url"];
                [_dataArray addObject:pModel];//存放Pages信息
                
            }
            
            //根据pk值找到每一页的item 进行分组,分组后的item按页数排列存入临时数组
            _tempArray = [NSMutableArray array];
            for (int i = 0; i < _dataArray.count; i++) {
                NSMutableArray * pageArr = [NSMutableArray array];
                pagesModel * pmodel = _dataArray[i];
                for (NSDictionary * articleDict in dataDict[@"articles"]) {
                    ArticleModel * model = [[ArticleModel alloc] init];
                    [model setValuesForKeysWithDictionary:articleDict];
                    if ([pmodel.articles containsString:model.pk]) {
                        model.page = [NSString stringWithFormat:@"%d",i];
                        [pageArr addObject:model];
                    }
                }
                [_tempArray addObject:pageArr];
            }

//            [ProgressHUD hideAfterSuccessOnView:self.view];
            //刷新表格
                [_collection reloadData];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //数据下载失败处理
//        [ProgressHUD hideAfterFailOnView:self.view];
        NSLog(@"column数据下载失败");
    }];
}



#pragma mark UICollectionView 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.tempArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.tempArray[section]  count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    ArticleModel * model = self.tempArray[indexPath.section][indexPath.row];
    MyCollectionCell * cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"xx" forIndexPath:indexPath];
    [cell2 configCellWithaArticlesModel:model andItemIndexPath:indexPath];
//    if (indexPath.section == 4) {
//        NSLog(@"%d",indexPath.section%6);
//        [self loadMoreData];
//    }
    return cell2;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ColumnHeaderCollectionViewCell * headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"oo" forIndexPath:indexPath];
        [headView.iconView sd_setImageWithURL:[NSURL URLWithString:_bModel.bgimage_url]];
        return headView;
    }
    return [[UICollectionReusableView alloc] init];
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ArticleModel * model = self.tempArray[indexPath.section][indexPath.item];
    NewsWebViewController * nvc = [[NewsWebViewController alloc] init];
    nvc.webUrl = model.weburl;
    nvc.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:nvc animated:YES];

}

@end
