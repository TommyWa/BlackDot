//
//  NetWorkAgent.h
//  BlackDot
//
//  Created by wYt on 17/5/23.
//  Copyright © 2017年 WangYuetong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"
#import "AFNetworking.h"

@interface NetWorkAgent : NSObject

+ (NetWorkAgent *)sharedWorkAgent;

- (void)addRequest:(BaseRequest *)request;

- (void)cancelRequest:(BaseRequest *)request;

- (void)cancelAllRequests;

- (NSString *)buildRequestUrl:(BaseRequest *)request;


@end
