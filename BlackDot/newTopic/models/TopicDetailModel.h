//
//  TopicDetailModel.h
//  MyZaker
//
//  Created by Penny&Me on 16/7/11.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicDetailModel : NSObject
@property(nonatomic,strong)NSArray * gallery;
@property(nonatomic,strong)NSArray * articles;
@property(nonatomic,strong)NSDictionary * block_info;
@property(nonatomic,strong)NSArray * share;
@property(nonatomic,strong)NSDictionary * topic_list;
@property(nonatomic,strong)NSDictionary * info;
@end

@interface gallery : NSObject
@property(nonatomic,copy)NSString * promotion_img;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *end_time;
@property(nonatomic,strong)NSDictionary * article;
@end

@interface articelsModel : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *show_dsp;
@property(nonatomic,strong)NSArray * list;
@end

@interface listModel : NSObject
@property(nonatomic,strong)NSDictionary * article;
@property(nonatomic,copy)NSString *pk;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *ID;
@end

@interface sonArticleModel : NSObject
@property(nonatomic,copy)NSString *pk;
@property(nonatomic,copy)NSString *app_ids;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *auther_name;
@property(nonatomic,copy)NSString *weburl;
@property(nonatomic,strong)NSDictionary * special_info; //item_type;
@property(nonatomic,strong)NSArray * thumbnail_medias;
@end

@interface thumbNailModel : NSObject
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *m_url;
@property(nonatomic,copy)NSString *min_url;
@property(nonatomic,copy)NSString *w;
@property(nonatomic,copy)NSString *h;
@end









