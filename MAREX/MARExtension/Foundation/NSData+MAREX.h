//
//  NSData+MAREX.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/16.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Provide hash, encrypt, encode and some common method for `NSData`.
 */
@interface NSData (MAREX)

/**
 Returns a lowercase NSString for md2 hash.
 */
- (NSString *)mar_md2String;

/**
 Returns an NSData for md2 hash.
 */
- (NSData *)mar_md2Data;

/**
 Returns a lowercase NSString for md4 hash.
 */
- (NSString *)mar_md4String;

/**
 Returns an NSData for md4 hash.
 */
- (NSData *)mar_md4Data;

/**
 Returns a lowercase NSString for md5 hash.
 */
- (NSString *)mar_md5String;

/**
 Returns an NSData for md5 hash.
 */
- (NSData *)mar_md5Data;

/**
 Returns a lowercase NSString for sha1 hash.
 */
- (NSString *)mar_sha1String;

/**
 Returns an NSData for sha1 hash.
 */
- (NSData *)mar_sha1Data;

/**
 Returns a lowercase NSString for sha224 hash.
 */
- (NSString *)mar_sha224String;

/**
 Returns an NSData for sha224 hash.
 */
- (NSData *)mar_sha224Data;

/**
 Returns a lowercase NSString for sha256 hash.
 */
- (NSString *)mar_sha256String;

/**
 Returns an NSData for sha256 hash.
 */
- (NSData *)mar_sha256Data;

/**
 Returns a lowercase NSString for sha384 hash.
 */
- (NSString *)mar_sha384String;

/**
 Returns an NSData for sha384 hash.
 */
- (NSData *)mar_sha384Data;

/**
 Returns a lowercase NSString for sha512 hash.
 */
- (NSString *)mar_sha512String;

/**
 Returns an NSData for sha512 hash.
 */
- (NSData *)mar_sha512Data;

/**
 Returns a lowercase NSString for hmac using algorithm md5 with key.
 @param key  The hmac key.
 */
- (NSString *)mar_hmacMD5StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm md5 with key.
 @param key  The hmac key.
 */
- (NSData *)mar_hmacMD5DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha1 with key.
 @param key  The hmac key.
 */
- (NSString *)mar_hmacSHA1StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha1 with key.
 @param key  The hmac key.
 */
- (NSData *)mar_hmacSHA1DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha224 with key.
 @param key  The hmac key.
 */
- (NSString *)mar_hmacSHA224StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha224 with key.
 @param key  The hmac key.
 */
- (NSData *)mar_hmacSHA224DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha256 with key.
 @param key  The hmac key.
 */
- (NSString *)mar_hmacSHA256StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha256 with key.
 @param key  The hmac key.
 */
- (NSData *)mar_hmacSHA256DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha384 with key.
 @param key  The hmac key.
 */
- (NSString *)mar_hmacSHA384StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha384 with key.
 @param key  The hmac key.
 */
- (NSData *)mar_hmacSHA384DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha512 with key.
 @param key  The hmac key.
 */
- (NSString *)mar_hmacSHA512StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha512 with key.
 @param key  The hmac key.
 */
- (NSData *)mar_hmacSHA512DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for crc32 hash.
 */
- (NSString *)mar_crc32String;

/**
 Returns crc32 hash.
 */
- (uint32_t)mar_crc32;

#pragma mark - Encrypt and Decrypt
///=============================================================================
/// @name Encrypt and Decrypt
///=============================================================================

/**
 Returns an encrypted NSData using AES.
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData encrypted, or nil if an error occurs.
 */
- (nullable NSData *)mar_aes256EncryptWithKey:(NSData *)key iv:(nullable NSData *)iv;

/**
 Returns an decrypted NSData using AES.
 
 @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
 
 @param iv    An initialization vector length of 16(128bits).
 Pass nil when you don't want to use iv.
 
 @return      An NSData decrypted, or nil if an error occurs.
 */
- (nullable NSData *)mar_aes256DecryptWithkey:(NSData *)key iv:(nullable NSData *)iv;

#pragma mark - Encode and decode
///=============================================================================
/// @name Encode and decode
///=============================================================================

/**
 Returns string decoded in UTF8.
 */
- (nullable NSString *)mar_utf8String;

/**
 Returns a uppercase NSString in HEX.
 */
- (nullable NSString *)mar_hexString;

/**
 Returns an NSData from hex string.
 
 @param hexString   The hex string which is case insensitive.
 
 @return a new NSData, or nil if an error occurs.
 */
+ (nullable NSData *)mar_dataWithHexString:(NSString *)hexString;

/**
 Returns an NSString for base64 encoded.
 */
- (nullable NSString *)mar_base64EncodedString;

/**
 Returns an NSData from base64 encoded string.
 
 @warning This method has been implemented in iOS7.
 
 @param base64EncodedString  The encoded string.
 */
+ (nullable NSData *)mar_dataWithBase64EncodedString:(NSString *)base64EncodedString;

/**
 Returns an NSDictionary or NSArray for decoded self.
 Returns nil if an error occurs.
 */
- (nullable id)mar_jsonValueDecoded;


#pragma mark - Inflate and deflate
///=============================================================================
/// @name Inflate and deflate
///=============================================================================

/**
 Decompress data from gzip data.
 @return Inflated data.
 */
- (nullable NSData *)mar_gzipInflate;

/**
 Comperss data to gzip in default compresssion level.
 @return Deflated data.
 */
- (nullable NSData *)mar_gzipDeflate;

/**
 Decompress data from zlib-compressed data.
 @return Inflated data.
 */
- (nullable NSData *)mar_zlibInflate;

/**
 Comperss data to zlib-compressed in default compresssion level.
 @return Deflated data.
 */
- (nullable NSData *)mar_zlibDeflate;


#pragma mark - Others
///=============================================================================
/// @name Others
///=============================================================================

/**
 Create data from the file in main bundle (similar to [UIImage imageNamed:]).
 
 @param name The file name (in main bundle).
 
 @return A new data create from the file.
 */
+ (nullable NSData *)mar_dataNamed:(NSString *)name;

/**
 Compress image and convert to type of NSData.

 @param image orignal image
 @param size max kbytes
 @return image binary
 */
+ (NSData *)mar_compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
