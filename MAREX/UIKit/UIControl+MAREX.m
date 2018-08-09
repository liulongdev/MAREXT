//
//  UIControl+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2018/3/30.
//  Copyright © 2018年 MAR. All rights reserved.
//

#import "UIControl+MAREX.h"
#import <objc/runtime.h>
static const char block_key;

@interface _MARUIControlBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);
@property (nonatomic, assign) UIControlEvents events;

- (id)initWithBlock:(void (^)(id sender))block events:(UIControlEvents)events;
- (void)invoke:(id)sender;

@end

@implementation _MARUIControlBlockTarget

- (id)initWithBlock:(void (^)(id))block events:(UIControlEvents)events {
    self = [super init];
    if (self) {
        _block = [block copy];
        _events = events;
    }
    return self;
}

- (void)invoke:(id)sender {
    if (_block) _block(sender);
}

@end

@implementation UIControl (MAREX)

- (void)mar_removeAllTargets {
    [[self allTargets] enumerateObjectsUsingBlock: ^(id object, BOOL *stop) {
        [self removeTarget:object action:NULL forControlEvents:UIControlEventAllEvents];
    }];
    [[self _mar_allUIControlBlockTargets] removeAllObjects];
}

- (void)mar_setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    if (!target || !action || !controlEvents) return;
    NSSet *targets = [self allTargets];
    for (id currentTarget in targets) {
        NSArray *actions = [self actionsForTarget:currentTarget forControlEvent:controlEvents];
        for (NSString *currentAction in actions) {
            [self removeTarget:currentTarget action:NSSelectorFromString(currentAction)
              forControlEvents:controlEvents];
        }
    }
    [self addTarget:target action:action forControlEvents:controlEvents];
}

- (void)mar_addBlockForControlEvents:(UIControlEvents)controlEvents
                           block:(void (^)(id))block {
    if (!controlEvents) return;
    _MARUIControlBlockTarget *target = [[_MARUIControlBlockTarget alloc]
                                       initWithBlock:block events:controlEvents];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
    NSMutableArray *targets = [self _mar_allUIControlBlockTargets];
    [targets addObject:target];
}

- (void)mar_setBlockForControlEvents:(UIControlEvents)controlEvents
                           block:(void (^)(id))block {
    [self mar_removeAllBlocksForControlEvents:UIControlEventAllEvents];
    [self mar_addBlockForControlEvents:controlEvents block:block];
}

- (void)mar_removeAllBlocksForControlEvents:(UIControlEvents)controlEvents {
    if (!controlEvents) return;
    
    NSMutableArray *targets = [self _mar_allUIControlBlockTargets];
    NSMutableArray *removes = [NSMutableArray array];
    for (_MARUIControlBlockTarget *target in targets) {
        if (target.events & controlEvents) {
            UIControlEvents newEvent = target.events & (~controlEvents);
            if (newEvent) {
                [self removeTarget:target action:@selector(invoke:) forControlEvents:target.events];
                target.events = newEvent;
                [self addTarget:target action:@selector(invoke:) forControlEvents:target.events];
            } else {
                [self removeTarget:target action:@selector(invoke:) forControlEvents:target.events];
                [removes addObject:target];
            }
        }
    }
    [targets removeObjectsInArray:removes];
}

- (NSMutableArray *)_mar_allUIControlBlockTargets {
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end
