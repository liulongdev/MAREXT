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
        completion(result);
    }];
}

+ (void)showTouchIDAuthenticationWithReason:(NSString * _Nonnull)reason fallbackTitle:(NSString * _Nullable)fallbackTitle completion:(void (^ _Nullable)(MARTouchIDResult))completion {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        completion(MARTouchIDResultNotAvailable);
        return;
    }
    
    LAContext *context = [[LAContext alloc] init];
    
    [context setLocalizedFallbackTitle:fallbackTitle];
    
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL success, NSError *error) {
            if (success) {
                completion(MARTouchIDResultSuccess);
            } else {
                switch (error.code) {
                    case LAErrorAuthenticationFailed:
                        completion(MARTouchIDResultAuthenticationFailed);
                        break;
                    case LAErrorUserCancel:
                        completion(MARTouchIDResultUserCancel);
                        break;
                    case LAErrorUserFallback:
                        completion(MARTouchIDResultUserFallback);
                        break;
                    case LAErrorSystemCancel:
                        completion(MARTouchIDResultSystemCancel);
                        break;
                    default:
                        completion(MARTouchIDResultError);
                        break;
                }            }

        }];
    } else {
        switch (error.code) {
            case LAErrorPasscodeNotSet:
                completion(MARTouchIDResultPasscodeNotSet);
                break;
            case LAErrorTouchIDNotAvailable:
                completion(MARTouchIDResultNotAvailable);
                break;
            case LAErrorTouchIDNotEnrolled:
                completion(MARTouchIDResultNotEnrolled);
                break;
            default:
                completion(MARTouchIDResultError);
                break;
        }
    }
}

@end
