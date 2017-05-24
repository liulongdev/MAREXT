//
//  UIView+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/16.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "UIView+MAREX.h"
#import "UIGestureRecognizer+MAREX.h"

@implementation UIView (MAREX)

- (UIImage *)mar_snapshotImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }
    else
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (UIImage *)mar_saveSnapshotImage
{
    UIImage *image = [self mar_saveSnapshotImage];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    return image;
}

- (UIImage *)mar_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates
{
    if (![self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        return [self mar_snapshotImage];
    }
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (NSData *)mar_snapshotPDF
{
    CGRect bounds = self.bounds;
    NSMutableData *data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

- (void)mar_setLayerShadow:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius
{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 1;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)mar_setLayerBorderWithColor:(UIColor *)color withCornerRadius:(CGFloat)radius andWidth:(CGFloat)width
{
    self.layer.borderWidth = width;
    self.layer.cornerRadius = radius;
    self.layer.shouldRasterize = NO;
    self.layer.rasterizationScale = 2;
    self.layer.edgeAntialiasingMask = kCALayerLeftEdge | kCALayerRightEdge | kCALayerBottomEdge | kCALayerTopEdge;
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGColorRef cgColor = [color CGColor];
    self.layer.borderColor = cgColor;
    CGColorSpaceRelease(space);
}

- (void)mar_removeBorders {
    self.layer.borderWidth = 0;
    self.layer.cornerRadius = 0;
    self.layer.borderColor = nil;
}

- (void)mar_removeAllSubviews
{
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

- (void)mar_setLayerShadowWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius
{
    if (!color) {
        color = [UIColor blackColor];
    }
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shouldRasterize = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:cornerRadius] CGPath];
    self.layer.masksToBounds = NO;
}

- (void)mar_removeShadow {
    [self.layer setShadowColor:[[UIColor clearColor] CGColor]];
    [self.layer setShadowOpacity:0.0f];
    [self.layer setShadowOffset:CGSizeMake(0.0f, 0.0f)];
}

- (void)mar_setGradientWithColors:(NSArray *)colors direction:(MARUIViewLinearGradientDirection)direction
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    
    NSMutableArray *mutableColors = colors.mutableCopy;
    for (int i = 0; i < colors.count; i++) {
        UIColor *currentColor = colors[i];
        [mutableColors replaceObjectAtIndex:i withObject:(id)currentColor.CGColor];
    }
    gradient.colors = mutableColors;
    
    switch (direction) {
        case MARUIViewLinearGradientDirectionVertical: {
            gradient.startPoint = CGPointMake(0.5f, 0.0f);
            gradient.endPoint = CGPointMake(0.5f, 1.0f);
            break;
        }
        case MARUIViewLinearGradientDirectionHorizontal: {
            gradient.startPoint = CGPointMake(0.0f, 0.5f);
            gradient.endPoint = CGPointMake(1.0f, 0.5f);
            break;
        }
        case MARUIViewLinearGradientDirectionDiagonalFromLeftToRightAndTopToDown: {
            gradient.startPoint = CGPointMake(0.0f, 0.0f);
            gradient.endPoint = CGPointMake(1.0f, 1.0f);
            break;
        }
        case MARUIViewLinearGradientDirectionDiagonalFromLeftToRightAndDownToTop: {
            gradient.startPoint = CGPointMake(0.0f, 1.0f);
            gradient.endPoint = CGPointMake(1.0f, 0.0f);
            break;
        }
        case MARUIViewLinearGradientDirectionDiagonalFromRightToLeftAndTopToDown: {
            gradient.startPoint = CGPointMake(1.0f, 0.0f);
            gradient.endPoint = CGPointMake(0.0f, 1.0f);
            break;
        }
        case MARUIViewLinearGradientDirectionDiagonalFromRightToLeftAndDownToTop: {
            gradient.startPoint = CGPointMake(1.0f, 1.0f);
            gradient.endPoint = CGPointMake(0.0f, 0.0f);
            break;
        }
    }
    [self.layer insertSublayer:gradient atIndex:0];
}

- (UIViewController *)mar_viewController
{
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (CGFloat)mar_visibleAlpha
{
    if ([self isKindOfClass:[UIWindow class]]) {
        if (self.hidden) return 0;
        return self.alpha;
    }
    if (!self.window) return 0;
    CGFloat alpha = 1;
    UIView *v = self;
    while (v) {
        if (v.hidden) {
            alpha = 0;
            break;
        }
        alpha *= v.alpha;
        v = v.superview;
    }
    return alpha;
}

- (CGPoint)mar_convertPoint:(CGPoint)point toViewOrWindow:(UIView *)view
{
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self ) convertPoint:point toWindow:nil];
        }
        else
        {
            return [self convertPoint:point toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point toView:view];
    point = [self convertPoint:point toView:from];
    point = [to convertPoint:point fromWindow:from];
    point = [view convertPoint:point fromView:from];
    point = [view convertPoint:point fromView:to];
    return point;
}

- (CGPoint)mar_convertPoint:(CGPoint)point fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point fromWindow:nil];
        } else {
            return [self convertPoint:point fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point fromView:view];
    point = [from convertPoint:point fromView:view];
    point = [to convertPoint:point fromWindow:from];
    point = [self convertPoint:point fromView:to];
    return point;
}

- (CGRect)mar_convertRect:(CGRect)rect toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect toWindow:nil];
        } else {
            return [self convertRect:rect toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if (!from || !to) return [self convertRect:rect toView:view];
    if (from == to) return [self convertRect:rect toView:view];
    rect = [self convertRect:rect toView:from];
    rect = [to convertRect:rect fromWindow:from];
    rect = [view convertRect:rect fromView:to];
    return rect;
}

- (CGRect)mar_convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect fromWindow:nil];
        } else {
            return [self convertRect:rect fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertRect:rect fromView:view];
    rect = [from convertRect:rect fromView:view];
    rect = [to convertRect:rect fromWindow:from];
    rect = [self convertRect:rect fromView:to];
    return rect;
}

- (CGFloat)mar_left {
    return self.frame.origin.x;
}

- (void)setMar_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)mar_top {
    return self.frame.origin.y;
}

- (void)setMar_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)mar_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setMar_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)mar_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setMar_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)mar_width {
    return self.frame.size.width;
}

- (void)setMar_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)mar_height {
    return self.frame.size.height;
}

- (void)setMar_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)mar_centerX {
    return self.center.x;
}

- (void)setMar_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)mar_centerY {
    return self.center.y;
}

- (void)setMar_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)mar_origin {
    return self.frame.origin;
}

- (void)setMar_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)mar_size {
    return self.frame.size;
}

- (void)setMar_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end

@implementation UIView (MAREX_Animation)

- (void)mar_shakeView
{
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    shake.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f)]];
    shake.autoreverses = YES;
    shake.repeatCount = 2.0f;
    shake.duration = 0.07f;
    
    [self.layer addAnimation:shake forKey:@"shake"];
}

- (void)mar_pulseViewWithDuration:(CGFloat)duration
{
    [UIView animateWithDuration:duration / 6 animations:^{
        [self setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:duration / 6 animations:^{
                [self setTransform:CGAffineTransformMakeScale(0.96, 0.96)];
            } completion:^(BOOL finished) {
                if (finished) {
                    [UIView animateWithDuration:duration / 6 animations:^{
                        [self setTransform:CGAffineTransformMakeScale(1.03, 1.03)];
                    } completion:^(BOOL finished) {
                        if (finished) {
                            [UIView animateWithDuration:duration / 6 animations:^{
                                [self setTransform:CGAffineTransformMakeScale(0.985, 0.985)];
                            } completion:^(BOOL finished) {
                                if (finished) {
                                    [UIView animateWithDuration:duration / 6 animations:^{
                                        [self setTransform:CGAffineTransformMakeScale(1.007, 1.007)];
                                    } completion:^(BOOL finished) {
                                        if (finished) {
                                            [UIView animateWithDuration:duration / 6 animations:^{
                                                [self setTransform:CGAffineTransformMakeScale(1, 1)];
                                            } completion:nil];
                                        }
                                    }];
                                }
                            }];
                        }
                    }];
                }
            }];
        }
    }];
}

- (void)mar_heartbeatViewWithDuration:(CGFloat)duration
{
    float maxSize = 1.4f, durationPerBeat = 0.5f;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(0.8, 0.8, 1);
    CATransform3D scale2 = CATransform3DMakeScale(maxSize, maxSize, 1);
    CATransform3D scale3 = CATransform3DMakeScale(maxSize - 0.3f, maxSize - 0.3f, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:[NSValue valueWithCATransform3D:scale1], [NSValue valueWithCATransform3D:scale2], [NSValue valueWithCATransform3D:scale3], [NSValue valueWithCATransform3D:scale4], nil];
    
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.05], [NSNumber numberWithFloat:0.2], [NSNumber numberWithFloat:0.6], [NSNumber numberWithFloat:1.0], nil];
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.duration = durationPerBeat;
    animation.repeatCount = duration / durationPerBeat;
    
    [self.layer addAnimation:animation forKey:@"heartbeat"];
}

- (void)mar_applyMotionEffects
{
    UIInterpolatingMotionEffect *horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalEffect.minimumRelativeValue = @(-10.0f);
    horizontalEffect.maximumRelativeValue = @(10.0f);
    UIInterpolatingMotionEffect *verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalEffect.minimumRelativeValue = @(-10.0f);
    verticalEffect.maximumRelativeValue = @(10.0f);
    UIMotionEffectGroup *motionEffectGroup = [[UIMotionEffectGroup alloc] init];
    motionEffectGroup.motionEffects = @[horizontalEffect, verticalEffect];
    
    [self addMotionEffect:motionEffectGroup];
}

- (void)mar_applyMotionEffectsWithOffset:(CGSize)offset
{
    UIInterpolatingMotionEffect *horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalEffect.minimumRelativeValue = @(offset.width);;
    horizontalEffect.maximumRelativeValue = @(-offset.width);;
    UIInterpolatingMotionEffect *verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalEffect.minimumRelativeValue = @(offset.height);
    verticalEffect.maximumRelativeValue = @(-offset.height);
    UIMotionEffectGroup *motionEffectGroup = [[UIMotionEffectGroup alloc] init];
    motionEffectGroup.motionEffects = @[horizontalEffect, verticalEffect];
    
    [self addMotionEffect:motionEffectGroup];
}

- (void)mar_flipWithDuration:(NSTimeInterval)duration direction:(MARUIViewAnimationFlipDirection)direction
{
    NSString *subtype = nil;
    
    switch (direction) {
        case MARUIViewAnimationFlipDirectionFromTop:
            subtype = @"fromTop";
            break;
        case MARUIViewAnimationFlipDirectionFromLeft:
            subtype = @"fromLeft";
            break;
        case MARUIViewAnimationFlipDirectionFromBottom:
            subtype = @"fromBottom";
            break;
        case MARUIViewAnimationFlipDirectionFromRight:
        default:
            subtype = @"fromRight";
            break;
    }
    
    CATransition *transition = [CATransition animation];
    
    transition.startProgress = 0;
    transition.endProgress = 1.0;
    transition.type = @"flip";
    transition.subtype = subtype;
    transition.duration = duration;
    transition.repeatCount = 1;
    transition.autoreverses = 1;
    
    [self.layer addAnimation:transition forKey:@"flip"];
}

- (void)mar_translateAroundTheView:(UIView *)topView duration:(CGFloat)duration direction:(MARUIViewAnimationTranslationDirection)direction repeat:(BOOL)repeat startFromEdge:(BOOL)startFromEdge
{
    CGFloat startPosition = self.center.x, endPosition;
    switch (direction) {
        case MARUIViewAnimationTranslationDirectionFromLeftToRight: {
            startPosition = self.frame.size.width / 2;
            endPosition = -(self.frame.size.width / 2) + topView.frame.size.width;
            break;
        }
        case MARUIViewAnimationTranslationDirectionFromRightToLeft:
        default: {
            startPosition = -(self.frame.size.width / 2) + topView.frame.size.width;
            endPosition = self.frame.size.width / 2;
            break;
        }
    }
    
    if (startFromEdge) {
        [self setCenter:CGPointMake(startPosition, self.center.y)];
    }
    
    [UIView animateWithDuration:duration / 2 delay:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self setCenter:CGPointMake(endPosition, self.center.y)];
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:duration / 2 delay:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self setCenter:CGPointMake(startPosition, self.center.y)];
            } completion:^(BOOL finished) {
                if (finished) {
                    if (repeat) {
                        [self mar_translateAroundTheView:topView duration:duration direction:direction repeat:repeat startFromEdge:startFromEdge];
                    }
                }
            }];
        }
    }];
}

@end

@implementation UIView (MAREX_GestureBlock)

- (void)mar_whenTouches:(NSUInteger)numberOfTouches tapped:(NSUInteger)numberOfTaps handler:(void (^)(void))block
{
    if (!block) return;
    
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer mar_recognizerWithHandler:^(UIGestureRecognizer * _Nonnull sender, UIGestureRecognizerState state, CGPoint location) {
            block();
    }];
    
    gesture.numberOfTouchesRequired = numberOfTouches;
    gesture.numberOfTapsRequired = numberOfTaps;
    
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[UITapGestureRecognizer class]]) return;
        
        UITapGestureRecognizer *tap = obj;
        BOOL rightTouches = (tap.numberOfTouchesRequired == numberOfTouches);
        BOOL rightTaps = (tap.numberOfTapsRequired == numberOfTaps);
        if (rightTouches && rightTaps) {
            [gesture requireGestureRecognizerToFail:tap];
        }
    }];
    
    [self addGestureRecognizer:gesture];
}

- (void)mar_whenTapped:(void (^)(void))block
{
    [self mar_whenTouches:1 tapped:1 handler:block];
}

- (void)mar_whenDoubleTapped:(void (^)(void))block
{
    [self mar_whenTouches:1 tapped:2 handler:block];
}

@end
