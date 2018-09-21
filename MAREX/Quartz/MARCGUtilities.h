//
//  MARCGUtilities.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MAREXMacro.h"

MAR_EXTERN_C_BEGIN
NS_ASSUME_NONNULL_BEGIN

/// Create an `ARGB` Bitmap context. Returns NULL if an error occurs.
///
/// @discussion The function is same as UIGraphicsBeginImageContextWithOptions(),
/// but it doesn't push the context to UIGraphic, so you can retain the context for reuse.
CGContextRef _Nullable MARCGContextCreateARGBBitmapContext(CGSize size, BOOL opaque, CGFloat scale);

/// Create a `DeviceGray` Bitmap context. Returns NULL if an error occurs.
CGContextRef _Nullable MARCGContextCreateGrayBitmapContext(CGSize size, CGFloat scale);



/// Get main screen's scale.
CGFloat MARScreenScale(void);

/// Get main screen's size. Height is always larger than width.
CGSize MARScreenSize(void);



/// Convert degrees to radians.
static inline CGFloat MARDegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;
}

/// Convert radians to degrees.
static inline CGFloat MARRadiansToDegrees(CGFloat radians) {
    return radians * 180 / M_PI;
}



/// Get the transform rotation.
/// @return the rotation in radians [-PI,PI] ([-180°,180°])
static inline CGFloat MARCGAffineTransformGetRotation(CGAffineTransform transform) {
    return atan2(transform.b, transform.a);
}

/// Get the transform's scale.x
static inline CGFloat MARCGAffineTransformGetScaleX(CGAffineTransform transform) {
    return  sqrt(transform.a * transform.a + transform.c * transform.c);
}

/// Get the transform's scale.y
static inline CGFloat MARCGAffineTransformGetScaleY(CGAffineTransform transform) {
    return sqrt(transform.b * transform.b + transform.d * transform.d);
}

/// Get the transform's translate.x
static inline CGFloat MARCGAffineTransformGetTranslateX(CGAffineTransform transform) {
    return transform.tx;
}

/// Get the transform's translate.y
static inline CGFloat MARCGAffineTransformGetTranslateY(CGAffineTransform transform) {
    return transform.ty;
}

/**
 If you have 3 pair of points transformed by a same CGAffineTransform:
 p1 (transform->) q1
 p2 (transform->) q2
 p3 (transform->) q3
 This method returns the original transform matrix from these 3 pair of points.
 
 @see http://stackoverflow.com/questions/13291796/calculate-values-for-a-cgaffinetransform-from-three-points-in-each-of-two-uiview
 */
CGAffineTransform MARCGAffineTransformGetFromPoints(CGPoint before[3], CGPoint after[3]);

/// Get the transform which can converts a point from the coordinate system of a given view to another.
CGAffineTransform MARCGAffineTransformGetFromViews(UIView *from, UIView *to);

/// Create a skew transform.
static inline CGAffineTransform MARCGAffineTransformMakeSkew(CGFloat x, CGFloat y){
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.c = -x;
    transform.b = y;
    return transform;
}

/// Negates/inverts a UIEdgeInsets.
static inline UIEdgeInsets MARUIEdgeInsetsInvert(UIEdgeInsets insets) {
    return UIEdgeInsetsMake(-insets.top, -insets.left, -insets.bottom, -insets.right);
}

/// Convert CALayer's gravity string to UIViewContentMode.
UIViewContentMode MARCAGravityToUIViewContentMode(NSString *gravity);

/// Convert UIViewContentMode to CALayer's gravity string.
NSString *MARUIViewContentModeToCAGravity(UIViewContentMode contentMode);



/**
 Returns a rectangle to fit the param rect with specified content mode.
 
 @param rect The constrant rect
 @param size The content size
 @param mode The content mode
 @return A rectangle for the given content mode.
 @discussion UIViewContentModeRedraw is same as UIViewContentModeScaleToFill.
 */
CGRect MARCGRectFitWithContentMode(CGRect rect, CGSize size, UIViewContentMode mode);

/// Returns the center for the rectangle.
static inline CGPoint MARCGRectGetCenter(CGRect rect) {
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

/// Returns the area of the rectangle.
static inline CGFloat MARCGRectGetArea(CGRect rect) {
    if (CGRectIsNull(rect)) return 0;
    rect = CGRectStandardize(rect);
    return rect.size.width * rect.size.height;
}

/// Returns the distance between two points.
static inline CGFloat MARCGPointGetDistanceToPoint(CGPoint p1, CGPoint p2) {
    return sqrt((p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y));
}

/// Returns the minmium distance between a point to a rectangle.
static inline CGFloat MARCGPointGetDistanceToRect(CGPoint p, CGRect r) {
    r = CGRectStandardize(r);
    if (CGRectContainsPoint(r, p)) return 0;
    CGFloat distV, distH;
    if (CGRectGetMinY(r) <= p.y && p.y <= CGRectGetMaxY(r)) {
        distV = 0;
    } else {
        distV = p.y < CGRectGetMinY(r) ? CGRectGetMinY(r) - p.y : p.y - CGRectGetMaxY(r);
    }
    if (CGRectGetMinX(r) <= p.x && p.x <= CGRectGetMaxX(r)) {
        distH = 0;
    } else {
        distH = p.x < CGRectGetMinX(r) ? CGRectGetMinX(r) - p.x : p.x - CGRectGetMaxX(r);
    }
    return MAX(distV, distH);
}



/// Convert point to pixel.
static inline CGFloat MARCGFloatToPixel(CGFloat value) {
    return value * MARScreenScale();
}

/// Convert pixel to point.
static inline CGFloat MARCGFloatFromPixel(CGFloat value) {
    return value / MARScreenScale();
}



/// floor point value for pixel-aligned
static inline CGFloat MARCGFloatPixelFloor(CGFloat value) {
    CGFloat scale = MARScreenScale();
    return floor(value * scale) / scale;
}

/// round point value for pixel-aligned
static inline CGFloat MARCGFloatPixelRound(CGFloat value) {
    CGFloat scale = MARScreenScale();
    return round(value * scale) / scale;
}

/// ceil point value for pixel-aligned
static inline CGFloat MARCGFloatPixelCeil(CGFloat value) {
    CGFloat scale = MARScreenScale();
    return ceil(value * scale) / scale;
}

/// round point value to .5 pixel for path stroke (odd pixel line width pixel-aligned)
static inline CGFloat MARCGFloatPixelHalf(CGFloat value) {
    CGFloat scale = MARScreenScale();
    return (floor(value * scale) + 0.5) / scale;
}



/// floor point value for pixel-aligned
static inline CGPoint MARCGPointPixelFloor(CGPoint point) {
    CGFloat scale = MARScreenScale();
    return CGPointMake(floor(point.x * scale) / scale,
                       floor(point.y * scale) / scale);
}

/// round point value for pixel-aligned
static inline CGPoint MARCGPointPixelRound(CGPoint point) {
    CGFloat scale = MARScreenScale();
    return CGPointMake(round(point.x * scale) / scale,
                       round(point.y * scale) / scale);
}

/// ceil point value for pixel-aligned
static inline CGPoint MARCGPointPixelCeil(CGPoint point) {
    CGFloat scale = MARScreenScale();
    return CGPointMake(ceil(point.x * scale) / scale,
                       ceil(point.y * scale) / scale);
}

/// round point value to .5 pixel for path stroke (odd pixel line width pixel-aligned)
static inline CGPoint MARCGPointPixelHalf(CGPoint point) {
    CGFloat scale = MARScreenScale();
    return CGPointMake((floor(point.x * scale) + 0.5) / scale,
                       (floor(point.y * scale) + 0.5) / scale);
}



/// floor point value for pixel-aligned
static inline CGSize MARCGSizePixelFloor(CGSize size) {
    CGFloat scale = MARScreenScale();
    return CGSizeMake(floor(size.width * scale) / scale,
                      floor(size.height * scale) / scale);
}

/// round point value for pixel-aligned
static inline CGSize MARCGSizePixelRound(CGSize size) {
    CGFloat scale = MARScreenScale();
    return CGSizeMake(round(size.width * scale) / scale,
                      round(size.height * scale) / scale);
}

/// ceil point value for pixel-aligned
static inline CGSize MARCGSizePixelCeil(CGSize size) {
    CGFloat scale = MARScreenScale();
    return CGSizeMake(ceil(size.width * scale) / scale,
                      ceil(size.height * scale) / scale);
}

/// round point value to .5 pixel for path stroke (odd pixel line width pixel-aligned)
static inline CGSize MARCGSizePixelHalf(CGSize size) {
    CGFloat scale = MARScreenScale();
    return CGSizeMake((floor(size.width * scale) + 0.5) / scale,
                      (floor(size.height * scale) + 0.5) / scale);
}



/// floor point value for pixel-aligned
static inline CGRect MARCGRectPixelFloor(CGRect rect) {
    CGPoint origin = MARCGPointPixelCeil(rect.origin);
    CGPoint corner = MARCGPointPixelFloor(CGPointMake(rect.origin.x + rect.size.width,
                                                   rect.origin.y + rect.size.height));
    CGRect ret = CGRectMake(origin.x, origin.y, corner.x - origin.x, corner.y - origin.y);
    if (ret.size.width < 0) ret.size.width = 0;
    if (ret.size.height < 0) ret.size.height = 0;
    return ret;
}

/// round point value for pixel-aligned
static inline CGRect MARCGRectPixelRound(CGRect rect) {
    CGPoint origin = MARCGPointPixelRound(rect.origin);
    CGPoint corner = MARCGPointPixelRound(CGPointMake(rect.origin.x + rect.size.width,
                                                   rect.origin.y + rect.size.height));
    return CGRectMake(origin.x, origin.y, corner.x - origin.x, corner.y - origin.y);
}

/// ceil point value for pixel-aligned
static inline CGRect MARCGRectPixelCeil(CGRect rect) {
    CGPoint origin = MARCGPointPixelFloor(rect.origin);
    CGPoint corner = MARCGPointPixelCeil(CGPointMake(rect.origin.x + rect.size.width,
                                                  rect.origin.y + rect.size.height));
    return CGRectMake(origin.x, origin.y, corner.x - origin.x, corner.y - origin.y);
}

/// round point value to .5 pixel for path stroke (odd pixel line width pixel-aligned)
static inline CGRect MARCGRectPixelHalf(CGRect rect) {
    CGPoint origin = MARCGPointPixelHalf(rect.origin);
    CGPoint corner = MARCGPointPixelHalf(CGPointMake(rect.origin.x + rect.size.width,
                                                  rect.origin.y + rect.size.height));
    return CGRectMake(origin.x, origin.y, corner.x - origin.x, corner.y - origin.y);
}



/// floor UIEdgeInset for pixel-aligned
static inline UIEdgeInsets MARUIEdgeInsetPixelFloor(UIEdgeInsets insets) {
    insets.top = MARCGFloatPixelFloor(insets.top);
    insets.left = MARCGFloatPixelFloor(insets.left);
    insets.bottom = MARCGFloatPixelFloor(insets.bottom);
    insets.right = MARCGFloatPixelFloor(insets.right);
    return insets;
}

/// ceil UIEdgeInset for pixel-aligned
static inline UIEdgeInsets MARUIEdgeInsetPixelCeil(UIEdgeInsets insets) {
    insets.top = MARCGFloatPixelCeil(insets.top);
    insets.left = MARCGFloatPixelCeil(insets.left);
    insets.bottom = MARCGFloatPixelCeil(insets.bottom);
    insets.right = MARCGFloatPixelCeil(insets.right);
    return insets;
}

/// Convert transform with simple coordinate. ref https://blog.csdn.net/u010679895/article/details/46648425
/// centerX 和 centerY是视图的字面意思， x和y是针对view上的坐标的点， 参照（x, y)这个点进行旋转
static inline CGAffineTransform  MARCGAffineTransformRotateAroundPoint(float centerX, float centerY ,float x ,float y ,float angle)
{
    x = x - centerX; //计算(x,y)从(0,0)为原点的坐标系变换到(CenterX ，CenterY)为原点的坐标系下的坐标
    y = y - centerY; //(0，0)坐标系的右横轴、下竖轴是正轴,(CenterX,CenterY)坐标系的正轴也一样
    
    CGAffineTransform  trans = CGAffineTransformMakeTranslation(x, y);
    trans = CGAffineTransformRotate(trans,angle);
    trans = CGAffineTransformTranslate(trans,-x, -y);
    return trans;
}

// main screen's scale
#ifndef kScreenScale
#define kScreenScale MARScreenScale()
#endif

// main screen's size (portrait)
#ifndef kScreenSize
#define kScreenSize MARScreenSize()
#endif

// main screen's width (portrait)
#ifndef kScreenWidth
#define kScreenWidth MARScreenSize().width
#endif

// main screen's height (portrait)
#ifndef kScreenHeight
#define kScreenHeight MARScreenSize().height
#endif

NS_ASSUME_NONNULL_END
MAR_EXTERN_C_END
