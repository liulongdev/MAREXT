//
//  CALayer+MAREX.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (MAREX)

/**
 Take snapshot without transform, image's size equals to bounds.
 */
- (nullable UIImage *)mar_snapshotImage;

/**
 Take snapshot without transform, PDF's page size equals to bounds.
 */
- (nullable NSData *)mar_snapshotPDF;

/**
 Shortcut to set the layer's shadow
 
 @param color  Shadow Color
 @param offset Shadow offset
 @param radius Shadow radius
 */
- (void)mar_setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

/**
 Remove all sublayers.
 */
- (void)mar_removeAllSublayers;

@property (nonatomic) CGFloat mar_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat mar_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat mar_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat mar_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat mar_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat mar_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGPoint mar_center;      ///< Shortcut for center.
@property (nonatomic) CGFloat mar_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat mar_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint mar_origin;      ///< Shortcut for frame.origin.
@property (nonatomic, getter=mar_frameSize, setter=setMar_frameSize:) CGSize  mar_size; ///< Shortcut for frame.size.


@property (nonatomic) CGFloat mar_transformRotation;     ///< key path "tranform.rotation"
@property (nonatomic) CGFloat mar_transformRotationX;    ///< key path "tranform.rotation.x"
@property (nonatomic) CGFloat mar_transformRotationY;    ///< key path "tranform.rotation.y"
@property (nonatomic) CGFloat mar_transformRotationZ;    ///< key path "tranform.rotation.z"
@property (nonatomic) CGFloat mar_transformScale;        ///< key path "tranform.scale"
@property (nonatomic) CGFloat mar_transformScaleX;       ///< key path "tranform.scale.x"
@property (nonatomic) CGFloat mar_transformScaleY;       ///< key path "tranform.scale.y"
@property (nonatomic) CGFloat mar_transformScaleZ;       ///< key path "tranform.scale.z"
@property (nonatomic) CGFloat mar_transformTranslationX; ///< key path "tranform.translation.x"
@property (nonatomic) CGFloat mar_transformTranslationY; ///< key path "tranform.translation.y"
@property (nonatomic) CGFloat mar_transformTranslationZ; ///< key path "tranform.translation.z"

/**
 Shortcut for transform.m34, -1/1000 is a good value.
 It should be set before other transform shortcut.
 */
@property (nonatomic) CGFloat mar_transformDepth;

/**
 Wrapper for `contentsGravity` property.
 */
@property (nonatomic) UIViewContentMode mar_contentMode;

/**
 Add a fade animation to layer's contents when the contents is changed.
 
 @param duration Animation duration
 @param curve    Animation curve.
 */
- (void)mar_addFadeAnimationWithDuration:(NSTimeInterval)duration curve:(UIViewAnimationCurve)curve;

/**
 Cancel fade animation which is added with "-addFadeAnimationWithDuration:curve:".
 */
- (void)mar_removePreviousFadeAnimation;


@end

NS_ASSUME_NONNULL_END
