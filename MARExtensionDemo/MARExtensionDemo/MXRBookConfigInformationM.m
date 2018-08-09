//
//  MXRBookConfigInformationM.m
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2018/8/9.
//  Copyright © 2018年 MAR. All rights reserved.
//


#import "MXRBookConfigInformationM.h"
#import "NSObject+MARModel.h"
#import "MAREXMacro.h"

#define MXRBOOK_CONFIG_SINGLE(property) \
if (!property) {   \
if ([property##s isKindOfClass:[NSArray class]] && property##s.count > 0) { \
property = property##s[0];  \
}   \
}   \
return property;

#define MXRBOOK_CONFIG_ARRAY(property) \
if (!property##s || ![property##s isKindOfClass:[NSArray class]] || property##s == 0) {  \
if (property) {  \
property##s = @[property];  \
}   \
}   \
return property##s;

//#define MXRBOOKCONFIGIMPCLASS(className)   \
//@implementation className  \
//@end
//
//MXRBOOKCONFIGIMPCLASS(MXREnvironmentCM)
//MXRBOOKCONFIGIMPCLASS(MXRResourceCM)
//MXRBOOKCONFIGIMPCLASS(MXRCourseCM)
//MXRBOOKCONFIGIMPCLASS(MXREventCM)

@implementation MXRBookConfigCM

+ (NSDictionary<NSString *,id> *)mar_modelContainerPropertyGenericClass
{
    return @{@"environment" : [MXREnvironmentCM class],
             @"resource"    : [MXRResourceCM class],
             @"courses"     : [MXRCourseCM class],
             @"events"      : [MXREventCM class],
             };
}

+ (NSDictionary<NSString *,id> *)mar_modelCustomPropertyMapper
{
    return @{@"resource"   : @"resources",
             @"courses"     : @"courses.course",
             @"events"      : @"events.event",
             };
}

@end

@implementation MXREnvironmentCM

@end

@implementation MXRResourceCM

+ (NSDictionary<NSString *,id> *)mar_modelContainerPropertyGenericClass
{
    return @{@"markers"     : [MXRMarkerCM class],
             @"models"      : [MXRModelPathCM class],
             @"images"      : [MXRModelPathCM class],
             };
}

+ (NSDictionary<NSString *,id> *)mar_modelCustomPropertyMapper
{
    return @{
             @"markers"     : @"markers.marker",
             @"models"      : @"models.model",
             @"images"      : @"images.image",
             };
}

@end

@implementation MXRMarkerCM

+ (NSDictionary<NSString *,id> *)mar_modelContainerPropertyGenericClass
{
    return @{@"region": [MXRRegionCM class]};
}

@end

@implementation MXRRegionCM

@end

@implementation MXRModelPathCM

@end

@implementation MXRCourseCM

+ (NSDictionary<NSString *,id> *)mar_modelContainerPropertyGenericClass
{
    return @{@"read_through": [MXRReadThroughCM class],
             @"pages": [MXRPageCM class]
             };
}

+ (NSDictionary<NSString *,id> *)mar_modelCustomPropertyMapper
{
    return @{@"pages": @"pages.page",
             };
}

@end

@implementation MXRReadThroughCM

@end

@implementation MXRPageCM

@end

@implementation MXREventCM
+ (NSDictionary<NSString *,id> *)mar_modelContainerPropertyGenericClass
{
    return @{@"groups": [MXRGroupCM class],
             };
}

+ (NSDictionary<NSString *,id> *)mar_modelCustomPropertyMapper
{
    return @{@"groups": @"groups.group",
             };
}

@end


@implementation MXRActionCM

+ (NSDictionary<NSString *,id> *)mar_modelContainerPropertyGenericClass
{
    return @{@"parameters": [MXRParameterCM class]};
}

@end

@implementation MXRParameterCM

+ (NSDictionary<NSString *,id> *)mar_modelContainerPropertyGenericClass
{
    return @{@"scale": [MXRCoordinateCM class],
             @"position": [MXRCoordinateCM class],
             @"rotation": [MXRCoordinateCM class],
             };
}

@end

@implementation MXRCoordinateCM

@end

@implementation MXRGroupCM

+ (NSDictionary<NSString *,id> *)mar_modelContainerPropertyGenericClass
{
    return @{@"actions": [MXRActionCM class],
             };
}

+ (NSDictionary<NSString *,id> *)mar_modelCustomPropertyMapper
{
    return @{@"actions": @"actions.action",
             };
}

@end

@implementation MXRBookConfigInformationM

@end
