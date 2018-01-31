//
//  Hot_noPic_Cell.h
//  MyZaker
//
//  Created by Penny&Me on 16/6/30.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotPointModel;
@interface Hot_noPic_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property(nonatomic,strong)HotPointModel * hModel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
-(void)setHModel:(HotPointModel *)hModel AndImageArray:(NSArray *)imageArray;


@end
