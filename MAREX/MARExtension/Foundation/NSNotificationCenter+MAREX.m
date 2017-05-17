//
//  NSNotificationCenter+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "NSNotificationCenter+MAREX.h"

@implementation NSNotificationCenter (MAREX)

- (void)mar_postNotificationOnMainThread:(NSNotification *)notification {
    if ([NSThread isMainThread]) return [self postNotification:notification];
    [self mar_postNotificationOnMainThread:notification waitUntilDone:NO];
}

- (void)mar_postNotificationOnMainThread:(NSNotification *)notification waitUntilDone:(BOOL)wait {
    if ([NSThread isMainThread]) return [self postNotification:notification];
    [[self class] performSelectorOnMainThread:@selector(_mar_postNotification:) withObject:notification waitUntilDone:wait];
}

- (void)mar_postNotificationOnMainThreadWithName:(NSString *)name object:(id)object {
    if ([NSThread isMainThread]) return [self postNotificationName:name object:object userInfo:nil];
    [self mar_postNotificationOnMainThreadWithName:name object:object userInfo:nil waitUntilDone:NO];
}

- (void)mar_postNotificationOnMainThreadWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo {
    if ([NSThread isMainThread]) return [self postNotificationName:name object:object userInfo:userInfo];
    [self mar_postNotificationOnMainThreadWithName:name object:object userInfo:userInfo waitUntilDone:NO];
}

- (void)mar_postNotificationOnMainThreadWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo waitUntilDone:(BOOL)wait {
    if ([NSThread isMainThread]) return [self postNotificationName:name object:object userInfo:userInfo];
    NSMutableDictionary *info = [[NSMutableDictionary allocWithZone:nil] initWithCapacity:3];
    if (name) [info setObject:name forKey:@"name"];
    if (object) [info setObject:object forKey:@"object"];
    if (userInfo) [info setObject:userInfo forKey:@"userInfo"];
    [[self class] performSelectorOnMainThread:@selector(_mar_postNotificationName:) withObject:info waitUntilDone:wait];
}

+ (void)_mar_postNotification:(NSNotification *)notification {
    [[self defaultCenter] postNotification:notification];
}

+ (void)_mar_postNotificationName:(NSDictionary *)info {
    NSString *name = [info objectForKey:@"name"];
    id object = [info objectForKey:@"object"];
    NSDictionary *userInfo = [info objectForKey:@"userInfo"];
    
    [[self defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}


@end
