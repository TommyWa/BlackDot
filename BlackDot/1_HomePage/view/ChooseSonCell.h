//
//  ChooseSonCell.h
//  MyZaker
//
//  Created by Penny&Me on 16/6/27.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

//////首页添加按钮----》CategoryChoose----》本页
#import <UIKit/UIKit.h>

@interface ChooseSonCell : UITableViewCell
@property(nonatomic,strong)UILabel * label;
@property(nonatomic,strong)UIButton * button;
@property(nonatomic,assign)BOOL isClicked;
- (void)setImageState;
@end
