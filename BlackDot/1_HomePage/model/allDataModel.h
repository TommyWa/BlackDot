//
//  allDataModel.h
//  MyZaker
//
//  Created by Penny&Me on 16/7/9.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <Foundation/Foundation.h>
//1.
@interface allDataModel : NSObject
@property(nonatomic,strong)NSDictionary * info;
@property(nonatomic,strong)NSArray * dates;
@property(nonatomic,strong)NSDictionary * message_info;
@end

//1.1
@interface InfoModel : NSObject
@property(nonatomic,copy)NSString *update_date;
@property(nonatomic,copy)NSString *skey;
@end
//1.2 --第二页分类的数组元素模型
@interface datesArrayModel : NSObject
@property(nonatomic,copy)NSString *pk;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *is_end;
@property(nonatomic,copy)NSString *father_id;
@property(nonatomic,copy)NSString *data_type;
@property(nonatomic,copy)NSString *list_icon;
@property(nonatomic,copy)NSString *list_stitle;
@property(nonatomic,copy)NSString *p_pk;
@property(nonatomic,strong)NSArray * sons;
@property(nonatomic,copy)NSString *sons_are_end;
@end
//1.3--
@interface message_infoModel : NSObject
@property(nonatomic,copy)NSString *refresh_key;
@property(nonatomic,copy)NSString *show_key;
@end

//1.2.1 第三页分类后的子类的数组元素模型
@interface sonsArrayModel : NSObject
@property(nonatomic,copy)NSString *pk;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *block_title;
@property(nonatomic,copy)NSString *is_end;
@property(nonatomic,copy)NSString *data_type;
@property(nonatomic,copy)NSString *list_icon;
@property(nonatomic,copy)NSString *list_stitle;
@property(nonatomic,copy)NSString *block_bg_key;
@property(nonatomic,copy)NSString *no_offline_dowm;
@property(nonatomic,copy)NSString *need_userinfo;
@property(nonatomic,copy)NSString *p_pk;
@property(nonatomic,copy)NSString *pic;
@property(nonatomic,copy)NSString *large_pic;
@property(nonatomic,copy)NSString *api_url;
@property(nonatomic,copy)NSString *block_color;
@property(nonatomic,strong)NSArray * sons;
@property(nonatomic,copy)NSString *sons_are_end;
@property(nonatomic,strong)UIImage *iconView;
@end

//1.2.1.1 分类后的子类的子分类
@interface sonsOfSonArrayModel : NSObject
@property(nonatomic,copy)NSString *need_userinfo;
@property(nonatomic,copy)NSString *pk;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *pic;
@property(nonatomic,copy)NSString *large_pic;
@property(nonatomic,copy)NSString *api_url;
@property(nonatomic,copy)NSString *list_icon;
@property(nonatomic,copy)NSString *list_stitle;
@property(nonatomic,copy)NSString *data_type;
@property(nonatomic,copy)NSString *block_color;
@end






