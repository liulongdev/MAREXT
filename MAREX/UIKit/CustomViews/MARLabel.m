//
//  MARLabel.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/22.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "MARLabel.h"

@interface MARLabel()

/**
 tmp edgeinsets
 */
@property (nonatomic, assign) UIEdgeInsets tmpEdgeInsets;

@end

@implementation MARLabel

@synthesize edgeInsets;

- (void)drawRect:(CGRect)rect

{
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
    
}


- (CGSize)intrinsicContentSize

{
    
    CGSize size = [super intrinsicContentSize];
    
    size.width += self.edgeInsets.left + self.edgeInsets.right;
    
    size.height += self.edgeInsets.top + self.edgeInsets.bottom;
    
    return size;
    
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsetsV
{
    self.tmpEdgeInsets = edgeInsetsV;
    edgeInsets = edgeInsetsV;
    [self setNeedsDisplay];
}

@end
