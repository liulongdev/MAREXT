//
//  MARIvar.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/6/1.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "MARIvar.h"

@interface _MARObjCIvar : MARIvar
{
    Ivar _ivar;
}
@end

@implementation _MARObjCIvar

- (instancetype)initWithObjCIvar:(Ivar)ivar
{
    self = [super init];
    if (self) {
        _ivar = ivar;
    }
    return self;
}

- (NSString *)name
{
    return [NSString stringWithUTF8String:ivar_getName(_ivar)];
}

- (NSString *)typeEncoding
{
    return [NSString stringWithUTF8String:ivar_getTypeEncoding(_ivar)];
}

- (ptrdiff_t)offset
{
    return ivar_getOffset(_ivar);
}

@end

@interface _MARComponentsIvar : MARIvar
{
    NSString *_name;
    NSString *_typeEncoding;   // @encode(id)
}
@end

@implementation _MARComponentsIvar

- (instancetype)initWithName:(NSString *)name encode:(const char *)encodeStr
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _typeEncoding = [NSString stringWithUTF8String:encodeStr];
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name typeEncoding:(NSString *)typeEncoding
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _typeEncoding = [typeEncoding copy];
    }
    return self;
}

- (NSString *)name
{
    return _name;
}

- (NSString *)typeEncoding
{
    return _typeEncoding;
}

- (ptrdiff_t)offset
{
    return -1;
}

@end

@implementation MARIvar

+ (instancetype)ivarWithObjCIvar:(Ivar)ivar
{
    return [[self alloc] initWithIvar:ivar];
}

+ (instancetype)ivarWithName:(NSString *)name encode:(const char *)encodeStr
{
    return [[self alloc] initWithName:name encode:encodeStr];
}

+ (instancetype)ivarWithName:(NSString *)name typeEncoding:(NSString *)typeEncoding
{
    return [[self alloc] ivarWithName:name typeEncoding:typeEncoding];
}

- (instancetype)initWithObjCIvar:(Ivar)ivar
{
    return [[_MARObjCIvar alloc] initWithObjCIvar:ivar];
}

- (instancetype)initWithName:(NSString *)name encode:(const char *)encodeStr
{
    return [[_MARComponentsIvar alloc] initWithName:name encode:encodeStr];
}

- (instancetype)initWithName:(NSString *)name typeEncoding:(NSString *)typeEncoding
{
    return [[_MARComponentsIvar alloc] initWithName:name typeEncoding:typeEncoding];
}

- (BOOL)isEqual:(id)object
{
    return [object isKindOfClass:[MARIvar class]] && [[self name] isEqual:[object name]] && [[self typeEncoding] isEqual:[object typeEncoding]] && [self offset] == [object offset];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ %p:[name:%@] [typeEncoding:%@] [offset:%ld]>", [self class], self, [self name], [self typeEncoding], (long)[self offset]];
}

- (NSUInteger)hash
{
    return [[self name] hash] ^ [[self typeEncoding] hash] ^ [self offset];
}

- (NSString *)name
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (MAREncodingType)type
{
    return MAREncodingGetType([[self typeEncoding] UTF8String]);
}

- (NSString *)typeEncoding
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (ptrdiff_t)offset
{
    [self doesNotRecognizeSelector:_cmd];
    return 0;
}

@end
