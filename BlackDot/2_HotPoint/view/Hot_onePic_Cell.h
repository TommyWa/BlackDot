//
//  Hot_onePic_Cell.h
//  MyZaker
//
//  Created by Penny&Me on 16/6/30.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotPointModel;
@interface Hot_onePic_Cell : UITableViewCell
@property(nonatomic,strong)HotPointModel * hModel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
-(void)setHModel:(HotPointModel *)hModel AndImageArray:(NSArray *)imageArray;
@end
