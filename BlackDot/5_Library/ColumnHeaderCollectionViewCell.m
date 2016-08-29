//
//  ColumnHeaderCollectionViewCell.m
//  MyZaker
//
//  Created by Penny&Me on 16/7/5.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "ColumnHeaderCollectionViewCell.h"

@implementation ColumnHeaderCollectionViewCell

- (void)awakeFromNib {
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, WIDTH, 55)];
        [self addSubview:self.iconView];
    }
    return self;
}




@end
