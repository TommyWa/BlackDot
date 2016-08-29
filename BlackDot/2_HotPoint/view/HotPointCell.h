//
//  HotPointCell.h
//  WYTNews
//
//  Created by Penny&Me on 16/6/23.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotPointModel;
@interface HotPointCell : UITableViewCell
@property(nonatomic,strong)HotPointModel * hModel;
- (void)setMyCellFrameWithItemType:(NSString *)itemType Image:(NSArray *)imageArray;

- (void)setMycellLayOutWithItemType:(NSString *)itemType Image:(NSArray *)imageArray;
@end
