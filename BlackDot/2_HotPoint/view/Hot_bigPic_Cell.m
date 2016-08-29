//
//  Hot_bigPic_Cell.m
//  MyZaker
//
//  Created by Penny&Me on 16/6/30.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "Hot_bigPic_Cell.h"
#import "HotPointModel.h"
@implementation Hot_bigPic_Cell

-(void)setHModel:(HotPointModel *)hModel AndImageArry:(NSArray * )imageArray{
    _hModel = hModel;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.titleLabel.text = hModel.title;
    self.timeLabel.text = hModel.list_dtime;
    self.authorLabel.text = hModel.auther_name;
    if (imageArray.count) {
        [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imageArray firstObject]]]] ;
        self.bigImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.bigImageView.clipsToBounds = YES;
    }
   
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
