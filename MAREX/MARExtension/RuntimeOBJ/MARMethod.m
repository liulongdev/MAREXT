//
//  MARMethod.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/6/5.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "MARMethod.h"

@interface MARObjCMethod : MARMethod
{
    Method _method;
}
@end

@implementation MARObjCMethod

- (id)initWithObjCMethod:(Method)method
{
    self = [super init];
    if (self) {
        _method = method;
    }
    return self;
}

- (SEL)selector
{
    return method_getName(_method);
}

- (IMP)implementation
{
    return method_getImplementation(_method);
}

- (NSString *)signature
{
    return [NSString stringWithUTF8String:method_getTypeEncoding(_method)];
}

- (void)setImplementation:(IMP)newImp
{
    method_setImplementation(_method, newImp);
}

@end

@interface MARComponentsMethod : MARMethod
{
    SEL _sel;
    IMP _imp;
    NSString *_signature;
}
@end

@implementation MARComponentsMethod

- (id)initWithSelector:(SEL)sel implementation:(IMP)imp signature:(NSString *)signature
{
    self = [super init];
    if (self) {
        _sel = sel;
        _imp = imp;
        _signature = signature;
    }
    return self;
}

- (SEL)selector
{
    return _sel;
}

- (IMP)implementation
{
    return _imp;
}

- (NSString *)signature
{
    return _signature;
}

- (void)setImplementation:(IMP)newImp
{
    _imp = newImp;
}

@end

@implementation MARMethod

+ (id)methodWithObjCMethod:(Method)method
{
    return [[self alloc] initWithObjCMethod:method];
}

+ (id)methodWithSelector:(SEL)sel implementation:(IMP)imp signature:(NSString *)signature
{
    return [[self alloc] initWithSelector:sel implementation:imp signature:signature];
}


- (id)initWithObjCMethod:(Method)method
{
    return [[MARObjCMethod alloc] initWithObjCMethod:method];
}

- (id)initWithSelector:(SEL)sel implementation:(IMP)imp signature:(NSString *)signature
{
    return [[MARComponentsMethod alloc] initWithSelector:sel implementation:imp signature:signature];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ %p: [sel:%@] [imp'p:%p] [sig:%@]>", [self class], self, NSStringFromSelector([self selector]), [self implementation], [self signature]];
}

- (BOOL)isEqual:(id)object
{
    return  [object isKindOfClass:[MARMethod class]] &&
            [self selector] == [object selector] &&
            [self implementation] == [object implementation] &&
            [[self signature] isEqual:[object signature]];
}

- (NSUInteger)hash
{
    return (NSUInteger)(void *)[self selector] ^ (NSUInteger)[self implementation] ^ [[self signature] hash];
}

- (SEL)selector
{
    [self doesNotRecognizeSelector: _cmd];
    return NULL;
}

- (NSString *)selectorName
{
    return NSStringFromSelector([self selector]);
}

- (IMP)implementation
{
    [self doesNotRecognizeSelector: _cmd];
    return NULL;
}

- (NSString *)signature
{
    [self doesNotRecognizeSelector: _cmd];
    return NULL;
}

- (void)setImplementation: (IMP)newImp
{
    [self doesNotRecognizeSelector: _cmd];
}

- (id)sendToTarget:(id)target, ...
{
    id retVal = nil;
    
    va_list args;
    va_start(args, target);
    [self p_returnValue:&retVal sendToArget:target arguments:args];
    va_end(args);
    
    return retVal;
}

- (void)p_returnValue:(void *)retPtr sendToArget:(id)target arguments:(va_list)args
{
    NSMethodSignature *signature = [target methodSignatureForSelector:[self selector]];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    NSUInteger argumentCount = [signature numberOfArguments];
    
    [invocation setTarget:target];
    [invocation setSelector:[self selector]];
 
    for (NSUInteger i = 2; i < argumentCount; i++) {
        int magicNumber = va_arg(args, int);
        if (magicNumber != MAR_ARG_MAGIC_NUMBER) {
            NSLog(@"%s: incorrect magic number %08x; did you forget to use MARRTARG() around your arguments?", __func__, magicNumber);
            abort();
        }
        const char *argTypeStr = va_arg(args, char *);
        void *argPtr = va_arg(args, void *);
        
        NSUInteger argTypeSize;
        NSGetSizeAndAlignment(argTypeStr, &argTypeSize, NULL);
        NSUInteger sigTypeSize;
        NSGetSizeAndAlignment([signature getArgumentTypeAtIndex:i], &sigTypeSize, NULL);
        
        if (argTypeSize != sigTypeSize) {
            NSLog(@"%s: size mismatch between passed-in argument and required argument; in type: %s (%lu) requested: %s (%lu)", __func__, argTypeStr, (long)argTypeSize, [signature getArgumentTypeAtIndex:i], (long)sigTypeSize);
            abort();
        }
        
        [invocation setArgument:argPtr atIndex:i];
    }
    
    [invocation invoke];
    if ([signature methodReturnLength] && retPtr) {
        [invocation getReturnValue:retPtr];
    }
}

@end
