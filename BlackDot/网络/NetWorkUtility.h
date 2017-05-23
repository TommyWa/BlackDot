//
//  NetWorkUtility.h
//  BlackDot
//
//  Created by wYt on 17/5/22.
//  Copyright © 2017年 WangYuetong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"

@interface NetWorkUtility : NSObject

+ (BOOL)checkJSON:(id)json validatorJson:(id)validatorJson;

+ (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters;

@end



@interface BaseRequest (RequestObserver)

- (void)tellObserversRequestWillStart;

- (void)tellObserversRequestWillStop;

- (void)tellObserversRequestDidStop;

@end
