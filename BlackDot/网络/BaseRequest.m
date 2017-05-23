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
        
        NSURLSession
        
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

- (void)addObserver:(id<BaseRequestObserver>)observer{
    
    if (nil == self.requestObservers) {
        
        self.requestObservers = [NSMutableArray array];
    }
    
    if (nil != observer) {
        
        [self.requestObservers addObject:observer];
    }
}


/// 以下方法由子类继承来覆盖默认值

//请求即将开始
- (void)requestWillStart
{
//    if (self.redirectBlock)
//    {
//        
//        [self.requstSessionTask setRedirectResponseBlock:self.redirectBlock];
//    }
//    
//    self.requestOperation.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
}

/// 请求成功的回调
- (void)requestDidCompleted
{
    
}

/// 请求失败的回调
- (void)requestDidFailed
{
    
}

/// 请求的URL
- (NSString *)requestUrl
{
    return @"";
}


/// 请求的连接超时时间，默认为20秒
- (NSTimeInterval)requestTimeoutInterval
{
    return 20;
}

/// 请求的参数列表
- (id)requestArgument
{
    return nil;
}

// 请求的string编码
- (NSStringEncoding)stringEncoding
{
    return NSUTF8StringEncoding;
}


/// Http请求的方法
- (SNRequestMethod)requestMethod
{
    return SNRequestMethodGet;
}


/// 在HTTP报头添加的自定义参数
- (NSDictionary *)requestHeaderFieldValueDictionary{
    
    //苏宁默认UA
    NSString *useragent = [self defaultUserAgentString];
    
    return @{@"User-Agent":useragent};
}

- (NSString *)defaultUserAgentString
{
    @synchronized (self) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        
        // Attempt to find a name for this application
        NSString *appName = [bundle objectForInfoDictionaryKey:@"CFBundleDisplayName"];
        if (!appName) {
            appName = [bundle objectForInfoDictionaryKey:@"CFBundleName"];
        }
        
        NSData *latin1Data = [appName dataUsingEncoding:NSUTF8StringEncoding];
        appName = [[NSString alloc] initWithData:latin1Data encoding:NSISOLatin1StringEncoding] ;
        
        // If we couldn't find one, we'll give up (and ASIHTTPRequest will use the standard CFNetwork user agent)
        if (!appName) {
            return nil;
        }
        
        NSString *appVersion = nil;
        NSString *marketingVersionNumber = [bundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        NSString *developmentVersionNumber = [bundle objectForInfoDictionaryKey:@"CFBundleVersion"];
        if (marketingVersionNumber && developmentVersionNumber) {
            if ([marketingVersionNumber isEqualToString:developmentVersionNumber]) {
                appVersion = marketingVersionNumber;
            } else {
                appVersion = [NSString stringWithFormat:@"%@ rv:%@",marketingVersionNumber,developmentVersionNumber];
            }
        } else {
            appVersion = (marketingVersionNumber ? marketingVersionNumber : developmentVersionNumber);
        }
        
        NSString *deviceName;
        NSString *OSName;
        NSString *OSVersion;
        NSString *locale = [[NSLocale currentLocale] localeIdentifier];
        
#if TARGET_OS_IPHONE
        UIDevice *device = [UIDevice currentDevice];
        deviceName = [device model];
        OSName = [device systemName];
        OSVersion = [device systemVersion];
        
#else
        deviceName = @"Macintosh";
        OSName = @"Mac OS X";
        
        // From http://www.cocoadev.com/index.pl?DeterminingOSVersion
        // We won't bother to check for systems prior to 10.4, since ASIHTTPRequest only works on 10.5+
        OSErr err;
        SInt32 versionMajor, versionMinor, versionBugFix;
        err = Gestalt(gestaltSystemVersionMajor, &versionMajor);
        if (err != noErr) return nil;
        err = Gestalt(gestaltSystemVersionMinor, &versionMinor);
        if (err != noErr) return nil;
        err = Gestalt(gestaltSystemVersionBugFix, &versionBugFix);
        if (err != noErr) return nil;
        OSVersion = [NSString stringWithFormat:@"%u.%u.%u", versionMajor, versionMinor, versionBugFix];
#endif
        
        // Takes the form "My Application 1.0 (Macintosh; Mac OS X 10.5.7; en_GB)"
        NSString *strAgent = [NSString stringWithFormat:@"%@ %@ (%@; %@ %@; %@) SNCLIENT", appName, appVersion, deviceName, OSName, OSVersion, locale];
        
        return strAgent;
        
    }
    return nil;
    
}

/// 构建自定义的UrlRequest，
/// 若这个方法返回非nil对象，会忽略requestUrl, requestArgument, requestMethod, requestSerializerType
- (NSURLRequest *)buildCustomUrlRequest
{
    return nil;
}


/// 用于检查JSON是否合法的对象
- (id)jsonValidator
{
    return nil;
}

/// 用于检查Status Code是否正常的方法
- (BOOL)statusCodeValidator
{
    NSInteger statusCode = [self responseStatusCode];
    if (statusCode >= 200 && statusCode <=299) {
        return YES;
    } else {
        return NO;
    }
}

- (id)responseJSONObject {
    
    id response = self.requstSessionTask.response;
    
    if (!response){
        
        //苏宁系统下发的json不标准，有时候AF解析不出来，这里再尝试解析一次
        
//        if ([self responseString].length > 0){
//            
//            response = [[self responseString] JSONValue2];
//        }
    }
    return response;
}

- (NSString *)responseString {
    
//    return self.requstSessionTask.response;
}

- (NSInteger)responseStatusCode {
    
    return self.requstSessionTask.;
}

- (NSDictionary *)responseHeaders {
    return self.requestOperation.response.allHeaderFields;
}

- (NSError *)error
{
    return self.requestOperation.error;
}



/// 当POST的内容带有文件等富文本时使用
- (AFConstructingBlock)constructingBodyBlock
{
    return nil;
}

- (AFURLConnectionOperationProgressBlock)downloadProgressBlock
{
    return nil;
}

- (void)setRequestOperation
{
    
}

// 4.1.0版本开始忽略接口缓存 by chupeng 2016/4/20
- (NSURLRequestCachePolicy)cachePolicy{
    
    return NSURLRequestReloadIgnoringLocalCacheData;
}
@end
















