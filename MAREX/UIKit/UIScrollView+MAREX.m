//
//  UIScrollView+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/16.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "UIScrollView+MAREX.h"

@implementation UIScrollView (MAREX)

- (void)mar_scrollToTop {
    [self mar_scrollToTopAnimated:YES];
}

- (void)mar_scrollToBottom {
    [self mar_scrollToBottomAnimated:YES];
}

- (void)mar_scrollToLeft {
    [self mar_scrollToLeftAnimated:YES];
}

- (void)mar_scrollToRight {
    [self mar_scrollToRightAnimated:YES];
}

- (void)mar_scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)mar_scrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)mar_scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)mar_scrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}

@end
