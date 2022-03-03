//
//  UIDevice+MAREX.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kMARMachieNameIPhone1G;
extern NSString * const kMARMachieNameIPhone3G;
extern NSString * const kMARMachieNameIPhones3GS;
extern NSString * const kMARMachieNameIPhone4GSM;
extern NSString * const kMARMachieNameIPhone4;
extern NSString * const kMARMachieNameIPhone4CDMA;
extern NSString * const kMARMachieNameIPhone4S;
extern NSString * const kMARMachieNameIPhone5;
extern NSString * const kMARMachieNameIPhone5C;
extern NSString * const kMARMachieNameIPhone5S;
extern NSString * const kMARMachieNameIPhone6Plus;
extern NSString * const kMARMachieNameIPhone6;
extern NSString * const kMARMachieNameIPhone6S;
extern NSString * const kMARMachieNameIPhone6SPlus;
extern NSString * const kMARMachieNameIPhoneSE;
extern NSString * const kMARMachieNameIPhone7;
extern NSString * const kMARMachieNameIPhone7Plus;
extern NSString * const kMARMachieNameIPhone8;
extern NSString * const kMARMachieNameIPhone8Plus;
extern NSString * const kMARMachieNameIPhoneX;
extern NSString * const kMARMachieNameIphoneXR;
extern NSString * const kMARMachieNameIphoneXS;
extern NSString * const kMARMachieNameIphoneXSMax;

#define kMAROldMachies              (@[kMARMachieNameIPhone1G, \
kMARMachieNameIPhone3G, \
kMARMachieNameIPhones3GS,\
kMARMachieNameIPhone4GSM,\
kMARMachieNameIPhone4,\
kMARMachieNameIPhone4CDMA,\
kMARMachieNameIPhone4S\
])

#define kMARIphone5SeriesMachies    (@[kMARMachieNameIPhone5, \
kMARMachieNameIPhone5C, \
kMARMachieNameIPhone5S,\
kMARMachieNameIPhoneSE\
])

#define kMARIphone6SeriesMachies    (@[kMARMachieNameIPhone6, \
kMARMachieNameIPhone6Plus, \
kMARMachieNameIPhone6S\
])

#define kMARIphone7SeriesMachies    (@[kMARMachieNameIPhone6, \
kMARMachieNameIPhone6Plus, \
kMARMachieNameIPhone6S\
])

#define kMARISOldMachie()           ([kMAROldMachies containsObject:[UIDevice currentDevice].MAR_machineModelName])
#define kMARISIphone5Series()       ([kMARIphone5SeriesMachies containsObject:[UIDevice currentDevice].MAR_machineModelName])
#define kMARISIphone6Series()       ([kMARIphone6SeriesMachies containsObject:[UIDevice currentDevice].MAR_machineModelName])
#define kMARISIphone7Series()       ([kMARIphone7SeriesMachies containsObject:[UIDevice currentDevice].MAR_machineModelName])

#define kMARIsIOSLater(_value_)     ([UIDevice currentDevice].systemVersion.doubleValue >= _value_)

@interface UIDevice (MAREX)

#pragma mark - Device Information
///=============================================================================
/// @name Device Information
///=============================================================================

/// Device system version (e.g. 8.1)
+ (double)mar_systemVersion;

/// Whether the device is iPad/iPad mini.
@property (nonatomic, readonly) BOOL mar_isPad;

/// Whether the device is a simulator.
@property (nonatomic, readonly) BOOL mar_isSimulator;

/// Whether the device is jailbroken.
@property (nonatomic, readonly) BOOL mar_isJailbroken;

/// Whether the current device has a Retina display
@property (nonatomic, readonly) BOOL mar_isRetina;

///  Whether if the current device has a Retina HD display
@property (nonatomic, readonly) BOOL mar_isRetinaHD;

/// Wherher the device can make phone calls.
@property (nonatomic, readonly) BOOL mar_canMakePhoneCalls NS_EXTENSION_UNAVAILABLE_IOS("");

/// The device's machine model.  e.g. "iPhone6,1" "iPad4,6"
/// @see http://theiphonewiki.com/wiki/Models
@property (nullable, nonatomic, readonly) NSString *mar_machineModel;

/// The device's machine model name. e.g. "iPhone 5s" "iPad mini 2"
/// @see http://theiphonewiki.com/wiki/Models
@property (nullable, nonatomic, readonly) NSString *mar_machineModelName;

/// The System's startup time.
@property (nonatomic, readonly) NSDate *mar_systemUptime;

/// Whther the device's screen is notch.
@property (nonatomic, readonly) BOOL mar_isNotchScreen;

#pragma mark - Network Information
///=============================================================================
/// @name Network Information
///=============================================================================

/// WIFI IP address of this device (can be nil). e.g. @"192.168.1.111"
@property (nullable, nonatomic, readonly) NSString *mar_ipAddressWIFI;

/// Cell IP address of this device (can be nil). e.g. @"10.2.2.222"
@property (nullable, nonatomic, readonly) NSString *mar_ipAddressCell;


/**
 Network traffic type:
 
 WWAN: Wireless Wide Area Network.
 For example: 3G/4G.
 
 WIFI: Wi-Fi.
 
 AWDL: Apple Wireless Direct Link (peer-to-peer connection).
 For exmaple: AirDrop, AirPlay, GameKit.
 */
typedef NS_OPTIONS(NSUInteger, MARNetworkTrafficType) {
    MARNetworkTrafficTypeWWANSent     = 1 << 0,
    MARNetworkTrafficTypeWWANReceived = 1 << 1,
    MARNetworkTrafficTypeWIFISent     = 1 << 2,
    MARNetworkTrafficTypeWIFIReceived = 1 << 3,
    MARNetworkTrafficTypeAWDLSent     = 1 << 4,
    MARNetworkTrafficTypeAWDLReceived = 1 << 5,
    
    MARNetworkTrafficTypeWWAN = MARNetworkTrafficTypeWWANSent | MARNetworkTrafficTypeWWANReceived,
    MARNetworkTrafficTypeWIFI = MARNetworkTrafficTypeWIFISent | MARNetworkTrafficTypeWIFIReceived,
    MARNetworkTrafficTypeAWDL = MARNetworkTrafficTypeAWDLSent | MARNetworkTrafficTypeAWDLReceived,
    
    MARNetworkTrafficTypeALL = MARNetworkTrafficTypeWWAN |
    MARNetworkTrafficTypeWIFI |
    MARNetworkTrafficTypeAWDL,
};

/**
 Get device network traffic bytes.
 
 @discussion This is a counter since the device's last boot time.
 Usage:
 
 uint64_t bytes = [[UIDevice currentDevice] getNetworkTrafficBytes:MARNetworkTrafficTypeALL];
 NSTimeInterval time = CACurrentMediaTime();
 
 uint64_t bytesPerSecond = (bytes - _lastBytes) / (time - _lastTime);
 
 _lastBytes = bytes;
 _lastTime = time;
 
 
 @param types traffic types
 @return bytes counter.
 */
- (uint64_t)mar_getNetworkTrafficBytes:(MARNetworkTrafficType)types;


#pragma mark - Disk Space
///=============================================================================
/// @name Disk Space
///=============================================================================

/// Total disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t mar_diskSpace;

/// Free disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t mar_diskSpaceFree;

/// Used disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t mar_diskSpaceUsed;


#pragma mark - Memory Information
///=============================================================================
/// @name Memory Information
///=============================================================================

/// Total physical memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t mar_memoryTotal;

/// Used (active + inactive + wired) memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t mar_memoryUsed;

/// Free memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t mar_memoryFree;

/// Acvite memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t mar_memoryActive;

/// Inactive memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t mar_memoryInactive;

/// Wired memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t mar_memoryWired;

/// Purgable memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t mar_memoryPurgable;

#pragma mark - CPU Information
///=============================================================================
/// @name CPU Information
///=============================================================================

/// Avaliable CPU processor count.
@property (nonatomic, readonly) NSUInteger mar_cpuCount;

/// Current CPU usage, 1.0 means 100%. (-1 when error occurs)
@property (nonatomic, readonly) float mar_cpuUsage;

/// Current CPU usage per processor (array of NSNumber), 1.0 means 100%. (nil when error occurs)
@property (nullable, nonatomic, readonly) NSArray<NSNumber *> *mar_cpuUsagePerProcessor;


@end

NS_ASSUME_NONNULL_END
