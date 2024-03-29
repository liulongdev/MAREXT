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
#import <sys/time.h>

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
#define NeedScaleValue()        (kScreenWIDTH != 375)
#define kSCALE(value)           (value * (kScreenWIDTH/375.0f))
#define kFontSCALE(value)       [UIFont systemFontOfSize:kSCALE(value)]

#define IS_IPAD()               (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE()             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA()             ([[UIScreen mainScreen] scale] >= 2.0)

#define IS_IPHONE_35Size()      (IS_IPHONE() && kScreenMAXLENGTH < 568.0)
#define IS_IPHONE_40Size()      (IS_IPHONE() && kScreenMAXLENGTH == 568.0)
#define IS_IPHONE_47Size()      (IS_IPHONE() && kScreenMAXLENGTH == 667.0)
#define IS_IPHONE_55Size()      (IS_IPHONE() && kScreenMAXLENGTH >= 736.0)

#if __has_include("UIDevice+MAREX.h")
#import "UIDevice+MAREX.h"
#define IS_NOTCH_SCREEN() ([UIDevice currentDevice].mar_isNotchScreen)
#define IS_iPhoneX_Device() IS_NOTCH_SCREEN()
#elif __has_include(<UIDevice+MAREX.h>)
#import <UIDevice+MAREX.h>
#define IS_NOTCH_SCREEN() ([UIDevice currentDevice].mar_isNotchScreen)
#define IS_iPhoneX_Device() IS_NOTCH_SCREEN()
#else
#define IS_iPhoneX_Device() NO
#endif

#define MARiPhoneX_BottomMargin (IS_iPhoneX_Device() && UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? 34 : 0)
#define MARiPhoneX_LeftMargin (IS_iPhoneX_Device() && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? 44 : 0)

// 关于iPhone11 x的适配
#define  MARAdjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)

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

// 循环引用
#ifndef weakify
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif

static inline BOOL MARIsEmpty(id thing) {
    return thing == nil || [thing isEqual:[NSNull null]]
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

/**
 Submits a block for asynchronous execution on a main queue and returns immediately.
 */
static inline void mar_dispatch_async_on_main_queue(void (^block)(void)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

/**
 Submits a block for execution on a main queue and waits until the block completes.
 */
static inline void mar_dispatch_sync_on_main_queue(void (^block)(void)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

static inline void MARBenchmark(void (^block)(void), void (^complete)(double ms)) {
    // <QuartzCore/QuartzCore.h> version  纳秒
    /*
     extern double CACurrentMediaTime (void);
     double begin, end, ms;
     begin = CACurrentMediaTime();
     block();
     end = CACurrentMediaTime();
     ms = (end - begin) * 1000.0;
     complete(ms);
     */
    
    // <sys/time.h> version  微秒
    struct timeval t0, t1;
    gettimeofday(&t0, NULL);
    block();
    gettimeofday(&t1, NULL);
    double ms = (double)(t1.tv_sec - t0.tv_sec) * 1e3 + (double)(t1.tv_usec - t0.tv_usec) * 1e-3;
    complete(ms);
}

#endif /* MAREXMacro_h */

/* 常用的宏定义
 #import <mach/mach_time.h>  // for mach_absolute_time() and friends
 // adapted from http://blog.bignerdranch.com/316-a-timing-utility/
 
 #import <CoreGraphics/CGBase.h>
 
 // Adapted from Will Shipley http://blog.wilshipley.com/2005/10/pimp-my-code-interlude-free-code.html
 static inline BOOL IsEmpty(id thing) {
 return thing == nil || [thing isEqual:[NSNull null]]
 || ([thing respondsToSelector:@selector(length)]
 && [(NSData *)thing length] == 0)
 || ([thing respondsToSelector:@selector(count)]
 && [(NSArray *)thing count] == 0);
 }
 
 static inline NSString *StringFromObject(id object) {
	if (object == nil || [object isEqual:[NSNull null]]) {
 return @"";
	} else if ([object isKindOfClass:[NSString class]]) {
 return object;
	} else if ([object respondsToSelector:@selector(stringValue)]){
 return [object stringValue];
	} else {
 return [object description];
	}
 }
 
 #pragma mark -
 #pragma mark Collections
 
 #define IDARRAY(...) (id []){ __VA_ARGS__ }
 #define IDCOUNT(...) (sizeof(IDARRAY(__VA_ARGS__)) / sizeof(id))
 
 #define ARRAY(...) [NSArray arrayWithObjects: IDARRAY(__VA_ARGS__) count: IDCOUNT(__VA_ARGS__)]
 
 #define DICT(...) DictionaryWithIDArray(IDARRAY(__VA_ARGS__), IDCOUNT(__VA_ARGS__) / 2)
 
 //The helper function unpacks the object array and then calls through to NSDictionary to create the dictionary:
 static inline NSDictionary *DictionaryWithIDArray(id *array, NSUInteger count) {
 id keys[count];
 id objs[count];
 
 for(NSUInteger i = 0; i < count; i++) {
 keys[i] = array[i * 2];
 objs[i] = array[i * 2 + 1];
 }
 
 return [NSDictionary dictionaryWithObjects: objs forKeys: keys count: count];
 }
 #define POINTERIZE(x) ((__typeof__(x) []){ x })
 #define NSVALUE(x) [NSValue valueWithBytes: POINTERIZE(x) objCType: @encode(__typeof__(x))]
 
 #pragma mark -
 #pragma mark Blocks
 
 #define BLOCK_SAFE_RUN(block, ...) block ? block(__VA_ARGS__) : nil
 
 #pragma mark -
 #pragma mark Logging
 
 #define LOG(fmt, ...) NSLog(@"%s: " fmt, __PRETTY_FUNCTION__, ## __VA_ARGS__)
 
 #ifdef DEBUG
 #define INFO(fmt, ...) LOG(fmt, ## __VA_ARGS__)
 #else
 // do nothing
 #define INFO(fmt, ...)
 #endif
 
 #define ERROR(fmt, ...) LOG(fmt, ## __VA_ARGS__)
 #define TRACE(fmt, ...) LOG(fmt, ## __VA_ARGS__)
 
 #define METHOD_NOT_IMPLEMENTED() NSAssert(NO, @"You must override %@ in a subclass", NSStringFromSelector(_cmd))
 
 #pragma mark -
 #pragma mark NSNumber
 
 #define NUM_INT(int) [NSNumber numberWithInt:int]
 #define NUM_FLOAT(float) [NSNumber numberWithFloat:float]
 #define NUM_BOOL(bool) [NSNumber numberWithBool:bool]
 
 #pragma mark -
 #pragma mark Transforms
 
 #define DEGREES_TO_RADIANS(degrees) degrees * M_PI / 180
 
 static inline void TimeThisBlock (void (^block)(void), NSString *message) {
 mach_timebase_info_data_t info;
 if (mach_timebase_info(&info) != KERN_SUCCESS) {
 block();
 return;
 };
 
 uint64_t start = mach_absolute_time ();
 block ();
 uint64_t end = mach_absolute_time ();
 uint64_t elapsed = end - start;
 
 uint64_t nanos = elapsed * info.numer / info.denom;
 LOG(@"Took %f seconds to %@", (CGFloat)nanos / NSEC_PER_SEC, message);
 }
 
 #pragma clang diagnostic push
 #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
 #pragma clang diagnostic pop
 
 -Warc-performSelector-leaks
 方法弃用告警
 -Wdeprecated-declarations
 不兼容指针类型
 -Wincompatible-pointer-types
 循环引用
 -Warc-retain-cycles
 未使用变量
 -Wunused-variable
 // see orders http://fuckingclangwarnings.com/

 */
