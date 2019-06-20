//
//  TopicViewCell.h
//  MyZaker
//
//  Created by Penny&Me on 16/7/11.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//	TestForJenkins

#import <UIKit/UIKit.h>
#import "TopicModel.h"
#import "NewsWebViewController.h"
#import "HotPointViewController.h"
@interface TopicViewCell : UITableViewCell
//@property(nonatomic,strong)UIImageView * bgImageView;
@property(nonatomic,strong)UILabel * titleLabel;
//@property (weak, nonatomic) IBOutlet UIButton *imageButton;
//@property (weak, nonatomic) IBOutlet UIButton *titleButton_1;
//@property (weak, nonatomic) IBOutlet UIButton *titleButton_2;
//@property (weak, nonatomic) IBOutlet UIButton *entranceButton;
@property(nonatomic,strong)TopicListModel * model;
@property (strong, nonatomic)  UIButton *imageButton;
@property (strong, nonatomic)  UIButton *titleButton_1;
@property (strong, nonatomic)  UIButton *titleButton_2;
@property (strong, nonatomic)  UIButton *entranceButton;
@property (strong, nonatomic)  UIImageView * bgImageView;
@property(strong,nonatomic)void(^urlBlock)(NSString *,UIViewController *);
- (void)configWithDataArray:(NSMutableArray *)dataArray AndIndexPaht:(NSIndexPath *)indexPath;
@end
