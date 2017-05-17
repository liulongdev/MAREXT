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
 *  是否是APP第一次打开应用
 *
 *  @return 第一次打开app返回YES，否则NO
 */
- (BOOL)isAPPFirstOpen;

/*
 简单封装 NSUserDefaults
 **/
- (void) userDefaultSetObject:(id)obj forKey:(NSString*)key;
- (id) userDefaultObjectForKey:(NSString*)key;
- (NSString*) userDefaultStringForKey:(NSString*)key;


- (BOOL)isLocationServiceOpen;

- (void)gotoLocationSystemSetting;

- (BOOL)isMessageNotificationServiceOpen;

- (void)gotoMessageNotificationServiceSystemSetting;

//- (BOOL)isNetworkAvailable;

@end
