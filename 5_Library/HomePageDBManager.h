//
//  HomePageDBManager.h
//  MyZaker
//
//  Created by Penny&Me on 16/6/28.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomePageButtonModel.h"
#import "ChooseModel.h"
#import "allDataModel.h"
#import "FMDatabase.h"
@class HomePageButtonModel;
@interface HomePageDBManager : NSObject
@property(nonatomic,strong) FMDatabase * dataBase;

+(HomePageDBManager *)sharedManager;

//添加一条数据
- (void)addCollectionItem:(sonsArrayModel *)item;

//查询所有收藏数据
- (void)selectAllFavorites:(void(^)(NSArray *array))finishBlock;

//判断是否收藏
- (void)isAppFavorite:(NSString *)appId flagBlock:(void (^)(BOOL flag))flagBlock;
- (void)isNewsFavorite:(NSString *)titleName flagBlock:(void (^)(BOOL flag))flagBlock;

//删除一条记录
- (void)deleteCollectionItem:(sonsArrayModel *)smodel;
@end


//@class CollectItem;
//@interface LFDBManager : NSObject
//
////获取单例对象
//+ (LFDBManager *)sharedManager;
//
////添加一条数据
//- (void)addCollectionItem:(CollectItem *)item;
//
////查询所有收藏数据
//- (void)selectAllFavorites:(void (^)(NSArray *array))finishBlock;
//
////判断是否已经收藏
///*
// @param appId:应用的id
// @param flagBlock:查询结束后调用的代码块
// */
//- (void)isAppFavorite:(NSString *)appId flagBlock:(void (^)(BOOL flag))flagBlock;
//
////删除一条记录
//- (void)deleteCollectApp:(NSString *)appId;
//
//
//@end
