//
//  MARUIButton.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/18.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "MARUIButton.h"

@implementation MARUIButton

@synthesize imagePosition = _imagePosition;

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_imagePosition == MARUIButtonImagePositionLeft) {
        return;
    }
    
    CGRect imageFrame = self.imageView.frame;
    CGRect labelFrame = self.titleLabel.frame;
    
    labelFrame.origin.x = imageFrame.origin.x - self.imageEdgeInsets.left + self.imageEdgeInsets.right;
    imageFrame.origin.x += labelFrame.size.width;
    
    self.imageView.frame = imageFrame;
    self.titleLabel.frame = labelFrame;
}

@end
