//
//  MARGlobalManager.m
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2017/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "MARGlobalManager.h"
#import <CoreLocation/CoreLocation.h>   // 定位权限用到   authority of location
#import <AVFoundation/AVFoundation.h>   // 摄像头权限用到 authority of camera
#import <Photos/Photos.h>               // 相册权限用到   authority of photo album
#import <AssetsLibrary/AssetsLibrary.h> // 相册权限用到   authority of photo album
#import "MAREXMacro.h"
#import "MARReachability.h"

/// 用到的宏
#ifndef kMARGlobalNotification
#define kMARGlobalNotification          @"kMARGlobalNotification"
#endif
static NSString *MARHasBeenOpened                   =   @"MARHasBeenOpened";
static NSString *MARHasBeenOpenedForCurrentVersion  =   @"";

@interface MARGlobalManager()

@property (nonatomic, strong) MARReachability *reachability;
@property (nonatomic, copy) void (^notifyChangeNetStatusBlock)(MARReachabilityNetStatus reachabilityNetStatus);

@end

@implementation MARGlobalManager

+ (instancetype)sharedInstance
{
    MARSINGLE_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (NSDateFormatter *)dataFormatter
{
    if (!_dataFormatter) {
        _dataFormatter = [[NSDateFormatter alloc] init];
        _dataFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    return _dataFormatter;
}

- (MARReachability *)reachability
{
    if (!_reachability) {
        _reachability = [MARReachability reachability];
    }
    return _reachability;
}

- (NSDictionary *)postNotif:(NSInteger)type data:(id)data object:(id)object
{
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    [info setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    if (data) {
        [info setObject:data forKey:@"data"];
    }
    if (object) {
        [info setObject:object forKey:@"object"];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMARGlobalNotification object:object userInfo:info];
    return info;
}

- (void)onFirstStart:(void (^)(BOOL))block
{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    BOOL hasBeenOpened = [user boolForKey:MARHasBeenOpened];
    if (!hasBeenOpened) {
        [user setBool:YES forKey:MARHasBeenOpened];
        [user synchronize];
    }
    
    block(!hasBeenOpened);
}

+ (void)onFirstStart:(void (^)(BOOL))block
{
    [MARGLOBALMANAGER onFirstStart:block];
}

- (void)onFirstStartForCurrentVersion:(void (^)(BOOL))block
{
    MARHasBeenOpenedForCurrentVersion = [NSString stringWithFormat:@"%@%@", MARHasBeenOpened, AppVersion];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasBeenOpenedForCurrentVersion = [defaults boolForKey:MARHasBeenOpenedForCurrentVersion];
    if (hasBeenOpenedForCurrentVersion != true) {
        [defaults setBool:YES forKey:MARHasBeenOpenedForCurrentVersion];
        [defaults synchronize];
    }
    
    block(!hasBeenOpenedForCurrentVersion);
}

+ (void)onFirstStartForCurrentVersion:(void (^)(BOOL))block
{
    [MARGLOBALMANAGER onFirstStartForCurrentVersion:block];
}

- (BOOL)isFirstStart
{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    BOOL isAPPFirstOpenFlag = [user boolForKey:MARHasBeenOpened];
    return isAPPFirstOpenFlag;
}

+ (BOOL)isFirstStart
{
    return [MARGLOBALMANAGER isFirstStart];
}

- (BOOL)isFirstStartForCurrentVersion
{
    MARHasBeenOpenedForCurrentVersion = [NSString stringWithFormat:@"%@%@", MARHasBeenOpened, AppVersion];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasBeenOpenedForCurrentVersion = [defaults boolForKey:MARHasBeenOpenedForCurrentVersion];
    return hasBeenOpenedForCurrentVersion;
}

+ (BOOL)isFirstStartForCurrentVersion
{
    return [MARGLOBALMANAGER isFirstStartForCurrentVersion];
}

- (void) userDefaultSetObject:(id)obj forKey:(NSString*)key
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:obj forKey:key];
    [userDefaults synchronize];
}

- (id) userDefaultObjectForKey:(NSString*)key
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

- (NSString*) userDefaultStringForKey:(NSString*)key
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:key];
}

- (BOOL)isLocationServiceOpen {
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        return NO;
    } else
        return YES;
}

- (void)gotoLocationSystemSetting
{
    NSURL *url = nil;
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
#else
    if (IS_IOSORLATER(8.0)) {
        url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
    } else {
        url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
    }
#endif
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (BOOL)isMessageNotificationServiceOpen
{
#if MARTARGET_OS_iPhoneSIMULATOR
    return YES;
#endif
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    return [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
#else
    if (IS_IOSORLATER(8.0)) {
        return [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
    } else {
        return [[UIApplication sharedApplication] enabledRemoteNotificationTypes] != UIRemoteNotificationTypeNone;
    }
#endif
}

- (void)gotoMessageNotificationServiceSystemSetting
{
    NSURL *url = nil;
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
#else
    if (IS_IOSORLATER(8.0)) {
        url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    } else {
        url = [NSURL URLWithString:@"prefs:root=NOTIFICATIONS_ID"];
    }
#endif
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

- (BOOL)isNetworkAvailable
{
    return self.reachability.isReachable;
//    return [GLobalRealReachability currentReachabilityStatus] != RealStatusNotReachable;
}

- (void)setNotifyChangeNetStatusBlock:(void (^)(MARReachabilityNetStatus))notifyChangeNetStatusBlock
{
    _notifyChangeNetStatusBlock = nil;
    _notifyChangeNetStatusBlock = [notifyChangeNetStatusBlock copy];
    if (notifyChangeNetStatusBlock == nil) {
        self.reachability = nil;
        return;
    }
    __block MARReachabilityNetStatus netStatus = MARReachabilityNetStatusNotReachbale;
    __weak MARGlobalManager* weakSelf = self;
    self.reachability.notifyBlock = ^(MARReachability *reachabilityB){
        netStatus = MARReachabilityNetStatusNotReachbale;
        if (reachabilityB.status == MARReachabilityStatusNone) {
            netStatus = MARReachabilityNetStatusNotReachbale;
        }
        else if (reachabilityB.status == MARReachabilityStatusWWAN)
        {
            switch (reachabilityB.wwanStatus) {
                case MARReachabilityWWANStatusNone:
                    netStatus = MARReachabilityNetStatusNotReachbale;
                    break;
                case MARReachabilityWWANStatus2G:
                    netStatus = MARReachabilityNetStatusWAN2G;
                    break;
                case MARReachabilityWWANStatus3G:
                    netStatus = MARReachabilityNetStatusWAN3G;
                    break;
                case MARReachabilityWWANStatus4G:
                    netStatus = MARReachabilityNetStatusWAN4G;
                    break;
            }
        }
        else if (reachabilityB.status == MARReachabilityStatusWiFi)
        {
            netStatus = MARReachabilityNetStatusWIFI;
        }
        if (weakSelf.notifyChangeNetStatusBlock) {
            weakSelf.notifyChangeNetStatusBlock(netStatus);
        }
    };
}

- (BOOL)isCameraServiceOpen
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        return NO;
    }
    else
        return YES;
}

- (void)checkCameraAuthorityCallBack:(void (^)(BOOL allowed))callBack
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        if (callBack) {
            callBack(NO);
        }
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined)
    {
        mar_dispatch_async_on_main_queue(^{
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (callBack) {
                    callBack(granted);
                }
            }];
        });
    }
    else
    {
        if (callBack) {
            callBack(YES);
        }
    }
}

- (BOOL)isPhotoAlbumServiceOpen
{
    return NO;
}

- (void)checkPhotoAlbumAuthorityCallBack:(void (^)(BOOL allowed))callBack
{
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (authStatus == PHAuthorizationStatusRestricted || authStatus == PHAuthorizationStatusDenied) {
        if (callBack) {
            callBack(NO);
        }
    }
    else if (authStatus == PHAuthorizationStatusNotDetermined)
    {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            mar_dispatch_async_on_main_queue(^{
                if (callBack) {
                    callBack(status == PHAuthorizationStatusAuthorized);
                }
            });
        }];
    }
    else
    {
        if (callBack) {
            callBack(YES);
        }
    }
#else
    if (IS_IOSORLATER(8.0)) {
        PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
        if (authStatus == PHAuthorizationStatusRestricted || authStatus == PHAuthorizationStatusDenied) {
            if (callBack) {
                callBack(NO);
            }
        }
        else if (authStatus == PHAuthorizationStatusNotDetermined)
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                mar_dispatch_async_on_main_queue(^{
                    if (callBack) {
                        callBack(status == PHAuthorizationStatusAuthorized);
                    }
                });
            }];
        }
        else
        {
            if (callBack) {
                callBack(YES);
            }
        }
    }
    else
    {
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied) {
            if (callBack) {
                callBack(NO);
            }
        }
        else if (authStatus == ALAuthorizationStatusNotDetermined)
        {
            if (callBack) {
                callBack(NO);
            }
        }
        else
        {
            if (callBack) {
                callBack(YES);
            }
        }
    }
#endif
}

@end
