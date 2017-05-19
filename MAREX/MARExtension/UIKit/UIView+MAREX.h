//
//  UIView+MAREX.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/16.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Direction of the linear gradient
 */
typedef NS_ENUM(NSInteger, MARUIViewLinearGradientDirection) {
    /**
     *  Linear gradient vertical
     */
    MARUIViewLinearGradientDirectionVertical = 0,
    /**
     *  Linear gradient horizontal
     */
    MARUIViewLinearGradientDirectionHorizontal,
    /**
     *  Linear gradient from left to right and top to down
     */
    MARUIViewLinearGradientDirectionDiagonalFromLeftToRightAndTopToDown,
    /**
     *  Linear gradient from left to right and down to top
     */
    MARUIViewLinearGradientDirectionDiagonalFromLeftToRightAndDownToTop,
    /**
     *  Linear gradient from right to left and top to down
     */
    MARUIViewLinearGradientDirectionDiagonalFromRightToLeftAndTopToDown,
    /**
     *  Linear gradient from right to left and down to top
     */
    MARUIViewLinearGradientDirectionDiagonalFromRightToLeftAndDownToTop
};

@interface UIView (MAREX)

/**
 Create a snapshot image of the complete view hierarchy.
 */
- (nullable UIImage *)snapshotImage;

/**
 *  Take a screenshot of the current view an saving to the saved photos album
 *
 *  @return Returns screenshot as UIImage
 */
- (UIImage * _Nonnull)saveSnapshotImage;

/**
 Create a snapshot image of the complete view hierarchy.
 @discussion It's faster than "snapshotImage", but may cause screen updates.
 See -[UIView drawViewHierarchyInRect:afterScreenUpdates:] for more information.
 */
- (nullable UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

/**
 Create a snapshot PDF of the complete view hierarchy.
 */
- (nullable NSData *)snapshotPDF;

/**
 Shortcut to set the view.layer's shadow
 
 @param color  Shadow Color
 @param offset Shadow offset
 @param radius Shadow radius
 */
- (void)setLayerShadow:(nullable UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

/**
 *  Create a border around the UIView
 *
 *  @param color  Border's color
 *  @param radius Border's radius
 *  @param width  Border's width
 */
- (void)setLayerBorderWithColor:(UIColor * _Nonnull)color
               withCornerRadius:(CGFloat)radius
                       andWidth:(CGFloat)width;

/**
 *  Remove the borders around the UIView
 */
- (void)removeBorders;

/**
 *  Create a corner radius shadow on the UIView
 *
 *  @param cornerRadius Corner radius value
 *  @param offset       Shadow's offset
 *  @param opacity      Shadow's opacity
 *  @param radius       Shadow's radius
 */
- (void)setLayerShadowWithColor:(nullable UIColor *)color
                   cornerRadius:(CGFloat)cornerRadius
                         offset:(CGSize)offset
                        opacity:(CGFloat)opacity
                         radius:(CGFloat)radius;

/**
 *  Remove the shadow around the UIView
 */
- (void)removeShadow;

/**
 *  Create a linear gradient
 *
 *  @param colors    NSArray of UIColor instances
 *  @param direction Direction of the gradient
 */
- (void)setGradientWithColors:(NSArray * _Nonnull)colors
                    direction:(MARUIViewLinearGradientDirection)direction;

/**
 Remove all subviews.
 
 @warning Never call this method inside your view's drawRect: method.
 */
- (void)removeAllSubviews;

/**
 Returns the view's view controller (may be nil).
 */
@property (nullable, nonatomic, readonly) UIViewController *viewController;

/**
 Returns the visible alpha on screen, taking into account superview and window.
 */
@property (nonatomic, readonly) CGFloat visibleAlpha;

/**
 Converts a point from the receiver's coordinate system to that of the specified view or window.
 
 @param point A point specified in the local coordinate system (bounds) of the receiver.
 @param view  The view or window into whose coordinate system point is to be converted.
 If view is nil, this method instead converts to window base coordinates.
 @return The point converted to the coordinate system of view.
 */
- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(nullable UIView *)view;

/**
 Converts a point from the coordinate system of a given view or window to that of the receiver.
 
 @param point A point specified in the local coordinate system (bounds) of view.
 @param view  The view or window with point in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The point converted to the local coordinate system (bounds) of the receiver.
 */
- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(nullable UIView *)view;

/**
 Converts a rectangle from the receiver's coordinate system to that of another view or window.
 
 @param rect A rectangle specified in the local coordinate system (bounds) of the receiver.
 @param view The view or window that is the target of the conversion operation. If view is nil, this method instead converts to window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(nullable UIView *)view;

/**
 Converts a rectangle from the coordinate system of another view or window to that of the receiver.
 
 @param rect A rectangle specified in the local coordinate system (bounds) of view.
 @param view The view or window with rect in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(nullable UIView *)view;

@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  size;        ///< Shortcut for frame.size.

@end


/**
 *  Direction of flip animation
 */
typedef NS_ENUM(NSInteger, MARUIViewAnimationFlipDirection) {
    /**
     *  Flip animation from top
     */
    MARUIViewAnimationFlipDirectionFromTop = 0,
    /**
     *  Flip animation from left
     */
    MARUIViewAnimationFlipDirectionFromLeft,
    /**
     *  Flip animation from right
     */
    MARUIViewAnimationFlipDirectionFromRight,
    /**
     *  Flip animation from bottom
     */
    MARUIViewAnimationFlipDirectionFromBottom
};

/**
 *  Direction of the translation
 */
typedef NS_ENUM(NSInteger, MARUIViewAnimationTranslationDirection) {
    /**
     *  Translation from left to right
     */
    MARUIViewAnimationTranslationDirectionFromLeftToRight = 0,
    /**
     *  Translation from right to left
     */
    MARUIViewAnimationTranslationDirectionFromRightToLeft
};

@interface UIView (MAREX_Animation)

/**
 *  Create a shake effect on the UIView
 */
- (void)shakeView;

/**
 *  Create a pulse effect on th UIView
 *
 *  @param duration Seconds of animation
 */
- (void)pulseViewWithDuration:(CGFloat)duration;

/**
 *  Create a heartbeat effect on the UIView
 *
 *  @param duration Seconds of animation
 */
- (void)heartbeatViewWithDuration:(CGFloat)duration;

/**
 *  Adds a motion effect to the view
 */
- (void)applyMotionEffects;

/**
 *  Adds a motion effect to the view With offset
 */
- (void)applyMotionEffectsWithOffset:(CGSize)offset;

/**
 *  Flip the view
 *
 *  @param duration  Seconds of animation
 *  @param direction Direction of the flip animation
 */
- (void)flipWithDuration:(NSTimeInterval)duration
               direction:(MARUIViewAnimationFlipDirection)direction;

/**
 *  Translate the UIView around the topView
 *
 *  @param topView       Top view to translate to
 *  @param duration      Duration of the translation
 *  @param direction     Direction of the translation
 *  @param repeat        If the animation must be repeat or no
 *  @param startFromEdge If the animation must start from the edge
 */
- (void)translateAroundTheView:(UIView * _Nonnull)topView
                      duration:(CGFloat)duration
                     direction:(MARUIViewAnimationTranslationDirection)direction
                        repeat:(BOOL)repeat
                 startFromEdge:(BOOL)startFromEdge;

@end
