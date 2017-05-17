//
//  UIButton+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "UIButton+MAREX.h"
#import <objc/runtime.h>

static const char kAllButtonTargetsKey;

@interface _MARUIButtonTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;

- (void)invoke:(id)sender;

@end

@implementation _MARUIButtonTarget

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

@implementation UIButton (MAREX)

- (void)addActionBlock:(void (^)(id))block forState:(UIControlEvents)event
{
    if (!block) return;
    _MARUIButtonTarget *target = [[_MARUIButtonTarget alloc] initWithBlock:block];
    [self addTarget:target action:@selector(invoke:) forControlEvents:event];
    NSMutableArray *targets = [self _mar_allButtonTargets];
    [targets addObject:target];
}

- (void)removeAllActionBlocks
{
    NSMutableArray *targets = [self _mar_allButtonTargets];
    [targets enumerateObjectsUsingBlock:^(id  _Nonnull target, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeTarget:target action:@selector(invoke:) forControlEvents:UIControlEventAllEvents];
    }];
    [targets removeAllObjects];
}

- (NSMutableArray *)_mar_allButtonTargets
{
    NSMutableArray *targets = objc_getAssociatedObject(self, &kAllButtonTargetsKey);
    if (!targets) {
        targets = [NSMutableArray arrayWithCapacity:7];
        objc_setAssociatedObject(self, &kAllButtonTargetsKey, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end
