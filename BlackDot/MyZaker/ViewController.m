//
//  ViewController.m
//  WYTNews
//
//  Created by Penny&Me on 16/6/21.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "ViewController.h"
#import "FactoryUtil.h"
@interface ViewController ()
{
    NSMutableArray * _vcArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _vcArray = [NSMutableArray array];
    [self createTabbarController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 创建Tabbar
- (void)createTabbarController{
    NSArray * imageArray = @[@"ic_loyalty_48px",@"ic_motorcycle_black_48px",@"ic_widgets_48px"];
    NSArray * titleArray = @[@"订阅",@"玩乐",@"专题"];
    NSArray * controllerArray = @[@"HomePage",@"Playenjoy",@"Topic"];
    for (int i = 0; i < controllerArray.count; i++) {
        
        NSString * className = [NSString stringWithFormat:@"%@ViewController",controllerArray[i]];
        Class myClass = NSClassFromString(className);
        UIViewController * vc = [[myClass alloc] init];
        UINavigationController * nag = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.tabBarItem.title = titleArray[i];
        vc.tabBarItem.image = [UIImage imageNamed:imageArray[i]];
        vc.tabBarItem.image = [UIImage imageNamed:imageArray[i]];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.view.backgroundColor = [UIColor whiteColor];
        vc.tabBarController.tabBar.barTintColor = methemColor;
        
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:methemColor} forState:UIControlStateSelected] ;
        vc.navigationController.navigationBar.barTintColor = methemColor;
        vc.title = titleArray[i];
        [_vcArray addObject:nag];
    }
    
    self.viewControllers = _vcArray;
    
}

@end
