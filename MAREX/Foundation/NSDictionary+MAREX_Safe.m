//
//  NSDictionary+MAREX_Safe.m
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2018/9/21.
//  Copyright © 2018年 MAR. All rights reserved.
//

#import "NSDictionary+MAREX_Safe.h"
#import "NSObject+MAREX.h"

@implementation NSDictionary (MAREX_Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self mar_swizzleInstanceMethod:@selector(initWithObjects:forKeys:count:) with:@selector(mar_initWithObjects:forKeys:count:)];
        [self mar_swizzleClassMethod:@selector(dictionaryWithObjects:forKeys:count:) with:@selector(mar_dictionaryWithObjects:forKeys:count:)];
    });
}

+ (instancetype)mar_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key || !obj) {
            continue;
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self mar_dictionaryWithObjects:safeObjects forKeys:safeKeys count:j];
}

- (instancetype)mar_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key || !obj) {
            continue;
        }
        if (!obj) {
            obj = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self mar_initWithObjects:safeObjects forKeys:safeKeys count:j];
}

@end

@implementation NSMutableDictionary (MAREX_Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSDictionaryM");
        [class mar_swizzleInstanceMethod:@selector(setObject:forKey:) with:@selector(mar_setObject:forKey:)];
        [class mar_swizzleInstanceMethod:@selector(setObject:forKeyedSubscript:) with:@selector(mar_setObject:forKeyedSubscript:)];
    });
}

- (void)mar_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!aKey || !anObject) {
        return;
    }
    [self mar_setObject:anObject forKey:aKey];
}

- (void)mar_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!key || !obj) {
        return;
    }
    [self mar_setObject:obj forKeyedSubscript:key];
}

@end

