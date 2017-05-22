//
//  Hot_noPic_Cell.m
//  MyZaker
//
//  Created by Penny&Me on 16/6/30.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "Hot_noPic_Cell.h"
#import "HotPointModel.h"
@interface Hot_noPic_Cell()


@end

@implementation Hot_noPic_Cell
-(void)setHModel:(HotPointModel *)hModel AndImageArray:(NSArray *)imageArray{
    _hModel = hModel;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.titleLabel.text = hModel.title;
//    self.timeLabel.text = hModel.list_dtime;
    self.authorLabel.text = hModel.auther_name;
    
}
-(void)setHModel:(HotPointModel *)hModel{
    
    _hModel = hModel;
    self.titleLabel.text = hModel.title;
//    self.timeLabel.text = hModel.list_dtime;
    self.authorLabel.text = hModel.auther_name;
}
- (void)awakeFromNib {
    
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
