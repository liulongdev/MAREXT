//
//  NSObject+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "NSObject+MAREX.h"
#import <objc/runtime.h>

@implementation NSObject (MAREX)

@end

#pragma mark - KVO EX

static const char marobj_kvo_block_key;

@interface _MARNSObjectKVOBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(__weak id obj, id oldVal, id newVal);

- (id)initWithBlock:(void (^)(__weak id obj, id oldVal, id newVal))block;

@end

@implementation _MARNSObjectKVOBlockTarget

- (id)initWithBlock:(void (^)(__weak id, id, id))block
{
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (!self.block) return;
    
    BOOL isPrior = [[change objectForKey:NSKeyValueChangeNotificationIsPriorKey] boolValue];
    if (isPrior) return;
    
    NSKeyValueChange changeKind = [[change objectForKey:NSKeyValueChangeKindKey] integerValue];
    if (changeKind != NSKeyValueChangeSetting) return;
    
    id oldVal = [change objectForKey:NSKeyValueChangeOldKey];
    if (oldVal == [NSNull null]) oldVal = nil;
    
    id newVal = [change objectForKey:NSKeyValueChangeNewKey];
    if (newVal == [NSNull null]) newVal = nil;
    
    self.block(object, oldVal, newVal);
}

@end

@implementation NSObject (MAREX_KVO)

- (void)mar_addObserverBlockForKeyPath:(NSString *)keyPath block:(void (^)(id _Nonnull, id _Nullable, id _Nullable))block
{
    if (!keyPath || !block) return;
    _MARNSObjectKVOBlockTarget *target = [[_MARNSObjectKVOBlockTarget alloc] initWithBlock:block];
    NSMutableDictionary *dic = [self _mar_allNSObjectObserverBlocks];
    NSMutableArray *arr = dic[keyPath];
    if (!arr) {
        arr = [NSMutableArray new];
        dic[keyPath] = arr;
    }
    [arr addObject:target];
    [self addObserver:target forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:NULL];
}

- (void)mar_removeObserverBlocksForKeyPath:(NSString *)keyPath
{
    if (!keyPath) return;
    NSMutableDictionary *dic = [self _mar_allNSObjectObserverBlocks];
    NSMutableArray *arr = dic[keyPath];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeObserver:obj forKeyPath:keyPath];
    }];
    
    [dic removeObjectForKey:keyPath];
}

- (void)mar_removeObserverBlocks
{
    NSMutableDictionary *dic = [self _mar_allNSObjectObserverBlocks];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSArray *array, BOOL *stop) {
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self removeObserver:obj forKeyPath:key];
        }];
    }];
    
    [dic removeAllObjects];
}

- (NSMutableDictionary *)_mar_allNSObjectObserverBlocks {
    NSMutableDictionary *targets = objc_getAssociatedObject(self, &marobj_kvo_block_key);
    if (!targets) {
        targets = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &marobj_kvo_block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end
