//
//  MARMethod.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/6/5.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface MARMethod : NSObject


+ (id)methodWithObjCMethod: (Method)method;
+ (id)methodWithSelector: (SEL)sel implementation: (IMP)imp signature: (NSString *)signature;

- (id)initWithObjCMethod: (Method)method;
- (id)initWithSelector: (SEL)sel implementation: (IMP)imp signature: (NSString *)signature;

- (SEL)selector;
- (NSString *)selectorName;
- (IMP)implementation;
- (NSString *)signature;

// for ObjC method instances, sets the underlying implementation
// for selector/implementation/signature instances, just changes the pointer
- (void)setImplementation: (IMP)newImp;

// easy sending of arbitrary methods with arbitrary arguments
// a simpler alternative to NSInvocation etc.
// for simple cases where the return type is an id, use sendToTarget:
// for others, use the returnValue: variant and pass a pointer to storage
// (you can pass NULL if you don't care about the return value)
// all arguments MUST BE WRAPPED in MARRTARG, e.g.:
// [method sendToTarget: target, MARRTARG(arg1), MAROBJCARG(arg2)]
#define MAR_ARG_MAGIC_NUMBER 0xdeadbeef
#define MARRTARG(expr) MAR_ARG_MAGIC_NUMBER, @encode(__typeof__(expr)), (__typeof__(expr) []){ expr }
- (id)sendToTarget: (id)target, ...;

@end
