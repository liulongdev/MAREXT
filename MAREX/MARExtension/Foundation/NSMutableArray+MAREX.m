//
//  NSMutableArray+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/18.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "NSMutableArray+MAREX.h"

@implementation NSMutableArray (MAREX)

- (void)mar_shuffle
{
    @synchronized (self) {
        for (uint32_t i = (uint32_t)[self count] - 1; i > 0; i--) {
            [self exchangeObjectAtIndex:arc4random_uniform(i + 1)
                      withObjectAtIndex:i];
        }
    }
}

+ (NSMutableArray * _Nonnull)mar_sortArrayByKey:(NSString * _Nonnull)key array:(NSMutableArray * _Nonnull)array ascending:(BOOL)ascending {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [tempArray removeAllObjects];
    [tempArray addObjectsFromArray:array];
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
    NSArray *sortedArray = [tempArray sortedArrayUsingDescriptors:@[descriptor]];
    
    [tempArray removeAllObjects];
    tempArray = (NSMutableArray *)sortedArray;
    
    [array removeAllObjects];
    [array addObjectsFromArray:tempArray];
    
    return array;
}

@end
