//
//  UIColor+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2018/3/28.
//  Copyright © 2018年 MAR. All rights reserved.
//

#import "UIColor+MAREX.h"
#import "NSString+MAREX.h"
@implementation UIColor (MAREX)

- (CGFloat)red {
    CGFloat r = 0, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return r;
}

- (CGFloat)green {
    CGFloat r, g = 0, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return g;
}

- (CGFloat)blue {
    CGFloat r, g, b = 0, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return b;
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}

- (uint32_t)rgbValue {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    int8_t red = r * 255;
    uint8_t green = g * 255;
    uint8_t blue = b * 255;
    return (red << 16) + (green << 8) + blue;
}

- (uint32_t)rgbaValue {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    int8_t red = r * 255;
    uint8_t green = g * 255;
    uint8_t blue = b * 255;
    uint8_t alpha = a * 255;
    return (red << 24) + (green << 16) + (blue << 8) + alpha;
}

- (NSString *)hexString {
    return [self hexStringWithAlpha:NO];
}

- (NSString *)hexStringWithAlpha {
    return [self hexStringWithAlpha:YES];
}

- (NSString *)hexStringWithAlpha:(BOOL)withAlpha {
    CGColorRef color = self.CGColor;
    size_t count = CGColorGetNumberOfComponents(color);
    const CGFloat *components = CGColorGetComponents(color);
    static NSString *stringFormat = @"%02x%02x%02x";
    NSString *hex = nil;
    if (count == 2) {
        NSUInteger white = (NSUInteger)(components[0] * 255.0f);
        hex = [NSString stringWithFormat:stringFormat, white, white, white];
    } else if (count == 4) {
        hex = [NSString stringWithFormat:stringFormat,
               (NSUInteger)(components[0] * 255.0f),
               (NSUInteger)(components[1] * 255.0f),
               (NSUInteger)(components[2] * 255.0f)];
    }
    
    if (hex && withAlpha) {
        hex = [hex stringByAppendingFormat:@"%02lx",
               (unsigned long)(self.alpha * 255.0 + 0.5)];
    }
    return hex;
}

+ (UIColor *)colorWithRGB:(uint32_t)rgbValue {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
                            blue:(rgbValue & 0xFF) / 255.0f
                           alpha:1];
}

+ (UIColor *)colorWithRGBA:(uint32_t)rgbaValue {
    return [UIColor colorWithRed:((rgbaValue & 0xFF000000) >> 24) / 255.0f
                           green:((rgbaValue & 0xFF0000) >> 16) / 255.0f
                            blue:((rgbaValue & 0xFF00) >> 8) / 255.0f
                           alpha:(rgbaValue & 0xFF) / 255.0f];
}

+ (UIColor *)colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
                            blue:(rgbValue & 0xFF) / 255.0f
                           alpha:alpha];
}

+ (instancetype)colorWithHexString:(NSString *)hexStr {
    CGFloat r, g, b, a;
    if (hexStrToRGBA(hexStr, &r, &g, &b, &a)) {
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    return nil;
}

static inline NSUInteger hexStrToInt(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}

static BOOL hexStrToRGBA(NSString *str,
                         CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a) {
    str = [[str mar_stringByTrim] uppercaseString];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0X"]) {
        str = [str substringFromIndex:2];
    }
    
    NSUInteger length = [str length];
    //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    
    //RGB,RGBA,RRGGBB,RRGGBBAA
    if (length < 5) {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
        if (length == 4)  *a = hexStrToInt([str substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
        else *a = 1;
    } else {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
        if (length == 8) *a = hexStrToInt([str substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
        else *a = 1;
    }
    return YES;
}

- (UIColor *)colorByAddColor:(UIColor *)add blendMode:(CGBlendMode)blendMode {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big;
    uint8_t pixel[4] = { 0 };
    CGContextRef context = CGBitmapContextCreate(&pixel, 1, 1, 8, 4, colorSpace, bitmapInfo);
    CGContextSetFillColorWithColor(context, self.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextSetBlendMode(context, blendMode);
    CGContextSetFillColorWithColor(context, add.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIColor colorWithRed:pixel[0] / 255.0f green:pixel[1] / 255.0f blue:pixel[2] / 255.0f alpha:pixel[3] / 255.0f];
}


@end

@implementation UIColor (MAREX_IMAGE)

- (BOOL)mar_isDarkColor
{
    UIColor *convertedColor = self;//[self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
    
    CGFloat r, g, b, a;
    
    [convertedColor getRed:&r green:&g blue:&b alpha:&a];
    
    CGFloat lum = 0.2126 * r + 0.7152 * g + 0.0722 * b;
    
    if ( lum < .5 )
    {
        return YES;
    }
    
    return NO;
}


- (BOOL)mar_isDistinct:(UIColor*)compareColor
{
    UIColor *convertedColor = self;//[self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
    UIColor *convertedCompareColor = compareColor;//[compareColor colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
    CGFloat r, g, b, a;
    CGFloat r1, g1, b1, a1;
    
    [convertedColor getRed:&r green:&g blue:&b alpha:&a];
    [convertedCompareColor getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    
    CGFloat threshold = .25; //.15
    
    if ( fabs(r - r1) > threshold ||
        fabs(g - g1) > threshold ||
        fabs(b - b1) > threshold ||
        fabs(a - a1) > threshold )
    {
        // check for grays, prevent multiple gray colors
        
        if ( fabs(r - g) < .03 && fabs(r - b) < .03 )
        {
            if ( fabs(r1 - g1) < .03 && fabs(r1 - b1) < .03 )
                return NO;
        }
        
        return YES;
    }
    
    return NO;
}


- (UIColor*)mar_colorWithMinimumSaturation:(CGFloat)minSaturation
{
    UIColor *tempColor = self;//[self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
    
    if ( tempColor != nil )
    {
        CGFloat hue = 0.0;
        CGFloat saturation = 0.0;
        CGFloat brightness = 0.0;
        CGFloat alpha = 0.0;
        
        [tempColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
        
        if ( saturation < minSaturation )
        {
            return [UIColor colorWithHue:hue saturation:minSaturation brightness:brightness alpha:alpha];
        }
    }
    
    return self;
}


- (BOOL)mar_isBlackOrWhite
{
    UIColor *tempColor = self;//[self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
    
    if ( tempColor != nil )
    {
        CGFloat r, g, b, a;
        
        [tempColor getRed:&r green:&g blue:&b alpha:&a];
        
        if ( r > .91 && g > .91 && b > .91 )
            return YES; // white
        
        if ( r < .09 && g < .09 && b < .09 )
            return YES; // black
    }
    
    return NO;
}


- (BOOL)mar_isContrastingColor:(UIColor*)color
{
    UIColor *backgroundColor = self;//[self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
    UIColor *foregroundColor = color;//[color colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
    
    if ( backgroundColor != nil && foregroundColor != nil )
    {
        CGFloat br, bg, bb, ba;
        CGFloat fr, fg, fb, fa;
        
        [backgroundColor getRed:&br green:&bg blue:&bb alpha:&ba];
        [foregroundColor getRed:&fr green:&fg blue:&fb alpha:&fa];
        
        CGFloat bLum = 0.2126 * br + 0.7152 * bg + 0.0722 * bb;
        CGFloat fLum = 0.2126 * fr + 0.7152 * fg + 0.0722 * fb;
        
        CGFloat contrast = 0.;
        
        if ( bLum > fLum )
            contrast = (bLum + 0.05) / (fLum + 0.05);
        else
            contrast = (fLum + 0.05) / (bLum + 0.05);
        
        //return contrast > 3.0; //3-4.5
        return contrast > 1.6;
    }
    
    return YES;
}

@end

