//
//  YPTabBarController.h
//  YPTabBarController
//
//  Created by 喻平 on 15/8/11.
//  Copyright (c) 2015年 YPTabBarController. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPTabBar.h"
#import "YPTabItem.h"
#import "NavViewController.h"
@interface YPTabBarController : NavViewController <YPTabBarDelegate>

@property (nonatomic, strong) YPTabBar *tabBar;

@property (nonatomic, copy) NSArray <UIViewController *> *viewControllers;

/**
 *  内容视图的Frame
 */
@property (nonatomic, assign) CGRect contentViewFrame;

/**
 *  被选中的ViewController的Index
 */
@property (nonatomic, assign, readonly) NSInteger selectedControllerIndex;

/**
 *  获取被选中的ViewController
 */
- (UIViewController *)selectedController;

/**
 *  设置内容视图支持滑动切换，以及点击item切换时是否有动画
 *
 *  @param animated  点击切换时是否支持动画
 */
- (void)setContentScrollEnabledAndTapSwitchAnimated:(BOOL)animated;

@end

@interface UIViewController (YPTabBarController)

@property (nonatomic, copy) NSString *yp_tabItemTitle; // tabItem的标题
@property (nonatomic, strong) UIImage *yp_tabItemImage; // tabItem的图像
@property (nonatomic, strong) UIImage *yp_tabItemSelectedImage; // tabItem的选中图像

- (YPTabItem *)yp_tabItem;
- (YPTabBarController *)yp_tabBarController;

/**
 *  ViewController对应的Tab被Select后，执行此方法
 */
- (void)tabItemDidSelected;

/**
 *  ViewController对应的Tab被Deselect后，执行此方法
 */
- (void)tabItemDidDeselected;
@end