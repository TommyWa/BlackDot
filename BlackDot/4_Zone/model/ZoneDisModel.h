//
//  ZoneDisModel.h
//  MyZaker
//
//  Created by Penny&Me on 16/6/24.
//  Copyright © 2016年 WangYuetong. All rights reserved.

//发现

#import <Foundation/Foundation.h>

@interface ZoneDisModel : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSArray * list;
@end


@interface listsModel : NSObject
@property(nonatomic,strong)NSDictionary * listDict;
@end



@interface cellModel : NSObject
@property(nonatomic,copy)NSString * pk;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString *stitle;

@property(nonatomic,copy)NSString *pic;
@property(nonatomic,copy)NSString *large_pic;
@property(nonatomic,copy)NSString *api_url;

@property(nonatomic,copy)NSString * block_color;
@property(nonatomic,copy)NSString * subscribe_count;
@property(nonatomic,copy)NSString * post_count;
@end

