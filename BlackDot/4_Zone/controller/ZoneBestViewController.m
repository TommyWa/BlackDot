
#import "ZoneBestViewController.h"
#import "AFHTTPSessionManager.h"
#import "Const.h"
#import "ZoneBestModel.h"
#import "ZoneBestCell.h"
#import "ZoneDetaiViewController.h"
#import "NewsWebViewController.h"
@interface ZoneBestViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation ZoneBestViewController
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self createtableView];
    [self downloadDataWithUrl:kSelected];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)createtableView{
        self.automaticallyAdjustsScrollViewInsets = NO;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, WIDTH, HIGTH-30) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}


- (void)downloadDataWithUrl:(NSString *)url{
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * bigDict = responseObject;
            NSDictionary * dataDict = bigDict[@"data"];
            for (NSDictionary *pModelDict in dataDict[@"posts"]) {
                postsModel * pModel = [[postsModel alloc] init];
                [pModel setValuesForKeysWithDictionary:pModelDict];
                [weakSelf.dataArray addObject:pModel];
            }
        }
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络错误:%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark UITableView代理方法


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"BestCellID";
    
    ZoneBestCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZoneBestCell" owner:nil options:nil] lastObject];
    }
    postsModel * pModel = self.dataArray[indexPath.row];
    [cell setPModel:pModel];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 380;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    postsModel * pModel = self.dataArray[indexPath.row];
    NewsWebViewController * zcvc = [[NewsWebViewController alloc] init];
    zcvc.webUrl = pModel.weburl;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:zcvc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

@end
