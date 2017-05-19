//
//  NSMutableArray+MAREX.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/18.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (MAREX)

/**
 Shuffles the elements of this array in-place using the Fisher-Yates algorithm
 
 */
- (void)mar_shuffle;

/**
 *  Sort an array by a given key with option for ascending or descending
 *
 *  @param key       The key to order the array
 *  @param array     The array to be ordered
 *  @param ascending A BOOL to choose if ascending or descending
 *
 *  @return Returns the given array ordered by the given key ascending or descending
 */
+ (NSMutableArray * _Nonnull)mar_sortArrayByKey:(NSString * _Nonnull)key
                                      array:(NSMutableArray * _Nonnull)array
                                  ascending:(BOOL)ascending;

@end
