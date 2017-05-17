//
//  MARGlobalManager.m
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2017/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "MARGlobalManager.h"
#import <CoreLocation/CoreLocation.h>
#import "MAREXMacro.h"

/// 用到的宏
#ifndef kMARGlobalNotification
#define kMARGlobalNotification          @"kMARGlobalNotification"
#endif
static NSString * const kMarAppFirstOpenKey = @"kMarAppFirstOpenKey";

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

- (BOOL)isAPPFirstOpen
{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    BOOL isAPPFirstOpenFlag = [user boolForKey:kMarAppFirstOpenKey];
    if (!isAPPFirstOpenFlag) {
        [user setBool:YES forKey:kMarAppFirstOpenKey];
        [user synchronize];
    }
    return isAPPFirstOpenFlag;
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

//- (BOOL)isNetworkAvailable
//{
//    return [GLobalRealReachability currentReachabilityStatus] != RealStatusNotReachable;
//}

@end
