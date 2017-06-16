//
//  UINavigationController+MAREX.h
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2017/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (MAREX)

/**
 如果navi中从栈底开始遍历，发现有vc是class类型的，直接把上面的vc都推出栈
 
 @param clazz 1
 @param animated 1
 @return 1
 */
- (NSArray<__kindof UIViewController *> *)mar_popToViewControllerClazz:(Class)clazz Animated:(BOOL)animated;

@end

@interface UINavigationBar (MAREX_Translucent)

/**
 *  Set the UINavigationBar to transparent or not
 *
 *  @param transparent YES to set it transparent, NO to not
 */
- (void)mar_setTransparent:(BOOL)transparent;

/**
 *  Set the UINavigationBar to transparent or not
 *
 *  @param transparent YES to set it transparent, NO to not
 *  @param translucent A Boolean value indicating whether the navigation bar is translucent or not
 */
- (void)mar_setTransparent:(BOOL)transparent translucent:(BOOL)translucent;

@end
