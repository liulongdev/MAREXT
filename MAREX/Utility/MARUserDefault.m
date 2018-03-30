//
//  MARUserDefault.m
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2017/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "MARUserDefault.h"

@implementation MARUserDefault

#pragma mark set&get
+ (void)setObject:(id)obj key:(NSString*)keyWord{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [user setObject:data forKey:keyWord];
    [user synchronize];
}

+ (id)getObjectBy:(NSString*)keyWord{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    id obj = [user objectForKey:keyWord];
    if (obj && [obj isKindOfClass:[NSData class]]) {
        id file = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
        return file;
    }
    return nil;
}

+ (void)setModel:(id)mod key:(NSString*)keyWord{
    [self setObject:mod key:keyWord];
}

+ (id)getModelBy:(NSString*)keyWord{
    return [self getObjectBy:keyWord];
}

+ (void)setString:(NSString*)str key:(NSString*)keyWord{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    [user setObject:str forKey:keyWord];
    [user synchronize];
}

+ (NSString* )getStringBy:(NSString*)keyWord{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    id obj = [user objectForKey:keyWord];
    return obj;
    
}

+ (void)setNumber:(NSNumber*)num key:(NSString*)keyWord{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    [user setObject:num forKey:keyWord];
    [user synchronize];
}

+ (NSNumber* )getNumberBy:(NSString*)keyWord{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    id obj = [user objectForKey:keyWord];
    if (obj && [obj isKindOfClass:[NSNumber class]]) {
        return obj;
    }
    return nil;
}

+ (void)setDict:(NSDictionary*)dict key:(NSString*)keyWord{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    [user setObject:dict forKey:keyWord];
    [user synchronize];
}

+ (NSDictionary* )getDictBy:(NSString*)keyWord{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    id obj = [user objectForKey:keyWord];
    if (obj && [obj isKindOfClass:[NSData class]]) {
        NSDictionary* dict = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
        return dict;
    }
    return nil;
}

+ (void)setBool:(BOOL)value key:(NSString*)keyWord{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    [user setBool:value forKey:keyWord];
    [user synchronize];
}

+ (BOOL)getBoolBy:(NSString*)keyWord{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    return [user boolForKey:keyWord];
}

+ (void)setDouble:(double)value key:(NSString*)keyWord{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    [user setDouble:value forKey:keyWord];
    [user synchronize];
}

+ (double)getDoubleBy:(NSString*)keyWord{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    return [user doubleForKey:keyWord];
}


@end
