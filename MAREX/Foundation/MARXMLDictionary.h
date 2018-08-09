//
//  MARXMLDictionary.h
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2018/8/9.
//  Copyright © 2018年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MARXMLDictionaryAttributesMode)
{
    MARXMLDictionaryAttributesModePrefixed = 0, //default
    MARXMLDictionaryAttributesModeDictionary,
    MARXMLDictionaryAttributesModeUnprefixed,
    MARXMLDictionaryAttributesModeDiscard
};


typedef NS_ENUM(NSInteger, MARXMLDictionaryNodeNameMode)
{
    MARXMLDictionaryNodeNameModeRootOnly = 0, //default
    MARXMLDictionaryNodeNameModeAlways,
    MARXMLDictionaryNodeNameModeNever
};

static NSString * const MARXMLDictionaryAttributesKey   = @"__attributes";
static NSString * const MARXMLDictionaryCommentsKey     = @"__comments";
static NSString * const MARXMLDictionaryTextKey         = @"__text";
static NSString * const MARXMLDictionaryNodeNameKey     = @"__name";
static NSString * const MARXMLDictionaryAttributePrefix = @"_";

@interface MARXMLDictionaryParser : NSObject<NSCopying>

+ (instancetype)sharedInstance;

@property (nonatomic, assign) BOOL collapseTextNodes; // defaults to YES
@property (nonatomic, assign) BOOL stripEmptyNodes;   // defaults to YES
@property (nonatomic, assign) BOOL trimWhiteSpace;    // defaults to YES
@property (nonatomic, assign) BOOL alwaysUseArrays;   // defaults to NO
@property (nonatomic, assign) BOOL preserveComments;  // defaults to NO
@property (nonatomic, assign) BOOL wrapRootNode;      // defaults to NO

@property (nonatomic, assign) MARXMLDictionaryAttributesMode attributesMode;
@property (nonatomic, assign) MARXMLDictionaryNodeNameMode nodeNameMode;

- (nullable NSDictionary<NSString *, id> *)dictionaryWithParser:(NSXMLParser *)parser;
- (nullable NSDictionary<NSString *, id> *)dictionaryWithData:(NSData *)data;
- (nullable NSDictionary<NSString *, id> *)dictionaryWithString:(NSString *)string;
- (nullable NSDictionary<NSString *, id> *)dictionaryWithFile:(NSString *)path;

@end

@interface NSDictionary (MARXMLDictionary)

+ (nullable NSDictionary<NSString *, id> *)mar_dictionaryWithXMLParser:(NSXMLParser *)parser;
+ (nullable NSDictionary<NSString *, id> *)mar_dictionaryWithXMLData:(NSData *)data;
+ (nullable NSDictionary<NSString *, id> *)mar_dictionaryWithXMLString:(NSString *)string;
+ (nullable NSDictionary<NSString *, id> *)mar_dictionaryWithXMLFile:(NSString *)path;

@property (nonatomic, readonly, copy, nullable) NSDictionary<NSString *, NSString *> *mar_attributes;
@property (nonatomic, readonly, copy, nullable) NSDictionary<NSString *, id> *mar_childNodes;
@property (nonatomic, readonly, copy, nullable) NSArray<NSString *> *mar_comments;
@property (nonatomic, readonly, copy, nullable) NSString *mar_nodeName;
@property (nonatomic, readonly, copy, nullable) NSString *mar_innerText;
@property (nonatomic, readonly, copy) NSString *mar_innerXML;
@property (nonatomic, readonly, copy) NSString *mar_XMLString;

- (nullable NSArray *)mar_arrayValueForKeyPath:(NSString *)keyPath;
- (nullable NSString *)mar_stringValueForKeyPath:(NSString *)keyPath;
- (nullable NSDictionary<NSString *, id> *)mar_dictionaryValueForKeyPath:(NSString *)keyPath;

@end


@interface NSString (MARXMLDictionary)

@property (nonatomic, readonly, copy) NSString *mar_XMLEncodedString;

@end


NS_ASSUME_NONNULL_END
