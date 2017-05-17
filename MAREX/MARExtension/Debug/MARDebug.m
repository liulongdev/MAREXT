//
//  MARDebug.m
//  MARExtensionDemo
//
//  Created by Martin.Liu on 17/5/16.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MARDebug.h"
#import <objc/runtime.h>

NSString*
MARDebugFunctionMsg(const char *func, const char *file, int line, NSString *fmt)
{
    NSString *message;
    message = [NSString stringWithFormat: @"File %s: %d. In %s %@",
               file, line, func, fmt];
    return message;
}

NSString*
MARDebugMethodMsg(id obj, SEL sel, const char *file, int line, NSString *fmt)
{
    NSString	*message;
    Class	cls = [obj class];
    char		c = '-';
    
    if (class_isMetaClass(cls))
    {
        cls = (Class)obj;
        c = '+';
    }
    message = [NSString stringWithFormat: @"File %s: %d. In [%@ %c%@] %@",
               file, line, NSStringFromClass(cls), c, NSStringFromSelector(sel), fmt];
    return message;
}

@implementation MARDebug

static MARDebugLogLevel _debugLogLevel;

+ (void)load
{
    _debugLogLevel = MARDebugLogLevelALL;
}

+ (MARDebugLogLevel)debugLogLevel
{
    return _debugLogLevel;
}

+ (void)setDebugLogLevel:(MARDebugLogLevel)debugLogLevel
{
    _debugLogLevel = debugLogLevel;
}


@end
