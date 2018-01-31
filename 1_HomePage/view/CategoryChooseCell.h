//
//  CategoryChooseCell.h
//  MyZaker
//
//  Created by Penny&Me on 16/6/27.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//
////从首页添加按钮推进/////////

#import <UIKit/UIKit.h>
#import "allDataModel.h"
@interface CategoryChooseCell : UITableViewCell
@property(nonatomic,strong)sonsArrayModel * sonsModel;
@property(nonatomic,strong)UIImageView * iconImageView;
@property(nonatomic,strong)UILabel * label;
@property(nonatomic,strong)UIImageView * nextMark;
@end
