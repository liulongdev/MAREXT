//
//  NSObject+MAREX.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MAREX)

/**
 *  Check if the object is valid (not nil or null)
 *
 *  @return Returns if the object is valid
 */
- (BOOL)mar_isValid;

/**
 *  Perform selector with unlimited objects
 *
 *  @param aSelector The selector
 *  @param object    The objects
 *
 *  @return An object that is the result of the message
 */
- (id _Nonnull)mar_performSelector:(SEL)aSelector
                   withObjects:(id _Nullable)object, ... NS_REQUIRES_NIL_TERMINATION;

- (id _Nonnull)mar_performHasNoArgsSelector:(SEL)aSelector;

@end

@interface NSObject(MAREX_RUNTIME)

#pragma mark - Swap method (Swizzling)
///=============================================================================
/// @name Swap method (Swizzling)
///=============================================================================

/**
 Swap two instance method's implementation in one class. Dangerous, be careful.
 
 @param originalSel   Selector 1.
 @param newSel        Selector 2.
 @return              YES if swizzling succeed; otherwise, NO.
 */
+ (BOOL)mar_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;

/**
 Swap two class method's implementation in one class. Dangerous, be careful.
 
 @param originalSel   Selector 1.
 @param newSel        Selector 2.
 @return              YES if swizzling succeed; otherwise, NO.
 */
+ (BOOL)mar_swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;


#pragma mark - Associate value
///=============================================================================
/// @name Associate value
///=============================================================================

/**
 Associate one object to `self`, as if it was a strong property (strong, nonatomic).
 
 @param value   The object to associate.
 @param key     The pointer to get value from `self`.
 */
- (void)mar_setAssociateValue:(nullable id)value withKey:(void *)key;

/**
 Associate one object to `self`, as if it was a weak property (week, nonatomic).
 
 @param value  The object to associate.
 @param key    The pointer to get value from `self`.
 */
- (void)mar_setAssociateWeakValue:(nullable id)value withKey:(void *)key;

/**
 Get the associated value from `self`.
 
 @param key The pointer to get value from `self`.
 */
- (nullable id)mar_getAssociatedValueForKey:(void *)key;

/**
 Remove all associated values.
 */
- (void)mar_removeAssociatedValues;

/**
 Returns the class name in NSString.
 */
- (NSString *)mar_className;
+ (NSString *)mar_className;

/**
 Returns array contains all the property in the current class
 */
- (NSArray *)mar_propertyKeyList;
+ (NSArray *)mar_propertyKeyList;

/**
 Return Detail info of all the perproty in the current class.
 */
- (NSArray *)mar_propertiyInfoList;
+ (NSArray *)mar_propertiyInfoList;

/**
 Return all the method name in the current class
 */
- (NSArray *)mar_methodNameList;
+ (NSArray *)mar_methodNameList;

/**
 Return all the method info in the current class
 */
- (NSArray *)mar_methodInfoList;
+ (NSArray *)mar_methodInfoList;

/**
 Return name of the classes which have registered
 */
+ (NSArray *)mar_registedClassList;

/**
 Return all the instance variabel in the current class,each item contains type and name of ivar
 */
- (NSArray *)mar_instanceVariableList;
+ (NSArray *)mar_instanceVariableList;

/**
 return all the protocol which the class or ancestors classes confirms.
 */
- (NSDictionary *)mar_protocolList;
+ (NSDictionary *)mar_protocolList;

/**
 Indicate whether has the name of the property in the current.
 */
- (BOOL)mar_hasPropertyForKey:(NSString *)key;
+ (BOOL)mar_hasPropertyForKey:(NSString *)key;

/**
 Indicate whether has the name of the Ivar in the current.
 */
- (BOOL)mar_hasIvarForKey:(NSString *)key;
+ (BOOL)mar_hasIvarForKey:(NSString *)key;

@end

#define MARNotUsedCategoryMAREX_KVO
#ifndef MARNotUsedCategoryMAREX_KVO
@interface NSObject (MAREX_KVO)

/**
 Registers a block to receive KVO notifications for the specified key-path
 relative to the receiver.
 
 @discussion The block and block captured objects are retained. Call
 `removeObserverBlocksForKeyPath:` or `removeObserverBlocks` to release.
 
 @param keyPath The key path, relative to the receiver, of the property to
 observe. This value must not be nil.
 
 @param block   The block to register for KVO notifications.
 */
- (void)mar_addObserverBlockForKeyPath:(NSString*)keyPath block:(void (^)(id _Nonnull obj, _Nullable id oldVal, _Nullable id newVal))block;

/**
 Stops all blocks (associated by `addObserverBlockForKeyPath:block:`) from
 receiving change notifications for the property specified by a given key-path
 relative to the receiver, and release these blocks.
 
 @param keyPath A key-path, relative to the receiver, for which blocks is
 registered to receive KVO change notifications.
 */
- (void)mar_removeObserverBlocksForKeyPath:(NSString*)keyPath;

/**
 Stops all blocks (associated by `addObserverBlockForKeyPath:block:`) from
 receiving change notifications, and release these blocks.
 */
- (void)mar_removeObserverBlocks;

@end
#endif

typedef __nonnull id <NSObject, NSCopying> MARCancelBlockToken;

@interface NSObject (MAREX_GCD)


/**
 This fun is valid only if on sub thread.
 Instead of funcion - (void)performSelector:(SEL)aSelector withObject:(id)anArgument afterDelay:(NSTimeInterval)delay
 and - (void)performSelector:(SEL)aSelector withObject:(id)anArgument afterDelay:(NSTimeInterval)delay inModes:(NSArray<NSRunLoopMode> *)modes
 Because two funs above not valid on sub thread, reference runloop.
 */
+ (MARCancelBlockToken)mar_gcdPerformAfterDelay:(NSTimeInterval)delay usingBlock:(void (^)(void))block;

- (MARCancelBlockToken)mar_gcdPerformAfterDelay:(NSTimeInterval)delay usingBlock:(void (^)(id objSelf))block;

- (MARCancelBlockToken)mar_gcdPerformOnBackgroundAfterDelay:(NSTimeInterval)delay usingBlock:(void (^)(id objSelf))block;

+ (MARCancelBlockToken)mar_gcdPerformOnBackgroundAfterDelay:(NSTimeInterval)delay usingBlock:(void (^)(void))block;

- (MARCancelBlockToken)mar_gcdPerformOnQueue:(dispatch_queue_t)queue afterDelay:(NSTimeInterval)delay usingBlock:(void (^)(id objSelf))block;

+ (MARCancelBlockToken)mar_gcdPerformOnQueue:(dispatch_queue_t)queue afterDelay:(NSTimeInterval)delay usingBlock:(void (^)(void))block;

+ (void)mar_cancelBlock:(MARCancelBlockToken)block;

@end

NS_ASSUME_NONNULL_END
