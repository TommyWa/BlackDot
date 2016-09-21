//
//  MyZoneViewController.m
//  WYTNews
//
//  Created by Penny&Me on 16/6/21.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "MyZoneViewController.h"
#import "ZoneBestViewController.h"
#import "ZoneDiscvViewController.h"

@interface MyZoneViewController ()


@end

@implementation MyZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initViewControllers];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentViewFrame = CGRectMake(0, 64, WIDTH, HIGTH-64-30);
    
    self.tabBar.frame = CGRectMake(0, 64, WIDTH, 30);
    
    self.tabBar.itemTitleColor = [UIColor lightGrayColor];
    self.tabBar.itemTitleSelectedColor = methemColor;
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:17];
    self.tabBar.itemTitleSelectedFont = [UIFont systemFontOfSize:22];
    
    [self.tabBar setScrollEnabledAndItemWidth:WIDTH/2];
    [self setContentScrollEnabledAndTapSwitchAnimated:NO];
    self.tabBar.itemFontChangeFollowContentScroll = YES;
    self.tabBar.itemSelectedBgScrollFollowContent = YES;
}

- (void)initViewControllers{
    ZoneDiscvViewController * dis = [[ZoneDiscvViewController alloc] init];
    dis.yp_tabItemTitle = @"发现";
    
    ZoneBestViewController * best = [[ZoneBestViewController alloc] init];
    best.yp_tabItemTitle = @"精选";
    
    self.viewControllers = @[dis,best];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
