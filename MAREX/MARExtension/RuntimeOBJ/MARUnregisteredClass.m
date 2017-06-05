//
//  MARUnregisteredClass.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/6/1.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "MARUnregisteredClass.h"

@implementation MARUnregisteredClass

+ (instancetype)unregisteredClassWithName:(NSString *)name superClass:(Class)superClass
{
    return [[self alloc] initWithName:name superClass:superClass];
}

+ (instancetype)unregisteredClassWithName:(NSString *)name
{
    return [[self alloc] initWithName:name];
}

- (instancetype)initWithName:(NSString *)name superClass:(Class)superClass
{
    self = [super init];
    if (self) {
        _class = objc_allocateClassPair(superClass, [name UTF8String], 0);
        if (!_class) {
            return nil;
        }
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name
{
    self = [self initWithName:name superClass:nil];
    return self;
}

- (BOOL)addIvar:(MARIvar *)ivar
{
    if (!_class) {
        return NO;
    }
    const char * typeEncode = [[ivar typeEncoding] UTF8String];
    NSUInteger size, alignment;
    NSGetSizeAndAlignment(typeEncode, &size, &alignment);
    BOOL addIvarRet = class_addIvar(_class, [[ivar name] UTF8String], size, alignment, typeEncode);
    return addIvarRet;
}

- (BOOL)addProperty:(MARProperty *)property autoSetterAndGetter:(BOOL)autoed
{
    if (!_class) {
        return NO;
    }
    if (!autoed) {
        return [property addToClass:_class];
    }
    return NO;
//    MARIvar *objIvar = [[MARIvar alloc] initWithName:[property ivarName] typeEncoding:[property typeEncoding]];
}

- (BOOL)addProperty:(MARProperty *)property
{
    return [self addProperty:property autoSetterAndGetter:NO];
//    if (!_class) {
//        return NO;
//    }
//    return [property addToClass:_class];
}

- (BOOL)addMethod:(MARMethod *)method
{
    if (!_class) {
        return NO;
    }
    return class_addMethod(_class, [method selector], [method implementation], [[method signature] UTF8String]);
}

@end
