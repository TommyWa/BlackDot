//
//  CategoryChooseCell.m
//  MyZaker
//
//  Created by Penny&Me on 16/6/27.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "CategoryChooseCell.h"
#import "UIImageView+WebCache.h"
#import "ChooseModel.h"
@implementation CategoryChooseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 45, 45)];
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, 100, 30)];
        self.nextMark = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH-35, 20, 25, 25)];
        self.nextMark.image = [UIImage imageNamed:@"ic_keyboard_arrow_right_48px"];
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.nextMark];
    
    }
    return self;
    
}
-(void)setSonsModel:(sonsArrayModel *)sonsModel{
    _sonsModel = sonsModel;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:sonsModel.list_icon]];
    self.label.text = sonsModel.title;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
