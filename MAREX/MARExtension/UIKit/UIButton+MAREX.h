//
//  UIButton+MAREX.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MAREX)

/**
 The block that invoked when the event is triggered.
 */
- (void)addActionBlock:(void (^)(id sender))block forState:(UIControlEvents)event;

/**
 Remvoe all blocks
 */
- (void)removeAllActionBlocks;

@end
