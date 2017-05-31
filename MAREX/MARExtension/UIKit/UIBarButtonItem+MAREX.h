//
//  UIBarButtonItem+MAREX.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (MAREX)

/**
 The block that invoked when the item is selected. The objects captured by block
 will retained by the ButtonItem.
 
 @discussion This param is conflict with `target` and `action` property.
 Set this will set `target` and `action` property to some internal objects.
 */
@property (nullable, nonatomic, copy) void (^mar_actionBlock)(id);

@end


/**
 @see https://github.com/mikeMTOL/UIBarButtonItem-Badge
 */
@interface UIBarButtonItem (MAREX_Badge)

@property (strong, atomic, nullable) UILabel *mar_badge;

// Badge value to be display
@property (nonatomic) NSString *mar_badgeValue;
// Badge background color
@property (nonatomic) UIColor *mar_badgeBGColor;
// Badge text color
@property (nonatomic) UIColor *mar_badgeTextColor;
// Badge font
@property (nonatomic) UIFont *mar_badgeFont;
// Padding value for the badge
@property (nonatomic) CGFloat mar_badgePadding;
// Minimum size badge to small
@property (nonatomic) CGFloat mar_badgeMinSize;
// Values for offseting the badge over the BarButtonItem you picked
@property (nonatomic) CGFloat mar_badgeOriginX;
@property (nonatomic) CGFloat mar_badgeOriginY;
// In case of numbers, remove the badge when reaching zero
@property BOOL mar_shouldHideBadgeAtZero;
// Badge has a bounce animation when value changes
@property BOOL mar_shouldAnimateBadge;

@end

NS_ASSUME_NONNULL_END
