//
//  MARTouchID.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/18.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

/**
 *  Touch result enum
 */
typedef NS_ENUM(NSInteger, MARTouchIDResult) {
    /**
     *  Success
     */
    MARTouchIDResultSuccess = 0,
    /**
     *  Generic error
     */
    MARTouchIDResultError,
    /**
     *  Authentication failed
     */
    MARTouchIDResultAuthenticationFailed,
    /**
     *  User cancel
     */
    MARTouchIDResultUserCancel,
    /**
     *  User fallback
     */
    MARTouchIDResultUserFallback,
    /**
     *  System cancel
     */
    MARTouchIDResultSystemCancel,
    /**
     *  Passcode not set
     */
    MARTouchIDResultPasscodeNotSet,
    /**
     *  Not available
     */
    MARTouchIDResultNotAvailable,
    /**
     *  Not enrolled
     */
    MARTouchIDResultNotEnrolled
} NS_ENUM_AVAILABLE_IOS(8_0);

NS_CLASS_AVAILABLE_IOS(8_0) @interface MARTouchID : NSObject

/**
 *  Shows the TouchID alert
 *
 *  @param reason     Text to show in the alert
 *  @param completion Completion handler. It returns the TouchID result, from the TouchIDResult enum
 */
+ (void)showTouchIDAuthenticationWithReason:(NSString * _Nonnull)reason
                                 completion:(void (^ _Nullable)(MARTouchIDResult result))completion;

/**
 *  Shows the TouchID alert
 *
 *  @param reason        Text to show in the alert
 *  @param fallbackTitle Default title "Enter Password" is used when this property is left nil. If set to empty string, the button will be hidden
 *  @param completion    Completion handler. It returns the TouchID result, from the TouchIDResult enum
 */
+ (void)showTouchIDAuthenticationWithReason:(NSString * _Nonnull)reason
                              fallbackTitle:(NSString * _Nullable)fallbackTitle
                                 completion:(void (^ _Nullable)(MARTouchIDResult result))completion;

@end
