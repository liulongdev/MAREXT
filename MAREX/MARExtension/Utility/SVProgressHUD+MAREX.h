//
//  SVProgressHUD+MAREX.h
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2017/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __has_include(<SVProgressHUD/SVProgressHUD.h>)
#import <SVProgressHUD/SVProgressHUD.h>
#define HASThirdClass_SVProgressHUD
#elif __has_include("SVProgressHUD.h")
#import "SVProgressHUD.h"
#define HASThirdClass_SVProgressHUD
#else
#undef HASThirdClass_SVProgressHUD
@interface SVProgressHUD : NSObject
+ (void) mar_showSuccessWithStatus:(NSString*)status duration:(CGFloat)duration;
+ (void) mar_showErrorWithStatus:(NSString*)status duration:(CGFloat)duration;
+ (void) mar_showInfoWithStatus:(NSString*)status  duration:(CGFloat)duration;
@end
#endif

#ifdef HASThirdClass_SVProgressHUD
@interface SVProgressHUD (MAREX_EX)
+ (void) mar_showSuccessWithStatus:(NSString*)status duration:(CGFloat)duration;
+ (void) mar_showErrorWithStatus:(NSString*)status duration:(CGFloat)duration;
+ (void) mar_showInfoWithStatus:(NSString*)status  duration:(CGFloat)duration;
@end
#endif


@interface SVProgressHUD (MAREX)

@end
