//
//  NSObject+MAR_Observer.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/24.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "NSObject+MAR_Observer.h"
#import <objc/runtime.h>
#import <objc/message.h>

typedef NS_ENUM(int, MARObserverContext) {
    MARObserverContextKey,
    MARObserverContextKeyWithChange,
    MARObserverContextManyKeys,
    MARObserverContextManyKeysWithChange
};

@interface _MARObserver : NSObject  {
    BOOL _isObserving;
}

@property (nonatomic, readonly, unsafe_unretained) id observee;
@property (nonatomic, readonly) NSMutableArray *keyPaths;
@property (nonatomic, readonly) id task;
@property (nonatomic, readonly) MARObserverContext context;

- (id)initWithObservee:(id)observee keyPaths:(NSArray *)keyPaths context:(MARObserverContext)context task:(id)task;

@end

static void *MARObserverBlocksKey = &MARObserverBlocksKey;
static void *MARBlockObservationContext = &MARBlockObservationContext;

@implementation _MARObserver

- (id)initWithObservee:(id)observee keyPaths:(NSArray *)keyPaths context:(MARObserverContext)context task:(id)task
{
    if (self = [super init]) {
        _observee = observee;
        _keyPaths = [keyPaths mutableCopy];
        _context = context;
        _task = [task copy];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context != MARBlockObservationContext) return;
    @synchronized (self) {
        switch (self.context) {
            case MARObserverContextKey:
            {
                void (^task)(id) = self.task;
                if (task) task(object);
                break;
            }
            case MARObserverContextKeyWithChange: {
                void (^task)(id, NSDictionary *) = self.task;
                if (task) task(object, change);
                break;
            }
            case MARObserverContextManyKeys: {
                void (^task)(id, NSString *) = self.task;
                if (task) task(object, keyPath);
                break;
            }
            case MARObserverContextManyKeysWithChange: {
                void (^task)(id, NSString *, NSDictionary *) = self.task;
                if (task) task(object, keyPath, change);
            }
        }
    }
}

- (void)startObservingWithOptions:(NSKeyValueObservingOptions)options
{
    @synchronized(self) {
        if (_isObserving) return;
        
        [self.keyPaths enumerateObjectsUsingBlock:^(NSString *keyPath, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.observee addObserver:self forKeyPath:keyPath options:options context:MARBlockObservationContext];
        }];
        
        _isObserving = YES;
    }
}

- (void)stopObservingKeyPath:(NSString *)keyPath
{
    NSParameterAssert(keyPath);
    
    @synchronized (self) {
        if (!_isObserving) return;
        if (![self.keyPaths containsObject:keyPath]) return;
        
        NSObject *observee = self.observee;
        if (!observee) return;
        
        [self.keyPaths removeObject: keyPath];
        keyPath = [keyPath copy];
        
        if (!self.keyPaths.count) {
            _task = nil;
            _observee = nil;
            _keyPaths = nil;
        }
        
        [observee removeObserver:self forKeyPath:keyPath context:MARBlockObservationContext];
    }
}

- (void)_stopObservingLocked
{
    if (!_isObserving) return;
    
    _task = nil;
    
    NSObject *observee = self.observee;
    NSArray *keyPaths = [self.keyPaths copy];
    
    _observee = nil;
    _keyPaths = nil;
    
    [keyPaths enumerateObjectsUsingBlock:^(NSString *keyPath, NSUInteger idx, BOOL * _Nonnull stop) {
        [observee removeObserver:self forKeyPath:keyPath context:MARBlockObservationContext];
    }];
}

- (void)stopObserving
{
    if (_observee == nil) return;
    
    @synchronized (self) {
        [self _stopObservingLocked];
    }
}

- (void)dealloc
{
    if (self.keyPaths) {
        [self _stopObservingLocked];
    }
}


@end

static const NSUInteger MARKeyValueObservingOptionWantsChangeDictionary = 0x1000;

@implementation NSObject (MAR_Observer)

- (NSString *)mar_addObserverForKeyPath:(NSString *)keyPath task:(void (^)(id target))task
{
    NSString *token = [[NSProcessInfo processInfo] globallyUniqueString];
    [self mar_addObserverForKeyPaths:@[ keyPath ] identifier:token options:0 context:MARObserverContextKey task:task];
    return token;
}

- (NSString *)mar_addObserverForKeyPaths:(NSArray *)keyPaths task:(void (^)(id obj, NSString *keyPath))task
{
    NSString *token = [[NSProcessInfo processInfo] globallyUniqueString];
    [self mar_addObserverForKeyPaths:keyPaths identifier:token options:0 context:MARObserverContextManyKeys task:task];
    return token;
}

- (NSString *)mar_addObserverForKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSDictionary *change))task
{
    NSString *token = [[NSProcessInfo processInfo] globallyUniqueString];
    options = options | MARKeyValueObservingOptionWantsChangeDictionary;
    [self mar_addObserverForKeyPath:keyPath identifier:token options:options task:task];
    return token;
}

- (NSString *)mar_addObserverForKeyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSString *keyPath, NSDictionary *change))task
{
    NSString *token = [[NSProcessInfo processInfo] globallyUniqueString];
    options = options | MARKeyValueObservingOptionWantsChangeDictionary;
    [self mar_addObserverForKeyPaths:keyPaths identifier:token options:options task:task];
    return token;
}

- (void)mar_addObserverForKeyPath:(NSString *)keyPath identifier:(NSString *)identifier options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSDictionary *change))task
{
    MARObserverContext context = (options == 0) ? MARObserverContextKey : MARObserverContextKeyWithChange;
    options = options & (~MARKeyValueObservingOptionWantsChangeDictionary);
    [self mar_addObserverForKeyPaths:@[keyPath] identifier:identifier options:options context:context task:task];
}

- (void)mar_addObserverForKeyPaths:(NSArray *)keyPaths identifier:(NSString *)identifier options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSString *keyPath, NSDictionary *change))task
{
    MARObserverContext context = (options == 0) ? MARObserverContextManyKeys : MARObserverContextManyKeysWithChange;
    options = options & (~MARKeyValueObservingOptionWantsChangeDictionary);
    [self mar_addObserverForKeyPaths:keyPaths identifier:identifier options:options context:context task:task];
}

- (void)mar_removeObserverForKeyPath:(NSString *)keyPath identifier:(NSString *)token
{
    NSParameterAssert(keyPath.length);
    NSParameterAssert(token.length);
    
    NSMutableDictionary *dict;
    
    @synchronized (self) {
        dict = [self mar_observerBlocks];
        if (!dict) return;
    }
    
    _MARObserver *observer = dict[token];
    [observer stopObservingKeyPath:keyPath];
    
    if (observer.keyPaths.count == 0) {
        [dict removeObjectForKey:token];
    }
    
    if (dict.count == 0) [self mar_setObserverBlocks:nil];
}

- (void)mar_removeObserversWithIdentifier:(NSString *)token
{
    NSParameterAssert(token);
    
    NSMutableDictionary *dict;
    
    @synchronized (self) {
        dict = [self mar_observerBlocks];
        if (!dict) return;
    }
    
    _MARObserver *observer = dict[token];
    [observer stopObserving];
    
    [dict removeObjectForKey:token];
    
    if (dict.count == 0) [self mar_setObserverBlocks:nil];
}

- (void)mar_removeAllBlockObservers
{
    NSDictionary *dict;
    
    @synchronized (self) {
        dict = [[self mar_observerBlocks] copy];
        [self mar_setObserverBlocks:nil];
    }
    
    [dict.allValues enumerateObjectsUsingBlock:^(_MARObserver *trampoline, NSUInteger idx, BOOL * _Nonnull stop) {
        [trampoline stopObserving];
    }];
}

#pragma mark - "Private"s
+ (NSMutableSet *)mar_observedClassesHash
{
    static dispatch_once_t onceToken;
    static NSMutableSet *swizzledClasses = nil;
    dispatch_once(&onceToken, ^{
        swizzledClasses = [[NSMutableSet alloc] init];
    });
    
    return swizzledClasses;
}

- (void)mar_addObserverForKeyPaths:(NSArray *)keyPaths identifier:(NSString *)identifier options:(NSKeyValueObservingOptions)options context:(MARObserverContext)context task:(id)task
{
    NSParameterAssert(keyPaths.count);
    NSParameterAssert(identifier.length);
    NSParameterAssert(task);
    
    Class classToSwizzle = self.class;
    NSMutableSet *classes = [self.class mar_observedClassesHash];
    @synchronized (classes) {
        NSString *className = NSStringFromClass(classToSwizzle);
        if (![classes containsObject:className]) {
            SEL deallocSelector = sel_registerName("dealloc");
            
            __block void (*originalDealloc)(__unsafe_unretained id, SEL) = NULL;
            
            id newDealloc = ^(__unsafe_unretained id objSelf) {
                [objSelf mar_removeAllBlockObservers];
                
                if (originalDealloc == NULL) {
                    struct objc_super superInfo = {
                        .receiver = objSelf,
                        .super_class = class_getSuperclass(classToSwizzle)
                    };
                    
                    void (*msgSend)(struct objc_super *, SEL) = (__typeof__(msgSend))objc_msgSendSuper;
                    msgSend(&superInfo, deallocSelector);
                }
                else
                {
                    originalDealloc(objSelf, deallocSelector);
                }
            };
            
            IMP newDeallocIMP = imp_implementationWithBlock(newDealloc);
            
            if (!class_addMethod(classToSwizzle, deallocSelector, newDeallocIMP, "v@:")) {
                // The class already contains a method implementation.
                Method deallocMethod = class_getInstanceMethod(classToSwizzle, deallocSelector);
                
                // We need to store original implementation before setting new implementation
                // in case method is called at the time of setting.
                originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_getImplementation(deallocMethod);
                originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_setImplementation(deallocMethod, newDeallocIMP);
            }
            
            [classes addObject:className];
        }
    }
    
    NSMutableDictionary *dict;
    _MARObserver *observer = [[_MARObserver alloc] initWithObservee:self keyPaths:keyPaths context:context task:task];
    [observer startObservingWithOptions:options];
    
    @synchronized (self) {
        dict = [self mar_observerBlocks];
        
        if (dict == nil) {
            dict = [NSMutableDictionary dictionary];
            [self mar_setObserverBlocks:dict];
        }
    }
    
    dict[identifier] = observer;

}

- (void)mar_setObserverBlocks:(NSMutableDictionary *)dict
{
    objc_setAssociatedObject(self, MARObserverBlocksKey, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)mar_observerBlocks
{
    return objc_getAssociatedObject(self, MARObserverBlocksKey);
}

@end
