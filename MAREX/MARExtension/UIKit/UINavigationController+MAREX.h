//
//  UINavigationController+MAREX.h
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2017/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (MAREX)

@end

@interface UINavigationBar (MAREX_Translucent)

/**
 *  Set the UINavigationBar to transparent or not
 *
 *  @param transparent YES to set it transparent, NO to not
 */
- (void)setTransparent:(BOOL)transparent;

/**
 *  Set the UINavigationBar to transparent or not
 *
 *  @param transparent YES to set it transparent, NO to not
 *  @param translucent A Boolean value indicating whether the navigation bar is translucent or not
 */
- (void)setTransparent:(BOOL)transparent translucent:(BOOL)translucent;

@end
