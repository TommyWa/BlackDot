//
//  MyCollectionCell.h
//  MyZaker
//
//  Created by Penny&Me on 16/7/12.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"
@interface MyCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsLabel;
@property(nonatomic,strong)ArticleModel *model;
- (void)configCellWithaArticlesModel:(ArticleModel *)model andItemIndexPath:(NSIndexPath *)indexPath;

@end
