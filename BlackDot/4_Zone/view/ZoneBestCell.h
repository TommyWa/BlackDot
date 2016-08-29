//
//  ZoneBestCell.h
//  MyZaker
//
//  Created by Penny&Me on 16/6/25.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZoneBestModel;
@class postsModel;
@interface ZoneBestCell : UITableViewCell
@property(nonatomic,strong)ZoneBestModel*zbModel;
@property(nonatomic,strong)postsModel * pModel;
@end
