//
//  NSTimer+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2018/3/29.
//  Copyright © 2018年 MAR. All rights reserved.
//

#import "NSTimer+MAREX.h"

@implementation NSTimer (MAREX)

+ (void)_mar_ExecBlock:(NSTimer *)timer {
    if ([timer userInfo]) {
        void (^block)(NSTimer *timer) = (void (^)(NSTimer *timer))[timer userInfo];
        block(timer);
    }
}

+ (NSTimer *)mar_scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats {
    return [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(_mar_ExecBlock:) userInfo:[block copy] repeats:repeats];
}

+ (NSTimer *)mar_timerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats {
    return [NSTimer timerWithTimeInterval:seconds target:self selector:@selector(_mar_ExecBlock:) userInfo:[block copy] repeats:repeats];
}

@end
