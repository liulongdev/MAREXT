//
//  MARKeyChain.h
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2018/8/24.
//  Copyright © 2018年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MARKeychainItem;

NS_ASSUME_NONNULL_BEGIN

/**
 A wrapper for system keychain API.
 
 Inspired by [YYKeychain]
 */
@interface MARKeychain : NSObject

#pragma mark - Convenience method for keychain
///=============================================================================
/// @name Convenience method for keychain
///=============================================================================

/**
 Returns the password for a given account and service, or `nil` if not found or
 an error occurs.
 
 @param serviceName The service for which to return the corresponding password.
 This value must not be nil.
 
 @param account The account for which to return the corresponding password.
 This value must not be nil.
 
 @param error   On input, a pointer to an error object. If an error occurs,
 this pointer is set to an actual error object containing the error information.
 You may specify nil for this parameter if you do not want the error information.
 See `MARKeychainErrorCode`.
 
 @return Password string, or nil when not found or error occurs.
 */
+ (nullable NSString *)getPasswordForService:(NSString *)serviceName
                                     account:(NSString *)account
                                       error:(NSError **)error;
+ (nullable NSString *)getPasswordForService:(NSString *)serviceName
                                     account:(NSString *)account;

/**
 Deletes a password from the Keychain.
 
 @param serviceName The service for which to return the corresponding password.
 This value must not be nil.
 
 @param account The account for which to return the corresponding password.
 This value must not be nil.
 
 @param error   On input, a pointer to an error object. If an error occurs,
 this pointer is set to an actual error object containing the error information.
 You may specify nil for this parameter if you do not want the error information.
 See `MARKeychainErrorCode`.
 
 @return Whether succeed.
 */
+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error;
+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account;

/**
 Insert or update the password for a given account and service.
 
 @param password    The new password.
 
 @param serviceName The service for which to return the corresponding password.
 This value must not be nil.
 
 @param account The account for which to return the corresponding password.
 This value must not be nil.
 
 @param error   On input, a pointer to an error object. If an error occurs,
 this pointer is set to an actual error object containing the error information.
 You may specify nil for this parameter if you do not want the error information.
 See `MARKeychainErrorCode`.
 
 @return Whether succeed.
 */
+ (BOOL)setPassword:(NSString *)password
         forService:(NSString *)serviceName
            account:(NSString *)account
              error:(NSError **)error;
+ (BOOL)setPassword:(NSString *)password
         forService:(NSString *)serviceName
            account:(NSString *)account;


#pragma mark - Full query for keychain (SQL-like)
///=============================================================================
/// @name Full query for keychain (SQL-like)
///=============================================================================

/**
 Insert an item into keychain.
 
 @discussion The service,account,password is required. If there's item exist
 already, an error occurs and insert fail.
 
 @param item  The item to insert.
 
 @param error On input, a pointer to an error object. If an error occurs,
 this pointer is set to an actual error object containing the error information.
 You may specify nil for this parameter if you do not want the error information.
 See `MARKeychainErrorCode`.
 
 @return Whether succeed.
 */
+ (BOOL)insertItem:(MARKeychainItem *)item error:(NSError **)error;
+ (BOOL)insertItem:(MARKeychainItem *)item;

/**
 Update item in keychain.
 
 @discussion The service,account,password is required. If there's no item exist
 already, an error occurs and insert fail.
 
 @param item  The item to insert.
 
 @param error On input, a pointer to an error object. If an error occurs,
 this pointer is set to an actual error object containing the error information.
 You may specify nil for this parameter if you do not want the error information.
 See `MARKeychainErrorCode`.
 
 @return Whether succeed.
 */
+ (BOOL)updateItem:(MARKeychainItem *)item error:(NSError **)error;
+ (BOOL)updateItem:(MARKeychainItem *)item;

/**
 Delete items from keychain.
 
 @discussion The service,account,password is required. If there's item exist
 already, an error occurs and insert fail.
 
 @param item  The item to update.
 
 @param error On input, a pointer to an error object. If an error occurs,
 this pointer is set to an actual error object containing the error information.
 You may specify nil for this parameter if you do not want the error information.
 See `MARKeychainErrorCode`.
 
 @return Whether succeed.
 */
+ (BOOL)deleteItem:(MARKeychainItem *)item error:(NSError **)error;
+ (BOOL)deleteItem:(MARKeychainItem *)item;

/**
 Find an item from keychain.
 
 @discussion The service,account is optinal. It returns only one item if there
 exist multi.
 
 @param item  The item for query.
 
 @param error On input, a pointer to an error object. If an error occurs,
 this pointer is set to an actual error object containing the error information.
 You may specify nil for this parameter if you do not want the error information.
 See `MARKeychainErrorCode`.
 
 @return An item or nil.
 */
+ (nullable MARKeychainItem *)selectOneItem:(MARKeychainItem *)item error:(NSError **)error;
+ (nullable MARKeychainItem *)selectOneItem:(MARKeychainItem *)item;

/**
 Find all items matches the query.
 
 @discussion The service,account is optinal. It returns all item matches by the
 query.
 
 @param item  The item for query.
 
 @param error On input, a pointer to an error object. If an error occurs,
 this pointer is set to an actual error object containing the error information.
 You may specify nil for this parameter if you do not want the error information.
 See `MARKeychainErrorCode`.
 
 @return An array of MARKeychainItem.
 */
+ (nullable NSArray<MARKeychainItem *> *)selectItems:(MARKeychainItem *)item error:(NSError **)error;
+ (nullable NSArray<MARKeychainItem *> *)selectItems:(MARKeychainItem *)item;

@end




#pragma mark - Const

/**
 Error code in MARKeychain API.
 */
typedef NS_ENUM (NSUInteger, MARKeychainErrorCode) {
    MARKeychainErrorUnimplemented = 1, ///< Function or operation not implemented.
    MARKeychainErrorIO, ///< I/O error (bummers)
    MARKeychainErrorOpWr, ///< File already open with with write permission.
    MARKeychainErrorParam, ///< One or more parameters passed to a function where not valid.
    MARKeychainErrorAllocate, ///< Failed to allocate memory.
    MARKeychainErrorUserCancelled, ///< User cancelled the operation.
    MARKeychainErrorBadReq, ///< Bad parameter or invalid state for operation.
    MARKeychainErrorInternalComponent, ///< Internal...
    MARKeychainErrorNotAvailable, ///< No keychain is available. You may need to restart your computer.
    MARKeychainErrorDuplicateItem, ///< The specified item already exists in the keychain.
    MARKeychainErrorItemNotFound, ///< The specified item could not be found in the keychain.
    MARKeychainErrorInteractionNotAllowed, ///< User interaction is not allowed.
    MARKeychainErrorDecode, ///< Unable to decode the provided data.
    MARKeychainErrorAuthFailed, ///< The user name or passphrase you entered is not.
};


/**
 When query to return the item's data, the error
 errSecInteractionNotAllowed will be returned if the item's data is not
 available until a device unlock occurs.
 */
typedef NS_ENUM (NSUInteger, MARKeychainAccessible) {
    MARKeychainAccessibleNone = 0, ///< no value
    
    /** Item data can only be accessed
     while the device is unlocked. This is recommended for items that only
     need be accesible while the application is in the foreground.  Items
     with this attribute will migrate to a new device when using encrypted
     backups. */
    MARKeychainAccessibleWhenUnlocked,
    
    /** Item data can only be
     accessed once the device has been unlocked after a restart.  This is
     recommended for items that need to be accesible by background
     applications. Items with this attribute will migrate to a new device
     when using encrypted backups.*/
    MARKeychainAccessibleAfterFirstUnlock,
    
    /** Item data can always be accessed
     regardless of the lock state of the device.  This is not recommended
     for anything except system use. Items with this attribute will migrate
     to a new device when using encrypted backups.*/
    MARKeychainAccessibleAlways,
    
    /** Item data can
     only be accessed while the device is unlocked. This class is only
     available if a passcode is set on the device. This is recommended for
     items that only need to be accessible while the application is in the
     foreground. Items with this attribute will never migrate to a new
     device, so after a backup is restored to a new device, these items
     will be missing. No items can be stored in this class on devices
     without a passcode. Disabling the device passcode will cause all
     items in this class to be deleted.*/
    MARKeychainAccessibleWhenPasscodeSetThisDeviceOnly,
    
    /** Item data can only
     be accessed while the device is unlocked. This is recommended for items
     that only need be accesible while the application is in the foreground.
     Items with this attribute will never migrate to a new device, so after
     a backup is restored to a new device, these items will be missing. */
    MARKeychainAccessibleWhenUnlockedThisDeviceOnly,
    
    /** Item data can
     only be accessed once the device has been unlocked after a restart.
     This is recommended for items that need to be accessible by background
     applications. Items with this attribute will never migrate to a new
     device, so after a backup is restored to a new device these items will
     be missing.*/
    MARKeychainAccessibleAfterFirstUnlockThisDeviceOnly,
    
    /** Item data can always
     be accessed regardless of the lock state of the device.  This option
     is not recommended for anything except system use. Items with this
     attribute will never migrate to a new device, so after a backup is
     restored to a new device, these items will be missing.*/
    MARKeychainAccessibleAlwaysThisDeviceOnly,
};

/**
 Whether the item in question can be synchronized.
 */
typedef NS_ENUM (NSUInteger, MARKeychainQuerySynchronizationMode) {
    
    /** Default, Don't care for synchronization  */
    MARKeychainQuerySynchronizationModeAny = 0,
    
    /** Is not synchronized */
    MARKeychainQuerySynchronizationModeNo,
    
    /** To add a new item which can be synced to other devices, or to obtain
     synchronized results from a query*/
    MARKeychainQuerySynchronizationModeYes,
} NS_AVAILABLE_IOS (7_0);


#pragma mark - Item

/**
 Wrapper for keychain item/query.
 */
@interface MARKeychainItem : NSObject <NSCopying>

@property (nullable, nonatomic, copy) NSString *service; ///< kSecAttrService
@property (nullable, nonatomic, copy) NSString *account; ///< kSecAttrAccount
@property (nullable, nonatomic, copy) NSData *genericData; ///<kSecAttrGeneric
@property (nullable, nonatomic, copy) NSString *generic; ///<genericData
@property (nullable, nonatomic, copy) id <NSCoding> genericObject; ///< shortcut for `genericData`
@property (nullable, nonatomic, copy) NSData *passwordData; ///< kSecValueData
@property (nullable, nonatomic, copy) NSString *password; ///< shortcut for `passwordData`
@property (nullable, nonatomic, copy) id <NSCoding> passwordObject; ///< shortcut for `passwordData`

@property (nullable, nonatomic, copy) NSString *label; ///< kSecAttrLabel
@property (nullable, nonatomic, copy) NSNumber *type; ///< kSecAttrType (FourCC)
@property (nullable, nonatomic, copy) NSNumber *creater; ///< kSecAttrCreator (FourCC)
@property (nullable, nonatomic, copy) NSString *comment; ///< kSecAttrComment
@property (nullable, nonatomic, copy) NSString *descr; ///< kSecAttrDescription
@property (nullable, nonatomic, readonly, strong) NSDate *modificationDate; ///< kSecAttrModificationDate
@property (nullable, nonatomic, readonly, strong) NSDate *creationDate; ///< kSecAttrCreationDate
@property (nullable, nonatomic, copy) NSString *accessGroup; ///< kSecAttrAccessGroup

@property (nonatomic) MARKeychainAccessible accessible; ///< kSecAttrAccessible
@property (nonatomic) MARKeychainQuerySynchronizationMode synchronizable NS_AVAILABLE_IOS(7_0); ///< kSecAttrSynchronizable

@end

NS_ASSUME_NONNULL_END
