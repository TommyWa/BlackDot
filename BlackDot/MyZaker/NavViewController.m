//
//  NavViewController.m
//  WYTNews
//
//  Created by Penny&Me on 16/6/21.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "NavViewController.h"
#import "FactoryUtil.h"
#import "ProgressHUD.h"
#import "MJRefresh.h"
#import "LoginViewController.h"
@interface NavViewController ()
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation NavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.barTintColor = methemColor;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

//自定义导航栏内容
- (void)setMyNavgationItem{
    
    UIButton * button = [FactoryUtil createButtonWithTitle:nil frame:CGRectMake(0, 0, 30, 30) backImage:[UIImage imageNamed:@"ic_account_circle_48px"] tatget:self action:@selector(gotoHomepage)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationController.navigationBar.barTintColor = methemColor;
    
}

#pragma Mark 进入个人设置界面，未实现
- (void)gotoHomepage{
    LoginViewController * vc = [[LoginViewController alloc] init];
    vc.view.backgroundColor = [UIColor cyanColor];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}



@end
