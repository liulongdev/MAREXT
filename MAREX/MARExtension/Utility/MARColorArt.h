//
//  MARColorArt.h
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2018/3/29.
//  Copyright © 2018年 MAR. All rights reserved.
//

// reference https://github.com/vinhnx/ColorArt

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MARColorArt : NSObject

@property(strong, nonatomic, readonly) UIColor *backgroundColor;
@property(strong, nonatomic, readonly) UIColor *primaryColor;
@property(strong, nonatomic, readonly) UIColor *secondaryColor;
@property(strong, nonatomic, readonly) UIColor *detailColor;
@property(nonatomic, readonly) NSInteger randomColorThreshold; // Default to 2

- (id)initWithImage:(UIImage*)image;
- (id)initWithImage:(UIImage*)image threshold:(NSInteger)threshold;

+ (void)processImage:(UIImage *)image
        scaledToSize:(CGSize)scaleSize
           threshold:(NSInteger)threshold
          onComplete:(void (^)(MARColorArt *colorArt))completeBlock;

@end
