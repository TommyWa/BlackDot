//
//  ButtonModel.h
//  WYTNews
//
//  Created by Penny&Me on 16/6/21.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageButtonModel : NSObject
@property(nonatomic,assign)int collectID;
@property(nonatomic,copy)NSString * pk;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *block_title;
@property(nonatomic,copy)NSString *is_end;
@property(nonatomic,copy)NSString *data_type;
@property(nonatomic,copy)NSString *list_icon;
@property(nonatomic,copy)NSString *list_stitle;
@property(nonatomic,copy)NSString *block_bg_key;
@property(nonatomic,copy)NSString *no_offline_down;
@property(nonatomic,copy)NSString *need_userinfo;
@property(nonatomic,copy)NSString *p_pk;
@property(nonatomic,copy)NSString *pic;
@property(nonatomic,copy)NSString *large_pic;
@property(nonatomic,copy)NSString *api_url;
@property(nonatomic,copy)NSString *block_color;
@property(nonatomic,strong)UIImage *iconView;
@end


