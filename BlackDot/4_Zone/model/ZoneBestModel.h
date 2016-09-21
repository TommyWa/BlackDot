//
//  ZoneBestModel.h
//  MyZaker
//
//  Created by Penny&Me on 16/6/25.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//精选

#import <Foundation/Foundation.h>

@interface ZoneBestModel : NSObject
@property(nonatomic,copy)NSString *stat;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end

@interface zbDataModel : NSObject
@property(nonatomic,strong)NSDictionary * info;
@property(nonatomic,strong)NSArray * posts;
@end

@interface postsModel : NSObject
@property(nonatomic,copy)NSString *pk;
@property(nonatomic,copy)NSString *discussion_id;
@property(nonatomic,strong)NSDictionary * auther;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *date;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *comment_count;
@property(nonatomic,copy)NSString *hot_num;
@property(nonatomic,copy)NSString *like_num;
@property(nonatomic,strong)NSArray * post_tag;
@property(nonatomic,strong)NSArray * list_tip;
@property(nonatomic,copy)NSString * list_date;
@property(nonatomic,strong)NSArray * thumbnail_medias;
@property(nonatomic,strong)NSArray * medias;
@property(nonatomic,copy)NSString * weburl;
@property(nonatomic,copy)NSString * content_url;
@property(nonatomic,copy)NSString *comment_list_url;
@property(nonatomic,copy)NSString *is_top;
@property(nonatomic,strong)NSDictionary * special_info;
@property(nonatomic,copy)NSString * is_liked;
@end


@interface specialInfoModel : NSObject
@property(nonatomic,copy)NSString * item_type;
@property(nonatomic,strong)NSString *medias_count;
@property(nonatomic,strong)NSString *discussion_title;
@property(nonatomic,strong)NSString *discussion_info_url;
@end


@interface autherModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *icon;
@end
