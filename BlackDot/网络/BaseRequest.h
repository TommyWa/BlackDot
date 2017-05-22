//
//  BaseRequest.h
//  BlockDot
//
//  Created by wYt on 17/5/22.
//  Copyright © 2017年 WangYuetong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRequest : NSObject

@property (nonatomic , assign) NSInteger tag;
    
@property (nonatomic , strong) NSDictionary * userInfo;
    
@end
