//
//  MARProperty.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/6/1.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "MARProperty.h"

@interface _MARComponentsProperty : MARProperty
{
    NSString *_name;
    NSString *_iVarName;
    NSMutableDictionary *_attrs;
//    MAREncodingType _type;
    NSString *_typeEncoding;
}
@end

@implementation _MARComponentsProperty

- (instancetype)initWithName:(NSString *)name attributes:(NSMutableDictionary *)attributes
{
    self = [super init];
    if (self) {
        _name = [name copy];
        if (![name hasPrefix:@"_"]) {
            _iVarName = [NSString stringWithFormat:@"_%@", name];
            _typeEncoding = [attributes objectForKey:@"T"] ? [[attributes objectForKey:@"T"] substringToIndex:1] : [NSString stringWithUTF8String:@encode(id)];
            if (![attributes isKindOfClass:[NSMutableDictionary class]] && [attributes isKindOfClass:[NSDictionary class]]) {
                attributes = [NSMutableDictionary dictionaryWithDictionary:attributes];
            }
            _attrs = attributes;
        }
        
    }
    return self;
}

- (NSString *)name
{
    return _name;
}

- (NSString *)ivarName
{
    if (!_iVarName && ![_iVarName hasPrefix:@"_"]) {
        _iVarName = [NSString stringWithFormat:@"_%@", _iVarName];
    }
    return _iVarName;
}

- (NSString *)typeEncoding
{
    return _typeEncoding;
}

- (NSString *)attributeEncodings
{
    NSMutableArray *filteredAttributes = [NSMutableArray arrayWithCapacity:[_attrs count]];
    for (NSString *attrKey in _attrs)
    {
        [filteredAttributes addObject:[NSString stringWithFormat:@"%@%@", attrKey, [_attrs objectForKey:attrKey] ?: @""]];
    }
    return [filteredAttributes componentsJoinedByString: @","];
}

- (BOOL)addToClass:(Class)clazz
{
    objc_property_attribute_t *cattrs = (objc_property_attribute_t*)calloc([_attrs count], sizeof(objc_property_attribute_t));
    unsigned int attrIndex = 0;
    for (NSString *attrKey in _attrs) {
        cattrs[attrIndex].name = [attrKey UTF8String];
        cattrs[attrIndex].value = [_attrs[attrKey] UTF8String];
    }
    
    BOOL result = class_addProperty(clazz,
                                    [[self name] UTF8String],
                                    cattrs,
                                    (unsigned int)[_attrs count]);
    free(cattrs);
    return result;
}

@end

@interface _MARObjCProperty : MARProperty
{
    objc_property_t _property;
    MAREncodingType _type;
    NSString *_typeEncoding;
    NSString *_name;
    NSString *_ivarName;
    NSMutableDictionary *_attrs;
    Class _clazz;
    SEL _getterSel;
    SEL _setterSel;
}
@end

@implementation _MARObjCProperty

- (instancetype)initWithObjCProperty:(objc_property_t)property
{
    if (!property) return nil;
    self = [super init];
    _property = property;
    const char *name = property_getName(property);
    if (name) {
        _name = [NSString stringWithUTF8String:name];
    }
    
    MAREncodingType type = 0;
    unsigned int attrCount;
    objc_property_attribute_t *attrs = property_copyAttributeList(property, &attrCount);
    for (unsigned int i = 0; i < attrCount; i++) {
        switch (attrs[i].name[0]) {
            case 'T': { // Type encoding
                if (attrs[i].value) {
                    _typeEncoding = [NSString stringWithUTF8String:attrs[i].value];
                    type = MAREncodingGetType(attrs[i].value);
                    
                    if ((type & MAREncodingTypeMask) == MAREncodingTypeObject && _typeEncoding.length) {
                        NSScanner *scanner = [NSScanner scannerWithString:_typeEncoding];
                        if (![scanner scanString:@"@\"" intoString:NULL]) continue;
                        
                        NSString *clsName = nil;
                        if ([scanner scanUpToCharactersFromSet: [NSCharacterSet characterSetWithCharactersInString:@"\"<"] intoString:&clsName]) {
                            if (clsName.length) _clazz = objc_getClass(clsName.UTF8String);
                        }
//                        NSMutableArray *protocols = nil;
//                        while ([scanner scanString:@"<" intoString:NULL]) {
//                            NSString* protocol = nil;
//                            if ([scanner scanUpToString:@">" intoString: &protocol]) {
//                                if (protocol.length) {
//                                    if (!protocols) protocols = [NSMutableArray new];
//                                    [protocols addObject:protocol];
//                                }
//                            }
//                            [scanner scanString:@">" intoString:NULL];
//                        }
//                        _protocols = protocols;
                    }
                }
            } break;
            case 'V': { // Instance variable
                if (attrs[i].value) {
                    _ivarName = [NSString stringWithUTF8String:attrs[i].value];
                }
            } break;
            case 'R': {
                type |= MAREncodingTypePropertyReadonly;
            } break;
            case 'C': {
                type |= MAREncodingTypePropertyCopy;
            } break;
            case '&': {
                type |= MAREncodingTypePropertyRetain;
            } break;
            case 'N': {
                type |= MAREncodingTypePropertyNonatomic;
            } break;
            case 'D': {
                type |= MAREncodingTypePropertyDynamic;
            } break;
            case 'W': {
                type |= MAREncodingTypePropertyWeak;
            } break;
            case 'G': {
                type |= MAREncodingTypePropertyCustomGetter;
                if (attrs[i].value) {
                    _getterSel = NSSelectorFromString([NSString stringWithUTF8String:attrs[i].value]);
                }
            } break;
            case 'S': {
                type |= MAREncodingTypePropertyCustomSetter;
                if (attrs[i].value) {
                    _setterSel = NSSelectorFromString([NSString stringWithUTF8String:attrs[i].value]);
                }
            } // break; commented for code coverage in next line
            default: break;
        }
    }
    if (attrs) {
        free(attrs);
        attrs = NULL;
    }
    
    _type = type;
    if (_name.length) {
        if (!_getterSel) {
            _getterSel = NSSelectorFromString(_name);
        }
        if (!_setterSel) {
            _setterSel = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:", [_name substringToIndex:1].uppercaseString, [_name substringFromIndex:1]]);
        }
    }
    
    NSArray *attrPairs = [[NSString stringWithUTF8String: property_getAttributes(property)] componentsSeparatedByString: @","];
    _attrs = [[NSMutableDictionary alloc] initWithCapacity:[attrPairs count]];
    for(NSString *attrPair in attrPairs)
        [_attrs setObject:[attrPair substringFromIndex:1] forKey:[attrPair substringToIndex:1]];
    
    return self;
}

- (NSString *)name
{
    if (!_property) {
        return nil;
    }
    return [NSString stringWithUTF8String:property_getName(_property)];
}

- (NSString *)ivarName
{
    return _ivarName;
}

- (NSString *)typeEncoding
{
    return _typeEncoding;
}

- (NSString *)attributeEncodings
{
    return [NSString stringWithUTF8String: property_getAttributes(_property)];
}

- (MAREncodingType)type
{
    return _type;
}

- (SEL)setterSEL
{
    return _setterSel;
}

- (SEL)getterSEL
{
    return _getterSel;
}

- (BOOL)addToClass:(Class)clazz
{
    objc_property_attribute_t *cattrs = (objc_property_attribute_t*)calloc([_attrs count], sizeof(objc_property_attribute_t));
    unsigned int attrIndex = 0;
    for (NSString *attrKey in _attrs) {
        cattrs[attrIndex].name = [attrKey UTF8String];
        cattrs[attrIndex].value = [_attrs[attrKey] UTF8String];
    }
    
    BOOL result = class_addProperty(clazz,
                                    [[self name] UTF8String],
                                    cattrs,
                                    (unsigned int)[_attrs count]);
    free(cattrs);
    return result;
}

@end

@implementation MARProperty

+ (instancetype)propertyWithObjCProperty:(objc_property_t)property
{
    return [[self alloc] initWithObjCProperty:property];
}

+ (instancetype)propertyWithName:(NSString *)name attributes:(NSDictionary *)attributes
{
    return [[self alloc] initWithName:name attributes:attributes];
}

- (instancetype)initWithObjCProperty:(objc_property_t)property
{
    return [[_MARObjCProperty alloc] initWithObjCProperty:property];
}

- (instancetype)initWithName:(NSString *)name attributes:(NSDictionary *)attributes
{
    return [[_MARComponentsProperty alloc] initWithName:name attributes:attributes];
}

- (NSString *)name
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSString *)ivarName
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSString *)attributeEncodings
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (MAREncodingType)type
{
    [self doesNotRecognizeSelector:_cmd];
    return MAREncodingTypeUnknown;
}

- (NSString *)typeEncoding
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (SEL)setterSEL
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (SEL)getterSEL
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (BOOL)addToClass:(Class)clazz
{
    [self doesNotRecognizeSelector:_cmd];
    return NO;
}

@end
