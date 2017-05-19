//
//  UIScrollView+MAREX.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/16.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (MAREX)

/**
 Scroll content to top with animation.
 */
- (void)mar_scrollToTop;

/**
 Scroll content to bottom with animation.
 */
- (void)mar_scrollToBottom;

/**
 Scroll content to left with animation.
 */
- (void)mar_scrollToLeft;

/**
 Scroll content to right with animation.
 */
- (void)mar_scrollToRight;

/**
 Scroll content to top.
 
 @param animated  Use animation.
 */
- (void)mar_scrollToTopAnimated:(BOOL)animated;

/**
 Scroll content to bottom.
 
 @param animated  Use animation.
 */
- (void)mar_scrollToBottomAnimated:(BOOL)animated;

/**
 Scroll content to left.
 
 @param animated  Use animation.
 */
- (void)mar_scrollToLeftAnimated:(BOOL)animated;

/**
 Scroll content to right.
 
 @param animated  Use animation.
 */
- (void)mar_scrollToRightAnimated:(BOOL)animated;

@end
