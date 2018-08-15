//
//  MARNetwork.h
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2018/8/15.
//  Copyright © 2018年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CGBase.h>
#if __has_include(<AFNetworking/AFNetworking.h>)
    #import <AFNetworking/AFNetworking.h>
    #define AFNetworkingEnabel
#elif __has_include("AFNetworking.h")
    #import "AFNetworking.h"
    #define AFNetworkingEnabel
#endif

typedef NS_ENUM(NSUInteger, MARNetworkRequestType)
{
    MARNetworkRequestTypeGet = 0,
    MARNetworkRequestTypePost = 1,
    MARNetworkRequestTypeDelete
};

typedef NS_ENUM(NSUInteger, MARNetworkLoadingType) {
    MARNetworkLoadingTypeNone = 0,
    MARNetworkLoadingTypeNormal
};

typedef void (^MARNetworkSuccess)(NSURLSessionTask *task, id responseObject);
typedef void (^MARNetworkFailure)(NSURLSessionTask *task, NSError *error);
typedef void (^MARNetworkProgress)(CGFloat progress);

#ifdef AFNetworkingEnabel
@interface MARNetwork : AFHTTPSessionManager
#else
@interface MARNetwork : NSObject
#endif


/**
 *  单例方法
 *
 *  @return 实例对象
 */
+ (instancetype)shareManager;

/**
 *  网络请求的类方法
 *
 *  @param type         get / post
 *  @param urlString    请求的地址
 *  @param parameters    请求的参数
 *  @param success      请求成功的回调 responseObj未经过处理
 *  @param failure      请求失败的回调
 *  @param progress 进度
 */
+ (NSURLSessionDataTask *)mar_requestType:(MARNetworkRequestType)type
                                urlString:(NSString *)urlString
                               parameters:(id)parameters
                                 progress:(MARNetworkProgress)progress
                                  success:(MARNetworkSuccess)success
                                  failure:(MARNetworkFailure)failure;


/**
 *  网络请求的类方法 get请求
 *
 *  @param urlString    请求的地址
 *  @param parameters    请求的参数
 *  @param success      请求成功的回调 responseObj未经过处理
 *  @param failure      请求失败的回调
 *  @param progress     进度
 */
+ (NSURLSessionDataTask *)mar_get:(NSString *)urlString
                       parameters:(id)parameters
                         progress:(MARNetworkProgress)progress
                          success:(MARNetworkSuccess)success
                          failure:(MARNetworkFailure)failure;

/**
 *  网络请求的类方法 get请求
 *
 *  @param urlString    请求的地址
 *  @param parameters    请求的参数
 *  @param success      请求成功的回调 responseObj未经过处理
 *  @param failure      请求失败的回调
 */
- (NSURLSessionDataTask *)mar_get:(NSString *)urlString
                       parameters:(id)parameters
                          success:(MARNetworkSuccess)success
                          failure:(MARNetworkFailure)failure;

/**
 *  网络请求的类方法 get请求
 *
 *  @param urlString    请求的地址
 *  @param parameters    请求的参数
 *  @param success      请求成功的回调 responseObj未经过处理
 *  @param failure      请求失败的回调
 */
+ (NSURLSessionDataTask *)mar_get:(NSString *)urlString
                       parameters:(id)parameters
                          success:(MARNetworkSuccess)success
                          failure:(MARNetworkFailure)failure;

/**
 *  网络请求的类方法 post请求
 *
 *  @param urlString    请求的地址
 *  @param parameters    请求的参数
 *  @param success      请求成功的回调 responseObj未经过处理
 *  @param failure      请求失败的回调
 *  @param progress     进度
 */
+ (NSURLSessionDataTask *)mar_post:(NSString *)urlString
                        parameters:(id)parameters
                          progress:(MARNetworkProgress)progress
                           success:(MARNetworkSuccess)success
                           failure:(MARNetworkFailure)failure;

/**
 *  网络请求的类方法 post请求
 *
 *  @param urlString    请求的地址
 *  @param parameters    请求的参数
 *  @param success      请求成功的回调 responseObj未经过处理
 *  @param failure      请求失败的回调
 
 */
- (NSURLSessionDataTask *)mar_post:(NSString *)urlString
                        parameters:(id)parameters
                           success:(MARNetworkSuccess)success
                           failure:(MARNetworkFailure)failure;
/**
 *  网络请求的类方法 post请求
 *
 *  @param urlString    请求的地址
 *  @param parameters    请求的参数
 *  @param success      请求成功的回调 responseObj未经过处理
 *  @param failure      请求失败的回调
 
 */
+ (NSURLSessionDataTask *)mar_post:(NSString *)urlString
                        parameters:(id)parameters
                           success:(MARNetworkSuccess)success
                           failure:(MARNetworkFailure)failure;

/**
 *  网络请求的类方法 delete请求
 *
 *  @param urlString    请求的地址
 *  @param parameters    请求的参数
 *  @param success      请求成功的回调 responseObj未经过处理
 *  @param failure      请求失败的回调
 
 */
+ (NSURLSessionDataTask *)mar_delete:(NSString *)urlString
                          parameters:(id)parameters
                             success:(MARNetworkSuccess)success
                             failure:(MARNetworkFailure)failure;

/**
 *  网络请求的类方法
 *
 *  @param request      request参数
 *  @param success      请求成功的回调 responseObj未经过处理
 *  @param failure      请求失败的回调
 */
+ (NSURLSessionDataTask *)mar_request:(NSURLRequest*)request
                              success:(void (^)(NSURLResponse *URLresponse, id responseObject))success
                              failure:(void (^)(NSURLResponse *URLresponse, id error))failure;

/**
 *  网络请求的类方法
 *
 *  @param request      request参数
 *  @param bodyData     上传的二进制对象
 *  @param progress     上传文件的完成情况回调
 *  @param success      请求成功的回调
 *  @param failure      请求失败的回调
 */
+ (NSURLSessionUploadTask *)mar_uploadRequest:(NSURLRequest *)request
                                     fromData:(NSData *)bodyData
                                     progress:(MARNetworkProgress)progress
                                      success:(void (^)(NSURLResponse *URLResponse, id responseObject))success
                                      failure:(void (^)(NSURLResponse *URLResponse, NSError *error))failure;


/**
 网络请求是否可到达
 
 @return YES可达到，NO不可到达
 */
+(BOOL)mar_reachable;

@end
