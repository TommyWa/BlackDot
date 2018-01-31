//
//  MyLayOut.m
//  MyZaker
//
//  Created by Penny&Me on 16/7/6.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#import "MyLayOut.h"

@implementation MyLayOut
-(NSMutableArray *)attArray{
    if (nil == _attArray) {
        _attArray = [NSMutableArray array];
    }
    
    return _attArray;
}
-(void)prepareLayout{
    [super prepareLayout];
    [self.attArray removeAllObjects];
     _numberOfSection = [self.collectionView numberOfSections];

}
-(CGSize)collectionViewContentSize{
    
    return CGSizeMake(kWidth * _numberOfSection, kHeight-40);
}
//返回collectionView的内容的尺寸

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    for (int i = 0; i < _numberOfSection ; i++) {
        _numberOfItem = [self.collectionView numberOfItemsInSection:i];
        for (int j = 0; j < _numberOfItem; j++) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes * attForItem = [self layoutAttributesForItemAtIndexPath:indexPath];
            UICollectionViewLayoutAttributes * attForHead = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
            
            [_attArray addObject:attForItem];
            [_attArray addObject:attForHead];
        }
    }
    return self.attArray;
}

//1.返回rect中的所有的元素的布局属性
//2.返回的是包含UICollectionViewLayoutAttributes的NSArray
//3.UICollectionViewLayoutAttributes可以是cell，追加视图或装饰视图的信息，通过不同的UICollectionViewLayoutAttributes初始化方法可以得到不同类型的UICollectionViewLayoutAttributes：
//1)layoutAttributesForCellWithIndexPath:
//2)layoutAttributesForSupplementaryViewOfKind:withIndexPath:
//3)layoutAttributesForDecorationViewOfKind:withIndexPath:

-(UICollectionViewLayoutAttributes * )layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *  attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSInteger r = indexPath.section;
    CGFloat heigth = (kHeight -100)/5;
    CGFloat width = kWidth/2;
    
    switch (indexPath.item) {
        case 0:
            attributes.frame = CGRectMake(kWidth * r, 60, width*2, heigth*2);
            break;
        case 1:
            attributes.frame = CGRectMake(kWidth * r, heigth*2+60, width, heigth);
            break;
        case 2:
            attributes.frame = CGRectMake(kWidth * r + width, heigth*2+60, width, heigth);
            break;
        case 3:
            attributes.frame = CGRectMake(kWidth * r, heigth*3+60, kWidth, heigth);
            break;
        case 4:
            attributes.frame = CGRectMake(kWidth *r, heigth*4+60, width, heigth);
            break;
        case 5:
            attributes.frame = CGRectMake(kWidth * r + width, heigth*4+60, width, heigth);
            break;
        default:
            break;
    }
    return attributes;
}

- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems{
    [super prepareForCollectionViewUpdates:updateItems];
    for (UICollectionViewUpdateItem * upItem in updateItems) {
        if (upItem.updateAction == UICollectionUpdateActionDelete)
            [_attArray addObject:upItem.indexPathAfterUpdate];
    }
}
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    if ([_attArray containsObject:itemIndexPath])
    {
        // only change attributes on inserted cells
        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        
        // Configure attributes ...
        attributes.alpha = 0.0;

    }

    return attributes;
}
//返回对应于indexPath的位置的cell的布局属性

-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind withIndexPath:indexPath];
    NSInteger r = indexPath.section;

    attributes.frame = CGRectMake(kWidth *r, 0, kWidth, 60);

    return attributes;
    
}
//返回对应于indexPath的位置的追加视图的布局属性，如果没有追加视图可不重载

//-(UICollectionViewLayoutAttributes * )layoutAttributesForDecorationViewOfKind:(NSString*)decorationViewKind atIndexPath:(NSIndexPath *)indexPath{

//}


-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
//当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。



@end
