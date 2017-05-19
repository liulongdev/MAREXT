//
//  UITextField+MAREX.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/16.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (MAREX)

/**
 Set all text selected.
 */
- (void)mar_selectAllText;

/**
 Set text in range selected.
 
 @param range  The range of selected text in a document.
 */
- (void)mar_setSelectedRange:(NSRange)range;

@end
