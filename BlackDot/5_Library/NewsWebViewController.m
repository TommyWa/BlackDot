//
//  NewsWebViewController.m
//  WYTNews
//
//  Created by Penny&Me on 16/6/22.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "NewsWebViewController.h"
#import "AFHTTPSessionManager.h"
#import "FactoryUtil.h"
@interface NewsWebViewController ()<UIWebViewDelegate>
@property(nonatomic, strong)UIWebView * webView;
@property(nonatomic,strong)UIToolbar * toolBar;
@property(nonatomic,strong)UIView * shareAlertView;
@property(nonatomic,strong)UIView * setAlertView;
@end

@implementation NewsWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self downloadData];  采用H5的方式请求时打开
    self.navigationController.navigationBarHidden = YES;

    [self.view addSubview:self.webView];
    [self.view addSubview:self.toolBar];
    [self createToolbarButton];
    [self createshareAlertView];
    [self createSetAlertView];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

//懒加载webView
-(UIWebView *)webView{
    if (nil == _webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -20, WIDTH, HIGTH+20)];
        _webView.backgroundColor = [UIColor clearColor];
        [ProgressHUD showOnView:self.view];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
        [ProgressHUD hideAfterSuccessOnView:self.view];
        _webView.delegate = self;
        
     }
    return _webView;
}

//懒加载toolBar
-(UIToolbar *)toolBar{
    if (nil == _toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, HIGTH-40, WIDTH, 40)];
        _toolBar.backgroundColor = methemColor;
        _toolBar.barTintColor = methemColor;
    }
    return _toolBar;
}

//添加工具栏按钮
- (void)createToolbarButton{
//    NSArray * buttoImageArr = @[@"ic_arrow_back_48px",@"ic_launch_48px",@"ic_sms_48px",@"ic_create_48px",@"ic_settings_48px"];
//    for (int i = 0; i < 5; i++) {
//        UIButton * button = [FactoryUtil createButtonWithTitle:nil frame:CGRectMake(15 + 80*i, 5, 30, 30) backImage:[UIImage imageNamed:buttoImageArr[i]] tatget:self action:@selector(buttonAction:)];
//        button.tag = 100 + i;
//        [self.toolBar addSubview:button];
//    }
    UIButton * button  = [FactoryUtil createButtonWithTitle:nil frame:CGRectMake(15, 5, 30, 30) backImage:[UIImage imageNamed:@"ic_arrow_back_48px"] tatget:self action:@selector(buttonAction:)];
    button.tag = 100;
    [self.toolBar addSubview:button];
    
}

//工具栏分享按钮
-(void)createshareAlertView{
    if (nil == _shareAlertView) {
        _shareAlertView = [[UIView alloc] initWithFrame:CGRectMake(0, 567, WIDTH, HIGTH-567)];
        _shareAlertView.hidden = YES;
        _shareAlertView.backgroundColor = [UIColor redColor];
        for (int i = 0; i <4; i++) {
            
        }
    }
    [self.webView addSubview:_shareAlertView];
}


//工具栏设置按钮
- (void)createSetAlertView{
    if (nil == _setAlertView) {
        _setAlertView = [[UIView alloc] initWithFrame:CGRectMake(0, 400, WIDTH, HIGTH-400)];
        _setAlertView.hidden = YES;
        _setAlertView.backgroundColor = [UIColor whiteColor];
    }
    [self.webView addSubview:_setAlertView];
}

#pragma mark tooBar工具栏按钮方法
- (void)buttonAction:(UIButton *)button{
    switch (button.tag) {
        case 100:{
            [self.navigationController popViewControllerAnimated:YES];
            
            //self.navigationController.navigationBarHidden = YES;
            //self.hidesBottomBarWhenPushed = NO;
            
            break;
        }
        case 101:{
            self.shareAlertView.hidden = !self.shareAlertView.hidden;
            self.setAlertView.hidden = YES;
            break;
        }
        case 102:{
            [_webView.scrollView scrollRectToVisible:CGRectMake(0, CGRectGetMaxY(self.webView.frame), WIDTH, HIGTH) animated:YES];
            break;
        }
        case 103:{
            
            break;
        }
        case 104:{
            self.setAlertView.hidden = !self.setAlertView.hidden;
            self.shareAlertView.hidden = YES;
            break;
        }
            
        default:
            break;
    }
}

#pragma mark UIWebView 代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#1E3E3E'"];
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'white'"];
}


//此下载数据方法不需要，在UIWebView中可以直接通过url请求H5数据；
- (void)downloadData{
//
//    NSString * urlString = self.webUrl;
//    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //请求成功
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            NSDictionary * bigDict = responseObject;
//            NSDictionary * dataDict = bigDict[@"data"];
//            NSString * content = dataDict[@"content"];
//            NSMutableString * mStr = [NSMutableString stringWithString:content];
//
//            [self.webView loadHTMLString:mStr baseURL:nil];
//
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"跳转到新闻页面出错:%@",error);
//    }];

}




@end
