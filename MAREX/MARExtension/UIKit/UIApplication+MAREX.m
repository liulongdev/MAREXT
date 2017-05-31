//
//  UIApplication+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/27.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "UIApplication+MAREX.h"
#import "NSFileManager+MAREX.h"

@implementation UIApplication (MAREX)

+ (NSInteger)mar_applicationByteSize
{
    NSInteger documentSize = [NSFileManager mar_contentsByteSizeWithDirectoryPath:[NSFileManager mar_documentsDirectoryPath]];
    NSInteger librarySize = [NSFileManager mar_contentsByteSizeWithDirectoryPath:[NSFileManager mar_libraryDirectoryPath]];
    NSInteger cacheSize = [NSFileManager mar_contentsByteSizeWithDirectoryPath:[NSFileManager mar_cacheDirectoryPath]];
    return documentSize + librarySize + cacheSize;
}

+ (NSString *)mar_applicationSizeString
{
    NSString *sizeString = [NSByteCountFormatter stringFromByteCount:[self.class mar_applicationByteSize] countStyle:NSByteCountFormatterCountStyleFile];
    return sizeString;
}

@end
