//
//  UIBarButtonItem+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "UIBarButtonItem+MAREX.h"
#import <objc/runtime.h>
#import "NSObject+MAREX.h"

static const char mar_barBtn_block_key;

@interface _MARUIBarButtonItemBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;
- (void)invoke:(id)sender;

@end

@implementation _MARUIBarButtonItemBlockTarget

- (id)initWithBlock:(void (^)(id sender))block{
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)invoke:(id)sender {
    if (self.block) self.block(sender);
}

@end


@implementation UIBarButtonItem (MAREX)

- (void)setMar_actionBlock:(void (^)(id sender))block {
    _MARUIBarButtonItemBlockTarget *target = [[_MARUIBarButtonItemBlockTarget alloc] initWithBlock:block];
    objc_setAssociatedObject(self, &mar_barBtn_block_key, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setTarget:target];
    [self setAction:@selector(invoke:)];
}

- (void (^)(id)) mar_actionBlock {
    _MARUIBarButtonItemBlockTarget *target = objc_getAssociatedObject(self, &mar_barBtn_block_key);
    return target.block;
}


@end

@implementation UIBarButtonItem (MAREX_Badge)

@dynamic mar_badgeValue, mar_badgeBGColor, mar_badgeTextColor, mar_badgeFont;
@dynamic mar_badgePadding, mar_badgeMinSize, mar_badgeOriginX, mar_badgeOriginY;
@dynamic mar_shouldHideBadgeAtZero, mar_shouldAnimateBadge;

- (void)mar_badgeInit
{
    UIView *superview = nil;
    CGFloat defaultOriginX = 0;
    if (self.customView) {
        superview = self.customView;
        defaultOriginX = superview.frame.size.width - self.mar_badge.frame.size.width/2;
        // Avoids badge to be clipped when animating its scale
        superview.clipsToBounds = NO;
    } else if ([self respondsToSelector:@selector(view)] && [(id)self view]) {
        superview = [(id)self view];
        defaultOriginX = superview.frame.size.width - self.mar_badge.frame.size.width;
    }
    [superview addSubview:self.mar_badge];
    
    // Default design initialization
    self.mar_badgeBGColor   = [UIColor redColor];
    self.mar_badgeTextColor = [UIColor whiteColor];
    self.mar_badgeFont      = [UIFont systemFontOfSize:12.0];
    self.mar_badgePadding   = 6;
    self.mar_badgeMinSize   = 8;
    self.mar_badgeOriginX   = defaultOriginX;
    self.mar_badgeOriginY   = -4;
    self.mar_shouldHideBadgeAtZero = YES;
    self.mar_shouldAnimateBadge = YES;
}

#pragma mark - Utility methods

// Handle badge display when its properties have been changed (color, font, ...)
- (void)mar_refreshBadge
{
    // Change new attributes
    self.mar_badge.textColor        = self.mar_badgeTextColor;
    self.mar_badge.backgroundColor  = self.mar_badgeBGColor;
    self.mar_badge.font             = self.mar_badgeFont;
    
    if (!self.mar_badgeValue || [self.mar_badgeValue isEqualToString:@""] || ([self.mar_badgeValue isEqualToString:@"0"] && self.mar_shouldHideBadgeAtZero)) {
        self.mar_badge.hidden = YES;
    } else {
        self.mar_badge.hidden = NO;
        [self mar_updateBadgeValueAnimated:YES];
    }
    
}

- (CGSize)mar_badgeExpectedSize
{
    // When the value changes the badge could need to get bigger
    // Calculate expected size to fit new value
    // Use an intermediate label to get expected size thanks to sizeToFit
    // We don't call sizeToFit on the true label to avoid bad display
    UILabel *frameLabel = [self mar_duplicateLabel:self.mar_badge];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}

- (void)mar_updateBadgeFrame
{
    
    CGSize expectedLabelSize = [self mar_badgeExpectedSize];
    
    // Make sure that for small value, the badge will be big enough
    CGFloat minHeight = expectedLabelSize.height;
    
    // Using a const we make sure the badge respect the minimum size
    minHeight = (minHeight < self.mar_badgeMinSize) ? self.mar_badgeMinSize : expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    CGFloat padding = self.mar_badgePadding;
    
    // Using const we make sure the badge doesn't get too smal
    minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width;
    self.mar_badge.layer.masksToBounds = YES;
    self.mar_badge.frame = CGRectMake(self.mar_badgeOriginX, self.mar_badgeOriginY, minWidth + padding, minHeight + padding);
    self.mar_badge.layer.cornerRadius = (minHeight + padding) / 2;
}

// Handle the badge changing value
- (void)mar_updateBadgeValueAnimated:(BOOL)animated
{
    // Bounce animation on badge if value changed and if animation authorized
    if (animated && self.mar_shouldAnimateBadge && ![self.mar_badge.text isEqualToString:self.mar_badgeValue]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.mar_badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    
    // Set the new value
    self.mar_badge.text = self.mar_badgeValue;
    
    // Animate the size modification if needed
    if (animated && self.mar_shouldAnimateBadge) {
        [UIView animateWithDuration:0.2 animations:^{
            [self mar_updateBadgeFrame];
        }];
    } else {
        [self mar_updateBadgeFrame];
    }
}

- (UILabel *)mar_duplicateLabel:(UILabel *)labelToCopy
{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    
    return duplicateLabel;
}

- (void)mar_removeBadge
{
    // Animate badge removal
    [UIView animateWithDuration:0.2 animations:^{
        self.mar_badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.mar_badge removeFromSuperview];
        self.mar_badge = nil;
    }];
}

#pragma mark - getters/setters
-(UILabel*)mar_badge {
    UILabel* lbl = objc_getAssociatedObject(self, @selector(mar_badgeValue));
    if(lbl==nil) {
        lbl = [[UILabel alloc] initWithFrame:CGRectMake(self.mar_badgeOriginX, self.mar_badgeOriginY, 20, 20)];
        [self setMar_badge:lbl];
        [self mar_badgeInit];
        [self.customView addSubview:lbl];
        lbl.textAlignment = NSTextAlignmentCenter;
    }
    return lbl;
}
-(void)setMar_badge:(UILabel *)badgeLabel
{
    [self mar_setAssociateValue:badgeLabel withKey:@selector(mar_badgeValue)];
}

// Badge value to be display
-(NSString *)mar_badgeValue {
    return objc_getAssociatedObject(self, @selector(mar_badgeValue));
}
-(void)setMar_badgeValue:(NSString *)badgeValue
{
    [self mar_setAssociateValue:badgeValue withKey:@selector(mar_badgeValue)];
    
    // When changing the badge value check if we need to remove the badge
    [self mar_updateBadgeValueAnimated:YES];
    [self mar_refreshBadge];
}

// Badge background color
-(UIColor *)mar_badgeBGColor {
    return objc_getAssociatedObject(self, @selector(mar_badgeValue));
}
-(void)setMar_badgeBGColor:(UIColor *)badgeBGColor
{
    [self mar_setAssociateValue:badgeBGColor withKey:@selector(mar_badgeValue)];
    if (self.mar_badge) {
        [self mar_refreshBadge];
    }
}

// Badge text color
-(UIColor *)mar_badgeTextColor {
    return objc_getAssociatedObject(self, @selector(mar_badgeTextColor));
}
-(void)setMar_badgeTextColor:(UIColor *)badgeTextColor
{
    [self mar_setAssociateValue:badgeTextColor withKey:@selector(mar_badgeTextColor)];
    if (self.mar_badge) {
        [self mar_refreshBadge];
    }
}

// Badge font
-(UIFont *)mar_badgeFont {
    return objc_getAssociatedObject(self, @selector(mar_badgeFont));
}
-(void)setMar_badgeFont:(UIFont *)badgeFont
{
    [self mar_setAssociateValue:badgeFont withKey:@selector(mar_badgeFont)];
    if (self.mar_badge) {
        [self mar_refreshBadge];
    }
}

// Padding value for the badge
-(CGFloat)mar_badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, @selector(mar_badgePadding));
    return number.floatValue;
}
-(void)setMar_badgePadding:(CGFloat)badgePadding
{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    [self mar_setAssociateValue:number withKey:@selector(mar_badgePadding)];
    if (self.mar_badge) {
        [self mar_updateBadgeFrame];
    }
}

// Minimum size badge to small
-(CGFloat)mar_badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, @selector(mar_badgeMinSize));
    return number.floatValue;
}
-(void) setmar_badgeMinSize:(CGFloat)badgeMinSize
{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    [self mar_setAssociateValue:number withKey:@selector(mar_badgeMinSize)];
    if (self.mar_badge) {
        [self mar_updateBadgeFrame];
    }
}

// Values for offseting the badge over the BarButtonItem you picked
-(CGFloat)mar_badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, @selector(mar_badgeOriginX));
    return number.floatValue;
}
-(void)setMar_badgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    [self mar_setAssociateValue:number withKey:@selector(mar_badgeOriginX)];
    if (self.mar_badge) {
        [self mar_updateBadgeFrame];
    }
}

-(CGFloat)mar_badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, @selector(mar_badgeOriginY));
    return number.floatValue;
}
-(void) setmar_badgeOriginY:(CGFloat)badgeOriginY
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    [self mar_setAssociateValue:number withKey:@selector(mar_badgeOriginY)];
    if (self.mar_badge) {
        [self mar_updateBadgeFrame];
    }
}

// In case of numbers, remove the badge when reaching zero
-(BOOL)mar_shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, @selector(mar_shouldHideBadgeAtZero));
    return number.boolValue;
}
- (void)setMar_shouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero
{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    [self mar_setAssociateValue:number withKey:@selector(mar_shouldHideBadgeAtZero)];
    if(self.mar_badge) {
        [self mar_refreshBadge];
    }
}

// Badge has a bounce animation when value changes
-(BOOL)mar_shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, @selector(mar_shouldAnimateBadge));
    return number.boolValue;
}
- (void)setMar_shouldAnimateBadge:(BOOL)shouldAnimateBadge
{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    [self mar_setAssociateValue:number withKey:@selector(mar_shouldAnimateBadge)];
    if(self.mar_badge) {
        [self mar_refreshBadge];
    }
}

@end
