//
//  NSArray+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/18.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "NSArray+MAREX.h"
#import "NSData+MAREX.h"
#import "NSMutableArray+MAREX.h"

@implementation NSArray (MAREX)

- (id)firstObject {
    if ([self count] == 0) {
        return nil;
    }
    
    return [self objectAtIndex:0];
}


- (id)mar_randomObject {
    if ([self count] == 0) {
        return nil;
    }
    
    return [self objectAtIndex:arc4random_uniform((uint32_t)[self count])];
}

- (NSArray *)mar_shuffledArray {
    NSMutableArray *array = [self mutableCopy];
    [array mar_shuffle];
    return array;
}

- (NSArray *)mar_reverseArray
{
//    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:[self count]];
//    NSEnumerator *enumerator = [self reverseObjectEnumerator];
//    for (id element in enumerator) [arrayTemp addObject:element];
//    return arrayTemp;
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    return [enumerator allObjects];
}

- (NSMutableArray *)mar_deepMutableCopy {
    return (__bridge_transfer NSMutableArray *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (__bridge CFArrayRef)self, kCFPropertyListMutableContainers);
}


- (NSString *)mar_md5String {
    return [[self p_mar_prehashData] mar_md5String];
}


- (NSString *)mar_sha1String {
    return [[self p_mar_prehashData] mar_sha1String];
}

- (NSData *)p_mar_prehashData
{
    return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:0 error:nil];
}

@end
