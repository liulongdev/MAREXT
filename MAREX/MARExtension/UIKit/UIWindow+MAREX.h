//
//  UIWindow+MAREX.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/18.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (MAREX)

/**
*  Take a screenshot of current window, without saving it
*
*  @return Returns the screenshot as an UIImage
*/
- (UIImage * _Nonnull)takeScreenshot;

/**
 *  Take a screenshot of current window and choose if save it or not
 *
 *  @param save YES to save, NO to don't save
 *
 *  @return Returns the screenshot as an UIImage
 */
- (UIImage * _Nonnull)takeScreenshotAndSave:(BOOL)save;

/**
 *  Take a screenshot of current window, choose if save it or not after a delay
 *
 *  @param delay      The delay, in seconds
 *  @param save       YES to save, NO to don't save
 *  @param completion Completion handler with the UIImage
 */
- (void)takeScreenshotWithDelay:(CGFloat)delay save:(BOOL)save completion:(void (^ _Nullable)(UIImage * _Nonnull screenshot))completion;

/**
 *  Show touch on screen. (Use BFShowTouchOnScreen macro)
 */
- (void)activateTouch;

/**
 *  Hide touch on screen. (Use BFHideTouchOnScreen macro)
 */
- (void)deactivateTouch;

- (UIImage * _Nonnull)touchImage;

@end
