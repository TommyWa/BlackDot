//
//  ColumnCollectionViewLayout.m
//  MyZaker
//
//  Created by Penny&Me on 16/7/5.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "ColumnCollectionViewLayout.h"
#import "ColumnHeaderCollectionViewCell.h"
@interface ColumnCollectionViewLayout()

@end
@implementation ColumnCollectionViewLayout
- (void)prepareLayout{
    [super prepareLayout];

    NSMutableArray * layoutInfoArray = [NSMutableArray array];
    NSInteger maxNumberOfItems = 0;
    
    //获取布局信息
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    for (NSInteger section = 0; section < numberOfSections; section++){
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        NSMutableArray *subArr = [NSMutableArray arrayWithCapacity:numberOfItems];
        NSIndexPath * indexpath = [NSIndexPath indexPathWithIndex:section];
        UICollectionViewLayoutAttributes * headAtt = [self layoutAttributesForSupplementaryViewOfKind:@"ColumnHeaderCollectionViewCell" atIndexPath:indexpath];
        for (NSInteger item = 0; item < numberOfItems; item++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            
            //小数组中添加每一个item的布局属性
            [subArr addObject:attributes];
        }
        if(maxNumberOfItems < numberOfItems){
            maxNumberOfItems = numberOfItems;
        }
        //添加小数组到二维数组
        [_headLayoutArr addObject:headAtt];
        [layoutInfoArray addObject:[subArr copy]];

    }
    //存储布局信息
    self.layoutInfoArr = [layoutInfoArray copy];

//    self.contentSize = CGSizeMake(maxNumberOfItems*(self.itemSize.width+self.interitemSpacing)+self.interitemSpacing, numberOfSections*(self.itemSize.height+self.lineSpacing)+self.lineSpacing);
    self.contentSize = CGSizeMake(WIDTH * numberOfSections, HIGTH);
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *  attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSInteger r = indexPath.section % 6;
    switch (indexPath.row % 6) {
        case 0:
            attributes.frame = CGRectMake( WIDTH *r, 100, WIDTH, 200);
            break;
        case 1:
            attributes.frame = CGRectMake(WIDTH*r, 305, WIDTH/2, 80);
            break;
        case 2:
            attributes.frame = CGRectMake(WIDTH/2 + WIDTH * r, 305, WIDTH/2, 80);
            break;
        case 3:
            attributes.frame = CGRectMake(WIDTH *r, 390, WIDTH, 100);
            break;
        case 4:
            attributes.frame = CGRectMake(WIDTH * r, 495, WIDTH/2, 80);
            break;
        case 5:
            attributes.frame = CGRectMake(WIDTH/2 + WIDTH *r, 495, WIDTH/2, 80);
            break;
        default:
            break;
    }

    
    
//    attributes.frame = CGRectMake((self.itemSize.width+self.interitemSpacing)*indexPath.row+self.interitemSpacing, (self.itemSize.height+self.lineSpacing)*indexPath.section+self.lineSpacing, self.itemSize.width, self.itemSize.height);
    return attributes;
}


- (CGSize)collectionViewContentSize{
    return self.contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *layoutAttributesArr = [NSMutableArray array];
    [self.layoutInfoArr enumerateObjectsUsingBlock:^(NSArray *array, NSUInteger i, BOOL * _Nonnull stop) {
        [array enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(CGRectIntersectsRect(obj.frame, rect)) {
                [layoutAttributesArr addObject:obj];
            }
        }];
    }];
    //add first supplementaryView
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
//
//    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
//    [layoutAttributesArr addObject:attributes];
    

    return _layoutInfoArr;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];

        if ([elementKind isEqualToString:@"ColumnHeaderCollectionViewCell"]) {
    attributes.frame = CGRectMake(0, 0, 100, HIGTH);
        }
    
    return attributes;
}

#pragma mark Set Method

-(void)setItemSize:(CGSize)itemSize{
    _itemSize = itemSize;
    [self invalidateLayout];
}

- (void)setInteritemSpacing:(CGFloat)interitemSpacing{
    _interitemSpacing = interitemSpacing;
    [self invalidateLayout];
}

- (void)setLineSpacing:(CGFloat)lineSpacing{
    _lineSpacing = lineSpacing;
    [self invalidateLayout];
}

-(void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection{
    _scrollDirection = scrollDirection;
    [self invalidateLayout];
    
}


@end








