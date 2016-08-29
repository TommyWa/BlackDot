//
//  ZoneBViewController.h
//  MyZaker
//
//  Created by Penny&Me on 16/6/25.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoneBestViewController : UIViewController
@property(nonatomic,copy)NSString * url;
@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
- (void)downloadDataWithUrl:(NSString *)url;
@end
