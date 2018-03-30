//
//  UIGestureRecognizer+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "UIGestureRecognizer+MAREX.h"
#import <objc/runtime.h>
#import "NSObject+MAREX.h"

static const char mar_gesture_block_key;

@interface _MARUIGestureRecognizerBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;
- (void)invoke:(id)sender;

@end

@implementation _MARUIGestureRecognizerBlockTarget

- (id)initWithBlock:(void (^)(id sender))block{
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)invoke:(id)sender {
    if (_block) _block(sender);
}

@end

@implementation UIGestureRecognizer (MAREX)

- (instancetype)initWithMarActionBlock:(void (^)(id sender))block {
    self = [self init];
    [self mar_addActionBlock:block];
    return self;
}

- (void)mar_addActionBlock:(void (^)(id sender))block {
    _MARUIGestureRecognizerBlockTarget *target = [[_MARUIGestureRecognizerBlockTarget alloc] initWithBlock:block];
    [self addTarget:target action:@selector(invoke:)];
    NSMutableArray *targets = [self _mar_allUIGestureRecognizerBlockTargets];
    [targets addObject:target];
}

- (void)mar_removeAllActionBlocks{
    NSMutableArray *targets = [self _mar_allUIGestureRecognizerBlockTargets];
    [targets enumerateObjectsUsingBlock:^(id target, NSUInteger idx, BOOL *stop) {
        [self removeTarget:target action:@selector(invoke:)];
    }];
    [targets removeAllObjects];
}

- (NSMutableArray *)_mar_allUIGestureRecognizerBlockTargets {
    NSMutableArray *targets = objc_getAssociatedObject(self, &mar_gesture_block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &mar_gesture_block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end


static const char MARGestureRecognizerBlockKey;
static const char MARGestureRecognizerDelayKey;
static const char MARGestureRecognizerShouldHandleActionKey;

@interface UIGestureRecognizer (MAREX_BlockInternal)

@property (nonatomic) BOOL mar_shouldHandleAction;

- (void)mar_handleAction:(UIGestureRecognizer *)recognizer;

@end

@implementation UIGestureRecognizer (MAREX_Block)

- (instancetype)initWithMarDelay:(NSTimeInterval)delay Handler:(void (^)(UIGestureRecognizer * _Nonnull, UIGestureRecognizerState, CGPoint))block
{
    self = [self initWithTarget:self action:@selector(mar_handleAction:)];
    if (!self) return nil;
    
    self.mar_handler = block;
    self.mar_handlerDelay = delay;
    
    return self;
}

- (instancetype)initWithMarHandler:(void (^)(UIGestureRecognizer * _Nonnull, UIGestureRecognizerState, CGPoint))block
{
    return (self = [self initWithMarDelay:0.0 Handler:block]);
}

- (void)mar_handleAction:(UIGestureRecognizer *)recognizer
{
    void (^handler)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) = recognizer.mar_handler;
    if (!handler) return;
    
    NSTimeInterval delay = self.mar_handlerDelay;
    CGPoint location = [self locationInView:self.view];
    void (^block)(void) = ^{
        if (!self.mar_shouldHandleAction) return;
        handler(self, self.state, location);
    };
    
    self.mar_shouldHandleAction = YES;
    
    [NSObject mar_gcdPerformAfterDelay:delay usingBlock:block];
}

+ (instancetype)mar_recognizerWithHandler:(void (^)(UIGestureRecognizer * _Nonnull, UIGestureRecognizerState, CGPoint))block
{
    return [[[self class] alloc] initWithMarDelay:0.0 Handler:block];
}

+ (instancetype)mar_recognizerWithDelay:(NSTimeInterval)delay handler:(void (^)(UIGestureRecognizer * _Nonnull, UIGestureRecognizerState, CGPoint))block
{
    return [[[self class] alloc] initWithMarDelay:delay Handler:block];
}

- (void)setMar_handler:(void (^)(UIGestureRecognizer * _Nonnull, UIGestureRecognizerState, CGPoint))mar_handler
{
    objc_setAssociatedObject(self, &MARGestureRecognizerBlockKey, mar_handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)mar_cancel
{
    self.mar_shouldHandleAction = NO;
}

- (void (^)(UIGestureRecognizer * _Nonnull, UIGestureRecognizerState, CGPoint))mar_handler
{
    return objc_getAssociatedObject(self, &MARGestureRecognizerBlockKey);
}

- (NSTimeInterval)mar_handlerDelay
{
    return [objc_getAssociatedObject(self, &MARGestureRecognizerDelayKey) doubleValue];
}

- (void)setMar_handlerDelay:(NSTimeInterval)mar_handlerDelay
{
    NSNumber *delayNum = mar_handlerDelay ? @(mar_handlerDelay) : nil;
    objc_setAssociatedObject(self, &MARGestureRecognizerDelayKey,delayNum, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)mar_shouldHandleAction
{
    return [objc_getAssociatedObject(self, &MARGestureRecognizerShouldHandleActionKey) boolValue];
}

- (void)setMar_shouldHandleAction:(BOOL)mar_shouldHandleAction
{
    objc_setAssociatedObject(self, &MARGestureRecognizerShouldHandleActionKey, @(mar_shouldHandleAction), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
