//
//  MARProperty.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/6/1.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "MARClassInfo.h"

@interface MARProperty : NSObject

+ (instancetype)propertyWithObjCProperty:(objc_property_t)property;
+ (instancetype)propertyWithName:(NSString *)name attributes:(NSDictionary *)attributes;

- (instancetype)initWithObjCProperty:(objc_property_t)property;
- (instancetype)initWithName:(NSString *)name attributes:(NSDictionary *)attributes;


- (MAREncodingType)type;    // only for MARObjCProperty instance
- (SEL)getterSEL;           // only for MARObjCProperty instance
- (SEL)setterSEL;           // only for MARObjCProperty instance

- (NSString *)attributeEncodings;
- (NSString *)name;
- (NSString *)ivarName;
- (NSString *)typeEncoding;

- (BOOL)addToClass:(Class)clazz;

@end
