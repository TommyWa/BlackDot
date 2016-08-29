//
//  EnjoyModel.h
//  WYTNews
//
//  Created by Penny&Me on 16/6/22.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnjoyModel : NSObject
@property(nonatomic, strong)NSDictionary * info;
@property(nonatomic, strong)NSArray * columns;
@end

@interface infoModel : NSObject
@property(nonatomic,copy)NSString * next_url;
@property(nonatomic, copy)NSString * page;
@property(nonatomic, copy)NSString *show_category;
@end

@interface columnsModel : NSObject
@property(nonatomic, copy)NSString * pk;
@property(nonatomic, copy)NSString * score;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString * build_banner;
@property(nonatomic, copy)NSString * rank;
@property(nonatomic,strong)NSDictionary * banner;
@property(nonatomic, copy)NSString *style;
@property(nonatomic, copy)NSString * show_more;
@property(nonatomic,strong)NSArray * items;
@end

@interface bannerModel : NSObject
@property(nonatomic, copy)NSString *url;
@property(nonatomic, copy)NSString * w;
@property(nonatomic, copy)NSString * h;
@property(nonatomic, copy)NSString *m_url;
@end

@interface itemModel : NSObject
@property(nonatomic, copy)NSString *pk;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *tag;
@property(nonatomic, copy)NSString *content;
@property(nonatomic, copy)NSString *share_content;
@property(nonatomic,strong)NSDictionary * pic;
@property(nonatomic, copy)NSString * tpl_cell_style;
@property(nonatomic, copy)NSString *click_stat_url;
@property(nonatomic, copy)NSString * type;
@property(nonatomic,strong)NSDictionary * article;
@end

@interface picModel : NSObject
@property(nonatomic, copy)NSString *url;
@property(nonatomic, copy)NSString *w;
@property(nonatomic, copy)NSString *h;
@property(nonatomic, copy)NSString *m_url;
@end

@interface articleModel : NSObject;
@property(nonatomic, copy)NSString *pk;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *app_ids;
@property(nonatomic, copy)NSString *date;
@property(nonatomic, copy)NSString *auther_name;
@property(nonatomic, copy)NSString *weburl;
@property(nonatomic, copy)NSString *is_full;
@property(nonatomic, copy)NSString *content;
@property(nonatomic, copy)NSString *full_url;
@property(nonatomic, copy)NSString *full_arg;
@end

