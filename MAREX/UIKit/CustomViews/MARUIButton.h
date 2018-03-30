//
//  MARUIButton.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/18.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MARUIButtonImagePosition) {
    MARUIButtonImagePositionLeft,
    MARUIButtonImagePositionRight
};

@interface MARUIButton : UIButton

@property (nonatomic, assign) MARUIButtonImagePosition imagePosition;

@end
