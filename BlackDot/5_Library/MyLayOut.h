//
//  MyLayOut.h
//  MyZaker
//
//  Created by Penny&Me on 16/7/6.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLayOut : UICollectionViewLayout
@property(nonatomic,strong)NSMutableArray * attArray;
@property(nonatomic,assign)NSInteger numberOfItem;
@property(nonatomic,assign)NSInteger numberOfSection;
-(void)prepareLayout;
//准备方法被自动调用，以保证layout实例的正确。

-(CGSize)collectionViewContentSize;
//返回collectionView的内容的尺寸

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect;
//1.返回rect中的所有的元素的布局属性
//2.返回的是包含UICollectionViewLayoutAttributes的NSArray
//3.UICollectionViewLayoutAttributes可以是cell，追加视图或装饰视图的信息，通过不同的UICollectionViewLayoutAttributes初始化方法可以得到不同类型的UICollectionViewLayoutAttributes：
//1)layoutAttributesForCellWithIndexPath:
//2)layoutAttributesForSupplementaryViewOfKind:withIndexPath:
//3)layoutAttributesForDecorationViewOfKind:withIndexPath:

-(UICollectionViewLayoutAttributes * )layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;
//返回对应于indexPath的位置的cell的布局属性

-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
//返回对应于indexPath的位置的追加视图的布局属性，如果没有追加视图可不重载

//-(UICollectionViewLayoutAttributes * )layoutAttributesForDecorationViewOfKind:(NSString*)decorationViewKind atIndexPath:(NSIndexPath *)indexPath;
//返回对应于indexPath的位置的装饰视图的布局属性，如果没有装饰视图可不重载

//-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds;
//当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
@end
