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

    NSString *ivarName = [property ivarName];
    MARIvar *objIvar = [[MARIvar alloc] initWithName:ivarName typeEncoding:[property typeEncoding]];
    BOOL addIvarRet = [self addIvar:objIvar];
    if (!addIvarRet) {
        NSLog(@"add ivar '%@' failure", ivarName);
        return NO;
    }
    NSLog(@"add ivar '%@' success", ivarName);
    
    NSString *pName = [property name];
    SEL getterSel = sel_registerName([pName UTF8String]);
    
    id getIvarBlock = ^(__unsafe_unretained id objSelf) {
        Ivar ivar = class_getInstanceVariable([objSelf class], [ivarName UTF8String]);
        id testValue = object_getIvar(objSelf, ivar);
        NSLog(@"getter function get value : %@", testValue);
        return testValue;
    };
    IMP getIvarImp = imp_implementationWithBlock(getIvarBlock);
    NSString *getIvarSignature = [NSString stringWithFormat:@"%@@:", [property typeEncoding]];
    MARMethod *getterMethod = [MARMethod methodWithSelector:getterSel implementation:getIvarImp signature:getIvarSignature];
    BOOL addGetterMethodRet = [self addMethod:getterMethod];
    if (!addGetterMethodRet) {
        NSLog(@"add getterMethod failure with ivarname : %@", ivarName);
        return NO;
    }
    NSLog(@"add getterMethod success with ivarname : %@", ivarName);
    
    
    SEL setterSel = sel_registerName([[NSString stringWithFormat:@"set%@%@:", [pName substringToIndex:1].uppercaseString, [pName substringFromIndex:1]] UTF8String]);
    
    id setIvarBlock = ^(__unsafe_unretained id objSelf, id value) {
        Ivar ivar = class_getInstanceVariable([objSelf class], [ivarName UTF8String]);
        [objSelf willChangeValueForKey:pName];
        object_setIvar(objSelf, ivar, value);
        [objSelf didChangeValueForKey:pName];
        NSLog(@"setter funcaiton set '%@' value : %@", ivarName, value);
    };
    
    IMP setIvarImp = imp_implementationWithBlock(setIvarBlock);
    NSString *setIvarSignature = [NSString stringWithFormat:@"v@:%@", [property typeEncoding]];
    MARMethod *setterMethod = [MARMethod methodWithSelector:setterSel implementation:setIvarImp signature:setIvarSignature];
    BOOL addSetterMethodRet = [self addMethod:setterMethod];
    if (!addSetterMethodRet) {
        NSLog(@"add setter method failure with ivarname : %@", ivarName);
        return NO;
    }
    NSLog(@"add setter method success with ivarname : %@", ivarName);
    
    BOOL addPropertyRet = [property addToClass:_class];
    if (!addPropertyRet) {
        NSLog(@"add property failer with name : %@", pName);
        return NO;
    }
    NSLog(@"add property success with name : %@", pName);
    return YES;
}

- (BOOL)addProperty:(MARProperty *)property
{
    return [self addProperty:property autoSetterAndGetter:NO];
}

- (BOOL)addMethod:(MARMethod *)method
{
    if (!_class) {
        return NO;
    }
    return class_addMethod(_class, [method selector], [method implementation], [[method signature] UTF8String]);
}

- (Class)registerClass
{
    objc_registerClassPair(_class);
    return _class;
}

@end
