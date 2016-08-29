//
//  ColumnCollectionViewLayout.h
//  MyZaker
//
//  Created by Penny&Me on 16/7/5.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColumnCollectionViewLayout : UICollectionViewLayout
@property(nonatomic,strong)NSMutableArray * layoutInfoArr;
@property(nonatomic,strong)NSMutableArray * headLayoutArr;

@property(nonatomic,assign)CGSize contentSize;
@property(nonatomic,assign)CGSize itemSize;
@property(nonatomic,assign)CGFloat interitemSpacing;
@property(nonatomic,assign)CGFloat lineSpacing;
@property(nonatomic,assign)UICollectionViewScrollDirection scrollDirection;
@end
