//
//  MyCollectionViewCell.m
//  MyZaker
//
//  Created by Penny&Me on 16/7/6.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (void)awakeFromNib {
//    self.backgroundColor = [UIColor colorWithRed:146/255.0 green:185/255.0 blue:111/255.0 alpha:0.5];
    self.layer.borderWidth = 0.3;
    self.layer.borderColor = [[UIColor blackColor] CGColor];

}
- (void)configCellWithaArticlesModel:(ArticleModel *)model andItemIndexPath:(NSIndexPath *)indexPath{
    
    self.newsLabel.text = model.title;
    self.nameLabel.text = model.auther_name;
    if (indexPath.section == 0 ) {
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail_pic]];
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.bgImageView.clipsToBounds = YES;
        self.newsLabel.textColor = [UIColor whiteColor];
        self.newsLabel.font = [UIFont boldSystemFontOfSize:16];
        self.nameLabel.text = nil;
    }else{
        self.bgImageView.image = [[UIImage alloc] init];
        self.newsLabel.textColor = [UIColor blackColor];
        self.newsLabel.font = [UIFont systemFontOfSize:15];
    }

    
}
@end
