//
//  MARClassInfo.h
//  MTNLibrary
//
//  Created by Martin.Liu on 16/11/29.
//  Copyright © 2016年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

/**
 Between NS_ASSUME_NONNULL_BEGIN and NS_ASSUME_NONNULL_END assum property nonnull default,
 if don't should add nullabel
 */
NS_ASSUME_NONNULL_BEGIN

/**
 Type encoding's type.
 */
typedef NS_OPTIONS(NSUInteger, MAREncodingType) {
    MAREncodingTypeMask       = 0xFF, ///< mask of type value
    MAREncodingTypeUnknown    = 0,  ///< unknown
    MAREncodingTypeVoid       = 1,  ///< void
    MAREncodingTypeBool       = 2,  ///< bool
    MAREncodingTypeInt8       = 3,  ///< char / BOOL
    MAREncodingTypeUInt8      = 4,  ///< unsigned char
    MAREncodingTypeInt16      = 5,  ///< short
    MAREncodingTypeUInt16     = 6,  ///< unsigned short
    MAREncodingTypeInt32      = 7,  ///< int
    MAREncodingTypeUInt32     = 8,  ///< unsigned int
    MAREncodingTypeInt64      = 9,  ///< long long
    MAREncodingTypeUInt64     = 10, ///< unsigned long long
    MAREncodingTypeFloat      = 11, ///< float
    MAREncodingTypeDouble     = 12, ///< double
    MAREncodingTypeLongDouble = 13, ///< long double
    MAREncodingTypeObject     = 14, ///< id
    MAREncodingTypeClass      = 15, ///< Class
    MAREncodingTypeSEL        = 16, ///< SEL
    MAREncodingTypeBlock      = 17, ///< block
    MAREncodingTypePointer    = 18, ///< void*
    MAREncodingTypeStruct     = 19, ///< struct
    MAREncodingTypeUnion      = 20, ///< union
    MAREncodingTypeCString    = 21, ///< char*
    MAREncodingTypeCArray     = 22, ///< char[10] (for example)
    
    MAREncodingTypeQualifierMask   = 0xFF00,  ///< mask of qualifier
    MAREncodingTypeQualifierConst  = 1 << 8,  ///< const
    MAREncodingTypeQualifierIn     = 1 << 9,  ///< in
    MAREncodingTypeQualifierInout  = 1 << 10, ///< inout
    MAREncodingTypeQualifierOut    = 1 << 11, ///< out
    MAREncodingTypeQualifierBycopy = 1 << 12, ///< bycopy
    MAREncodingTypeQualifierByref  = 1 << 13, ///< byref
    MAREncodingTypeQualifierOneway = 1 << 14, ///< oneway
    
    MAREncodingTypePropertyMask         = 0xFF0000,///< mask of property
    MAREncodingTypePropertyReadonly     = 1 << 16, ///< readonly
    MAREncodingTypePropertyCopy         = 1 << 17, ///< copy
    MAREncodingTypePropertyRetain       = 1 << 18, ///< retain
    MAREncodingTypePropertyNonatomic    = 1 << 19, ///< nonatomic
    MAREncodingTypePropertyWeak         = 1 << 20, ///< weak
    MAREncodingTypePropertyCustomGetter = 1 << 21, ///< getter=
    MAREncodingTypePropertyCustomSetter = 1 << 22, ///< setter=
    MAREncodingTypePropertyDynamic      = 1 << 23, ///< @dynamic
};

/**
 Get the type from a Type-Encoding string.
 
 @discussion See also:
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html
 
 @param typeEncoding  A Type-Encoding string.
 @return The encoding type.
 */
MAREncodingType MAREncodingGetType(const char *typeEncoding);


/**
 Instance variable information.
 */
@interface MARClassIvarInfo : NSObject
@property (nonatomic, assign, readonly) Ivar ivar;              ///< ivar opaque struct
@property (nonatomic, strong, readonly) NSString *name;         ///< Ivar's name
@property (nonatomic, assign, readonly) ptrdiff_t offset;       ///< Ivar's offset
@property (nonatomic, strong, readonly) NSString *typeEncoding; ///< Ivar's type encoding
@property (nonatomic, assign, readonly) MAREncodingType type;   ///< Ivar's type

/**
 Creates and returns an ivar info object.
 
 @param ivar ivar opaque struct
 @return A new object, or nil if an error occurs.
 */
- (instancetype)initWithIvar:(Ivar)ivar;
@end


/**
 Method information.
 */
@interface MARClassMethodInfo : NSObject
@property (nonatomic, assign, readonly) Method method;                  ///< method opaque struct
@property (nonatomic, strong, readonly) NSString *name;                 ///< method name
@property (nonatomic, assign, readonly) SEL sel;                        ///< method's selector
@property (nonatomic, assign, readonly) IMP imp;                        ///< method's implementation
@property (nonatomic, strong, readonly) NSString *typeEncoding;         ///< method's parameter and return types
@property (nonatomic, strong, readonly) NSString *returnTypeEncoding;   ///< return value's type
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *argumentTypeEncodings; ///< array of arguments' type

/**
 Creates and returns a method info object.
 
 @param method method opaque struct
 @return A new object, or nil if an error occurs.
 */
- (instancetype)initWithMethod:(Method)method;
@end


/**
 Property information.
 */
@interface MARClassPropertyInfo : NSObject
@property (nonatomic, assign, readonly) objc_property_t property; ///< property's opaque struct
@property (nonatomic, strong, readonly) NSString *name;           ///< property's name
@property (nonatomic, assign, readonly) MAREncodingType type;     ///< property's type
@property (nonatomic, strong, readonly) NSString *typeEncoding;   ///< property's encoding value
@property (nonatomic, strong, readonly) NSString *ivarName;       ///< property's ivar name
@property (nullable, nonatomic, assign, readonly) Class cls;      ///< may be nil
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *protocols; ///< may nil
@property (nonatomic, assign, readonly) SEL getter;               ///< getter (nonnull)
@property (nonatomic, assign, readonly) SEL setter;               ///< setter (nonnull)

/**
 Creates and returns a property info object.
 
 @param property property opaque struct
 @return A new object, or nil if an error occurs.
 */
- (instancetype)initWithProperty:(objc_property_t)property;
@end


/**
 Class information for a class.
 */
@interface MARClassInfo : NSObject
@property (nonatomic, assign, readonly) Class cls; ///< class object
@property (nullable, nonatomic, assign, readonly) Class superCls; ///< super class object
@property (nullable, nonatomic, assign, readonly) Class metaCls;  ///< class's meta class object
@property (nonatomic, readonly) BOOL isMeta; ///< whether this class is meta class
@property (nonatomic, strong, readonly) NSString *name; ///< class name
@property (nullable, nonatomic, strong, readonly) MARClassInfo *superClassInfo; ///< super class's class info
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, MARClassIvarInfo *> *ivarInfos; ///< ivars
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, MARClassMethodInfo *> *methodInfos; ///< methods
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, MARClassPropertyInfo *> *propertyInfos; ///< properties

/**
 If the class is changed (for example: you add a method to this class with
 'class_addMethod()'), you should call this method to refresh the class info cache.
 
 After called this method, `needUpdate` will returns `YES`, and you should call
 'classInfoWithClass' or 'classInfoWithClassName' to get the updated class info.
 */
- (void)setNeedUpdate;

/**
 If this method returns `YES`, you should stop using this instance and call
 `classInfoWithClass` or `classInfoWithClassName` to get the updated class info.
 
 @return Whether this class info need update.
 */
- (BOOL)needUpdate;

/**
 Get the class info of a specified Class.
 
 @discussion This method will cache the class info and super-class info
 at the first access to the Class. This method is thread-safe.
 
 @param cls A class.
 @return A class info, or nil if an error occurs.
 */
+ (nullable instancetype)classInfoWithClass:(Class)cls;

/**
 Get the class info of a specified Class.
 
 @discussion This method will cache the class info and super-class info
 at the first access to the Class. This method is thread-safe.
 
 @param className A class name.
 @return A class info, or nil if an error occurs.
 */
+ (nullable instancetype)classInfoWithClassName:(NSString *)className;

@end

NS_ASSUME_NONNULL_END

