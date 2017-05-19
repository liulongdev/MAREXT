//
//  UIButton+MAREX.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MARSystemSound.h"

@interface UIButton (MAREX)

/**
 The block that invoked when the event is triggered.
 */
- (void)mar_addActionBlock:(void (^)(id sender))block forState:(UIControlEvents)event;

/**
 Remvoe all blocks
 */
- (void)mar_removeAllActionBlocks;

/**
 Set the sound for a particular control event (or events).
 */
- (void)mar_setSoundID:(MARAudioID)audioID forState:(UIControlEvents)event;

- (void)mar_setLocalSoundURL:(NSURL *)soundURL forState:(UIControlEvents)event;

@end
