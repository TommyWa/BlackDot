//
//  HomeTopScrollView.h
//  MyZaker
//
//  Created by Penny&Me on 16/6/28.
//  Copyright © 2016年 WangYuetong. All rights reserved.


#pragma mark 首页顶部视图

#import <UIKit/UIKit.h>

@interface HomeTopScrollView : UIView

@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,copy)NSString * apiUrl;
@property(nonatomic,copy)void(^block)(NSString *,NSString *);

- (instancetype)initWithFrame:(CGRect)frame AndPicArray:(NSArray *)picArray;

@end
