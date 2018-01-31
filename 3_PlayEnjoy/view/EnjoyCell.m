//
//  EnjoyCell.m
//  WYTNews
//
//  Created by Penny&Me on 16/6/22.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "EnjoyCell.h"
#import "EnjoyModel.h"
#import "UIImageView+WebCache.h"
@implementation EnjoyCell

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
//        [self.contentView addSubview:self.bgImageView];
//        
//        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH-20, 100, WIDTH, 50)];
//        self.titleLabel.textColor = [UIColor whiteColor];
//        self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
//        [self.contentView addSubview:self.titleLabel];
//        
//        self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH-40, 155, WIDTH-40, 45)];
//        self.subTitleLabel.textColor = [UIColor whiteColor];
//        self.subTitleLabel.font = [UIFont systemFontOfSize:12];
//        [self.contentView addSubview:self.subTitleLabel];
//    }
//    return self;
//}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 195)];
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.bgImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.bgImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, WIDTH, 50)];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [self.bgImageView addSubview:self.titleLabel];
        
        self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 125, WIDTH, 45)];
        self.subTitleLabel.textColor = [UIColor whiteColor];
        self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.subTitleLabel.font = [UIFont systemFontOfSize:15];
        [self.bgImageView addSubview:self.subTitleLabel];

    }
    
    return self;
}

-(void)configCellWithPmodel:(picModel *)pModel andImodel:(itemModel *)iModel{
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:pModel.url]];
    self.titleLabel.text = iModel.title;
    self.subTitleLabel.text = iModel.content;
}



- (void)awakeFromNib {

    [super awakeFromNib];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
