//
//  TopicModel.h
//  MyZaker
//
//  Created by Penny&Me on 16/7/11.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicModel : NSObject
@property(nonatomic,copy)NSString *date;
@property(nonatomic,strong)NSArray * topic_list;
@end

@interface TopicListModel : NSObject
@property(nonatomic,copy)NSString *timeline;
@property(nonatomic,strong)NSArray * entrance;
@property(nonatomic,strong)NSArray * gallery;
@property(nonatomic,strong)NSArray * article;
@property(nonatomic,copy)NSString *next_url;
@end

@interface entranceArray : NSObject
@property(nonatomic,copy)NSString *pk;
@property(nonatomic,copy)NSString *topic;
@property(nonatomic,copy)NSString *title;
//@property(nonatomic,strong)NSDictionary * topicc;
@end

@interface galleryArray : NSObject
@property(nonatomic,copy)NSString *pk;
@property(nonatomic,copy)NSString *promotion_img;
@property(nonatomic,copy)NSString *img_height;
@property(nonatomic,copy)NSString *img_width;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *end_time;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *hide_mask;
@property(nonatomic,copy)NSString *ads_stat_url;
@property(nonatomic,strong)NSDictionary * article;
@end

@interface articelArray : NSObject
@property(nonatomic,copy)NSString *pk;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,strong)NSDictionary * article;

@end









