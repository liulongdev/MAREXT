//
//  MARTouchID.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/18.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "MARTouchID.h"
#import <UIKit/UIDevice.h>

@implementation MARTouchID

+ (void)showTouchIDAuthenticationWithReason:(NSString * _Nonnull)reason completion:(void (^ _Nullable)(MARTouchIDResult result))completion {
    [self showTouchIDAuthenticationWithReason:reason fallbackTitle:nil completion:^(MARTouchIDResult result) {
        if (completion) completion(result);
    }];
}

+ (void)showTouchIDAuthenticationWithReason:(NSString * _Nonnull)reason fallbackTitle:(NSString * _Nullable)fallbackTitle completion:(void (^ _Nullable)(MARTouchIDResult))completion {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        if (completion) completion(MARTouchIDResultNotAvailable);
        return;
    }
    
    LAContext *context = [[LAContext alloc] init];
    
    [context setLocalizedFallbackTitle:fallbackTitle];
    
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL success, NSError *error) {
            if (success) {
                if (completion) completion(MARTouchIDResultSuccess);
            } else {
                switch (error.code) {
                    case LAErrorAuthenticationFailed:
                        if (completion) completion(MARTouchIDResultAuthenticationFailed);
                        break;
                    case LAErrorUserCancel:
                        if (completion) completion(MARTouchIDResultUserCancel);
                        break;
                    case LAErrorUserFallback:
                        if (completion) completion(MARTouchIDResultUserFallback);
                        break;
                    case LAErrorSystemCancel:
                        if (completion) completion(MARTouchIDResultSystemCancel);
                        break;
                    default:
                        if (completion) completion(MARTouchIDResultError);
                        break;
                }            }

        }];
    } else {
        switch (error.code) {
            case LAErrorPasscodeNotSet:
                if (completion) completion(MARTouchIDResultPasscodeNotSet);
                break;
            case LAErrorTouchIDNotAvailable:
                if (completion) completion(MARTouchIDResultNotAvailable);
                break;
            case LAErrorTouchIDNotEnrolled:
                if (completion) completion(MARTouchIDResultNotEnrolled);
                break;
            default:
                if (completion) completion(MARTouchIDResultError);
                break;
        }
    }
}

@end
