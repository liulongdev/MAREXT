//
//  MARGlobalManager.h
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2017/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD+MAREX.h"

#define MARGLOBALMANAGER [MARGlobalManager sharedInstance]

#define ShowSuccessMessage(message, durationValue) [SVProgressHUD mar_showSuccessWithStatus:message duration:durationValue]
#define ShowErrorMessage(message, durationValue) [SVProgressHUD mar_showErrorWithStatus:message duration:durationValue]
#define ShowInfoMessage(message, durationValue) [SVProgressHUD mar_showInfoWithStatus:message  duration:durationValue]
#define Duration_Normal 1.f

typedef NS_OPTIONS(NSUInteger, MARReachabilityNetStatus) {
    MARReachabilityNetStatusNotReachbale    = 0,
    MARReachabilityNetStatusWAN             = 0x0000000F,
    MARReachabilityNetStatusWAN2G           = 1 << 0,
    MARReachabilityNetStatusWAN3G           = 1 << 1,
    MARReachabilityNetStatusWAN4G           = 1 << 2,
    MARReachabilityNetStatusWIFI            = 1 << 4,
};

@interface MARGlobalManager : NSObject

@property (nonatomic, strong) NSDateFormatter *dataFormatter;

+ (instancetype)sharedInstance;

/**
 *  发出全局通知
 *
 *  @param type 通知类型
 *  @param data 数据
 *  @param object  通知来源对象，填self
 *  @return @{type:,data:,object:}
 */
- (NSDictionary*)postNotif:(NSInteger)type data:(id)data object:(id)object;

/**
 *  Executes a block on first start of the App for current version.
 *  Remember to execute UI instuctions on main thread
 *
 *  @param block The block to execute, returns isFirstStartForCurrentVersion
 */
- (void)onFirstStart:(void (^)(BOOL isFirstStart))block;
+ (void)onFirstStart:(void (^)(BOOL isFirstStart))block;

/**
 *  Executes a block on first start of the App.
 *  Remember to execute UI instuctions on main thread
 *
 *  @param block The block to execute, returns isFirstStart
 */
- (void)onFirstStartForCurrentVersion:(void (^)(BOOL isFirstStartForCurrentVersion))block;
+ (void)onFirstStartForCurrentVersion:(void (^)(BOOL isFirstStartForCurrentVersion))block;

/**
 *  Returns if is the first start of the App
 *
 *  @return Returns if is the first start of the App
 */
- (BOOL)isFirstStart;
+ (BOOL)isFirstStart;

/**
 *  Returns if is the first start of the App for current version
 *
 *  @return Returns if is the first start of the App for current version
 */
- (BOOL)isFirstStartForCurrentVersion;
+ (BOOL)isFirstStartForCurrentVersion;

/**
 wrapper NSUserDefaults simply
 */
- (void) userDefaultSetObject:(id)obj forKey:(NSString*)key;
- (id) userDefaultObjectForKey:(NSString*)key;
- (NSString*) userDefaultStringForKey:(NSString*)key;


/**
 Authority(permission) of location service
 */
- (BOOL)isLocationServiceOpen;

/**
 Go system setting to set Authority(permission) of location service
 */
- (void)gotoLocationSystemSetting;

/**
 Authority(permission) of remote notification service
 */
- (BOOL)isMessageNotificationServiceOpen;

/**
 Go system setting to set Authority(permission) of remote notification service
 */
- (void)gotoMessageNotificationServiceSystemSetting;

/**
 Return the result indicte wherther network is available
 */
- (BOOL)isNetworkAvailable;

/**
 When status of network change, will callback
 */
- (void)setNotifyChangeNetStatusBlock:(void (^)(MARReachabilityNetStatus netStatus))notifyChangeNetStatusBlock;

/**
 Authority(permission) of camera service
 */
- (BOOL)isCameraServiceOpen;

/**
 Check authority(permission) of camera, and will callback. If not be setted yet, will request and still callback
 */
- (void)checkCameraAuthorityCallBack:(void (^)(BOOL allowed))callBack;

/**
 Authority(permission) of photo album service
 */
- (BOOL)isPhotoAlbumServiceOpen;

/**
 Check authority(permission) of photoalbum, and will callback. (ios8 or later)If not be setted yet, will request and still callback
 */
- (void)checkPhotoAlbumAuthorityCallBack:(void (^)(BOOL allowed))callBack;

@end
