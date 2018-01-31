//
//  EnjoyCell.h
//  WYTNews
//
//  Created by Penny&Me on 16/6/22.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class picModel;
@class itemModel;
@interface EnjoyCell : UITableViewCell
@property(nonatomic,strong)picModel * pModel;
@property(nonatomic,strong)itemModel * iModel;
@property(nonatomic,strong)UIImageView * bgImageView;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * subTitleLabel;

-(void)configCellWithPmodel:(picModel *)pModel andImodel:(itemModel *)iModel;
@end
