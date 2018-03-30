//
//  MARSystemSound.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/18.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "MARSystemSound.h"

@implementation MARSystemSound

+ (void)playSystemSound:(MARAudioID)audioID {
    AudioServicesPlaySystemSound(audioID);
}

+ (void)playSystemSoundVibrate {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

+ (SystemSoundID)playCustomSound:(NSURL * _Nonnull)soundURL {
    SystemSoundID soundID;
    
    OSStatus error = AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(soundURL), &soundID);
    if (error != kAudioServicesNoError) {
        NSLog(@"Could not load %@", soundURL);
    }
    return soundID;
}

+ (BOOL)disposeSound:(SystemSoundID)soundID {
    OSStatus error = AudioServicesDisposeSystemSoundID(soundID);
    if (error != kAudioServicesNoError) {
        NSLog(@"Error while disposing sound %i", (unsigned int)soundID);
        return NO;
    }
    return YES;
}

- (void)play
{
    if (self.audioID != 0) {
        [self.class playSystemSound:self.audioID];
    }
    else if (self.soundURL)
    {
        [self.class playCustomSound:self.soundURL];
    }
}

@end
