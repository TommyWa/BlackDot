//
//  TopicDetailController.m
//  MyZaker
//
//  Created by Penny&Me on 16/7/11.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "TopicDetailController.h"
#import "TopicDetailModel.h"
#import "Hot_noPic_Cell.h"
#import "Hot_onePic_Cell.h"
#import "NewsWebViewController.h"
@interface TopicDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * sectionArray;
@property(nonatomic,strong)NSMutableArray * scrollArray;
@property(nonatomic,copy)NSString * headUrl;
@property(nonatomic,copy)NSString * nextUrl;
@property(nonatomic,strong)UIView * hideView;
@end

@implementation TopicDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _hideView = [[UIView alloc] initWithFrame:CGRectMake(0, -64, WIDTH, HIGTH+64)];
//    _hideView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_hideView];
    _dataArray = [NSMutableArray array];
    _sectionArray = [NSMutableArray array];
    _scrollArray = [NSMutableArray array];
    self.navigationController.navigationBarHidden = YES;
    [self createMyTableView];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self downloadDataWithUrl:self.url];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;

}
- (void)createMyTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HIGTH)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.view addSubview:_tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"Hot_onePic_Cell" bundle:nil] forCellReuseIdentifier:@"one"];
    [self.tableView registerNib:[UINib nibWithNibName:@"Hot_noPic_Cell" bundle:nil] forCellReuseIdentifier:@"none"];
    [self loadFirstPage];
//    [self loadMore];

}
-(void)loadFirstPage{
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_dataArray removeAllObjects];
        [self downloadDataWithUrl:_url];
    }];
    self.tableView.mj_header = header;
    _tableView.mj_header.hidden = YES;

}


-(void)loadMore{
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (_nextUrl) {
            [self downloadDataWithUrl:_nextUrl];
        }else{
            NSLog(@"暂无精彩文章请稍后再来");
        }
    }];
    
    self.tableView.mj_footer = footer;
}


- (void)setMyNavgationBar{
    UIImageView * nagImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH,64)];
    [nagImg sd_setImageWithURL:[NSURL URLWithString:_headUrl]];
    
    [nagImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"ic_keyboard_arrow_left_48px"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 23, 30, 30);
    [button addTarget:self action:@selector(backToFront) forControlEvents:UIControlEventTouchUpInside];
    nagImg.userInteractionEnabled = YES;
    [nagImg addSubview:button];
    [self.view addSubview:nagImg];
    
}

- (void)backToFront{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createTableHeader{
    UIScrollView * scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,WIDTH,200)];
    scroll.contentSize = CGSizeMake(WIDTH * _scrollArray.count, 200);
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.bounces = NO;
    scroll.pagingEnabled = YES;
    for (int i = 0 ; i < _scrollArray.count; i++) {
        gallery * gmodel = _scrollArray[i];
        UIImageView * header = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH *i, 0, WIDTH, 200)];
        header.userInteractionEnabled = YES;
        [header sd_setImageWithURL:[NSURL URLWithString:gmodel.promotion_img]];
        header.tag = 1000 + i;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToDetail:)];
        [header addGestureRecognizer:tap];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH * i, 170, WIDTH, 20)];
        label.text = gmodel.title;
        label.textColor = mytitleColor;
        [scroll addSubview:header];
        [scroll addSubview:label];
    }
    self.tableView.tableHeaderView = scroll;
}

- (void)goToDetail:(UITapGestureRecognizer *)tap{
    UIImageView * img = (UIImageView *)tap.view;
    gallery *gmodel = _scrollArray[img.tag - 1000];
    NewsWebViewController * new = [[NewsWebViewController alloc] init];
    new.webUrl = gmodel.article[@"weburl"];
    NSLog(@"xxxxxx%@",new.webUrl);
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:new animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)downloadDataWithUrl:(NSString *)url{

    [ProgressHUD showOnView:self.hideView];
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    NSDictionary * param = @{@"_appid":@"iphone",@"_bsize":@"640_960",@"_v":@"6.6",@"_version":@"6.6"};
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [ProgressHUD hideAfterSuccessOnView:weakSelf.view];

        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * bigDict = responseObject;
            NSDictionary * dataDict = bigDict[@"data"];
            _headUrl = dataDict[@"block_info"][@"diy"][@"bgimage_url"];

            NSArray * galleryArray = dataDict[@"gallery"];
            for (NSDictionary * dict in galleryArray) {
                gallery * gModel = [[gallery alloc] init];
                [gModel setValuesForKeysWithDictionary:dict];
                if (gModel.article[@"weburl"]) {
                    [_scrollArray addObject:gModel];
                }
            }
            for (NSDictionary * dic in dataDict[@"articles"]) {
                articelsModel * model = [[articelsModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                NSMutableArray * array = [NSMutableArray array];
                for (NSDictionary * listDic in model.list) {
                    listModel * lmodel = [[listModel alloc] init];
                    [lmodel setValuesForKeysWithDictionary:listDic];
                    [array addObject:lmodel];
                }
                [_dataArray addObject:model];
                [_sectionArray addObject:array];
            }
            
            [self setMyNavgationBar];
            [self createTableHeader];
            [self.hideView removeFromSuperview];
//            _tableView.mj_header.hidden = NO;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView.mj_header endRefreshing];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //数据请求失败
        [ProgressHUD hideAfterFailOnView:weakSelf.hideView];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        NSLog(@"热点数据%@",error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_sectionArray[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    listModel * model = _sectionArray[indexPath.section][indexPath.row];
    thumbNailModel * imageModel = [model.article[@"thumbnail_medias"] firstObject];
    if (imageModel) {
        Hot_onePic_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"one"];
        cell.titleLabel.text = model.title;
        cell.authorLabel.text = model.article[@"auther_name"];
        [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:imageModel.url]];
        cell.leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.leftImageView.clipsToBounds = YES;
        return cell;
    }else{
        Hot_noPic_Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"none"];
        cell.titleLabel.text = model.title;
        cell.authorLabel.text = model.article[@"auther_name"];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    articelsModel * model = _dataArray[section];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 15)];
    label.text = model.title;
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [UIColor lightGrayColor];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    listModel * model = _sectionArray[indexPath.section][indexPath.row];
    NSString * url =  model.article[@"weburl"];
    NewsWebViewController * vc = [[NewsWebViewController alloc] init];
    vc.webUrl = url;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
