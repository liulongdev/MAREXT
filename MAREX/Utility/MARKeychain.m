//
//  MARKeychain.m
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2018/8/24.
//  Copyright © 2018年 MAR. All rights reserved.
//

#import "MARKeychain.h"
#import <Security/Security.h>
#import "MAREXMacro.h"

static MARKeychainErrorCode MARKeychainErrorCodeFromOSStatus(OSStatus status) {
    switch (status) {
        case errSecUnimplemented: return MARKeychainErrorUnimplemented;
        case errSecIO: return MARKeychainErrorIO;
        case errSecOpWr: return MARKeychainErrorOpWr;
        case errSecParam: return MARKeychainErrorParam;
        case errSecAllocate: return MARKeychainErrorAllocate;
        case errSecUserCanceled: return MARKeychainErrorUserCancelled;
        case errSecBadReq: return MARKeychainErrorBadReq;
        case errSecInternalComponent: return MARKeychainErrorInternalComponent;
        case errSecNotAvailable: return MARKeychainErrorNotAvailable;
        case errSecDuplicateItem: return MARKeychainErrorDuplicateItem;
        case errSecItemNotFound: return MARKeychainErrorItemNotFound;
        case errSecInteractionNotAllowed: return MARKeychainErrorInteractionNotAllowed;
        case errSecDecode: return MARKeychainErrorDecode;
        case errSecAuthFailed: return MARKeychainErrorAuthFailed;
        default: return 0;
    }
}

static NSString *MARKeychainErrorDesc(MARKeychainErrorCode code) {
    switch (code) {
        case MARKeychainErrorUnimplemented:
            return @"Function or operation not implemented.";
        case MARKeychainErrorIO:
            return @"I/O error (bummers)";
        case MARKeychainErrorOpWr:
            return @"ile already open with with write permission.";
        case MARKeychainErrorParam:
            return @"One or more parameters passed to a function where not valid.";
        case MARKeychainErrorAllocate:
            return @"Failed to allocate memory.";
        case MARKeychainErrorUserCancelled:
            return @"User canceled the operation.";
        case MARKeychainErrorBadReq:
            return @"Bad parameter or invalid state for operation.";
        case MARKeychainErrorInternalComponent:
            return @"Inrernal Component";
        case MARKeychainErrorNotAvailable:
            return @"No keychain is available. You may need to restart your computer.";
        case MARKeychainErrorDuplicateItem:
            return @"The specified item already exists in the keychain.";
        case MARKeychainErrorItemNotFound:
            return @"The specified item could not be found in the keychain.";
        case MARKeychainErrorInteractionNotAllowed:
            return @"User interaction is not allowed.";
        case MARKeychainErrorDecode:
            return @"Unable to decode the provided data.";
        case MARKeychainErrorAuthFailed:
            return @"The user name or passphrase you entered is not";
        default:
            break;
    }
    return nil;
}

static NSString *MARKeychainAccessibleStr(MARKeychainAccessible e) {
    switch (e) {
        case MARKeychainAccessibleWhenUnlocked:
            return (__bridge NSString *)(kSecAttrAccessibleWhenUnlocked);
        case MARKeychainAccessibleAfterFirstUnlock:
            return (__bridge NSString *)(kSecAttrAccessibleAfterFirstUnlock);
        case MARKeychainAccessibleAlways:
            return (__bridge NSString *)(kSecAttrAccessibleAlways);
        case MARKeychainAccessibleWhenPasscodeSetThisDeviceOnly:
            return (__bridge NSString *)(kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly);
        case MARKeychainAccessibleWhenUnlockedThisDeviceOnly:
            return (__bridge NSString *)(kSecAttrAccessibleWhenUnlockedThisDeviceOnly);
        case MARKeychainAccessibleAfterFirstUnlockThisDeviceOnly:
            return (__bridge NSString *)(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly);
        case MARKeychainAccessibleAlwaysThisDeviceOnly:
            return (__bridge NSString *)(kSecAttrAccessibleAlwaysThisDeviceOnly);
        default:
            return nil;
    }
}

static MARKeychainAccessible MARKeychainAccessibleEnum(NSString *s) {
    if ([s isEqualToString:(__bridge NSString *)kSecAttrAccessibleWhenUnlocked])
        return MARKeychainAccessibleWhenUnlocked;
    if ([s isEqualToString:(__bridge NSString *)kSecAttrAccessibleAfterFirstUnlock])
        return MARKeychainAccessibleAfterFirstUnlock;
    if ([s isEqualToString:(__bridge NSString *)kSecAttrAccessibleAlways])
        return MARKeychainAccessibleAlways;
    if ([s isEqualToString:(__bridge NSString *)kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly])
        return MARKeychainAccessibleWhenPasscodeSetThisDeviceOnly;
    if ([s isEqualToString:(__bridge NSString *)kSecAttrAccessibleWhenUnlockedThisDeviceOnly])
        return MARKeychainAccessibleWhenUnlockedThisDeviceOnly;
    if ([s isEqualToString:(__bridge NSString *)kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly])
        return MARKeychainAccessibleAfterFirstUnlockThisDeviceOnly;
    if ([s isEqualToString:(__bridge NSString *)kSecAttrAccessibleAlwaysThisDeviceOnly])
        return MARKeychainAccessibleAlwaysThisDeviceOnly;
    return MARKeychainAccessibleNone;
}

static id MARKeychainQuerySynchonizationID(MARKeychainQuerySynchronizationMode mode) {
    switch (mode) {
        case MARKeychainQuerySynchronizationModeAny:
            return (__bridge id)(kSecAttrSynchronizableAny);
        case MARKeychainQuerySynchronizationModeNo:
            return (__bridge id)kCFBooleanFalse;
        case MARKeychainQuerySynchronizationModeYes:
            return (__bridge id)kCFBooleanTrue;
        default:
            return (__bridge id)(kSecAttrSynchronizableAny);
    }
}

static MARKeychainQuerySynchronizationMode MARKeychainQuerySynchonizationEnum(NSNumber *num) {
    if ([num isEqualToNumber:@NO]) return MARKeychainQuerySynchronizationModeNo;
    if ([num isEqualToNumber:@YES]) return MARKeychainQuerySynchronizationModeYes;
    return MARKeychainQuerySynchronizationModeAny;
}

@interface MARKeychainItem ()
@property (nonatomic, readwrite, strong) NSDate *modificationDate;
@property (nonatomic, readwrite, strong) NSDate *creationDate;
@end

@implementation MARKeychainItem


- (void)setPasswordObject:(id <NSCoding> )object {
    self.passwordData = [NSKeyedArchiver archivedDataWithRootObject:object];
}

- (id <NSCoding> )passwordObject {
    if ([self.passwordData length]) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:self.passwordData];
    }
    return nil;
}

- (void)setPassword:(NSString *)password {
    self.passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)password {
    if ([self.passwordData length]) {
        return [[NSString alloc] initWithData:self.passwordData encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (void)setGenericObject:(id<NSCoding>)genericObject
{
    self.genericData = [NSKeyedArchiver archivedDataWithRootObject:genericObject];
}

- (id<NSCoding>)genericObject
{
    if ([self.genericData length]) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:self.genericData];
    }
    return nil;
}

- (void)setGeneric:(NSString *)generic
{
    self.genericData = [generic dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)generic
{
    if ([self.genericData length]) {
        return [[NSString alloc] initWithData:self.genericData encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSMutableDictionary *)queryDic {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    
    dic[(__bridge id)kSecClass] = (__bridge id)kSecClassGenericPassword;
    
    if (self.account) dic[(__bridge id)kSecAttrAccount] = self.account;
    if (self.service) dic[(__bridge id)kSecAttrService] = self.service;
    if (self.generic) dic[(__bridge id)kSecAttrGeneric] = self.generic;
#if TARGET_OS_SIMULATOR
#else
    // Remove the access group if running on the iPhone simulator.
    //
    // Apps that are built for the simulator aren't signed, so there's no keychain access group
    // for the simulator to check. This means that all apps can see all keychain items when run
    // on the simulator.
    //
    // If a SecItem contains an access group attribute, SecItemAdd and SecItemUpdate on the
    // simulator will return -25243 (errSecNoAccessForItem).
    //
    // The access group attribute will be included in items returned by SecItemCopyMatching,
    // which is why we need to remove it before updating the item.
    if (self.accessGroup) dic[(__bridge id)kSecAttrAccessGroup] = self.accessGroup;
#endif
    
    if (IS_IOSORLATER(7)) {
        dic[(__bridge id)kSecAttrSynchronizable] = MARKeychainQuerySynchonizationID(self.synchronizable);
    }
    
    return dic;
}

- (NSMutableDictionary *)dic {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    
    dic[(__bridge id)kSecClass] = (__bridge id)kSecClassGenericPassword;
    
    if (self.account) dic[(__bridge id)kSecAttrAccount] = self.account;
    if (self.service) dic[(__bridge id)kSecAttrService] = self.service;
    if (self.label) dic[(__bridge id)kSecAttrLabel] = self.label;
    if (self.generic) dic[(__bridge id)kSecAttrGeneric] = self.generic;
#if TARGET_OS_SIMULATOR
#else
    // Remove the access group if running on the iPhone simulator.
    //
    // Apps that are built for the simulator aren't signed, so there's no keychain access group
    // for the simulator to check. This means that all apps can see all keychain items when run
    // on the simulator.
    //
    // If a SecItem contains an access group attribute, SecItemAdd and SecItemUpdate on the
    // simulator will return -25243 (errSecNoAccessForItem).
    //
    // The access group attribute will be included in items returned by SecItemCopyMatching,
    // which is why we need to remove it before updating the item.
    if (self.accessGroup) dic[(__bridge id)kSecAttrAccessGroup] = self.accessGroup;
#endif
    
    if (IS_IOSORLATER(7)) {
        dic[(__bridge id)kSecAttrSynchronizable] = MARKeychainQuerySynchonizationID(self.synchronizable);
    }
    
    if (self.accessible) dic[(__bridge id)kSecAttrAccessible] = MARKeychainAccessibleStr(self.accessible);
    if (self.passwordData) dic[(__bridge id)kSecValueData] = self.passwordData;
    if (self.genericData) dic[(__bridge id)kSecAttrGeneric] = self.genericData;
    if (self.type != nil) dic[(__bridge id)kSecAttrType] = self.type;
    if (self.creater != nil) dic[(__bridge id)kSecAttrCreator] = self.creater;
    if (self.comment) dic[(__bridge id)kSecAttrComment] = self.comment;
    if (self.descr) dic[(__bridge id)kSecAttrDescription] = self.descr;
    
    return dic;
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (dic.count == 0) return nil;
    self = self.init;
    
    self.service = dic[(__bridge id)kSecAttrService];
    self.account = dic[(__bridge id)kSecAttrAccount];
    self.passwordData = dic[(__bridge id)kSecValueData];
    self.genericData = dic[(__bridge id)kSecAttrGeneric];
    self.label = dic[(__bridge id)kSecAttrLabel];
    self.type = dic[(__bridge id)kSecAttrType];
    self.creater = dic[(__bridge id)kSecAttrCreator];
    self.comment = dic[(__bridge id)kSecAttrComment];
    self.descr = dic[(__bridge id)kSecAttrDescription];
    self.modificationDate = dic[(__bridge id)kSecAttrModificationDate];
    self.creationDate = dic[(__bridge id)kSecAttrCreationDate];
    self.accessGroup = dic[(__bridge id)kSecAttrAccessGroup];
    self.accessible = MARKeychainAccessibleEnum(dic[(__bridge id)kSecAttrAccessible]);
    self.synchronizable = MARKeychainQuerySynchonizationEnum(dic[(__bridge id)kSecAttrSynchronizable]);
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    MARKeychainItem *item = [MARKeychainItem new];
    item.service = self.service;
    item.account = self.account;
    item.passwordData = self.passwordData;
    item.genericData = self.genericData;
    item.label = self.label;
    item.type = self.type;
    item.creater = self.creater;
    item.comment = self.comment;
    item.descr = self.descr;
    item.modificationDate = self.modificationDate;
    item.creationDate = self.creationDate;
    item.accessGroup = self.accessGroup;
    item.accessible = self.accessible;
    item.synchronizable = self.synchronizable;
    return item;
}

- (NSString *)description {
    NSMutableString *str = @"".mutableCopy;
    [str appendString:@"MARKeychainItem:{\n"];
    if (self.service) [str appendFormat:@"  service:%@,\n", self.service];
    if (self.account) [str appendFormat:@"  service:%@,\n", self.account];
    if (self.password) [str appendFormat:@"  service:%@,\n", self.password];
    if (self.generic) [str appendFormat:@"  generic:%@,\n", self.generic];
    if (self.label) [str appendFormat:@"  service:%@,\n", self.label];
    if (self.type != nil) [str appendFormat:@"  service:%@,\n", self.type];
    if (self.creater != nil) [str appendFormat:@"  service:%@,\n", self.creater];
    if (self.comment) [str appendFormat:@"  service:%@,\n", self.comment];
    if (self.descr) [str appendFormat:@"  service:%@,\n", self.descr];
    if (self.modificationDate) [str appendFormat:@"  service:%@,\n", self.modificationDate];
    if (self.creationDate) [str appendFormat:@"  service:%@,\n", self.creationDate];
    if (self.accessGroup) [str appendFormat:@"  service:%@,\n", self.accessGroup];
    [str appendString:@"}"];
    return str;
}

@end



@implementation MARKeychain

+ (NSString *)getPasswordForService:(NSString *)serviceName
                            account:(NSString *)account
                              error:(NSError **)error {
    if (!serviceName || !account) {
        if (error) *error = [MARKeychain errorWithCode:errSecParam];
        return nil;
    }
    
    MARKeychainItem *item = [MARKeychainItem new];
    item.service = serviceName;
    item.account = account;
    MARKeychainItem *result = [self selectOneItem:item error:error];
    return result.password;
}

+ (nullable NSString *)getPasswordForService:(NSString *)serviceName
                                     account:(NSString *)account {
    return [self getPasswordForService:serviceName account:account error:NULL];
}

+ (BOOL)deletePasswordForService:(NSString *)serviceName
                         account:(NSString *)account
                           error:(NSError **)error {
    if (!serviceName || !account) {
        if (error) *error = [MARKeychain errorWithCode:errSecParam];
        return NO;
    }
    
    MARKeychainItem *item = [MARKeychainItem new];
    item.service = serviceName;
    item.account = account;
    return [self deleteItem:item error:error];
}

+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account {
    return [self deletePasswordForService:serviceName account:account error:NULL];
}

+ (BOOL)setPassword:(NSString *)password
         forService:(NSString *)serviceName
            account:(NSString *)account
              error:(NSError **)error {
    if (!password || !serviceName || !account) {
        if (error) *error = [MARKeychain errorWithCode:errSecParam];
        return NO;
    }
    MARKeychainItem *item = [MARKeychainItem new];
    item.service = serviceName;
    item.account = account;
    MARKeychainItem *result = [self selectOneItem:item error:NULL];
    if (result) {
        result.password = password;
        return [self updateItem:result error:error];
    } else {
        item.password = password;
        return [self insertItem:item error:error];
    }
}

+ (BOOL)setPassword:(NSString *)password
         forService:(NSString *)serviceName
            account:(NSString *)account {
    return [self setPassword:password forService:serviceName account:account error:NULL];
}

+ (BOOL)insertItem:(MARKeychainItem *)item error:(NSError **)error {
    if (!item.service || !item.account || !item.passwordData) {
        if (error) *error = [MARKeychain errorWithCode:errSecParam];
        return NO;
    }
    
    NSMutableDictionary *query = [item dic];
    OSStatus status = status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    if (status != errSecSuccess) {
        if (error) *error = [MARKeychain errorWithCode:status];
        return NO;
    }
    
    return YES;
}

+ (BOOL)insertItem:(MARKeychainItem *)item {
    return [self insertItem:item error:NULL];
}

+ (BOOL)updateItem:(MARKeychainItem *)item error:(NSError **)error {
    if (!item.service || !item.account || !item.passwordData) {
        if (error) *error = [MARKeychain errorWithCode:errSecParam];
        return NO;
    }
    
    NSMutableDictionary *query = [item queryDic];
    NSMutableDictionary *update = [item dic];
    [update removeObjectForKey:(__bridge id)kSecClass];
    if (!query || !update) return NO;
    OSStatus status = status = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)update);
    if (status != errSecSuccess) {
        if (error) *error = [MARKeychain errorWithCode:status];
        return NO;
    }
    
    return YES;
}

+ (BOOL)updateItem:(MARKeychainItem *)item {
    return [self updateItem:item error:NULL];
}

+ (BOOL)deleteItem:(MARKeychainItem *)item error:(NSError **)error {
    if (!item.service || !item.account) {
        if (error) *error = [MARKeychain errorWithCode:errSecParam];
        return NO;
    }
    
    NSMutableDictionary *query = [item dic];
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);
    if (status != errSecSuccess) {
        if (error) *error = [MARKeychain errorWithCode:status];
        return NO;
    }
    
    return YES;
}

+ (BOOL)deleteItem:(MARKeychainItem *)item {
    return [self deleteItem:item error:NULL];
}

+ (MARKeychainItem *)selectOneItem:(MARKeychainItem *)item error:(NSError **)error {
    if (!item.service || !item.account) {
        if (error) *error = [MARKeychain errorWithCode:errSecParam];
        return nil;
    }
    
    NSMutableDictionary *query = [item dic];
    query[(__bridge id)kSecMatchLimit] = (__bridge id)kSecMatchLimitOne;
    query[(__bridge id)kSecReturnAttributes] = @YES;
    query[(__bridge id)kSecReturnData] = @YES;
    
    OSStatus status;
    CFTypeRef result = NULL;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
    if (status != errSecSuccess) {
        if (error) *error = [[self class] errorWithCode:status];
        return nil;
    }
    if (!result) return nil;
    
    NSDictionary *dic = nil;
    if (CFGetTypeID(result) == CFDictionaryGetTypeID()) {
        dic = (__bridge NSDictionary *)(result);
    } else if (CFGetTypeID(result) == CFArrayGetTypeID()){
        dic = [(__bridge NSArray *)(result) firstObject];
        if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
    }
    if (!dic.count) return nil;
    return [[MARKeychainItem alloc] initWithDic:dic];
}

+ (MARKeychainItem *)selectOneItem:(MARKeychainItem *)item {
    return [self selectOneItem:item error:NULL];
}

+ (NSArray *)selectItems:(MARKeychainItem *)item error:(NSError **)error {
    NSMutableDictionary *query = [item dic];
    query[(__bridge id)kSecMatchLimit] = (__bridge id)kSecMatchLimitAll;
    query[(__bridge id)kSecReturnAttributes] = @YES;
    query[(__bridge id)kSecReturnData] = @YES;
    
    OSStatus status;
    CFTypeRef result = NULL;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
    if (status != errSecSuccess && error != NULL) {
        *error = [[self class] errorWithCode:status];
        return nil;
    }
    
    NSMutableArray *res = [NSMutableArray new];
    NSDictionary *dic = nil;
    if (CFGetTypeID(result) == CFDictionaryGetTypeID()) {
        dic = (__bridge NSDictionary *)(result);
        MARKeychainItem *item = [[MARKeychainItem alloc] initWithDic:dic];
        if (item) [res addObject:item];
    } else if (CFGetTypeID(result) == CFArrayGetTypeID()){
        for (NSDictionary *dic in (__bridge NSArray *)(result)) {
            MARKeychainItem *item = [[MARKeychainItem alloc] initWithDic:dic];
            if (item) [res addObject:item];
        }
    }
    
    return res;
}

+ (NSArray *)selectItems:(MARKeychainItem *)item {
    return [self selectItems:item error:NULL];
}

+ (NSError *)errorWithCode:(OSStatus)osCode {
    MARKeychainErrorCode code = MARKeychainErrorCodeFromOSStatus(osCode);
    NSString *desc = MARKeychainErrorDesc(code);
    NSDictionary *userInfo = desc ? @{ NSLocalizedDescriptionKey : desc } : nil;
    return [NSError errorWithDomain:@"com.martin.marext.keychain" code:code userInfo:userInfo];
}

@end
