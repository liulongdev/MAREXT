//
//  MARNetwork.m
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2018/8/15.
//  Copyright © 2018年 MAR. All rights reserved.
//

#import "MARNetwork.h"
#import "MARReachability.h"
@interface MARNetwork ()

@end

@implementation MARNetwork

#pragma mark - shareManager
+(instancetype)shareManager
{
    static MARNetwork * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self.class alloc] initWithBaseURL:nil];
    });
    
    return manager;
}

- (instancetype)init
{
    return [[self.class alloc] initWithBaseURL:nil];
}

+ (instancetype)instance
{
    return [[self.class alloc] initWithBaseURL:nil];
    static MARNetwork * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] initWithBaseURL:nil];
    });
    
    return manager;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
#ifdef AFNetworkingEnabel
    self = [super initWithBaseURL:url];
    if (!self) return nil;
    //  self.requestSerializer = [AFHTTPRequestSerializer serializer];
    //  self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    /**设置请求超时时间*/
    self.requestSerializer.timeoutInterval = 15;
    
    /**复杂的参数类型 需要使用json传值-设置请求内容的类型*/
    [self.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //    [self.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    self.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
    
    // post 对paramter进行加密，加工放入request的httpbody前的string格式
    [self.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
        if ([parameters isKindOfClass:[NSString class]]) {
            return parameters;
        }
        
        if ([[request.HTTPMethod uppercaseString] isEqualToString:@"POST"]||[[request.HTTPMethod uppercaseString] isEqualToString:@"DELETE"])
        {
            NSString *paramString = [parameters mar_modelToJSONString];
            //            NSString *decodeParamString = [MXRBase64 encodeBase64WithString:paramString];
            //            return decodeParamString;
            return paramString;
        }else if([[request.HTTPMethod uppercaseString] isEqualToString:@"GET"] ){
            if ([parameters isKindOfClass:[NSDictionary class]]) {
                return AFQueryStringFromParameters(parameters);
            }
            return AFQueryStringFromParameters([parameters mar_modelToJSONObject]);
        }else {
            if ([parameters isKindOfClass:[NSDictionary class]]) {
                return AFQueryStringFromParameters(parameters);
            }
            return AFQueryStringFromParameters([parameters mar_modelToJSONObject]);
        }
        
        return parameters;
    }];
    
    /**设置接受的类型*/
    [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html", nil]];
#else
    self = [super init];
    if (!self) return nil;
#endif
    return self;
}

- (NSURLSessionDataTask *)_mar_requestType:(MARNetworkRequestType)type
                                 urlString:(NSString *)urlString
                                parameters:(id)parameters
                                  progress:(MARNetworkProgress)progress
                                   success:(MARNetworkSuccess)success
                                   failure:(MARNetworkFailure)failure
                               loadingType:(MARNetworkLoadingType)loadingType     // 备用
                                    inView:(UIView *)inView
{
    NSURLSessionDataTask *task;
#ifdef AFNetworkingEnabel
    __weak __typeof(self) weakSelf = self;
    switch (type) {
        case MARNetworkRequestTypeGet:
        {
            task = [self GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                if (progress) progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                __strong __typeof(weakSelf) strongSelf = weakSelf;
                if (!strongSelf) return;
                if (success) {
                    success(task, responseObject);
                    //                    MARNetworkResponse *responce = [MARNetworkResponse mar_modelWithDictionary:responseObject];
                    //                    success(task, responce);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                __strong __typeof(weakSelf) strongSelf = weakSelf;
                if (!strongSelf) return;
                if (failure) {
                    failure(task, error);
                }
            }];
        }
            break;
        case MARNetworkRequestTypePost:
        {
            task = [self POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                if (progress) progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                __strong __typeof(weakSelf) strongSelf = weakSelf;
                if (!strongSelf) return;
                if (success) {
                    success(task, responseObject);
                    //                    MARNetworkResponse *responce = [MARNetworkResponse mar_modelWithDictionary:responseObject];
                    //                    success(task, responce);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                __strong __typeof(weakSelf) strongSelf = weakSelf;
                if (!strongSelf) return;
                if (failure) {
                    failure(task, error);
                }
            }];
        }
            break;
        case MARNetworkRequestTypeDelete:
        {
            task = [self DELETE:urlString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                __strong __typeof(weakSelf) strongSelf = weakSelf;
                if (!strongSelf) return;
                if (success) {
                    success(task, responseObject);
                    //                    MARNetworkResponse *responce = [MARNetworkResponse mar_modelWithDictionary:responseObject];
                    //                    success(task, responce);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                __strong __typeof(weakSelf) strongSelf = weakSelf;
                if (!strongSelf) return;
                if (failure) {
                    failure(task, error);
                }
            }];
        }
            break;
    }
#endif
    return task;
}

+ (NSURLSessionDataTask *)_mar_requestType:(MARNetworkRequestType)type
                                 urlString:(NSString *)urlString
                                parameters:(id)parameters
                                  progress:(MARNetworkProgress)progress
                                   success:(MARNetworkSuccess)success
                                   failure:(MARNetworkFailure)failure
                               loadingType:(MARNetworkLoadingType)loadingType     // 备用
                                    inView:(UIView *)inView;                      // 备用
{
    return [[self shareManager] _mar_requestType:type urlString:urlString parameters:parameters progress:progress success:success failure:failure loadingType:loadingType inView:inView];
}

- (NSURLSessionDataTask *)_mar_requestType:(MARNetworkRequestType)type
                                 urlString:(NSString *)urlString
                                parameters:(id)parameters
                                  progress:(MARNetworkProgress)progress
                                   success:(MARNetworkSuccess)success
                                   failure:(MARNetworkFailure)failure
{
    return [self _mar_requestType:type
                        urlString:urlString
                       parameters:parameters
                         progress:progress
                          success:success
                          failure:failure
                      loadingType:MARNetworkLoadingTypeNone
                           inView:nil];
}

+ (NSURLSessionDataTask *)_mar_requestType:(MARNetworkRequestType)type
                                 urlString:(NSString *)urlString
                                parameters:(id)parameters
                                  progress:(MARNetworkProgress)progress
                                   success:(MARNetworkSuccess)success
                                   failure:(MARNetworkFailure)failure
{
    return [self _mar_requestType:type
                        urlString:urlString
                       parameters:parameters
                         progress:progress
                          success:success
                          failure:failure
                      loadingType:MARNetworkLoadingTypeNone
                           inView:nil];
}

- (NSURLSessionDataTask *)mar_requestType:(MARNetworkRequestType)type
                                urlString:(NSString *)urlString
                               parameters:(id)parameters
                                 progress:(MARNetworkProgress)progress
                                  success:(MARNetworkSuccess)success
                                  failure:(MARNetworkFailure)failure
{
    return [self _mar_requestType:type
                        urlString:urlString
                       parameters:parameters
                         progress:progress
                          success:success
                          failure:failure];
}

+ (NSURLSessionDataTask *)mar_requestType:(MARNetworkRequestType)type
                                urlString:(NSString *)urlString
                               parameters:(id)parameters
                                 progress:(MARNetworkProgress)progress
                                  success:(MARNetworkSuccess)success
                                  failure:(MARNetworkFailure)failure
{
    return [self _mar_requestType:type
                        urlString:urlString
                       parameters:parameters
                         progress:progress
                          success:success
                          failure:failure];
}

- (NSURLSessionDataTask *)mar_get:(NSString *)urlString
                       parameters:(id)parameters
                         progress:(MARNetworkProgress)progress
                          success:(MARNetworkSuccess)success
                          failure:(MARNetworkFailure)failure
{
    return [self _mar_requestType:MARNetworkRequestTypeGet
                        urlString:urlString parameters:parameters
                         progress:progress
                          success:success
                          failure:failure];
}

- (NSURLSessionDataTask *)mar_get:(NSString *)urlString
                       parameters:(id)parameters
                          success:(MARNetworkSuccess)success
                          failure:(MARNetworkFailure)failure
{
    return [self _mar_requestType:MARNetworkRequestTypeGet
                        urlString:urlString
                       parameters:parameters
                         progress:nil
                          success:success
                          failure:failure];
}

+ (NSURLSessionDataTask *)mar_get:(NSString *)urlString
                       parameters:(id)parameters
                         progress:(MARNetworkProgress)progress
                          success:(MARNetworkSuccess)success
                          failure:(MARNetworkFailure)failure
{
    return [self _mar_requestType:MARNetworkRequestTypeGet
                        urlString:urlString parameters:parameters
                         progress:progress
                          success:success
                          failure:failure];
}

+ (NSURLSessionDataTask *)mar_get:(NSString *)urlString
                       parameters:(id)parameters
                          success:(MARNetworkSuccess)success
                          failure:(MARNetworkFailure)failure
{
    return [self _mar_requestType:MARNetworkRequestTypeGet
                        urlString:urlString
                       parameters:parameters
                         progress:nil
                          success:success
                          failure:failure];
}

- (NSURLSessionDataTask *)mar_post:(NSString *)urlString
                        parameters:(id)parameters
                          progress:(MARNetworkProgress)progress
                           success:(MARNetworkSuccess)success
                           failure:(MARNetworkFailure)failure
{
    return [self _mar_requestType:MARNetworkRequestTypePost
                        urlString:urlString
                       parameters:parameters
                         progress:progress
                          success:success
                          failure:failure];
}

+ (NSURLSessionDataTask *)mar_post:(NSString *)urlString
                        parameters:(id)parameters
                          progress:(MARNetworkProgress)progress
                           success:(MARNetworkSuccess)success
                           failure:(MARNetworkFailure)failure
{
    return [self _mar_requestType:MARNetworkRequestTypePost
                        urlString:urlString
                       parameters:parameters
                         progress:progress
                          success:success
                          failure:failure];
}

- (NSURLSessionDataTask *)mar_post:(NSString *)urlString
                        parameters:(id)parameters
                           success:(MARNetworkSuccess)success
                           failure:(MARNetworkFailure)failure
{
    return [self _mar_requestType:MARNetworkRequestTypePost
                        urlString:urlString
                       parameters:parameters
                         progress:nil
                          success:success
                          failure:failure];
}

+ (NSURLSessionDataTask *)mar_post:(NSString *)urlString
                        parameters:(id)parameters
                           success:(MARNetworkSuccess)success
                           failure:(MARNetworkFailure)failure
{
    return [self _mar_requestType:MARNetworkRequestTypePost
                        urlString:urlString
                       parameters:parameters
                         progress:nil
                          success:success
                          failure:failure];
}

- (NSURLSessionDataTask *)mar_delete:(NSString *)urlString
                          parameters:(id)parameters
                             success:(MARNetworkSuccess)success
                             failure:(MARNetworkFailure)failure
{
    return [self _mar_requestType:MARNetworkRequestTypeDelete
                        urlString:urlString
                       parameters:parameters
                         progress:nil
                          success:success
                          failure:failure];
}

+ (NSURLSessionDataTask *)mar_delete:(NSString *)urlString
                          parameters:(id)parameters
                             success:(MARNetworkSuccess)success
                             failure:(MARNetworkFailure)failure
{
    return [self _mar_requestType:MARNetworkRequestTypeDelete
                        urlString:urlString
                       parameters:parameters
                         progress:nil
                          success:success
                          failure:failure];
}

- (NSURLSessionDataTask*)mar_request:(NSURLRequest *)request
                             success:(void (^)(NSURLResponse *, id))success
                             failure:(void (^)(NSURLResponse *, id))failure
{
    NSURLSessionDataTask *datatask = nil;
#ifdef AFNetworkingEnabel
    __weak __typeof(self) weakSelf = self;
    datatask = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            if (!strongSelf) return;
            if (failure) {
                failure(response, error);
            }
        }
        else
        {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            if (!strongSelf) return;
            if (success) {
                success(response, responseObject);
            }
        }
    }];
    [datatask resume];
#endif
    return datatask;
}

+ (NSURLSessionDataTask*)mar_request:(NSURLRequest *)request
                             success:(void (^)(NSURLResponse *, id))success
                             failure:(void (^)(NSURLResponse *, id))failure
{
    return [[self shareManager] mar_request:request success:success failure:failure];
}

- (NSURLSessionUploadTask *)mar_uploadRequest:(NSURLRequest *)request
                                     fromData:(NSData *)bodyData
                                     progress:(MARNetworkProgress)progress
                                      success:(void (^)(NSURLResponse *, id))success
                                      failure:(void (^)(NSURLResponse *, NSError *))failure
{
    NSURLSessionUploadTask *uploadTask = nil;
#ifdef AFNetworkingEnabel
    __weak __typeof(self) weakSelf = self;
    uploadTask = [self uploadTaskWithRequest:request fromData:bodyData progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) progress(uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) return;
        if (error) {
            if (failure) {
                failure(response, error);
            }
        }
        else
        {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            if (!strongSelf) return;
            if (success) {
                success(response,responseObject);
            }
        }
        
    }];
    [uploadTask resume];
#endif
    return uploadTask;
}

+ (NSURLSessionUploadTask *)mar_uploadRequest:(NSURLRequest *)request
                                     fromData:(NSData *)bodyData
                                     progress:(MARNetworkProgress)progress
                                      success:(void (^)(NSURLResponse *, id))success
                                      failure:(void (^)(NSURLResponse *, NSError *))failure
{
    return [[self shareManager] mar_uploadRequest:request fromData:bodyData progress:progress success:success failure:failure];
}


/**
 网络请求是否可到达
 
 @return YES可达到，NO不可到达
 */
+(BOOL)mar_reachable{
#ifdef AFNetworkingEnabel
    return [AFNetworkReachabilityManager sharedManager].reachable;
#endif
    return [MARReachability reachability].isReachable;
}

@end
