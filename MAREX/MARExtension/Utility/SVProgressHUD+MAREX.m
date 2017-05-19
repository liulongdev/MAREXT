//
//  SVProgressHUD+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2017/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "SVProgressHUD+MAREX.h"

#ifdef HASThirdClass_SVProgressHUD
@implementation SVProgressHUD (MAREX_EX)

+ (void) mar_showSuccessWithStatus:(NSString*)status duration:(CGFloat)duration
{
    [self setMinimumDismissTimeInterval:duration];
    [self showSuccessWithStatus:status];
}

+ (void) mar_showErrorWithStatus:(NSString*)status duration:(CGFloat)duration
{
    [self setMinimumDismissTimeInterval:duration];
    [self showErrorWithStatus:status];
}

+ (void) mar_showInfoWithStatus:(NSString*)status  duration:(CGFloat)duration
{
    [self setMinimumDismissTimeInterval:duration];
    [self showInfoWithStatus:status];
}
@end

#else

@implementation SVProgressHUD
+ (void) mar_showSuccessWithStatus:(NSString*)status duration:(CGFloat)duration{NSLog(@"%@", status);}
+ (void) mar_showErrorWithStatus:(NSString*)status duration:(CGFloat)duration{NSLog(@"%@", status);}
+ (void) mar_showInfoWithStatus:(NSString*)status  duration:(CGFloat)duration{NSLog(@"%@", status);}
@end

#endif

@implementation SVProgressHUD (MAREX)

@end
