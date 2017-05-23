//
//  BaseRequest.h
//  BlockDot
//
//  Created by wYt on 17/5/22.
//  Copyright © 2017年 WangYuetong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , RequestSerializerType) {
    
    RequestSerializerTypeHTTP = 0,
    RequestSerializerTypeJSON,
};

typedef NS_ENUM(NSInteger, SNRequestMethod) {

    SNRequestMethodGet = 0,
    SNRequestMethodPost,
    SNRequestMethodHead,
    SNRequestMethodPut,
    SNRequestMethodDelete,
    SNRequestMethodPatch
};


@class BaseRequest;

@protocol BaseRequestDelegate <NSObject>

- (void)requestFinished:(BaseRequest *)request;

- (void)requestFaild:(BaseRequest *)request;

@end

@protocol BaseRequestObserver <NSObject>

- (void)requestWillStart:(id)request;

- (void)requestWillStop:(id)request;

- (void)requestDidStop:(id)request;

@end

@interface BaseRequest : NSObject

@property (nonatomic , assign) NSInteger tag;
    
@property (nonatomic , strong) NSDictionary * userInfo;

@property (nonatomic , weak)id <BaseRequestDelegate>delegate;

@property (nonatomic , strong , readonly) NSDictionary * responseHeaders;

@property (nonatomic , copy , readonly) NSString * responseString;

@property (nonatomic , strong , readonly) id responseJSONObject;

@property (nonatomic , assign) NSInteger responseStatusCode;

@property (nonatomic , copy) void(^successCompletionBlock)(BaseRequest *);

@property (nonatomic , copy) void(^failurCompletionBlock)(BaseRequest *);

@property (nonatomic , readonly) NSError * error;

@property (nonatomic, strong) NSMutableArray *requestObservers;

@property (nonatomic, assign) NSURLRequestCachePolicy cachePolicy;

@property (nonatomic, assign) RequestSerializerType  requestSerializerType;

@property (nonatomic, strong) NSMutableArray *arrayRedirectedHosts;

- (void)startWithCompletionBlockWithSuccess:(void (^)(BaseRequest *request))success
                                    failure:(void (^)(BaseRequest *request))failure;

- (void)setCompletionBlockWithSuccess:(void (^)(BaseRequest *request))success
                              failure:(void (^)(BaseRequest *request))failure;

- (void)clearCompletionBlock;

- (void)start;

- (void)stop;

- (BOOL)isExecuting;

// Request Observer，可以看到 Request的start和stop
- (void)addObserver:(id<BaseRequestObserver>)observer;


/// 以下方法由子类继承来覆盖默认值

//请求即将开始,这里可以做最后一次初始化
- (void)requestWillStart;

/// 请求成功的回调
- (void)requestDidCompleted;

/// 请求失败的回调
- (void)requestDidFailed;

/// 请求的URL
- (NSString *)requestUrl;

// 请求的string编码
- (NSStringEncoding)stringEncoding;

/// 请求的连接超时时间，默认为20秒
- (NSTimeInterval)requestTimeoutInterval;

/// 请求的参数列表
- (id)requestArgument;

/// Http请求的方法
- (SNRequestMethod)requestMethod;

/// 请求的SerializerType
//- (SNRequestSerializerType)requestSerializerType;

/// 在HTTP报头添加的自定义参数
- (NSDictionary *)requestHeaderFieldValueDictionary;

/// 构建自定义的UrlRequest，
/// 若这个方法返回非nil对象，会忽略requestUrl, requestArgument, requestMethod, requestSerializerType
- (NSURLRequest *)buildCustomUrlRequest;


/// 用于检查JSON是否合法的对象,如果这里返回nil，那么就不会验证json
- (id)jsonValidator;

/// 用于检查Status Code是否正常的方法，如果返回yes，会继续进行json合法验证，
//  如果返回no，认为请求失败
- (BOOL)statusCodeValidator;

///// 当POST的内容带有文件等富文本时使用
//- (AFConstructingBlock)constructingBodyBlock;
//
////下载进度的处理block
//- (AFURLConnectionOperationProgressBlock)downloadProgressBlock;

@end





























