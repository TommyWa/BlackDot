//
//  Hot_threePic_Cell.m
//  MyZaker
//
//  Created by Penny&Me on 16/6/30.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "Hot_threePic_Cell.h"
#import "HotPointModel.h"
@implementation Hot_threePic_Cell

-(void)setHModel:(HotPointModel *)hModel AndImageArray:(NSArray *)imageArray{
    _hModel = hModel;

    
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.titleLabel.text = hModel.title;
    self.timeLabel.text = hModel.list_dtime;
    self.authorLabel.text = hModel.auther_name;
    if (imageArray.count >=3) {
        [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imageArray firstObject]]]];
        self.firstImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.firstImageView.clipsToBounds = YES;
        [self.secondImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageArray [1]]]];
        self.secondImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.secondImageView.clipsToBounds = YES;
        [self.thirdImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imageArray lastObject ]]]];
        self.secondImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.secondImageView.clipsToBounds = YES;
    }
    
}
- (void)awakeFromNib {
   
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    
}

@end
