//
//  FactoryUtil.h
//  WYTNews
//
//  Created by Penny&Me on 16/6/21.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FactoryUtil : NSObject

+ (UIButton *)createButtonWithTitle:(NSString *)title frame:(CGRect)frame backImage:(UIImage * )image tatget:(id)target action:(SEL)action;

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame andImage:(UIImage *)image;


@end
