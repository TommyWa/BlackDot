//
//  NetWorkAgent.m
//  BlackDot
//
//  Created by wYt on 17/5/23.
//  Copyright © 2017年 WangYuetong. All rights reserved.
//

#import "NetWorkAgent.h"
#import "NetWorkUtility.h"

@interface NetWorkAgent ()

@property (nonatomic , strong)AFHTTPSessionManager * manager;

@property (nonatomic , strong)NSMutableDictionary * requestDictionary;

@end

@implementation NetWorkAgent

+ (NetWorkAgent *)sharedWorkAgent {
    
    static NetWorkAgent * netWorkAgent = nil;
    
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        
        netWorkAgent = [[NetWorkAgent alloc] init];
    });
    
    return netWorkAgent;
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.manager = [[AFHTTPSessionManager alloc] init];
        
        self.requestDictionary = [NSMutableDictionary dictionary];
        
        self.manager.operationQueue.maxConcurrentOperationCount = 4;
    }
    
    return self;
}

- (void)addRequest:(BaseRequest *)request{
    
    //自定义配置
//    if ([SNHttpConfigurer globalConfigurer].setupBlock)
//    {
//        [SNHttpConfigurer globalConfigurer].setupBlock();
//    }
    
    SNRequestMethod method = [request requestMethod];
    
    NSString *url = [self buildRequestUrl:request];
    
    id param = request.requestArgument;
    
//    AFConstructingBlock constructingBlock = [request constructingBodyBlock];
    
    //请求序列化类型
    if (request.requestSerializerType == RequestSerializerTypeHTTP) {
        
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    
    else if (request.requestSerializerType == RequestSerializerTypeJSON) {
        
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    //缓存策略
    self.manager.requestSerializer.cachePolicy = request.cachePolicy;
    
    //超时
    self.manager.requestSerializer.timeoutInterval = [request requestTimeoutInterval];
    
    //字符编码
    self.manager.requestSerializer.stringEncoding = [request stringEncoding];
    
    //自定义http头
    NSMutableDictionary *headerFieldValueDictionary = [[request requestHeaderFieldValueDictionary] mutableCopy];
    
    if (headerFieldValueDictionary != nil) {
        
        for (id httpHeaderField in headerFieldValueDictionary.allKeys) {
        
            id value = headerFieldValueDictionary[httpHeaderField];
            
            if ([httpHeaderField isKindOfClass:[NSString class]] && [value isKindOfClass:[NSString class]]) {
            
                [self.manager.requestSerializer setValue:(NSString *)value forHTTPHeaderField:(NSString *)httpHeaderField];
            
            } else {
            
                NSLog(@"Error, class of key/value in headerFieldValueDictionary should be NSString.");
            }
        }
    }
    
    //如果给了自定义的request,则使用自定义的request来生成operation
    
    if ([request buildCustomUrlRequest]){
 
        //目前没有根据请求方法做特殊处理，这里主要给SNWeexBaseRequest对接weex使用
        NSURLRequest *originRequest = [request buildCustomUrlRequest];
        
        NSMutableURLRequest *copyRequest = [originRequest mutableCopy];
        
        copyRequest.cachePolicy = [request cachePolicy];
        
    }

        //没有给自定义的request,则根据请求方法来生成request并发送请求,这里已经开始了请求的发送
    else
    {
        if (method == RequestMethodGet) {
            
            request.requstSessionTask = [self.manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
                
                                        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                                        }];
            
        }
        
        else if (method == RequestMethodPost) {
            
            request.requstSessionTask = [self.manager POST:url parameters:param constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
                
                                        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                                        }];
        }
        
        else {
        
            NSLog(@"Error, unsupport method type");
            
            return;
        }
        
    }
    
    
    
    [request requestWillStart];
    
    //加入请求管理的字典
    [self addOperation:request];
    
}

- (void)cancelRequest:(BaseRequest *)request {
    
    [request.requstSessionTask cancel];
    
    [self removeOperation:request.requstSessionTask];
    
    [request clearCompletionBlock];
}

- (void)cancelAllRequests {
    
    NSDictionary *copyRecord = [self.requestDictionary copy];
    
    for (NSString *key in copyRecord) {
    
        BaseRequest *request = copyRecord[key];
        
        [request stop];
    }
}

- (BOOL)checkResult:(BaseRequest *)request {

    BOOL result = [request statusCodeValidator];
    
    if (!result) {
    
        return result;
    }
    
    id validator = [request jsonValidator];
    
    if (validator != nil) {
    
        id json = [request responseJSONObject];
        
        
        if (!json){
            
            //苏宁系统下发的json不标准，有时候AF解析不出来，这里再尝试解析一次
            
//            if ([request responseString].length > 0){
//                
//                json = [[request responseString] JSONValue2];
//            }
        }
        
        result = [NetWorkUtility checkJSON:json validatorJson:validator];
    }
    return result;
}


- (void)handleRequestResult:(NSURLSessionTask *)operation {
    
    NSString *key = [self requestHashKey:operation];
    
    BaseRequest *request = self.requestDictionary[key];
    
    if (request) {
        
        BOOL succeed = [self checkResult:request];
        
        if (succeed) {
#if DEBUG
            NSString *debugString = @"";
            NSString *urlString = [request requestUrl];
            
            //NSLog中文unicode问题修改
            NSString *requestArgumentDesc = [[request requestArgument] description];
            if (requestArgumentDesc) {
                requestArgumentDesc = [NSString stringWithCString:[requestArgumentDesc cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
            }
            
            NSLog(@"\n=============================================================================================begin");
            NSLog(@"request finished \n class = %@ \n url = %@ \n params = %@ \n statusCode = %d \n Response = \n %@", NSStringFromClass([request class]), urlString, requestArgumentDesc, [request responseStatusCode], [[request responseString] formatJSON]);
            NSLog(@"\n=============================================================================================end\n");
#endif
            
//            if ([SNHttpLogger sharedHttpLogger].bCatchLog)
//            {
//                NSString *urlString = [request requestUrl];
//                NSString *debugString = [NSString stringWithFormat:@"\n=============================================================================================begin \n request finished \n class = %@ \n url = %@ \n params = %@ \n statusCode = %d \n Response = \n %@ \n=============================================================================================end\n", NSStringFromClass([request class]), urlString, [request requestArgument], [request responseStatusCode], [[request responseString] formatJSON]];
//                [[SNHttpLogger sharedHttpLogger] catchLog:debugString];
//            }
//            
            [request tellObserversRequestWillStop];
            [request requestDidCompleted];
            [request responseHeaders]; // !!! 登录失效处理
            
            if (request.delegate != nil && [request.delegate respondsToSelector:@selector(requestFinished:)]) {
                [request.delegate requestFinished:request];
            }
            if (request.successCompletionBlock) {
                request.successCompletionBlock(request);
            }
            [request tellObserversRequestDidStop];
        } else {
            
#if DEBUG
            NSString *debugString = @"";
            NSString *urlString = [request requestUrl];
            
            NSLog(@"\n=============================================================================================begin\n");
            NSLog(@"request failed \n class = %@ \n url = %@ \n params = %@ \n statusCode = %d \n Response = \n %@", NSStringFromClass([request class]), urlString, [request requestArgument], [request responseStatusCode], [[request responseString] formatJSON]);
            NSLog(@"\n=============================================================================================end\n");
#endif
//            if ([SNHttpLogger sharedHttpLogger].bCatchLog)
//            {
//                NSString *urlString = [request requestUrl];
//                NSString *debugString = [NSString stringWithFormat:@"\n=============================================================================================begin \n request failed \n class = %@ \n url = %@ \n params = %@ \n statusCode = %d \n Response = \n %@ \n=============================================================================================end\n", NSStringFromClass([request class]), urlString, [request requestArgument], [request responseStatusCode], [[request responseString] formatJSON]];
//                [[SNHttpLogger sharedHttpLogger] catchLog:debugString];
//            }
            
            [request tellObserversRequestWillStop];
            [request requestDidFailed];
            [request responseHeaders]; // !!! 登录失效处理

            //            if (request.delegate != nil && [request.delegate respondsToSelector:@selector(requestFailed:)]) {
//                [request.delegate requestFailed:request];
//            }
//
//            if (request.failureCompletionBlock) {
//                request.failureCompletionBlock(request);
//            }

            [request tellObserversRequestDidStop];
        }
    }
    
    [self removeOperation:operation];
    
    [request clearCompletionBlock];
}


- (void)addOperation:(BaseRequest *)request {
    
    if (request.requstSessionTask != nil) {
        
        NSString *key = [self requestHashKey:request.requstSessionTask];
        
        @synchronized(self) {
        
            self.requestDictionary[key] = request;
        }
    }
}

- (NSString *)requestHashKey:(NSURLSessionTask *)operation {
    
    NSString *key = [NSString stringWithFormat:@"%lu", (unsigned long)[operation hash]];
    
    return key;
}

- (void)removeOperation:(NSURLSessionTask *)operation {
    
    NSString *key = [self requestHashKey:operation];
    
    @synchronized(self) {
    
        [self.requestDictionary removeObjectForKey:key];
    }
    NSLog(@"Request queue size = %lu", (unsigned long)[self.requestDictionary count]);
}



@end
