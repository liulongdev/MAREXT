//
//  MAREXMacro.h
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2017/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#ifndef MAREXMacro_h
#define MAREXMacro_h
#import <UIKit/UIKit.h>
#import <pthread.h>

#ifdef __cplusplus
#ifndef MAR_EXTERN_C_BEGIN
#define MAR_EXTERN_C_BEGIN extern "C" {
#define MAR_EXTERN_C_END }
#endif
#else
#ifndef MAR_EXTERN_C_BEGIN
#define MAR_EXTERN_C_BEGIN
#define MAR_EXTERN_C_END
#endif
#endif

//  颜色相关
#ifndef UIColorFromRGB
#define UIColorFromRGB(rgbValue,alphaValue)     [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]
#endif

#ifndef RGBHEX
#define RGBHEX(_hex)            [UIColor \
colorWithRed:((float)((_hex & 0xFF0000) >> 16))/255.0 \
green:((float)((_hex & 0xFF00) >> 8))/255.0 \
blue:((float)(_hex & 0xFF))/255.0 alpha:1]
#endif

#ifndef RGBAHEX
#define RGBAHEX(_hex, _alpha)   [UIColor \
colorWithRed:((float)((_hex & 0xFF0000) >> 16))/255.0 \
green:((float)((_hex & 0xFF00) >> 8))/255.0 \
blue:((float)(_hex & 0xFF))/255.0 alpha:_alpha]
#endif

//  布局相关
#define kScreenOnePixelSize     1.0f/[[UIScreen mainScreen] scale]
#define kScreenWIDTH            ([UIScreen mainScreen].bounds.size.width)
#define kScreenHEIGHT           ([UIScreen mainScreen].bounds.size.height)
#define kScreenMAXLENGTH        (MAX(kScreenWIDTH, kScreenHEIGHT))
#define kScreenMINLENGTH        (MIN(kScreenWIDTH, kScreenHEIGHT))
#define NeedScaleValue()        (kScreenWIDTH != 320)
#define kSCALE(value)           (value * (kScreenWIDTH/320.0f))
#define kFontSCALE(value)       [UIFont systemFontOfSize:kSCALE(value)]

#define IS_IPAD()               (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE()             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA()             ([[UIScreen mainScreen] scale] >= 2.0)

#define IS_IPHONE_35Size()      (IS_IPHONE() && kScreenMAXLENGTH < 568.0)
#define IS_IPHONE_40Size()      (IS_IPHONE() && kScreenMAXLENGTH == 568.0)
#define IS_IPHONE_47Size()      (IS_IPHONE() && kScreenMAXLENGTH == 667.0)
#define IS_IPHONE_55Size()      (IS_IPHONE() && kScreenMAXLENGTH >= 736.0)

//版本号相关
#define AppVersion              [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define AppBuildVersion         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APPDisplayName          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define APPBundleIdentifier     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]

#define DEVICEUUID              [[[UIDevice currentDevice] identifierForVendor] UUIDString]

#define CURRENT_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define IS_IOSORLATER(_value_) ((CURRENT_VERSION>=_value_) ? YES : NO)

#define IOS_VERSION_10ORLATER   (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_9_x_Max)?(YES):(NO)

#ifndef MARSYNTH_DUMMY_CLASS
#define MARSYNTH_DUMMY_CLASS(_name_) \
@interface MARSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation MARSYNTH_DUMMY_CLASS_ ## _name_ @end
#endif

/**
 *  单例宏方法
 *
 *  @param block
 *
 *  @return 返回单例
 */
#ifndef MARSINGLE_INSTANCE_USING_BLOCK
#define MARSINGLE_INSTANCE_USING_BLOCK(block)  \
static dispatch_once_t pred = 0;        \
static id _sharedObject = nil;          \
dispatch_once(&pred, ^{                 \
_sharedObject = block();            \
});                                     \
return _sharedObject;
#endif

#if defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
#define MARTARGET_OS_MAC 1
#elif TARGET_OS_SIMULATOR
#define MARTARGET_OS_iPhoneSIMULATOR 1
#elif defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
#define MARTARGET_OS_IPhone 1
#endif

/**
 Submits a block for asynchronous execution on a main queue and returns immediately.
 */
static inline void mar_dispatch_async_on_main_queue(void (^block)()) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

/**
 Submits a block for execution on a main queue and waits until the block completes.
 */
static inline void mar_dispatch_sync_on_main_queue(void (^block)()) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

#endif /* MAREXMacro_h */
