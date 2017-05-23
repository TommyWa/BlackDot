//
//  BaseRequest.m
//  BlockDot
//
//  Created by wYt on 17/5/22.
//  Copyright © 2017年 WangYuetong. All rights reserved.
//

#import "BaseRequest.h"
#import "NetWorkUtility.h"

@implementation BaseRequest

- (instancetype)init{
    
    if ( self = [super init]) {
        
        self.arrayRedirectedHosts = [NSMutableArray array];
        
    }
    return self;
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(BaseRequest *))success failure:(void (^)(BaseRequest *))failure{
    
    [self setCompletionBlockWithSuccess:success failure:failure];
    
    
}

- (void)setCompletionBlockWithSuccess:(void (^)(BaseRequest *))success failure:(void (^)(BaseRequest *))failure{
    
    self.successCompletionBlock = success;
    
    self.failurCompletionBlock = failure;
}

- (void)clearCompletionBlock{
    
    self.successCompletionBlock = nil;
    
    self.failurCompletionBlock = nil;
}

- (void)start{
    
    [self tellObserversRequestWillStart];
}

- (void)stop{
    
    [self tellObserversRequestWillStop];
    
    [self tellObserversRequestDidStop];
}



@end
