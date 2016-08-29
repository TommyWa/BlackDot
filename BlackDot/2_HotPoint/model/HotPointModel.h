//
//  HotPointModel.h
//  WYTNews
//
//  Created by Penny&Me on 16/6/23.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface HotPointUrlModel :NSObject
@property(nonatomic)NSString * next_url;
@property(nonatomic)NSString *pre_url;
@property(nonatomic)NSString *comment_list_url;
@property(nonatomic)NSString *comment_url;
@property(nonatomic)NSString *comment_reply_url;
@property(nonatomic)NSString *comment_count_url;
@property(nonatomic)NSString *like_count_url;
@property(nonatomic)NSString *like_remove_url;
@property(nonatomic)NSString *readstat;
@property(nonatomic)NSString *localremovc_url;
@property(nonatomic)NSString *localsave_url;
@property(nonatomic)NSString *tuijian_list_url;
@property(nonatomic)NSString *force_refresh;
@end


@interface HotPointModel : NSObject
@property(nonatomic,copy)NSString *pk;
@property(nonatomic,copy)NSString *app_ids;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString * date;
@property(nonatomic,copy)NSString * list_dtime;
@property(nonatomic,copy)NSString * auther_name;
@property(nonatomic,copy)NSString * weburl;
@property(nonatomic,copy)NSString *isfull;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *full_arg;
@property(nonatomic,copy)NSString *full_url;

@property(nonatomic,strong)NSDictionary * special_info;
@property(nonatomic,strong)NSArray * thumbnail_medias;

@property(nonatomic,copy)NSString *url;

@end


@interface specialInfoModel : HotPointModel
@property(nonatomic,copy)NSString *show_jingcai;
@property(nonatomic,copy)NSString *item_type;
@end


@interface thumbnailModel : NSObject
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy,setter=Id:)NSString *ID;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *m_url;
@property(nonatomic,copy)NSString *min_url;
@property(nonatomic,copy)NSString *raw_url;
@property(nonatomic,copy)NSString *w;
@property(nonatomic,copy)NSString *h;

@end













