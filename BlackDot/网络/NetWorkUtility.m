//
//  NetWorkUtility.m
//  BlackDot
//
//  Created by wYt on 17/5/22.
//  Copyright © 2017年 WangYuetong. All rights reserved.
//

#import "NetWorkUtility.h"

@implementation NetWorkUtility

+ (BOOL)checkJSON:(id)json validatorJson:(id)validatorJson{
    
    if ([json isKindOfClass:[NSDictionary class]] && [validatorJson isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary * dict = json;
        
        NSDictionary * validator = validatorJson;
        
        BOOL result = YES;
        
        NSEnumerator * enumerator = [validator keyEnumerator];
        
        NSString * key;
        
        while ((key = [enumerator nextObject]) != nil) {
        
            id value = dict[key];
            
            id format = validator[key];
            
            if ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSArray class]]) {
                
                result = [self checkJSON:value validatorJson:format];
                
                if (!result) {
                
                    break;
                }
                
            } else {
                
                if ([value isKindOfClass:format] == NO && [value isKindOfClass:[NSNull class]] == NO) {
                    
                    result = NO;
                    
                    break;
                }
            }
        }
        return result;
        
    } else if ([json isKindOfClass:[NSArray class]] && [validatorJson isKindOfClass:[NSArray class]]) {
        
        NSArray * validatorArray = (NSArray *)validatorJson;
        
        if (validatorArray.count > 0) {
        
            NSArray * array = json;
            
            NSDictionary * validator = validatorJson[0];
            
            for (id item in array) {
            
                BOOL result = [self checkJSON:item validatorJson:validator];
                
                if (!result) {
                
                    return NO;
                }
            }
        }
        return YES;
        
    } else if ([json isKindOfClass:validatorJson]) {
        
        return YES;
        
    } else {
        
        return NO;
    }

}

+ (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters {
    
    NSString *filteredUrl = originUrlString;
    
    NSString *paraUrlString = [self urlParametersStringFromParameters:parameters];
    
    if (paraUrlString && paraUrlString.length > 0) {
        
        if ([originUrlString rangeOfString:@"?"].location != NSNotFound) {
        
            filteredUrl = [filteredUrl stringByAppendingString:paraUrlString];
        
        } else {
    
            filteredUrl = [filteredUrl stringByAppendingFormat:@"?%@", [paraUrlString substringFromIndex:1]];
        }
        return filteredUrl;

    } else {
        return originUrlString;
    }
}

+ (NSString *)urlParametersStringFromParameters:(NSDictionary *)parameters {
    
    NSMutableString *urlParametersString = [[NSMutableString alloc] initWithString:@""];
    
    if (parameters && parameters.count > 0) {
        
        for (NSString *key in parameters) {
            
            NSString *value = parameters[key];
            
            value = [NSString stringWithFormat:@"%@",value];
            
            value = [self urlEncode:value];
            
            [urlParametersString appendFormat:@"&%@=%@", key, value];
        }
    }
    return urlParametersString;
}

+ (NSString*)urlEncode:(NSString*)str {
    //different library use slightly different escaped and unescaped set.
    //below is copied from AFNetworking but still escaped [] as AF leave them for Rails array parameter which we don't use.
    //https://github.com/AFNetworking/AFNetworking/pull/555
 
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)str, CFSTR("."), CFSTR(":/?#[]@!$&'()*+,;="), kCFStringEncodingUTF8);
    
    return result;
}

@end




@implementation BaseRequest(RequestObserver)

- (void)tellObserversRequestWillStart{
    
    for (id<BaseRequestObserver> observer in self.requestObservers) {
        
        if ([observer respondsToSelector:@selector(requestWillStart:)]) {
        
            [observer requestWillStart:self];
        }
    }
}

- (void)tellObserversRequestWillStop{
    
    for (id<BaseRequestObserver> observer in self.requestObservers) {
    
        if ([observer respondsToSelector:@selector(requestWillStop:)]) {
        
            [observer requestWillStop:self];
        }
    }
    
}

- (void)tellObserversRequestDidStop{
    
    for (id<BaseRequestObserver> observer in self.requestObservers) {
        
        if ([observer respondsToSelector:@selector(requestDidStop:)]) {
        
            [observer requestDidStop:self];
        }
    }
    
}

@end
