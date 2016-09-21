//
//  ChooseModel.h
//  MyZaker
//
//  Created by Penny&Me on 16/6/26.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChooseModel : NSObject
@property(nonatomic,strong)NSDictionary * info;
@property(nonatomic,strong)NSArray * datas;
@end

//datas数组中的每一个元素是一个字典
@interface categoryModel : NSObject
@property(nonatomic,copy)NSString * pk;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * is_end;
@property(nonatomic,copy)NSString * father_id;
@property(nonatomic,copy)NSString *data_type;
@property(nonatomic,copy)NSString *list_icon;
@property(nonatomic,copy)NSString *p_pk;
@property(nonatomic,strong)NSArray * sons;
@property(nonatomic,copy)NSString * sons_are_end;

@end

//category下的字内容
@interface sonsModel : NSObject
@property(nonatomic,copy)NSString * pk;
@property(nonatomic,copy)NSString *title;
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
@property(nonatomic,copy)NSString *desktop_color_number;
@property(nonatomic,strong)UIImage * iconView;
@end

