//
//  UIDevice+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "UIDevice+MAREX.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <mach/mach.h>
#include <arpa/inet.h>
#include <ifaddrs.h>
#import "NSString+MAREX.h"


NSString * const kMARMachieNameIPhone1G     = @"iPhone 1G";
NSString * const kMARMachieNameIPhone3G     = @"iPhone 3G";
NSString * const kMARMachieNameIPhones3GS   = @"iPhone 3GS";
NSString * const kMARMachieNameIPhone4GSM   = @"iPhone 4 (GSM)";
NSString * const kMARMachieNameIPhone4      = @"iPhone 4";
NSString * const kMARMachieNameIPhone4CDMA  = @"iPhone 4 (CDMA)";
NSString * const kMARMachieNameIPhone4S     = @"iPhone 4S";
NSString * const kMARMachieNameIPhone5      = @"iPhone 5";
NSString * const kMARMachieNameIPhone5C     = @"iPhone 5c";
NSString * const kMARMachieNameIPhone5S     = @"iPhone 5s";
NSString * const kMARMachieNameIPhone6Plus  = @"iPhone 6 Plus";
NSString * const kMARMachieNameIPhone6      = @"iPhone 6";
NSString * const kMARMachieNameIPhone6S     = @"iPhone 6s";
NSString * const kMARMachieNameIPhone6SPlus = @"iPhone 6s Plus";
NSString * const kMARMachieNameIPhoneSE     = @"iPhone SE";
NSString * const kMARMachieNameIPhone7      = @"iPhone 7";
NSString * const kMARMachieNameIPhone7Plus  = @"iPhone 7 Plus";
NSString * const kMARMachieNameIPhone8      = @"iPhone 8";
NSString * const kMARMachieNameIPhone8Plus  = @"iPhone 8 Plus";
NSString * const kMARMachieNameIPhoneX      = @"iPhone X";
NSString * const kMARMachieNameIphoneXR     = @"iPhone XR";
NSString * const kMARMachieNameIphoneXS     = @"iPhone XS";
NSString * const kMARMachieNameIphoneXSMax  = @"iPhone XS Max";
NSString * const kMARMachieNameIphone11         = @"iPhone 11";
NSString * const kMARMachieNameIphone11Pro      = @"iPhone 11 Pro";
NSString * const kMARMachieNameIphone11ProMax   = @"iPhone 11 Pro Max";
NSString * const kMARMachieNameIphoneSE2nd      = @"iPhone SE (2nd generation)";
NSString * const kMARMachieNameIphone12Mini     = @"iPhone 12 mini";
NSString * const kMARMachieNameIphone12         = @"iPhone 12";
NSString * const kMARMachieNameIphone12Pro      = @"iPhone 12 Pro";
NSString * const kMARMachieNameIphone12ProMax   = @"iPhone 12 Pro Max";
NSString * const kMARMachieNameIphone13Mini     = @"iPhone 13 mini";
NSString * const kMARMachieNameIphone13         = @"iPhone 13";
NSString * const kMARMachieNameIphone13Pro      = @"iPhone 13 Pro";
NSString * const kMARMachieNameIphone13PeoMax   = @"iPhone 13 Pro Max";

@implementation UIDevice (MAREX)

+ (double)mar_systemVersion
{
    static double version;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        version = [UIDevice currentDevice].systemVersion.doubleValue;
    });
    return version;
}

- (BOOL)mar_isPad
{
    static BOOL pad;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    });
    return pad;
}

- (BOOL)mar_isSimulator
{
#if TARGET_OS_SIMULATOR
    return YES;
#else
    return NO;
#endif
}

- (BOOL)mar_isJailbroken
{
    if ([self mar_isSimulator]) return NO; // Dont't check simulator
    
    // iOS9 URL Scheme query changed ...
    // NSURL *cydiaURL = [NSURL URLWithString:@"cydia://package"];
    // if ([[UIApplication sharedApplication] canOpenURL:cydiaURL]) return YES;
    
    NSArray *paths = @[@"/Applications/Cydia.app",
                       @"/private/var/lib/apt/",
                       @"/private/var/lib/cydia",
                       @"/private/var/stash"];
    for (NSString *path in paths) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) return YES;
    }
    
    FILE *bash = fopen("/bin/bash", "r");
    if (bash != NULL) {
        fclose(bash);
        return YES;
    }
    
    NSString *path = [NSString stringWithFormat:@"/private/%@", [NSString mar_stringWithUUID]];
    if ([@"test" writeToFile : path atomically : YES encoding : NSUTF8StringEncoding error : NULL]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        return YES;
    }
    
    return NO;
}

- (BOOL)mar_isRetina
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0 || [UIScreen mainScreen].scale == 3.0 || [UIScreen mainScreen].scale > 3)) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)mar_isRetinaHD
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 3.0 || [UIScreen mainScreen].scale > 3)) {
        return YES;
    } else {
        return NO;
    }
}

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
- (BOOL)mar_canMakePhoneCalls {
    __block BOOL can;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        can = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
    });
    return can;
}
#endif

- (NSString *)mar_ipAddressWithIfaName:(NSString *)name {
    if (name.length == 0) return nil;
    NSString *address = nil;
    struct ifaddrs *addrs = NULL;
    if (getifaddrs(&addrs) == 0) {
        struct ifaddrs *addr = addrs;
        while (addr) {
            if ([[NSString stringWithUTF8String:addr->ifa_name] isEqualToString:name]) {
                sa_family_t family = addr->ifa_addr->sa_family;
                switch (family) {
                    case AF_INET: { // IPv4
                        char str[INET_ADDRSTRLEN] = {0};
                        inet_ntop(family, &(((struct sockaddr_in *)addr->ifa_addr)->sin_addr), str, sizeof(str));
                        if (strlen(str) > 0) {
                            address = [NSString stringWithUTF8String:str];
                        }
                    } break;
                        
                    case AF_INET6: { // IPv6
                        char str[INET6_ADDRSTRLEN] = {0};
                        inet_ntop(family, &(((struct sockaddr_in6 *)addr->ifa_addr)->sin6_addr), str, sizeof(str));
                        if (strlen(str) > 0) {
                            address = [NSString stringWithUTF8String:str];
                        }
                    }
                        
                    default: break;
                }
                if (address) break;
            }
            addr = addr->ifa_next;
        }
    }
    freeifaddrs(addrs);
    return address;
}

- (NSString *)mar_ipAddressWIFI {
    return [self mar_ipAddressWithIfaName:@"en0"];
}

- (NSString *)mar_ipAddressCell {
    return [self mar_ipAddressWithIfaName:@"pdp_ip0"];
}

typedef struct {
    uint64_t en_in;
    uint64_t en_out;
    uint64_t pdp_ip_in;
    uint64_t pdp_ip_out;
    uint64_t awdl_in;
    uint64_t awdl_out;
} mar_net_interface_counter;


static uint64_t mar_net_counter_add(uint64_t counter, uint64_t bytes) {
    if (bytes < (counter % 0xFFFFFFFF)) {
        counter += 0xFFFFFFFF - (counter % 0xFFFFFFFF);
        counter += bytes;
    } else {
        counter = bytes;
    }
    return counter;
}

static uint64_t mar_net_counter_get_by_type(mar_net_interface_counter *counter, MARNetworkTrafficType type) {
    uint64_t bytes = 0;
    if (type & MARNetworkTrafficTypeWWANSent) bytes += counter->pdp_ip_out;
    if (type & MARNetworkTrafficTypeWWANReceived) bytes += counter->pdp_ip_in;
    if (type & MARNetworkTrafficTypeWIFISent) bytes += counter->en_out;
    if (type & MARNetworkTrafficTypeWIFIReceived) bytes += counter->en_in;
    if (type & MARNetworkTrafficTypeAWDLSent) bytes += counter->awdl_out;
    if (type & MARNetworkTrafficTypeAWDLReceived) bytes += counter->awdl_in;
    return bytes;
}

static mar_net_interface_counter mar_get_net_interface_counter() {
    static dispatch_semaphore_t lock;
    static NSMutableDictionary *sharedInCounters;
    static NSMutableDictionary *sharedOutCounters;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInCounters = [NSMutableDictionary new];
        sharedOutCounters = [NSMutableDictionary new];
        lock = dispatch_semaphore_create(1);
    });
    
    mar_net_interface_counter counter = {0};
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    if (getifaddrs(&addrs) == 0) {
        cursor = addrs;
        dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
        while (cursor) {
            if (cursor->ifa_addr->sa_family == AF_LINK) {
                const struct if_data *data = cursor->ifa_data;
                NSString *name = cursor->ifa_name ? [NSString stringWithUTF8String:cursor->ifa_name] : nil;
                if (name) {
                    uint64_t counter_in = ((NSNumber *)sharedInCounters[name]).unsignedLongLongValue;
                    counter_in = mar_net_counter_add(counter_in, data->ifi_ibytes);
                    sharedInCounters[name] = @(counter_in);
                    
                    uint64_t counter_out = ((NSNumber *)sharedOutCounters[name]).unsignedLongLongValue;
                    counter_out = mar_net_counter_add(counter_out, data->ifi_obytes);
                    sharedOutCounters[name] = @(counter_out);
                    
                    if ([name hasPrefix:@"en"]) {
                        counter.en_in += counter_in;
                        counter.en_out += counter_out;
                    } else if ([name hasPrefix:@"awdl"]) {
                        counter.awdl_in += counter_in;
                        counter.awdl_out += counter_out;
                    } else if ([name hasPrefix:@"pdp_ip"]) {
                        counter.pdp_ip_in += counter_in;
                        counter.pdp_ip_out += counter_out;
                    }
                }
            }
            cursor = cursor->ifa_next;
        }
        dispatch_semaphore_signal(lock);
        freeifaddrs(addrs);
    }
    
    return counter;
}

- (uint64_t)mar_getNetworkTrafficBytes:(MARNetworkTrafficType)types {
    mar_net_interface_counter counter = mar_get_net_interface_counter();
    return mar_net_counter_get_by_type(&counter, types);
}

- (NSString *)mar_machineModel {
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
    });
    return model;
}

- (NSString *)mar_machineModelName {
    static dispatch_once_t one;
    static NSString *name;
    dispatch_once(&one, ^{
        NSString *model = [self mar_machineModel];
        if (!model) return;
        NSDictionary *dic = @{
                                // Apple Watch
                              @"Watch1,1" : @"Apple Watch 38mm",
                              @"Watch1,2" : @"Apple Watch 42mm",
                              @"Watch2,3" : @"Apple Watch Series 2 38mm",
                              @"Watch2,4" : @"Apple Watch Series 2 42mm",
                              @"Watch2,6" : @"Apple Watch Series 1 38mm",
                              @"Watch2,7" : @"Apple Watch Series 1 42mm",
                              @"Watch3,1" : @"Apple Watch Series 3 38mm",
                              @"Watch3,2" : @"Apple Watch Series 3 42mm",
                              @"Watch3,3" : @"Apple Watch Series 3 38mm",
                              @"Watch3,4" : @"Apple Watch Series 3 42mm",
                              @"Watch4,1" : @"Apple Watch Series 4 40mm",
                              @"Watch4,2" : @"Apple Watch Series 4 44mm",
                              @"Watch4,3" : @"Apple Watch Series 4 40mm",
                              @"Watch4,4" : @"Apple Watch Series 4 44mm",
                              @"Watch5,1": @"Apple Watch Series 5",
                              @"Watch5,2": @"Apple Watch Series 5",
                              @"Watch5,3": @"Apple Watch Series 5",
                              @"Watch5,4": @"Apple Watch Series 5",
                              @"Watch5,9": @"Apple Watch SE",
                              @"Watch5,10": @"Apple Watch SE",
                              @"Watch5,11": @"Apple Watch SE",
                              @"Watch5,12": @"Apple Watch SE",
                              @"Watch6,1": @"Apple Watch Series 6",
                              @"Watch6,2": @"Apple Watch Series 6",
                              @"Watch6,3": @"Apple Watch Series 6",
                              @"Watch6,4": @"Apple Watch Series 6",
                              @"Watch6,6": @"Apple Watch Series 7",
                              @"Watch6,7": @"Apple Watch Series 7",
                              @"Watch6,8": @"Apple Watch Series 7",
                              @"Watch6,9": @"Apple Watch Series 7",
                              
                              // iPod touch
                              @"iPod1,1" : @"iPod touch 1",
                              @"iPod2,1" : @"iPod touch 2",
                              @"iPod3,1" : @"iPod touch 3",
                              @"iPod4,1" : @"iPod touch 4",
                              @"iPod5,1" : @"iPod touch 5",
                              @"iPod7,1" : @"iPod touch 6",
                              @"iPod9,1": @"iPod touch (7th generation)",
                              
//                              @"iPhone1,1" : @"iPhone 1G",
//                              @"iPhone1,2" : @"iPhone 3G",
//                              @"iPhone2,1" : @"iPhone 3GS",
//                              @"iPhone3,1" : @"iPhone 4 (GSM)",
//                              @"iPhone3,2" : @"iPhone 4",
//                              @"iPhone3,3" : @"iPhone 4 (CDMA)",
//                              @"iPhone4,1" : @"iPhone 4S",
//                              @"iPhone5,1" : @"iPhone 5",
//                              @"iPhone5,2" : @"iPhone 5",
//                              @"iPhone5,3" : @"iPhone 5c",
//                              @"iPhone5,4" : @"iPhone 5c",
//                              @"iPhone6,1" : @"iPhone 5s",
//                              @"iPhone6,2" : @"iPhone 5s",
//                              @"iPhone7,1" : @"iPhone 6 Plus",
//                              @"iPhone7,2" : @"iPhone 6",
//                              @"iPhone8,1" : @"iPhone 6s",
//                              @"iPhone8,2" : @"iPhone 6s Plus",
//                              @"iPhone8,4" : @"iPhone SE",
//                              @"iPhone9,1" : @"iPhone 7",
//                              @"iPhone9,2" : @"iPhone 7 Plus",
//                              @"iPhone9,3" : @"iPhone 7",
//                              @"iPhone9,4" : @"iPhone 7 Plus",
                            
                              // iphone
                              @"iPhone1,1" : kMARMachieNameIPhone1G,
                              @"iPhone1,2" : kMARMachieNameIPhone3G,
                              @"iPhone2,1" : kMARMachieNameIPhones3GS,
                              @"iPhone3,1" : kMARMachieNameIPhone4GSM,
                              @"iPhone3,2" : kMARMachieNameIPhone4,
                              @"iPhone3,3" : kMARMachieNameIPhone4CDMA,
                              @"iPhone4,1" : kMARMachieNameIPhone4S,
                              @"iPhone5,1" : kMARMachieNameIPhone5,
                              @"iPhone5,2" : kMARMachieNameIPhone5,
                              @"iPhone5,3" : kMARMachieNameIPhone5C,
                              @"iPhone5,4" : kMARMachieNameIPhone5C,
                              @"iPhone6,1" : kMARMachieNameIPhone5S,
                              @"iPhone6,2" : kMARMachieNameIPhone5S,
                              @"iPhone7,1" : kMARMachieNameIPhone6Plus,
                              @"iPhone7,2" : kMARMachieNameIPhone6,
                              @"iPhone8,1" : kMARMachieNameIPhone6S,
                              @"iPhone8,2" : kMARMachieNameIPhone6SPlus,
                              @"iPhone8,4" : kMARMachieNameIPhoneSE,
                              @"iPhone9,1" : kMARMachieNameIPhone7,
                              @"iPhone9,2" : kMARMachieNameIPhone7Plus,
                              @"iPhone9,3" : kMARMachieNameIPhone7,
                              @"iPhone9,4" : kMARMachieNameIPhone7Plus,
                              @"iPhone10,1": kMARMachieNameIPhone8,
                              @"iPhone10,2": kMARMachieNameIPhone8Plus,
                              @"iPhone10,3": kMARMachieNameIPhoneX,
                              @"iPhone10,4": kMARMachieNameIPhone8,
                              @"iPhone10,5": kMARMachieNameIPhone8Plus,
                              @"iPhone10,6": kMARMachieNameIPhoneX,
                              @"iPhone11,8": kMARMachieNameIphoneXR,
                              @"iPhone11,2": kMARMachieNameIphoneXS,
                              @"iPhone11,6": kMARMachieNameIphoneXSMax,
                              @"iPhone11,4": kMARMachieNameIphoneXSMax,
                              @"iPhone12,1": kMARMachieNameIphone11,
                              @"iPhone12,3": kMARMachieNameIphone11Pro,
                              @"iPhone12,5": kMARMachieNameIphone11ProMax,
                              @"iPhone12,8": kMARMachieNameIphoneSE2nd,
                              @"iPhone13,1": kMARMachieNameIphone12Mini,
                              @"iPhone13,2": kMARMachieNameIphone12,
                              @"iPhone13,3": kMARMachieNameIphone12Pro,
                              @"iPhone13,4": kMARMachieNameIphone12ProMax,
                              @"iPhone14,4": kMARMachieNameIphone13Mini,
                              @"iPhone14,5": kMARMachieNameIphone13,
                              @"iPhone14,2": kMARMachieNameIphone13Pro,
                              @"iPhone14,3": kMARMachieNameIphone13PeoMax,
                              
                              // ipad
                              @"iPad1,1" : @"iPad 1",
                              @"iPad2,1" : @"iPad 2 (WiFi)",
                              @"iPad2,2" : @"iPad 2 (GSM)",
                              @"iPad2,3" : @"iPad 2 (CDMA)",
                              @"iPad2,4" : @"iPad 2",
                              @"iPad3,1" : @"iPad 3 (WiFi)",
                              @"iPad3,2" : @"iPad 3 (4G)",
                              @"iPad3,3" : @"iPad 3 (4G)",
                              @"iPad3,4" : @"iPad 4",
                              @"iPad3,5" : @"iPad 4",
                              @"iPad3,6" : @"iPad 4",
                              @"iPad6,11" : @"iPad (5th generation)",
                              @"iPad6,12" : @"iPad (5th generation)",
                              @"iPad7,5" : @"iPad (6th generation)",
                              @"iPad7,6" : @"iPad (6th generation)",
                              @"iPad7,11": @"iPad (7th generation)",
                              @"iPad7,12": @"iPad (7th generation)",
                              @"iPad11,6": @"iPad (8th generation)",
                              @"iPad11,7": @"iPad (8th generation)",
                              @"iPad12,1": @"iPad (9th generation)",
                              @"iPad12,2": @"iPad (9th generation)",
                              
                              // iPad mini
                              @"iPad2,5" : @"iPad mini 1",
                              @"iPad2,6" : @"iPad mini 1",
                              @"iPad2,7" : @"iPad mini 1",
                              @"iPad4,4" : @"iPad mini 2",
                              @"iPad4,5" : @"iPad mini 2",
                              @"iPad4,6" : @"iPad mini 2",
                              @"iPad4,7" : @"iPad mini 3",
                              @"iPad4,8" : @"iPad mini 3",
                              @"iPad4,9" : @"iPad mini 3",
                              @"iPad5,1" : @"iPad mini 4",
                              @"iPad5,2" : @"iPad mini 4",
                              @"iPad11,1": @"iPad mini (6th generation)",
                              @"iPad11,2": @"iPad mini (6th generation)",
                              @"iPad14,1": @"iPad mini (6th generation)",
                              @"iPad14,2": @"iPad mini (6th generation)",
                              
                              // iPad Air
                              @"iPad4,1" : @"iPad Air",
                              @"iPad4,2" : @"iPad Air",
                              @"iPad4,3" : @"iPad Air",
                              @"iPad5,3" : @"iPad Air 2",
                              @"iPad5,4" : @"iPad Air 2",
                              @"iPad11,3": @"iPad Air (3rd generation)",
                              @"iPad11,4": @"iPad Air (3rd generation)",
                              @"iPad13,1": @"iPad Air (4th generation)",
                              @"iPad13,2": @"iPad Air (4th generation)",
                              
                              // iPad Pro
                              @"iPad6,3" : @"iPad Pro (9.7 inch)",
                              @"iPad6,4" : @"iPad Pro (9.7 inch)",
                              @"iPad6,7" : @"iPad Pro (12.9 inch)",
                              @"iPad6,8" : @"iPad Pro (12.9 inch)",
                              @"iPad7,1" : @"iPad Pro (12.9-inch, 2nd generation)",
                              @"iPad7,2" : @"iPad Pro (12.9-inch, 2nd generation)",
                              @"iPad7,3" : @"iPad Pro (10.5-inch)",
                              @"iPad7,4" : @"iPad Pro (10.5-inch)",
                              @"iPad8,1" : @"iPad Pro (11-inch)",
                              @"iPad8,2" : @"iPad Pro (11-inch)",
                              @"iPad8,3" : @"iPad Pro (11-inch)",
                              @"iPad8,4" : @"iPad Pro (11-inch)",
                              @"iPad8,5" : @"iPad Pro (12.9-inch) (3rd generation)",
                              @"iPad8,6" : @"iPad Pro (12.9-inch) (3rd generation)",
                              @"iPad8,7" : @"iPad Pro (12.9-inch) (3rd generation)",
                              @"iPad8,8" : @"iPad Pro (12.9-inch) (3rd generation)",
                              @"iPad8,9": @"iPad Pro (11-inch) (2nd generation)",
                              @"iPad8,10": @"iPad Pro (11-inch) (2nd generation)",
                              @"iPad8,11": @"iPad Pro (12.9-inch) (4th generation)",
                              @"iPad8,12": @"iPad Pro (12.9-inch) (4th generation)",
                              @"iPad13,4": @"iPad Pro (11-inch) (3rd generation)",
                              @"iPad13,5": @"iPad Pro (11-inch) (3rd generation)",
                              @"iPad13,6": @"iPad Pro (11-inch) (3rd generation)",
                              @"iPad13,8": @"iPad Pro (12.9-inch) (5th generation)",
                              @"iPad13,9": @"iPad Pro (12.9-inch) (5th generation)",
                              @"iPad13,10": @"iPad Pro (12.9-inch) (5th generation)",
                              @"iPad13,11": @"iPad Pro (12.9-inch) (5th generation)",
                          
                              // Apple TV
                              @"AppleTV1,1": @"Apple TV (1st generation)",
                              @"AppleTV2,1" : @"Apple TV 2",
                              @"AppleTV3,1" : @"Apple TV 3",
                              @"AppleTV3,2" : @"Apple TV 3",
                              @"AppleTV5,3" : @"Apple TV 4",
                              @"AppleTV6,2" : @"Apple TV 4K",
                              @"AppleTV11,1": @"Apple TV 4K (2nd generation)",
                              
                              @"i386" : @"Simulator x86",
                              @"x86_64" : @"Simulator x64",
                              };
        name = dic[model];
        if (!name) name = model;
    });
    return name;
}

- (NSDate *)mar_systemUptime {
    NSTimeInterval time = [[NSProcessInfo processInfo] systemUptime];
    return [[NSDate alloc] initWithTimeIntervalSinceNow:(0 - time)];
}

- (BOOL)mar_isNotchScreen
{
    if (@available(iOS 11.0, *)) {
        // H:UIEdgeInsets(top: 44.0, left: 0.0, bottom: 34.0, right: 0.0)
        // V:UIEdgeInsets(top: 0.0, left: 44.0, bottom: 21.0, right: 44.0)
//        UIWindow *window = [UIApplication sharedApplication].delegate.window;
//        if (window && !UIEdgeInsetsEqualToEdgeInsets(window.safeAreaInsets, UIEdgeInsetsZero)) {
//            return YES;
//        }
        CGFloat iPhoneNotchDirectionSafeAreaInsets = 0;
        UIEdgeInsets safeAreaInsets = [UIApplication sharedApplication].windows[0].safeAreaInsets;
        switch ([UIApplication sharedApplication].statusBarOrientation) {
            case UIInterfaceOrientationPortrait:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
            }
                break;
            case UIInterfaceOrientationLandscapeLeft:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.left;
            }
                break;
            case UIInterfaceOrientationLandscapeRight:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.right;
            }
                break;
            case UIInterfaceOrientationPortraitUpsideDown:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.bottom;
            }
                break;
            default:
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
                break;
        }
        return iPhoneNotchDirectionSafeAreaInsets > 20;
    }
    return NO;
}

- (int64_t)mar_diskSpace {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}

- (int64_t)mar_diskSpaceFree {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}

- (int64_t)mar_diskSpaceUsed {
    int64_t total = self.mar_diskSpace;
    int64_t free = self.mar_diskSpaceFree;
    if (total < 0 || free < 0) return -1;
    int64_t used = total - free;
    if (used < 0) used = -1;
    return used;
}

- (int64_t)mar_memoryTotal {
    int64_t mem = [[NSProcessInfo processInfo] physicalMemory];
    if (mem < -1) mem = -1;
    return mem;
}

- (int64_t)mar_memoryUsed {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return page_size * (vm_stat.active_count + vm_stat.inactive_count + vm_stat.wire_count);
}

- (int64_t)mar_memoryFree {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.free_count * page_size;
}

- (int64_t)mar_memoryActive {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.active_count * page_size;
}

- (int64_t)mar_memoryInactive {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.inactive_count * page_size;
}

- (int64_t)mar_memoryWired {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.wire_count * page_size;
}

- (int64_t)mar_memoryPurgable {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.purgeable_count * page_size;
}

- (NSUInteger)mar_cpuCount {
    return [NSProcessInfo processInfo].activeProcessorCount;
}

- (float)mar_cpuUsage {
    float cpu = 0;
    NSArray *cpus = [self mar_cpuUsagePerProcessor];
    if (cpus.count == 0) return -1;
    for (NSNumber *n in cpus) {
        cpu += n.floatValue;
    }
    return cpu;
}

- (NSArray *)mar_cpuUsagePerProcessor {
    processor_info_array_t _cpuInfo, _prevCPUInfo = nil;
    mach_msg_type_number_t _numCPUInfo, _numPrevCPUInfo = 0;
    unsigned _numCPUs;
    NSLock *_cpuUsageLock;
    
    int _mib[2U] = { CTL_HW, HW_NCPU };
    size_t _sizeOfNumCPUs = sizeof(_numCPUs);
    int _status = sysctl(_mib, 2U, &_numCPUs, &_sizeOfNumCPUs, NULL, 0U);
    if (_status)
        _numCPUs = 1;
    
    _cpuUsageLock = [[NSLock alloc] init];
    
    natural_t _numCPUsU = 0U;
    kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &_numCPUsU, &_cpuInfo, &_numCPUInfo);
    if (err == KERN_SUCCESS) {
        [_cpuUsageLock lock];
        
        NSMutableArray *cpus = [NSMutableArray new];
        for (unsigned i = 0U; i < _numCPUs; ++i) {
            Float32 _inUse, _total;
            if (_prevCPUInfo) {
                _inUse = (
                          (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
                          );
                _total = _inUse + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
            } else {
                _inUse = _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
                _total = _inUse + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
            }
            [cpus addObject:@(_inUse / _total)];
        }
        
        [_cpuUsageLock unlock];
        if (_prevCPUInfo) {
            size_t prevCpuInfoSize = sizeof(integer_t) * _numPrevCPUInfo;
            vm_deallocate(mach_task_self(), (vm_address_t)_prevCPUInfo, prevCpuInfoSize);
        }
        return cpus;
    } else {
        return nil;
    }
}

@end
