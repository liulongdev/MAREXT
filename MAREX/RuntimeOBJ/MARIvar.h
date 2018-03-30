//
//  MARIvar.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/6/1.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MARClassInfo.h"
#import <objc/runtime.h>

@interface MARIvar : NSObject

+ (instancetype)ivarWithObjCIvar:(Ivar)ivar;

+ (instancetype)ivarWithName:(NSString *)name encode:(const char *)encodeStr;

+ (instancetype)ivarWithName:(NSString *)name typeEncoding:(NSString *)typeEncoding;

- (instancetype)initWithObjCIvar:(Ivar)ivar;

- (instancetype)initWithName:(NSString *)name encode:(const char *)encodeStr;

- (instancetype)initWithName:(NSString *)name typeEncoding:(NSString *)typeEncoding;

- (NSString *)name;
- (NSString *)typeEncoding;
- (ptrdiff_t)offset;
- (MAREncodingType)type;  

@end
