//
//  FactoryUtil.h
//  WYTNews
//
//  Created by Penny&Me on 16/6/21.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HIGTH [UIScreen mainScreen].bounds.size.height

//#define methemColor [UIColor colorWithRed:84/255.0 green:110/255.0 blue:122/255.0 alpha:1.0]
#define methemColor [UIColor colorWithRed:143/255.0 green:161/255.0 blue:54/255.0 alpha:1.0]
#define collectColor [UIColor colorWithRed:232/255.0 green:245/255.0 blue:233/255.0  alpha:1.0]
#define mytitleColor [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1]
#define timeNow [[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]] substringToIndex:10]


@interface FactoryUtil : NSObject

+ (UIButton *)createButtonWithTitle:(NSString *)title frame:(CGRect)frame backImage:(UIImage * )image tatget:(id)target action:(SEL)action;

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame andImage:(UIImage *)image;


@end
