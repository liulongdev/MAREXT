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

- (BOOL)mar_isValid {
    return !(self == nil || [self isKindOfClass:[NSNull class]]);
}

- (id)mar_performHasNoArgsSelector:(SEL)aSelector
{
    NSMethodSignature *signagure = [self methodSignatureForSelector:aSelector];
    if (signagure) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signagure];
        if (signagure.numberOfArguments == 2) {
            [invocation setTarget:self];
            [invocation setSelector:aSelector];
            
            [invocation invoke];
            if (signagure.methodReturnLength) {
                id objRet = nil;
                [invocation getReturnValue:&objRet];
                return objRet;
            }
            return nil;
        }
    }
    return nil;
}

- (id)mar_performSelector:(SEL)aSelector withObjects:(id)object, ...
{
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    if (signature) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:aSelector];
        
        va_list args;
        va_start(args, object);
        
        [invocation setArgument:&object atIndex:2];
        
        id arg = nil;
        int index = 3;
        while ((arg = va_arg(args, id))) {
            [invocation setArgument:&arg atIndex:index];
            index++;
        }
        
        va_end(args);
        
        [invocation invoke];
        if (signature.methodReturnLength) {
            id anObject;
            [invocation getReturnValue:&anObject];
            return anObject;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

@end

@implementation NSObject(MAREX_RUNTIME)

+ (BOOL)mar_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return NO;
    
    class_addMethod(self,
                    originalSel,
                    class_getMethodImplementation(self, originalSel),
                    method_getTypeEncoding(originalMethod));
    class_addMethod(self,
                    newSel,
                    class_getMethodImplementation(self, newSel),
                    method_getTypeEncoding(newMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, originalSel),
                                   class_getInstanceMethod(self, newSel));
    return YES;
}

+ (BOOL)mar_swizzleClassMethod:(SEL)originalSel with:(SEL)newSel {
    Class class = object_getClass(self);
    Method originalMethod = class_getInstanceMethod(class, originalSel);
    Method newMethod = class_getInstanceMethod(class, newSel);
    if (!originalMethod || !newMethod) return NO;
    method_exchangeImplementations(originalMethod, newMethod);
    return YES;
}

- (void)mar_setAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)mar_setAssociateWeakValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (void)mar_removeAssociatedValues {
    objc_removeAssociatedObjects(self);
}

- (id)mar_getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}


+ (NSString *)mar_className {
    return NSStringFromClass([self class]);
    // or
    //    Class aClass = [self class];
    //    if (aClass != (Class)0)
    //        return [NSString stringWithUTF8String: (char*)class_getName(aClass)];
    //    return nil;
}

- (NSString *)mar_className {
    return [self.class mar_className];
    // or
//    Class aClass = [self class];
//    if (aClass != (Class)0)
//        return [NSString stringWithUTF8String: (char*)class_getName(aClass)];
//    return nil;
}

- (NSArray *)mar_propertyKeyList
{
    return [self.class mar_propertyKeyList];
}

+ (NSArray *)mar_propertyKeyList;
{
    unsigned int propertyCount = 0;
    objc_property_t * properties = class_copyPropertyList(self, &propertyCount);
    NSMutableArray * propertyNames = [NSMutableArray array];
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        [propertyNames addObject:[NSString stringWithUTF8String:name]];
    }
    free(properties);
    return propertyNames;
}

- (NSArray *)mar_propertiyInfoList
{
    return [self.class mar_propertiyInfoList];
}

+ (NSArray *)mar_propertiyInfoList
{
    NSMutableArray *propertieArray = [NSMutableArray array];
    
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    
    for (int i = 0; i < propertyCount; i++)
    {
        [propertieArray addObject:({
            NSDictionary *dictionary = [self p_mar_dictionaryWithProperty:properties[i]];
            dictionary;
        })];
    }
    free(properties);
    return propertieArray;
}

// @see https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
- (NSDictionary *)p_mar_dictionaryWithProperty:(objc_property_t)property
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    //name
    
    NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
    [result setObject:propertyName forKey:@"name"];

    //attribute
    NSMutableDictionary *attributeDictionary = [NSMutableDictionary dictionary];
    
    unsigned int attributeCount;
    objc_property_attribute_t *attrs = property_copyAttributeList(property, &attributeCount);
    
    for (int i = 0; i < attributeCount; i++)
    {
        NSString *name = [NSString stringWithCString:attrs[i].name encoding:NSUTF8StringEncoding];
        NSString *value = [NSString stringWithCString:attrs[i].value encoding:NSUTF8StringEncoding];
        [attributeDictionary setObject:value forKey:name];
    }
    
    free(attrs);

    NSMutableArray *attributeArray = [NSMutableArray array];
    //R
    if ([attributeDictionary objectForKey:@"R"])
    {
        [attributeArray addObject:@"readonly"];
    }
    //C
    if ([attributeDictionary objectForKey:@"C"])
    {
        [attributeArray addObject:@"copy"];
    }
    //&
    if ([attributeDictionary objectForKey:@"&"])
    {
        [attributeArray addObject:@"strong"];
    }
    //N
    if ([attributeDictionary objectForKey:@"N"])
    {
        [attributeArray addObject:@"nonatomic"];
    }
    else
    {
        [attributeArray addObject:@"atomic"];
    }
    //G<name>
    if ([attributeDictionary objectForKey:@"G"])
    {
        [attributeArray addObject:[NSString stringWithFormat:@"getter=%@", [attributeDictionary objectForKey:@"G"]]];
    }
    //S<name>
    if ([attributeDictionary objectForKey:@"S"])
    {
        [attributeArray addObject:[NSString stringWithFormat:@"setter=%@", [attributeDictionary objectForKey:@"G"]]];
    }
    //D
    if ([attributeDictionary objectForKey:@"D"])
    {
        [result setObject:[NSNumber numberWithBool:YES] forKey:@"isDynamic"];
    }
    else
    {
        [result setObject:[NSNumber numberWithBool:NO] forKey:@"isDynamic"];
    }
    //W
    if ([attributeDictionary objectForKey:@"W"])
    {
        [attributeArray addObject:@"weak"];
    }
    //P
    if ([attributeDictionary objectForKey:@"P"])
    {
        //TODO:P | The property is eligible for garbage collection.
    }
    //T
    if ([attributeDictionary objectForKey:@"T"])
    {
        NSDictionary *typeDic = @{@"c":@"char",
                                  @"i":@"int",
                                  @"s":@"short",
                                  @"l":@"long",
                                  @"q":@"long long",
                                  @"C":@"unsigned char",
                                  @"I":@"unsigned int",
                                  @"S":@"unsigned short",
                                  @"L":@"unsigned long",
                                  @"Q":@"unsigned long long",
                                  @"f":@"float",
                                  @"d":@"double",
                                  @"B":@"BOOL",
                                  @"v":@"void",
                                  @"*":@"char *",
                                  @"@":@"id",
                                  @"#":@"Class",
                                  @":":@"SEL",
                                  };
        //TODO:An array
        NSString *key = [attributeDictionary objectForKey:@"T"];
        
        id type_str = [typeDic objectForKey:key];
        
        if (type_str == nil)
        {
            if ([[key substringToIndex:1] isEqualToString:@"@"] && [key rangeOfString:@"?"].location == NSNotFound)
            {
                type_str = [[key substringWithRange:NSMakeRange(2, key.length - 3)] stringByAppendingString:@"*"];
            }
            else if ([[key substringToIndex:1] isEqualToString:@"^"])
            {
                id str = [typeDic objectForKey:[key substringFromIndex:1]];
                
                if (str)
                {
                    type_str = [NSString stringWithFormat:@"%@ *",str];
                }
            }
            else
            {
                type_str = @"unknow";
            }
        }
        
        [result setObject:type_str forKey:@"type"];
    }
    
    [result setObject:attributeArray forKey:@"attribute"];
    
    return result;
}

- (NSArray *)mar_methodNameList
{
    return [self.class mar_methodNameList];
}

+ (NSArray *)mar_methodNameList
{
    u_int count;
    NSMutableArray *methodList = [NSMutableArray array];
    Method *methods= class_copyMethodList([self class], &count);
    for (int i = 0; i < count ; i++)
    {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString  stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        [methodList addObject:strName];
    }
    free(methods);
    return methodList;

}

- (NSArray *)mar_methodInfoList
{
    return [self.class mar_methodInfoList];
}

+ (NSArray *)mar_methodInfoList
{
    u_int count;
    NSMutableArray *methodList = [NSMutableArray array];
    Method *methods= class_copyMethodList([self class], &count);
    for (int i = 0; i < count ; i++)
    {
        NSMutableDictionary *info = [NSMutableDictionary dictionary];
        
        Method method = methods[i];
        //        IMP imp = method_getImplementation(method);
        SEL name = method_getName(method);
        // 返回方法的参数的个数
        int argumentsCount = method_getNumberOfArguments(method);
        //获取描述方法参数和返回值类型的字符串
        const char *encoding =method_getTypeEncoding(method);
        //取方法的返回值类型的字符串
        const char *returnType =method_copyReturnType(method);
        
        NSMutableArray *arguments = [NSMutableArray array];
        for (int index=0; index<argumentsCount; index++) {
            // 获取方法的指定位置参数的类型字符串
            char *arg =   method_copyArgumentType(method,index);
            //            NSString *argString = [NSString stringWithCString:arg encoding:NSUTF8StringEncoding];
            [arguments addObject:[[self class] p_mar_decodeType:arg]];
        }
        
        NSString *returnTypeString =[[self class] p_mar_decodeType:returnType];
        NSString *encodeString = [[self class] p_mar_decodeType:encoding];
        NSString *nameString = [NSString  stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        
        [info setObject:arguments forKey:@"arguments"];
        [info setObject:[NSString stringWithFormat:@"%d",argumentsCount] forKey:@"argumentsCount"];
        [info setObject:returnTypeString forKey:@"returnType"];
        [info setObject:encodeString forKey:@"encode"];
        [info setObject:nameString forKey:@"name"];
        //        [info setObject:imp_f forKey:@"imp"];
        [methodList addObject:info];
    }
    free(methods);
    return methodList;
}

+ (NSString *)p_mar_decodeType:(const char *)cString
{
    if (!strcmp(cString, @encode(char)))
        return @"char";
    if (!strcmp(cString, @encode(int)))
        return @"int";
    if (!strcmp(cString, @encode(short)))
        return @"short";
    if (!strcmp(cString, @encode(long)))
        return @"long";
    if (!strcmp(cString, @encode(long long)))
        return @"long long";
    if (!strcmp(cString, @encode(unsigned char)))
        return @"unsigned char";
    if (!strcmp(cString, @encode(unsigned int)))
        return @"unsigned int";
    if (!strcmp(cString, @encode(unsigned short)))
        return @"unsigned short";
    if (!strcmp(cString, @encode(unsigned long)))
        return @"unsigned long";
    if (!strcmp(cString, @encode(unsigned long long)))
        return @"unsigned long long";
    if (!strcmp(cString, @encode(float)))
        return @"float";
    if (!strcmp(cString, @encode(double)))
        return @"double";
    if (!strcmp(cString, @encode(bool)))
        return @"bool";
    if (!strcmp(cString, @encode(_Bool)))
        return @"_Bool";
    if (!strcmp(cString, @encode(void)))
        return @"void";
    if (!strcmp(cString, @encode(char *)))
        return @"char *";
    if (!strcmp(cString, @encode(id)))
        return @"id";
    if (!strcmp(cString, @encode(Class)))
        return @"class";
    if (!strcmp(cString, @encode(SEL)))
        return @"SEL";
    if (!strcmp(cString, @encode(BOOL)))
        return @"BOOL";

    NSString *result = [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
    
    if ([[result substringToIndex:1] isEqualToString:@"@"] && [result rangeOfString:@"?"].location == NSNotFound) {
        result = [[result substringWithRange:NSMakeRange(2, result.length - 3)] stringByAppendingString:@"*"];
    } else
    {
        if ([[result substringToIndex:1] isEqualToString:@"^"]) {
            result = [NSString stringWithFormat:@"%@ *",
                      [NSString p_mar_decodeType:[[result substringFromIndex:1] cStringUsingEncoding:NSUTF8StringEncoding]]];
        }
    }
    return result;
}

+ (NSArray *)mar_registedClassList
{
    NSMutableArray *result = [NSMutableArray array];
    
    unsigned int count;
    Class *classes = objc_copyClassList(&count);
    for (int i = 0; i < count; i++)
    {
        [result addObject:NSStringFromClass(classes[i])];
    }
    free(classes);
    [result sortedArrayUsingSelector:@selector(compare:)];
    
    return result;
}

- (NSArray *)mar_instanceVariableList
{
    return [self.class mar_instanceVariableList];
}

+ (NSArray *)mar_instanceVariableList
{
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < outCount; i++) {
        NSString *type = [[self class] p_mar_decodeType:ivar_getTypeEncoding(ivars[i])];
        NSString *name = [NSString stringWithCString:ivar_getName(ivars[i]) encoding:NSUTF8StringEncoding];
        NSString *ivarDescription = [NSString stringWithFormat:@"%@ %@", type, name];
        [result addObject:ivarDescription];
    }
    free(ivars);
    return result.count ? [result copy] : nil;
}

- (NSDictionary *)mar_protocolList
{
    return [self.class mar_protocolList];
}

+ (NSDictionary *)mar_protocolList
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    unsigned int count;
    Protocol * __unsafe_unretained * protocols = class_copyProtocolList([self class], &count);
    for (int i = 0; i < count; i++)
    {
        Protocol *protocol = protocols[i];
        
        NSString *protocolName = [NSString stringWithCString:protocol_getName(protocol) encoding:NSUTF8StringEncoding];
        
        NSMutableArray *superProtocolArray = ({
            
            NSMutableArray *array = [NSMutableArray array];
            
            unsigned int superProtocolCount;
            Protocol * __unsafe_unretained * superProtocols = protocol_copyProtocolList(protocol, &superProtocolCount);
            for (int ii = 0; ii < superProtocolCount; ii++)
            {
                Protocol *superProtocol = superProtocols[ii];
                
                NSString *superProtocolName = [NSString stringWithCString:protocol_getName(superProtocol) encoding:NSUTF8StringEncoding];
                
                [array addObject:superProtocolName];
            }
            free(superProtocols);
            
            array;
        });
        
        [dictionary setObject:superProtocolArray forKey:protocolName];
    }
    free(protocols);
    
    return dictionary;
}

- (BOOL)mar_hasPropertyForKey:(NSString *)key
{
    return [self.class mar_hasPropertyForKey:key];
}

+ (BOOL)mar_hasPropertyForKey:(NSString *)key
{
    objc_property_t property = class_getProperty([self class], [key UTF8String]);
    return (BOOL)property;
}

- (BOOL)mar_hasIvarForKey:(NSString *)key
{
    return [self.class mar_hasIvarForKey:key];
}
+ (BOOL)mar_hasIvarForKey:(NSString *)key
{
    Ivar ivar = class_getInstanceVariable([self class], [key UTF8String]);
    return (BOOL)ivar;
}

@end

#pragma mark - KVO EX
#ifndef MARNotUsedCategoryMAREX_KVO
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
#endif

#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0) || (defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && __MAC_OS_X_VERSION_MAX_ALLOWED >= __MAC_10_10)
#define DISPATCH_CANCELBLOCK_SUPPORTED 1
#else
#define DISPATCH_CANCELBLOCK_SUPPORTED 1
#endif

static inline dispatch_time_t MAREXTimeDelay(NSTimeInterval second){
    return dispatch_time(DISPATCH_TIME_NOW, (uint64_t)NSEC_PER_SEC * second);
}

NS_INLINE BOOL MAREXSupportsDispatchCancelBlock(void) {
#if DISPATCH_CANCELBLOCK_SUPPORTED
    return (&dispatch_block_cancel != NULL);
#else
    return NO;
#endif
}

static inline dispatch_queue_t MAREXGetBackgroundQueue(void) {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

static MARCancelBlockToken MARDispatchCancellableBlock(dispatch_queue_t queue, NSTimeInterval delay, void(^block)(void)){
    dispatch_time_t time = MAREXTimeDelay(delay);
    
    if (MAREXSupportsDispatchCancelBlock()) {
#if DISPATCH_CANCELBLOCK_SUPPORTED
        dispatch_block_t ret = dispatch_block_create(0, block);
        dispatch_after(time, queue, ret);
        return ret;
#endif
    }
    
    __block BOOL cancelled = NO;
    void (^wrapped)(BOOL) = ^(BOOL cancel)
    {
        if (cancel) {
            cancelled = YES;
            return ;
        }
        if (!cancelled) block();
    };
    
    dispatch_after(time, queue, block);
    return wrapped;
}

@implementation NSObject (MAREX_GCD)

+ (MARCancelBlockToken)mar_gcdPerformAfterDelay:(NSTimeInterval)delay usingBlock:(void (^)(void))block
{
    return [NSObject mar_gcdPerformOnQueue:dispatch_get_main_queue() afterDelay:delay usingBlock:block];
}

- (MARCancelBlockToken)mar_gcdPerformAfterDelay:(NSTimeInterval)delay usingBlock:(void (^)(id))block
{
    return [self mar_gcdPerformOnQueue:dispatch_get_main_queue() afterDelay:delay usingBlock:block];
}

- (MARCancelBlockToken)mar_gcdPerformOnBackgroundAfterDelay:(NSTimeInterval)delay usingBlock:(void (^)(id))block
{
    return [self mar_gcdPerformOnQueue:MAREXGetBackgroundQueue() afterDelay:delay usingBlock:block];
}

+ (MARCancelBlockToken)mar_gcdPerformOnBackgroundAfterDelay:(NSTimeInterval)delay usingBlock:(void (^)(void))block
{
    return [NSObject mar_gcdPerformOnQueue:MAREXGetBackgroundQueue() afterDelay:delay usingBlock:block];
}

- (MARCancelBlockToken)mar_gcdPerformOnQueue:(dispatch_queue_t)queue afterDelay:(NSTimeInterval)delay usingBlock:(void (^)(id))block
{
    NSParameterAssert( block != nil);
    return MARDispatchCancellableBlock(queue, delay, ^{
        block(self);
    });
}

+ (MARCancelBlockToken)mar_gcdPerformOnQueue:(dispatch_queue_t)queue afterDelay:(NSTimeInterval)delay usingBlock:(void (^)(void))block
{
    NSParameterAssert( block != nil);
    return MARDispatchCancellableBlock(queue, delay, block);
}

+ (void)mar_cancelBlock:(MARCancelBlockToken)block
{
#if DISPATCH_CANCELBLOCK_SUPPORTED
    if (MAREXSupportsDispatchCancelBlock()) {
        dispatch_block_cancel((dispatch_block_t)block);
        return;
    }
#endif
    
    void (^wrapper)(BOOL) = (void(^)(BOOL))block;
    wrapper(YES);
}

@end
