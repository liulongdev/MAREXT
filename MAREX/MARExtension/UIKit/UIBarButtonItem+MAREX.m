//
//  UIBarButtonItem+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "UIBarButtonItem+MAREX.h"
#import <objc/runtime.h>

static const char mar_barBtn_block_key;

@interface _MARUIBarButtonItemBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;
- (void)invoke:(id)sender;

@end

@implementation _MARUIBarButtonItemBlockTarget

- (id)initWithBlock:(void (^)(id sender))block{
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)invoke:(id)sender {
    if (self.block) self.block(sender);
}

@end


@implementation UIBarButtonItem (MAREX)

- (void)setMar_actionBlock:(void (^)(id sender))block {
    _MARUIBarButtonItemBlockTarget *target = [[_MARUIBarButtonItemBlockTarget alloc] initWithBlock:block];
    objc_setAssociatedObject(self, &mar_barBtn_block_key, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setTarget:target];
    [self setAction:@selector(invoke:)];
}

- (void (^)(id)) mar_actionBlock {
    _MARUIBarButtonItemBlockTarget *target = objc_getAssociatedObject(self, &mar_barBtn_block_key);
    return target.block;
}


@end
