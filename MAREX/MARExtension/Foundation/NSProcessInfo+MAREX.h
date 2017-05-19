//
//  NSProcessInfo+MAREX.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/18.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSProcessInfo (MAREX)

/**
 *  Returns the CPU usage
 *
 *  @return Returns the CPU usage
 */
+ (float)mar_cpuUsage DEPRECATED_MSG_ATTRIBUTE("Use +currentAppCPUUsage");

/**
 *  Returns the CPU usage by the current App
 *
 *  @return Returns the CPU usage by the current App
 */
+ (float)mar_currentAppCPUUsage;

@end
