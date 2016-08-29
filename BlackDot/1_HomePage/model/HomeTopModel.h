//
//  HomeTopModel.h
//  TestNetAPI
//
//  Created by Penny&Me on 16/6/19.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeTopModel : NSObject
@property(nonatomic,copy)NSString *pk;
@property(nonatomic,copy)NSString * promotion_img;
@property(nonatomic,copy)NSString * img_height;

@property(nonatomic,copy)NSString * img_width;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * end_time;

@property(nonatomic,copy)NSString * type;
@property(nonatomic,copy)NSString * pop_type;
@property(nonatomic,copy)NSString * hide_mask;

@property(nonatomic,copy)NSString * ads_stat_url;
@property(nonatomic,copy)NSString * stat_read_url;
@property(nonatomic,strong)NSDictionary *tag_info;
@property(nonatomic,copy)NSString * start_time;
@property(nonatomic,strong)NSDictionary * topic;

@property(nonatomic,strong)NSDictionary * article;
@property(nonatomic,strong)NSDictionary * block_info;
@end

@interface blockModel : NSObject
@property(nonatomic,copy)NSString * api_url;

@end
@interface articelModel : NSObject
@property(nonatomic,copy)NSString * weburl;

@end
@interface TagInfoDict : NSObject
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString * text;
@property(nonatomic,copy)NSString * image_url;

@property(nonatomic,copy)NSString * img_width;
@property(nonatomic,copy)NSString * img_height;
@property(nonatomic,copy)NSString * tag_position;

@property(nonatomic,copy)NSString * topic;
@property(nonatomic,copy)NSString * pop_type;
@property(nonatomic,copy)NSString * hide_mask;

@property(nonatomic,copy)NSString * ads_stat_url;
@property(nonatomic,copy)NSString * stat_read_url;
@property(nonatomic,strong)NSDictionary *tag_info;

@end
@interface TopicDict : NSObject
@property(nonatomic,copy)NSString *pk;
@property(nonatomic,copy)NSString *block_title;
@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *block_in_title;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *skey;

@property(nonatomic,copy)NSString * api_url;

@end

//"img_height": "360",
//"img_width": "640",
//"title": "实用攻略！上海迪士尼的正确打开方式",
//"end_time": "1466343180",
//"type": "topic",
//"pop_type": "",
//"hide_mask": "N",
//"ads_stat_url": "http://adm.myzaker.com/ads_stat.php?ads_id=57665bb79490cb8b6f00006e&position=my_subscriptions_promotion&click_stat=1",
//"stat_read_url": "http://adm.myzaker.com/ads_stat.php?ads_id=57665bb79490cb8b6f00006e&position=my_subscriptions_promotion_read&action=read",
//"tag_info": {
//    "type": "img",
//    "text": "专题",
//    "image_url": "http://zkres.myzaker.com/data/image/mark/topic_2x.png",
//    "img_height": "26",
//    "img_width": "46",
//    "tag_position": "1"
//},
//"start_time": "1466328600",
//"topic": {
//    "pk": "5761b3c1a07aecec66000009",
//    "block_title": "20160619生活大爆炸",
//    "title": "20160619生活大爆炸",
//    "block_in_title": "20160619生活大爆炸",
//    "type": "user",
//    "skey": "1466325943",
//    "api_url": "http://iphone.myzaker.com/zaker/topic.php?app_id=660&topic_id=5761b3c1a07aecec66000009"
//}
//},