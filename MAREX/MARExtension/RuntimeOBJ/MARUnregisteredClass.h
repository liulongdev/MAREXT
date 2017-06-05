//
//  MARUnregisteredClass.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/6/1.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "MARIvar.h"
#import "MARProperty.h"
#import "MARMethod.h"

NS_ASSUME_NONNULL_BEGIN

@interface MARUnregisteredClass : NSObject
{
    Class _class;
}
+ (instancetype)unregisteredClassWithName:(NSString *)name superClass:(nullable Class)superClass;

+ (instancetype)unregisteredClassWithName:(NSString *)name;

- (instancetype)initWithName:(NSString *)name superClass:(nullable Class)superClass;

- (instancetype)initWithName:(NSString *)name;

- (BOOL)addIvar:(MARIvar *)ivar;
- (BOOL)addProperty:(MARProperty *)property;
- (BOOL)addMethod:(MARMethod *)method;
- (BOOL)addProperty:(MARProperty *)property autoSetterAndGetter:(BOOL)autoed;

- (Class)registerClass;

@end

NS_ASSUME_NONNULL_END
