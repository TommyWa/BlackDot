//
//  Hot_onePic_Cell.m
//  MyZaker
//
//  Created by Penny&Me on 16/6/30.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "Hot_onePic_Cell.h"
#import "HotPointModel.h"
@implementation Hot_onePic_Cell

-(void)setHModel:(HotPointModel *)hModel AndImageArray:(NSArray *)imageArray{
    _hModel = hModel;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.titleLabel.text = hModel.title;
//    self.timeLabel.text = hModel.list_dtime;
    self.authorLabel.text = hModel.auther_name;
    if (imageArray.count) {
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imageArray lastObject]]]];
        self.leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.leftImageView.clipsToBounds = YES;

    }
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
