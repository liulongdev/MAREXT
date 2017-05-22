//
//  NSString+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/16.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "NSString+MAREX.h"
#import "NSData+MAREX.h"
#import "NSNumber+MAREX.h"

@implementation NSString (MAREX)

- (NSString *)mar_md2String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] mar_md2String];
}

- (NSString *)mar_md4String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] mar_md4String];
}

- (NSString *)mar_md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] mar_md5String];
}

- (NSString *)mar_sha1String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] mar_sha1String];
}

- (NSString *)mar_sha224String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] mar_sha224String];
}

- (NSString *)mar_sha256String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] mar_sha256String];
}

- (NSString *)mar_sha384String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] mar_sha384String];
}

- (NSString *)mar_sha512String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] mar_sha512String];
}

- (NSString *)mar_crc32String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] mar_crc32String];
}

- (NSString *)mar_hmacMD5StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            mar_hmacMD5StringWithKey:key];
}

- (NSString *)mar_hmacSHA1StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            mar_hmacSHA1StringWithKey:key];
}

- (NSString *)mar_hmacSHA224StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            mar_hmacSHA224StringWithKey:key];
}

- (NSString *)mar_hmacSHA256StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            mar_hmacSHA256StringWithKey:key];
}

- (NSString *)mar_hmacSHA384StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            mar_hmacSHA384StringWithKey:key];
}

- (NSString *)mar_hmacSHA512StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            mar_hmacSHA512StringWithKey:key];
}

- (NSString *)mar_base64EncodedString {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] mar_base64EncodedString];
}

+ (NSString *)mar_stringWithBase64EncodedString:(NSString *)base64EncodedString {
    NSData *data = [NSData mar_dataWithBase64EncodedString:base64EncodedString];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)mar_stringByURLEncode
{
    if ([self respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)]) {
        /**
         AFNetworking/AFURLRequestSerialization.m
         
         Returns a percent-escaped string following RFC 3986 for a query string key or value.
         RFC 3986 states that the following characters are "reserved" characters.
         - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
         - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
         In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
         query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
         should be percent-escaped in the query string.
         - parameter string: The string to be percent-escaped.
         - returns: The percent-escaped string.
         */
        static NSString * const kAFCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
        static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
        
        NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
        [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
        static NSUInteger const batchSize = 50;
        
        NSUInteger index = 0;
        NSMutableString *escaped = @"".mutableCopy;
        
        while (index < self.length) {
            NSUInteger length = MIN(self.length - index, batchSize);
            NSRange range = NSMakeRange(index, length);
            // To avoid breaking up character sequences such as 👴🏻👮🏽
            range = [self rangeOfComposedCharacterSequencesForRange:range];
            NSString *substring = [self substringWithRange:range];
            NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
            [escaped appendString:encoded];
            
            index += range.length;
        }
        return escaped;
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding cfEncoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *encoded = (__bridge_transfer NSString *)
        CFURLCreateStringByAddingPercentEscapes(
                                                kCFAllocatorDefault,
                                                (__bridge CFStringRef)self,
                                                NULL,
                                                CFSTR("!#$&'()*+,/:;=?@[]"),
                                                cfEncoding);
        return encoded;
#pragma clang diagnostic pop
    }
}

- (NSString *)mar_stringByURLDecode
{
    if ([self respondsToSelector:@selector(stringByRemovingPercentEncoding)]) {
        return [self stringByRemovingPercentEncoding];
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding en = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *decoded = [self stringByReplacingOccurrencesOfString:@"+"
                                                            withString:@" "];
        decoded = (__bridge_transfer NSString *)
        CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                NULL,
                                                                (__bridge CFStringRef)decoded,
                                                                CFSTR(""),
                                                                en);
        return decoded;
#pragma clang diagnostic pop
    }
}

- (NSString *)mar_stringByEscapingHTML {
    NSUInteger len = self.length;
    if (!len) return self;
    
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) return self;
    [self getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < len; i++) {
        unichar c = buf[i];
        NSString *esc = nil;
        switch (c) {
            case 34: esc = @"&quot;"; break;
            case 38: esc = @"&amp;"; break;
            case 39: esc = @"&apos;"; break;
            case 60: esc = @"&lt;"; break;
            case 62: esc = @"&gt;"; break;
            default: break;
        }
        if (esc) {
            [result appendString:esc];
        } else {
            CFStringAppendCharacters((CFMutableStringRef)result, &c, 1);
        }
    }
    free(buf);
    return result;
}

- (CGSize)mar_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (CGFloat)mar_widthForFont:(UIFont *)font {
    CGSize size = [self mar_sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)mar_heightForFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self mar_sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

- (BOOL)mar_matchesRegex:(NSString *)regex options:(NSRegularExpressionOptions)options {
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:NULL];
    if (!pattern) return NO;
    return ([pattern numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)] > 0);
}

- (void)mar_enumerateRegexMatches:(NSString *)regex
                      options:(NSRegularExpressionOptions)options
                   usingBlock:(void (^)(NSString *match, NSRange matchRange, BOOL *stop))block {
    if (regex.length == 0 || !block) return;
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:nil];
    if (!regex) return;
    [pattern enumerateMatchesInString:self options:kNilOptions range:NSMakeRange(0, self.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        block([self substringWithRange:result.range], result.range, stop);
    }];
}

- (NSString *)mar_stringByReplacingRegex:(NSString *)regex
                             options:(NSRegularExpressionOptions)options
                          withString:(NSString *)replacement; {
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:nil];
    if (!pattern) return self;
    return [pattern stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:replacement];
}

- (char)mar_charValue {
    return self.mar_numberValue.charValue;
}

- (unsigned char)mar_unsignedCharValue {
    return self.mar_numberValue.unsignedCharValue;
}

- (short)mar_shortValue {
    return self.mar_numberValue.shortValue;
}

- (unsigned short)mar_unsignedShortValue {
    return self.mar_numberValue.unsignedShortValue;
}

- (unsigned int)mar_unsignedIntValue {
    return self.mar_numberValue.unsignedIntValue;
}

- (long)mar_longValue {
    return self.mar_numberValue.longValue;
}

- (unsigned long)mar_unsignedLongValue {
    return self.mar_numberValue.unsignedLongValue;
}

- (unsigned long long)mar_unsignedLongLongValue {
    return self.mar_numberValue.unsignedLongLongValue;
}

- (NSUInteger)mar_unsignedIntegerValue {
    return self.mar_numberValue.unsignedIntegerValue;
}

+ (NSString *)mar_stringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

+ (NSString *)mar_stringWithUTF32Char:(UTF32Char)char32 {
    char32 = NSSwapHostIntToLittle(char32);
    return [[NSString alloc] initWithBytes:&char32 length:4 encoding:NSUTF32LittleEndianStringEncoding];
}

+ (NSString *)mar_stringWithUTF32Chars:(const UTF32Char *)char32 length:(NSUInteger)length {
    return [[NSString alloc] initWithBytes:(const void *)char32
                                    length:length * 4
                                  encoding:NSUTF32LittleEndianStringEncoding];
}

- (void)mar_enumerateUTF32CharInRange:(NSRange)range usingBlock:(void (^)(UTF32Char char32, NSRange range, BOOL *stop))block {
    NSString *str = self;
    if (range.location != 0 || range.length != self.length) {
        str = [self substringWithRange:range];
    }
    NSUInteger len = [str lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4;
    UTF32Char *char32 = (UTF32Char *)[str cStringUsingEncoding:NSUTF32LittleEndianStringEncoding];
    if (len == 0 || char32 == NULL) return;
    
    NSUInteger location = 0;
    BOOL stop = NO;
    NSRange subRange;
    UTF32Char oneChar;
    
    for (NSUInteger i = 0; i < len; i++) {
        oneChar = char32[i];
        subRange = NSMakeRange(location, oneChar > 0xFFFF ? 2 : 1);
        block(oneChar, subRange, &stop);
        if (stop) return;
        location += subRange.length;
    }
}

- (NSString *)mar_stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSString *)mar_stringByAppendingNameScale:(CGFloat)scale {
    if (fabs(scale - 1) <= __FLT_EPSILON__ || self.length == 0 || [self hasSuffix:@"/"]) return self.copy;
    return [self stringByAppendingFormat:@"@%@x", @(scale)];
}

- (NSString *)mar_stringByAppendingPathScale:(CGFloat)scale {
    if (fabs(scale - 1) <= __FLT_EPSILON__ || self.length == 0 || [self hasSuffix:@"/"]) return self.copy;
    NSString *ext = self.pathExtension;
    NSRange extRange = NSMakeRange(self.length - ext.length, 0);
    if (ext.length > 0) extRange.location -= 1;
    NSString *scaleStr = [NSString stringWithFormat:@"@%@x", @(scale)];
    return [self stringByReplacingCharactersInRange:extRange withString:scaleStr];
}

- (CGFloat)mar_pathScale {
    if (self.length == 0 || [self hasSuffix:@"/"]) return 1;
    NSString *name = self.stringByDeletingPathExtension;
    __block CGFloat scale = 1;
    [name mar_enumerateRegexMatches:@"@[0-9]+\\.?[0-9]*x$" options:NSRegularExpressionAnchorsMatchLines usingBlock: ^(NSString *match, NSRange matchRange, BOOL *stop) {
        scale = [match substringWithRange:NSMakeRange(1, match.length - 2)].doubleValue;
    }];
    return scale;
}

- (BOOL)mar_isNotBlank {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)mar_containsString:(NSString *)string {
    if (string == nil) return NO;
    return [self rangeOfString:string].location != NSNotFound;
}

- (BOOL)mar_containsCharacterSet:(NSCharacterSet *)set {
    if (set == nil) return NO;
    return [self rangeOfCharacterFromSet:set].location != NSNotFound;
}

- (NSNumber *)mar_numberValue {
    return [NSNumber mar_numberWithString:self];
}

- (NSData *)mar_dataValue {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSRange)mar_rangeOfAll {
    return NSMakeRange(0, self.length);
}

- (id)mar_jsonValueDecoded {
    return [[self mar_dataValue] mar_jsonValueDecoded];
}

+ (NSString *)mar_stringNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    if (!str) {
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
        str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    }
    return str;
}


- (BOOL)mar_isEmail {
    return [NSString mar_isEmail:self];
}

+ (BOOL)mar_isEmail:(NSString * _Nonnull)email {
    NSString *emailRegEx = @"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[email lowercaseString]];
}

- (NSString * _Nonnull)mar_removeExtraSpaces {
    NSString *squashed = [self stringByReplacingOccurrencesOfString:@"[ ]+" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
    return [squashed stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end

@implementation NSString (MAREX_CheckPasswordStrong)

+ (MARPasswordStrengthLevel)mar_checkPasswordStrength:(NSString * _Nonnull)password {
    NSInteger length = [password length];
    int lowercase = [self p_mar_countLowercaseLetters:password];
    int uppercase = [self p_mar_countUppercaseLetters:password];
    int numbers = [self p_mar_countNumbers:password];
    int symbols = [self p_mar_countSymbols:password];
    
    int score = 0;
    
    if (length < 5)
        score += 5;
    else
        if (length > 4 && length < 8)
            score += 10;
        else
            if (length > 7)
                score += 20;
    
    if (numbers == 1)
        score += 10;
    else
        if (numbers == 2)
            score += 15;
        else
            if (numbers > 2)
                score += 20;
    
    if (symbols == 1)
        score += 10;
    else
        if (symbols == 2)
            score += 15;
        else
            if (symbols > 2)
                score += 20;
    
    if (lowercase == 1)
        score += 10;
    else
        if (lowercase == 2)
            score += 15;
        else
            if (lowercase > 2)
                score += 20;
    
    if (uppercase == 1)
        score += 10;
    else
        if (uppercase == 2)
            score += 15;
        else
            if (uppercase > 2)
                score += 20;
    
    if (score == 100)
        return MARPasswordStrengthLevelVerySecure;
    else
        if (score >= 90)
            return MARPasswordStrengthLevelSecure;
        else
            if (score >= 80)
                return MARPasswordStrengthLevelVeryStrong;
            else
                if (score >= 70)
                    return MARPasswordStrengthLevelStrong;
                else
                    if (score >= 60)
                        return MARPasswordStrengthLevelAverage;
                    else
                        if (score >= 50)
                            return MARPasswordStrengthLevelWeak;
                        else
                            return MARPasswordStrengthLevelVeryWeak;
}

+ (int)p_mar_countLowercaseLetters:(NSString * _Nonnull)password {
    int count = 0;
    
    for (int i = 0; i < [password length]; i++) {
        BOOL isLowercase = [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:[password characterAtIndex:i]];
        if (isLowercase == YES) {
            count++;
        }
    }
    
    return count;
}

+ (int)p_mar_countUppercaseLetters:(NSString * _Nonnull)password {
    int count = 0;
    
    for (int i = 0; i < [password length]; i++) {
        BOOL isUppercase = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:[password characterAtIndex:i]];
        if (isUppercase == YES) {
            count++;
        }
    }
    
    return count;
}

+ (int)p_mar_countNumbers:(NSString * _Nonnull)password {
    int count = 0;
    
    for (int i = 0; i < [password length]; i++) {
        BOOL isNumber = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] characterIsMember:[password characterAtIndex:i]];
        if (isNumber == YES) {
            count++;
        }
    }
    
    return count;
}

+ (int)p_mar_countSymbols:(NSString * _Nonnull)password {
    int count = 0;
    
    for (int i = 0; i < [password length]; i++) {
        BOOL isSymbol = [[NSCharacterSet characterSetWithCharactersInString:@"`~!?@#$€£¥§%^&*()_+-={}[]:\";.,<>'•\\|/"] characterIsMember:[password characterAtIndex:i]];
        if (isSymbol == YES) {
            count++;
        }
    }
    
    return count;
}

@end

@implementation NSString (MAREX_Path)

- (NSString *)mar_documentsDirectoryPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
