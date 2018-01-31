//
//  CollectionButtonCell.h
//  WYTNews
//
//  Created by Penny&Me on 16/6/21.
//  Copyright © 2016年 WangYuetong. All rights reserved.

//首页添加按钮模板//////

#import <UIKit/UIKit.h>
@class sonsModel;

@interface HomePageButtonCell : UICollectionViewCell

@property(nonatomic,strong)sonsModel * sonModel;
@property(nonatomic,strong)UIImageView * favImageView;
@property(nonatomic,strong)UILabel * label;
@property(nonatomic,strong)UIButton * delButton;
@property(nonatomic,strong)UIButton * editButton;

@end
