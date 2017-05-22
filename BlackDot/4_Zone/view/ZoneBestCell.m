//
//  ZoneBestCell.m
//  MyZaker
//
//  Created by Penny&Me on 16/6/25.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "ZoneBestCell.h"
#import "ZoneBestModel.h"
#import "UIImageView+WebCache.h"
@interface ZoneBestCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *isLookedLabel;
@property (weak, nonatomic) IBOutlet UILabel *disCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *zanCountLabel;

@end
@implementation ZoneBestCell


-(void)setPModel:(postsModel *)pModel{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:pModel.auther[@"icon"]]];
    self.nameLabel.text = pModel.auther[@"name"];
    self.timeLabel.text = pModel.date;
    self.markLabel.text = [NSString stringWithFormat:@"#%@",pModel.special_info[@"discussion_title"]];
    self.titleLabel.text = pModel.content;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:pModel.thumbnail_medias[0][@"m_url"]]];
    self.picImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.picImageView.clipsToBounds = YES;
    self.isLookedLabel.text = pModel.hot_num;
    self.disCountLabel.text = pModel.comment_count;
    self.zanCountLabel.text = pModel.like_num;
    
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.font = [UIFont systemFontOfSize:11];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.numberOfLines = 0;
    self.markLabel.font = [UIFont systemFontOfSize:11];
    
    self.isLookedLabel.font = [UIFont systemFontOfSize:10];
    self.disCountLabel.font = [UIFont systemFontOfSize:10];
    self.zanCountLabel.font = [UIFont systemFontOfSize:10];
    
    self.nameLabel.textColor = [UIColor blueColor];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    self.markLabel.textColor = [UIColor lightGrayColor];
    self.isLookedLabel.textColor = [UIColor lightGrayColor];
    self.disCountLabel.textColor = [UIColor lightGrayColor];
    self.zanCountLabel.textColor = [UIColor lightGrayColor];
    
    self.markLabel.textAlignment = NSTextAlignmentRight;
    self.iconImageView.layer.cornerRadius = 25;
    self.iconImageView.layer.masksToBounds = YES;

}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
