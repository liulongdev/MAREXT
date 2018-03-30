//
//  MARDebug.h
//  MARExtensionDemo
//
//  Created by Martin.Liu on 17/5/16.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAREXMacro.h"

typedef NS_OPTIONS(NSUInteger, MARDebugLogLevel) {
    MARDebugLogLevelNone            = 0,
    MARDebugLogLevelInfo            = 1 << 0,
    MARDebugLogLevelWarn            = 1 << 1,
    MARDebugLogLevelError           = 1 << 2,
    MARDebugLogLevelALL             = 0xFFFFFFFF
};

#define MARDebugLog
#ifdef MARDebugLog
#define MARDEBUGLOGLEVEL            [MARDebug debugLogLevel]
#define MARDebugCouldLogInfo()      (MARDEBUGLOGLEVEL & MARDebugLogLevelInfo)
#define MARDebugCouldLogWarn()      (MARDEBUGLOGLEVEL & MARDebugLogLevelWarn)
#define MARDebugCouldLogError()     (MARDEBUGLOGLEVEL & MARDebugLogLevelError)

#ifndef MARAssert
#define MARAssert(a,s, ...) NSAssert(!(a), @"%s [Line %d] %@", __PRETTY_FUNCTION__, __LINE__,[NSString stringWithFormat:(s), ##__VA_ARGS__] );
#endif

#define MARInfoLog(format, args...)                             \
do {                                                    \
if (MARDebugCouldLogInfo()) {                       \
NSString *s = MARDebugMethodMsg(                \
self, _cmd, __FILE__, __LINE__,                 \
[NSString stringWithFormat: format, ##args]);   \
NSLog(@"[info]%@", s);                          \
}                                                   \
} while (0)

#define MARWarnLog(format, args...)                             \
do {                                                    \
if (MARDebugCouldLogWarn()) {                       \
NSString *s = MARDebugMethodMsg(                \
self, _cmd, __FILE__, __LINE__,                 \
[NSString stringWithFormat: format, ##args]);   \
NSLog(@"[warn]%@", s);                          \
}                                                   \
} while (0)

#define MARErrorLog(format, args...)                            \
do {                                                    \
if (MARDebugCouldLogError()) {                      \
NSString *s = MARDebugMethodMsg(                \
self, _cmd, __FILE__, __LINE__,                 \
[NSString stringWithFormat: format, ##args]);   \
NSLog(@"[error]%@", s);                         \
}                                                   \
} while (0)

#define MARFuncInfoLog(format, args...)                         \
do {                                                    \
if (MARDebugCouldLogInfo()) {                       \
NSString *s = MARDebugFunctionMsg(              \
__PRETTY_FUNCTION__, __FILE__, __LINE__,        \
[NSString stringWithFormat: format, ##args]);   \
NSLog(@"[info]%@", s);                          \
}                                                   \
} while (0)

#define MARFuncWarnLog(format, args...)                         \
do {                                                    \
if (MARDebugCouldLogWarn()) {                       \
NSString *s = MARDebugFunctionMsg(              \
__PRETTY_FUNCTION__, __FILE__, __LINE__,        \
[NSString stringWithFormat: format, ##args]);   \
NSLog(@"[warn]%@", s);                          \
}                                                   \
} while (0)

#define MARFuncErrorLog(format, args...)                        \
do {                                                    \
if (MARDebugCouldLogError()) {                      \
NSString *s = MARDebugFunctionMsg(              \
__PRETTY_FUNCTION__, __FILE__, __LINE__,        \
[NSString stringWithFormat: format, ##args]);   \
NSLog(@"[error]%@", s);                         \
}                                                   \
} while (0)

#else

#define MARInfoLog(format, args...)     do {} while (0)
#define MARWarnLog(format, args...)     do {} while (0)
#define MARErrorLog(format, args...)    do {} while (0)

#define MARFuncInfoLog(format, args...)     do {} while (0)
#define MARFuncWarnLog(format, args...)     do {} while (0)
#define MARFuncErrorLog(format, args...)    do {} while (0)

#endif


#define MARLog(format, ...) MARInfoLog(format, ##__VA_ARGS__);

MAR_EXTERN_C_BEGIN

/**
 * Used to produce a format string for logging a message with function
 * location details.
 */
extern NSString*	MARDebugFunctionMsg(const char *func, const char *file,
                                        int line, NSString *fmt);
/**
 * Used to produce a format string for logging a message with method
 * location details.
 */
extern NSString*	MARDebugMethodMsg(id obj, SEL sel, const char *file,
                                      int line, NSString *fmt);


@interface MARDebug : NSObject

+ (MARDebugLogLevel)debugLogLevel;

+ (void)setDebugLogLevel:(MARDebugLogLevel)debugLogLevel;

@end


MAR_EXTERN_C_END
