//
//  ArticleModel.h
//  MyZaker
//
//  Created by Penny&Me on 16/7/1.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bigDataModel : NSObject
@property(nonatomic,strong)NSArray * share;
@property(nonatomic,strong)NSDictionary * info;
@property(nonatomic,strong)NSString * catalog;
@property(nonatomic,strong)NSArray * articles;
@property(nonatomic,strong)NSDictionary * ipadconfig;
@property(nonatomic,strong)NSDictionary *block_info;
@end


//articles
@interface ArticleModel : NSObject
@property(nonatomic,copy)NSString *pk;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *date;
@property(nonatomic,copy)NSString *auther_name;
@property(nonatomic,copy)NSString *page;
@property(nonatomic,copy)NSString *index;
@property(nonatomic,copy)NSString *weburl;
@property(nonatomic,copy)NSString *tpl_group;
@property(nonatomic,copy)NSString *tpl_style;
@property(nonatomic,copy)NSString *media_count;
@property(nonatomic,copy)NSString *is_full;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *full_arg;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString * thumbnail_mpic;
@property(nonatomic,copy)NSString * thumbnail_pic;
@property(nonatomic,strong)NSDictionary * special_info;
@property(nonatomic,strong)NSDictionary *block_info;
@end

@interface specialModel : NSObject
@property(nonatomic,copy)NSString *full_url;
@property(nonatomic,copy)NSString *list_dtime;
@end



//ipadConfig
@interface ipadconfig : NSObject
@property(nonatomic,strong)NSArray * pages;
@property(nonatomic,strong)NSArray * artcle_block_colors;
@property(nonatomic,strong)NSArray * only_text_page_bgcolors;
@end

@interface pagesModel : ipadconfig
@property(nonatomic,copy)NSString *pk;
@property(nonatomic,copy)NSString *page;
@property(nonatomic,copy)NSString *tpl_group;
@property(nonatomic,copy)NSString *tpl_type;
@property(nonatomic,copy)NSString *tpl_styletype;
@property(nonatomic,copy)NSString *tpl_style;
@property(nonatomic,copy)NSString *articles;
@property(nonatomic,strong)NSDictionary * diy;
@end

@interface diy : pagesModel
@property(nonatomic,copy)NSString *bgimage_url;
@property(nonatomic,copy)NSString *bgimage_frame;
@property(nonatomic,copy)NSString *title_h;
@property(nonatomic,copy)NSString *hide_title;
@end

//block_info
@interface blockInfoModel : NSObject
@property(nonatomic,copy)NSString *pic;
@property(nonatomic,copy)NSString *large_pic;
@property(nonatomic,copy)NSString *hidden_time;
@property(nonatomic,copy)NSString *need_userinfo;
@property(nonatomic,copy)NSString *block_title;
@property(nonatomic,copy)NSString *desktop_color_number;
@property(nonatomic,copy)NSString *use_original_icon;

@end



