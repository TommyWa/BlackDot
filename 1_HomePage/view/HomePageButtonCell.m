//
//  CollectionButtonCell.m
//  WYTNews
//
//  Created by Penny&Me on 16/6/21.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "HomePageButtonCell.h"
#import "HomePageButtonModel.h"
@interface HomePageButtonCell()


@end

@implementation HomePageButtonCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.favImageView = [[UIImageView alloc] initWithFrame:self.bounds];
//        self.favImageView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1.0];
        self.favImageView.backgroundColor = methemColor;
        self.backgroundColor = [UIColor blackColor];
        self.favImageView.layer.borderColor = [[UIColor brownColor] CGColor];
        self.favImageView.layer.borderWidth = 0.5;
        self.label = [[UILabel alloc] init];
        self.label.frame = CGRectMake(0, WIDTH/3-25, WIDTH/3, 20);
        self.label.textColor = [UIColor whiteColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:14];
        self.delButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.delButton setBackgroundImage:[UIImage imageNamed:@"ic_remove_circle_outline_48px"] forState:UIControlStateNormal];
        self.delButton.frame = CGRectMake(5, 5, 20, 20);
        self.delButton.hidden = YES;
        [self.delButton addTarget:self action:@selector(delButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.favImageView];
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.delButton];
}
    return self;
}

- (void)goToEditing{
//    self.contentView.subviews
//    self.delButton.hidden = NO;
}

-(void)delButtonAction:(UIButton *)button{
    
}

-(void)setSonModel:(sonsModel *)sonModel{
    _sonModel = sonModel;
    [self.favImageView sd_setImageWithURL:[NSURL URLWithString:sonModel.pic]];
    self.label.text = sonModel.title;
}


@end
