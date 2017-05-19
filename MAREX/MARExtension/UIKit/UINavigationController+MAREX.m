//
//  UINavigationController+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2017/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "UINavigationController+MAREX.h"

@implementation UINavigationController (MAREX)

#ifdef MARUINavigationOrientation
- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}
#endif

@end

#ifdef MARUINavigationBarCustomBackImage        // 自定义返回尖头图片
@interface UINavigationBar (MAREX_BACKIMG)

@end

@implementation UINavigationBar (MAREX_BACKIMG)

- (UIImage *)backIndicatorImage
{
    return [UIImage imageNamed:@"icon_navi_back"];
}

@end
#endif

#ifdef MARUINavigationNULLBackBarButtonItem     // 导航栏去掉“返回”等字样
@interface UINavigationItem (MAREX_BACKNULL)

@end

@implementation UINavigationItem (MAREX_BACKNULL)

- (UIBarButtonItem *)backBarButtonItem
{
    return [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

@end
#endif

@implementation UINavigationBar (MAREX_Translucent)

- (void)mar_setTransparent:(BOOL)transparent {
    [self mar_setTransparent:transparent translucent:YES];
}

- (void)mar_setTransparent:(BOOL)transparent translucent:(BOOL)translucent {
    if (transparent) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = [UIImage new];
        self.translucent = translucent;
    } else {
        [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = nil;
        self.translucent = translucent;
    }
}

@end
