//
//  HomePageDBManager.m
//  MyZaker
//
//  Created by Penny&Me on 16/6/28.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "HomePageDBManager.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"

@interface HomePageDBManager()
@property (nonatomic,strong)FMDatabaseQueue *queue;//数据库操作队列
@end

@implementation HomePageDBManager

+(HomePageDBManager *)sharedManager{
    static HomePageDBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        manager = [[HomePageDBManager alloc] init];
    });
    return manager;
}

-(instancetype)init{
    if (self = [super init]) {
        [self createDataBase];
    }
    return self;
}

- (void)createDataBase{
    NSString * path = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents/BlackJacker.db"];
    NSLog(@"%@",path);
    
    //创建队列
    self.queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    //创建表格
    [self.queue inDatabase:^(FMDatabase *db) {
        //创建表格执行语句
        NSString *createSql = @"create table if not exists BlackJacker (title varchar(255), pic varchar(255), large_pic varchar(255), api_url varchar(255), imageData blob)";
        BOOL ret = [db executeUpdate:createSql];
        if (ret) {
            NSLog(@"创建表格成功");
        }else{
            NSLog(@"创建表格失败%@",_dataBase.lastErrorMessage);
        }

    }];

}

//添加一条数据
- (void)addCollectionItem:(sonsArrayModel *)item{
    
    NSString *insertSql = @"insert into BlackJacker (title, pic, large_pic, api_url, imageData) values (?,?,?,?,?)";
    [self.queue inDatabase:^(FMDatabase *db) {
        NSData *data = UIImagePNGRepresentation(item.iconView);
        BOOL ret = [db executeUpdate:insertSql, item.title, item.pic, item.large_pic, item.api_url, data];
        if (!ret) {
            NSLog(@"表格添加出问题了%@",db.lastErrorMessage);
        }else{
            NSLog(@"收藏了%@",item.title);
        }
        
    }];
    
    
    
}

//查询所有收藏数据
- (void)selectAllFavorites:(void(^)(NSArray *array))finishBlock{
    [self.queue inDatabase:^(FMDatabase *db) {

       NSString *selectSql = @"select * from BlackJacker";
        FMResultSet *rs = [db executeQuery:selectSql];

        NSMutableArray * resultArray = [NSMutableArray array];
        while ([rs next]) {
            HomePageButtonModel * model = [[HomePageButtonModel alloc] init];
            model.title = [rs stringForColumn:@"title"];
            model.pic   = [rs stringForColumn:@"pic"];
            model.large_pic = [rs stringForColumn:@"large_pic"];
            model.api_url = [rs stringForColumn:@"api_url"];
            NSData * data = [rs dataForColumn:@"imageData"];
            model.iconView = [UIImage imageWithData:data];
            [resultArray addObject:model];

        }
        finishBlock(resultArray);
        [rs close];
    }];
    
}

//"pk": "310000",
//"title": "今日看点",
//"block_title": "今日看点",
//"is_end": "Y",
//"data_type": "",
//"list_icon": "",
//"list_stitle": "",
//"block_bg_key": "3",
//"no_offline_down": "N",
//"need_userinfo": "YES",
//"p_pk": "",
//"pic": "http://zkres.myzaker.com/data/image/logo/ipad3/1057.png",
//"large_pic": "http://zkres.myzaker.com/data/image/logo/ipad3/1057.png",
//"api_url": "http://iphone.myzaker.com/zaker/daily_hot.php?app_id_4=310000",
//"block_color": "#2e4260"




//判断是否收藏
- (void)isNewsFavorite:(NSString *)titleName flagBlock:(void (^)(BOOL flag))flagBlock{
    [self.queue inDatabase:^(FMDatabase *db) {
       NSString *sql = @"select * from BlackJacker where title=?";
        BOOL reslut = NO;
        FMResultSet * rs = [db executeQuery:sql,titleName];
        if ([rs next]) {
            reslut = YES;
        }
        flagBlock(reslut);
        [rs close];
    }];
}
- (void)isAppFavorite:(NSString *)appId flagBlock:(void (^)(BOOL flag))flagBlock
{
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
#if 0
        //第一种方式
        NSString *sql = @"select * from favorite where applicationId=?";
        
        BOOL result = NO;
        FMResultSet *rs = [db executeQuery:sql, appId];
        if ([rs next]) {
            result = YES;
        }
        
        flagBlock(result);
        
#endif
        
        //第二种方式
        //as cnt表示取别名
        NSString *sql = @"select count(*) as cnt from favorite where applicationId=?";
        
        FMResultSet *rs = [db executeQuery:sql, appId];
        NSInteger cnt = 0;
        if ([rs next]) {
            cnt = [rs intForColumn:@"cnt"];
        }
        
        if (cnt > 0) {
            //收藏过
            flagBlock(YES);
        }else{
            //没有收藏
            flagBlock(NO);
        }
        //关闭结果集
        [rs close];
        
    }];
    
}

//删除一条记录
//
- (void)deleteCollectionItem:( sonsArrayModel*)smodel{
    [self.queue inDatabase:^(FMDatabase *db) {
        NSString * deleteSql = @"delete from BlackJacker where title=?";
        BOOL ret = [db executeUpdate:deleteSql,smodel.title];
        if (!ret) {
            NSLog(@"删除失败:%@",db.lastErrorMessage);
        }
    }];
}






@end
