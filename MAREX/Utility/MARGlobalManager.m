//
//  MARGlobalManager.m
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2017/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "MARGlobalManager.h"
#import <CoreLocation/CoreLocation.h>   // 定位权限用到   authority of location
#import <AVFoundation/AVFoundation.h>   // 摄像头权限用到 authority of camera
#import <Photos/Photos.h>               // 相册权限用到   authority of photo album
#import <AssetsLibrary/AssetsLibrary.h> // 相册权限用到   authority of photo album
#import "MAREXMacro.h"
#import "MARReachability.h"

/// 用到的宏
#ifndef kMARGlobalNotification
#define kMARGlobalNotification          @"kMARGlobalNotification"
#endif
static NSString *MARHasBeenOpened                   =   @"MARHasBeenOpened";
static NSString *MARHasBeenOpenedForCurrentVersion  =   @"";

@interface MARGlobalManager()

@property (nonatomic, strong) MARReachability *reachability;
@property (nonatomic, strong) NSMutableDictionary<NSString *, MARNotifyChangeNetStatusBlock> *notifyNetStatusBlockDic;

#ifdef MXRMonitorShakeOn
#define MXRMonitorLock dispatch_semaphore_wait(_motionLock, dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC));
#define MXRMonitorUnLock dispatch_semaphore_signal(_motionLock);
@property (nonatomic, strong) NSMutableDictionary<NSString *, MARShakeCompleteHandler> *monitorShakeHandlerDic;
@property (strong,nonatomic) CMMotionManager *motionManager;
#endif

@end

@implementation MARGlobalManager
{
#ifdef MXRMonitorShakeOn
    dispatch_semaphore_t _motionLock;
#endif
}

+ (instancetype)sharedInstance
{
    MARSINGLE_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (instancetype)init
{
    if (self = [super init]) {
#ifdef MXRMonitorShakeOn
        _motionLock = dispatch_semaphore_create(1);
#endif
    }
    return self;
}

- (NSDateFormatter *)dataFormatter
{
    return self.dateFormatter;
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    return _dateFormatter;
}

- (NSByteCountFormatter *)byteFormatter
{
    if (!_byteFormatter) {
        _byteFormatter = [[NSByteCountFormatter alloc] init];
    }
    return _byteFormatter;
}

- (MARReachability *)reachability
{
    if (!_reachability) {
        _reachability = [MARReachability reachability];
    }
    return _reachability;
}

- (NSDictionary *)postNotif:(NSInteger)type data:(id)data object:(id)object
{
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    [info setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    if (data) {
        [info setObject:data forKey:@"data"];
    }
    if (object) {
        [info setObject:object forKey:@"object"];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMARGlobalNotification object:object userInfo:info];
    return info;
}

- (void)onFirstStart:(void (^)(BOOL))block
{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    BOOL hasBeenOpened = [user boolForKey:MARHasBeenOpened];
    if (!hasBeenOpened) {
        [user setBool:YES forKey:MARHasBeenOpened];
        [user synchronize];
    }
    
    if (block) block(!hasBeenOpened);
}

+ (void)onFirstStart:(void (^)(BOOL))block
{
    [MARGLOBALMANAGER onFirstStart:block];
}

- (void)onFirstStartForCurrentVersion:(void (^)(BOOL))block
{
    MARHasBeenOpenedForCurrentVersion = [NSString stringWithFormat:@"%@%@", MARHasBeenOpened, AppVersion];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasBeenOpenedForCurrentVersion = [defaults boolForKey:MARHasBeenOpenedForCurrentVersion];
    if (hasBeenOpenedForCurrentVersion != true) {
        [defaults setBool:YES forKey:MARHasBeenOpenedForCurrentVersion];
        [defaults synchronize];
    }
    
    if (block) block(!hasBeenOpenedForCurrentVersion);
}

+ (void)onFirstStartForCurrentVersion:(void (^)(BOOL))block
{
    [MARGLOBALMANAGER onFirstStartForCurrentVersion:block];
}

- (BOOL)isFirstStart
{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    BOOL hasAPPFirstOpened = [user boolForKey:MARHasBeenOpened];
    return !hasAPPFirstOpened;
}

+ (BOOL)isFirstStart
{
    return [MARGLOBALMANAGER isFirstStart];
}

- (BOOL)isFirstStartForCurrentVersion
{
    MARHasBeenOpenedForCurrentVersion = [NSString stringWithFormat:@"%@%@", MARHasBeenOpened, AppVersion];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasBeenOpenedForCurrentVersion = [defaults boolForKey:MARHasBeenOpenedForCurrentVersion];
    return !hasBeenOpenedForCurrentVersion;
}

+ (BOOL)isFirstStartForCurrentVersion
{
    return [MARGLOBALMANAGER isFirstStartForCurrentVersion];
}

- (void) userDefaultSetObject:(id)obj forKey:(NSString*)key
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:obj forKey:key];
    [userDefaults synchronize];
}

- (id) userDefaultObjectForKey:(NSString*)key
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

- (NSString*) userDefaultStringForKey:(NSString*)key
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:key];
}

- (BOOL)isLocationServiceOpen {
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        return NO;
    } else
        return YES;
}

- (void)gotoLocationSystemSetting
{
    NSURL *url = nil;
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
#else
    if (IS_IOSORLATER(8.0)) {
        url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    } else {
        url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
    }
#endif
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (BOOL)isMessageNotificationServiceOpen
{
#if MARTARGET_OS_iPhoneSIMULATOR
    return YES;
#endif
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    return [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
#else
    if (IS_IOSORLATER(8.0)) {
        return [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
    } else {
        return [[UIApplication sharedApplication] enabledRemoteNotificationTypes] != UIRemoteNotificationTypeNone;
    }
#endif
}

- (void)gotoMessageNotificationServiceSystemSetting
{
    NSURL *url = nil;
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
#else
    if (IS_IOSORLATER(8.0)) {
        url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    } else {
        url = [NSURL URLWithString:@"prefs:root=NOTIFICATIONS_ID"];
    }
#endif
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

- (NSMutableDictionary<NSString *,MARNotifyChangeNetStatusBlock> *)notifyNetStatusBlockDic
{
    if (!_notifyNetStatusBlockDic) {
        _notifyNetStatusBlockDic = [NSMutableDictionary dictionaryWithCapacity:1 << 4];
    }
    return _notifyNetStatusBlockDic;
}

- (BOOL)isNetworkAvailable
{
    return self.reachability.isReachable;
}

- (BOOL)isNetworkWifi
{
    return self.reachability.status == MARReachabilityStatusWiFi;
}

- (BOOL)isNetworkWWAN
{
    return self.reachability.status == MARReachabilityStatusWWAN;
}

- (void)setNotifyChangeNetStatusForKey:(NSString *)key block:(MARNotifyChangeNetStatusBlock)notifyChangeNetStatusBlock
{
    if (notifyChangeNetStatusBlock) {
        [self.notifyNetStatusBlockDic setObject:notifyChangeNetStatusBlock forKey:key];
    }
    else
        [self.notifyNetStatusBlockDic removeObjectForKey:key];
    
    if (!self.reachability.notifyBlock) {
        __block MARReachabilityNetStatus netStatus = MARReachabilityNetStatusNotReachbale;
        __weak MARGlobalManager* weakSelf = self;
        self.reachability.notifyBlock = ^(MARReachability *reachabilityB){
            __strong __typeof(self) strongSelf = weakSelf;
            if (!strongSelf) return;
            netStatus = MARReachabilityNetStatusNotReachbale;
            if (reachabilityB.status == MARReachabilityStatusNone) {
                netStatus = MARReachabilityNetStatusNotReachbale;
            }
            else if (reachabilityB.status == MARReachabilityStatusWWAN)
            {
                switch (reachabilityB.wwanStatus) {
                    case MARReachabilityWWANStatusNone:
                    case MARReachabilityWWANStatusNG:
                        netStatus = MARReachabilityNetStatusNotReachbale;
                        break;
                    case MARReachabilityWWANStatus2G:
                        netStatus = MARReachabilityNetStatusWAN2G;
                        break;
                    case MARReachabilityWWANStatus3G:
                        netStatus = MARReachabilityNetStatusWAN3G;
                        break;
                    case MARReachabilityWWANStatus4G:
                        netStatus = MARReachabilityNetStatusWAN4G;
                        break;
                }
            }
            else if (reachabilityB.status == MARReachabilityStatusWiFi)
            {
                netStatus = MARReachabilityNetStatusWIFI;
            }
            for (NSString *key in strongSelf.notifyNetStatusBlockDic) {
                MARNotifyChangeNetStatusBlock block =strongSelf.notifyNetStatusBlockDic[key];
                block(netStatus);
            }
        };
    }
}

- (void)setNotifyChangeNetStatusBlock:(void (^)(MARReachabilityNetStatus))notifyChangeNetStatusBlock
{
    [self setNotifyChangeNetStatusForKey:@"defaultKey" block:notifyChangeNetStatusBlock];
}

- (BOOL)isCameraServiceOpen
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        return NO;
    }
    else
        return YES;
}

- (void)checkCameraAuthorityCallBack:(void (^)(BOOL allowed))callBack
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        if (callBack) {
            callBack(NO);
        }
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined)
    {
        mar_dispatch_async_on_main_queue(^{
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (callBack) {
                    callBack(granted);
                }
            }];
        });
    }
    else
    {
        if (callBack) {
            callBack(YES);
        }
    }
}

- (void)checkCameraAuthorityWithDeniedAlert:(BOOL)isAlert callBack:(void (^)(BOOL))callBack
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        if (isAlert && authStatus == AVAuthorizationStatusDenied) {
            NSString *msg = @"您的摄像头功能被关闭了。开启请到APP{设置}-{隐私}-{摄像头}中开启摄像头功能";
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:msg
                                                               delegate:nil
                                                      cancelButtonTitle:@"好的"
                                                      otherButtonTitles: nil];

            [alertView show];
        }
        if (callBack) {
            callBack(NO);
        }
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined)
    {
        mar_dispatch_async_on_main_queue(^{
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (callBack) {
                    callBack(granted);
                }
            }];
        });
    }
    else
    {
        if (callBack) {
            callBack(YES);
        }
    }
}

- (BOOL)isPhotoAlbumServiceOpen
{
    return NO;
}

- (void)checkPhotoAlbumAuthorityCallBack:(void (^)(BOOL allowed))callBack
{
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (authStatus == PHAuthorizationStatusRestricted || authStatus == PHAuthorizationStatusDenied) {
        if (callBack) {
            callBack(NO);
        }
    }
    else if (authStatus == PHAuthorizationStatusNotDetermined)
    {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            mar_dispatch_async_on_main_queue(^{
                if (callBack) {
                    callBack(status == PHAuthorizationStatusAuthorized);
                }
            });
        }];
    }
    else
    {
        if (callBack) {
            callBack(YES);
        }
    }
#else
    if (IS_IOSORLATER(8.0)) {
        PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
        if (authStatus == PHAuthorizationStatusRestricted || authStatus == PHAuthorizationStatusDenied) {
            if (callBack) {
                callBack(NO);
            }
        }
        else if (authStatus == PHAuthorizationStatusNotDetermined)
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                mar_dispatch_async_on_main_queue(^{
                    if (callBack) {
                        callBack(status == PHAuthorizationStatusAuthorized);
                    }
                });
            }];
        }
        else
        {
            if (callBack) {
                callBack(YES);
            }
        }
    }
    else
    {
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied) {
            if (callBack) {
                callBack(NO);
            }
        }
        else if (authStatus == ALAuthorizationStatusNotDetermined)
        {
            if (callBack) {
                callBack(NO);
            }
        }
        else
        {
            if (callBack) {
                callBack(YES);
            }
        }
    }
#endif
}

#ifdef MXRMonitorShakeOn
- (CMMotionManager *)motionManager
{
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        self.motionManager.accelerometerUpdateInterval = .1;//加速仪更新频率，以秒为单位
    }
    return _motionManager;
}

- (NSMutableDictionary<NSString *,MARShakeCompleteHandler> *)monitorShakeHandlerDic
{
    if (!_monitorShakeHandlerDic) {
        _monitorShakeHandlerDic = [NSMutableDictionary dictionaryWithCapacity:1 << 4];
    }
    return _monitorShakeHandlerDic;
}

- (void)startMontitorShakeForKey:(NSString *)key completeHandler:(void (^)(void))completeHandler
{
    if (completeHandler)
    {
        MXRMonitorLock
        [self.monitorShakeHandlerDic setObject:completeHandler forKey:key];
        MXRMonitorUnLock
    }
    else
    {
        [self stopMontitorShakeForKey:key];
    }
    
    if (!self.motionManager.isAccelerometerActive && self.motionManager.isAccelerometerAvailable) {
        __weak __typeof(self) weakSelf = self;
        
        [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            __strong __typeof(self) strongSelf = weakSelf;
            if (error) {
                NSLog(@"Global motion error:%@",error);
                return;
            }
            BOOL isShake = [strongSelf isShakeForHandleAcceleration:accelerometerData.acceleration];
            if (isShake) {
                mar_dispatch_async_on_main_queue(^{
                    [strongSelf p_notifyShake];
                });
            }
        }];
    }
}

- (void)p_notifyShake
{
    MXRMonitorLock
    for (NSString *key in self.monitorShakeHandlerDic) {
        MARShakeCompleteHandler block = self.monitorShakeHandlerDic[key];
        block();
    }
    MXRMonitorUnLock
}

- (BOOL)isShakeForHandleAcceleration:(CMAcceleration)acceleration
{
    double accelerameter =sqrt( pow( acceleration.x , 2 ) + pow( acceleration.y , 2 )
                               + pow( acceleration.z , 2) );
    //当综合加速度大于2.3时，就激活效果（此数值根据需求可以调整，数据越小，用户摇动的动作就越小，越容易激活，反之加大难度，但不容易误触发）!
    if (accelerameter>1.8f) {
        return YES;
    }
    return NO;
}

- (void)stopMontitorShakeForKey:(NSString *)key
{
    MXRMonitorLock
    [self.monitorShakeHandlerDic removeObjectForKey:key];
    if (self.monitorShakeHandlerDic.count == 0 && _motionManager.isAccelerometerActive) {
        [_motionManager stopAccelerometerUpdates];
    }
    MXRMonitorUnLock
}
#endif

@end
