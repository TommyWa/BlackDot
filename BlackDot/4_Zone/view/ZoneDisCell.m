//
//  ZoneDisCell.m
//  MyZaker
//
//  Created by Penny&Me on 16/6/24.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "ZoneDisCell.h"
#import "ZoneDisModel.h"
#import "UIImageView+WebCache.h"
@interface ZoneDisCell()
@property(nonatomic,strong)UIImageView * leftImage;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * subTitleLabel;
@end
@implementation ZoneDisCell

//重写init方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, WIDTH-100, 20)];
        self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, WIDTH-100, 20)];
        
        [self.contentView addSubview:self.leftImage];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subTitleLabel];

    }
    return self;
}

- (void)setCModel:(cellModel *)cModel{
    _cModel = cModel;
    [self.leftImage sd_setImageWithURL:[NSURL URLWithString:cModel.pic]];
    self.titleLabel.text = cModel.title;
    self.subTitleLabel.text = cModel.stitle;
    self.subTitleLabel.font = [UIFont systemFontOfSize:12];
}

- (void)awakeFromNib {

    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
