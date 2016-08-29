//
//  ChooseSonCell.m
//  MyZaker
//
//  Created by Penny&Me on 16/6/27.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "ChooseSonCell.h"
#import "HomePageDBManager.h"
@implementation ChooseSonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(WIDTH-25, 10, 20, 20);
        [self.contentView addSubview:self.button];
    }
    return self;
    
}
- (void)setImageState{
    //判断本页哪些cell在数据库中，来该表cell右侧button的背景图片
    [[HomePageDBManager sharedManager] isNewsFavorite:self.textLabel.text flagBlock:^(BOOL flag) {
        if (flag) {
            [self.button setBackgroundImage:[UIImage imageNamed:@"ic_radio_button_checked_48px"] forState:UIControlStateNormal];
            self.button.selected = YES;
        }else{
            [self.button setBackgroundImage:[UIImage imageNamed:@"ic_radio_button_unchecked_48px"] forState:UIControlStateNormal];
            self.button.selected = NO;
        }
    }];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
