//
//  MyCollectionCell.m
//  MyZaker
//
//  Created by Penny&Me on 16/7/12.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "MyCollectionCell.h"

@implementation MyCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = [methemColor CGColor];
    self.layer.borderWidth = 0.5;
    
}
- (void)configCellWithaArticlesModel:(ArticleModel *)model andItemIndexPath:(NSIndexPath *)indexPath{

    self.newsLabel.text = model.title;
//    self.nameLabel.text = model.auther_name;
    if (indexPath.item == 0 ) {
        NSLog(@"图片网站%@",model.thumbnail_mpic);
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail_pic]];
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.bgImageView.clipsToBounds = YES;
        self.newsLabel.font = [UIFont boldSystemFontOfSize:18];
//        self.nameLabel.text = nil;
        
      }else{
        self.bgImageView.image = [[UIImage alloc] init];
        self.newsLabel.textColor = [UIColor blackColor];
        self.newsLabel.font = [UIFont systemFontOfSize:17];
        self.newsLabel.numberOfLines = 2;
//        self.nameLabel.text = model.auther_name;
    }
    
}

@end
