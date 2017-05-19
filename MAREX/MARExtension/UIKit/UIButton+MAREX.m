//
//  UIButton+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "UIButton+MAREX.h"
#import <objc/runtime.h>
#import "NSObject+MAREX.h"

static const char kAllButtonTargetsKey;

@interface _MARUIButtonTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;

- (void)invoke:(id)sender;

@end

@implementation _MARUIButtonTarget

- (id)initWithBlock:(void (^)(id sender))block{
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)invoke:(id)sender {
    if (_block) _block(sender);
}

@end

static char * mar_button_sounddic_key;

@implementation UIButton (MAREX)

- (void)mar_addActionBlock:(void (^)(id))block forState:(UIControlEvents)event
{
    if (!block) return;
    _MARUIButtonTarget *target = [[_MARUIButtonTarget alloc] initWithBlock:block];
    [self addTarget:target action:@selector(invoke:) forControlEvents:event];
    NSMutableArray *targets = [self _mar_allButtonTargets];
    [targets addObject:target];
}

- (void)mar_removeAllActionBlocks
{
    NSMutableArray *targets = [self _mar_allButtonTargets];
    [targets enumerateObjectsUsingBlock:^(id  _Nonnull target, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeTarget:target action:@selector(invoke:) forControlEvents:UIControlEventAllEvents];
    }];
    [targets removeAllObjects];
}

- (NSMutableArray *)_mar_allButtonTargets
{
    NSMutableArray *targets = objc_getAssociatedObject(self, &kAllButtonTargetsKey);
    if (!targets) {
        targets = [NSMutableArray arrayWithCapacity:7];
        objc_setAssociatedObject(self, &kAllButtonTargetsKey, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

- (void)mar_setSoundID:(MARAudioID)audioID forState:(UIControlEvents)event
{
    NSMutableDictionary *soundDic = [self mar_soundDic];
    NSString *key = [NSString stringWithFormat:@"%ld", (long)event];
    MARSystemSound *sound = [soundDic objectForKey:key];
    if (sound) {
        [self removeTarget:sound action:@selector(play) forControlEvents:event];
        [soundDic removeAllObjects];
    }
    sound = [MARSystemSound new];
    sound.audioID = audioID;
    [soundDic setObject:sound forKey:key];
    [self addTarget:sound action:@selector(play) forControlEvents:event];
}

- (void)mar_setLocalSoundURL:(NSURL *)soundURL forState:(UIControlEvents)event
{
    NSMutableDictionary *soundDic = [self mar_soundDic];
    NSString *key = [NSString stringWithFormat:@"%ld", (long)event];
    MARSystemSound *sound = [soundDic objectForKey:key];
    if (sound) {
        [self removeTarget:sound action:@selector(play) forControlEvents:event];
        [soundDic removeAllObjects];
    }
    sound = [MARSystemSound new];
    sound.soundURL = soundURL;
    [soundDic setObject:sound forKey:key];
    [self addTarget:sound action:@selector(play) forControlEvents:event];
}

- (NSMutableDictionary *)mar_soundDic
{
    NSMutableDictionary *soundDic = [self mar_getAssociatedValueForKey:mar_button_sounddic_key];
    if (!soundDic) {
        soundDic = [NSMutableDictionary dictionaryWithCapacity:7];
        [self mar_setAssociateValue:soundDic withKey:mar_button_sounddic_key];
    }
    return soundDic;
}

@end
