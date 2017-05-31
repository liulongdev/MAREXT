//
//  MARTestExamples.m
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2017/5/20.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "MARTestExamples.h"
#import "MARCategory.h"
#import "MARClassInfo.h"
@implementation MARTestExamples

- (void)testSoundIDS
{
    NSInteger soundIds[] = {MARAudioIDNewMail,  // New Mail
        MARAudioIDMailSent,                     // Mail Sent
        MARAudioIDVoiceMail,                    // Voice Mail
        MARAudioIDRecivedMessage,               // Recived Message
        MARAudioIDSentMessage,                  // Sent Message
        MARAudioIDAlarm,                        // Alerm
        MARAudioIDLowPower,                     // Low pPower
        MARAudioIDSMSReceived1,                 // SMS Received 1
        MARAudioIDSMSReceived2 ,                // SMS Received 2
        MARAudioIDSMSReceived3 ,                // SMS Received 3
        MARAudioIDSMSReceived4,                 // SMS Received 4
        MARAudioIDSMSReceived5 ,                // SMS Received 5
        MARAudioIDSMSReceived6,                 // SMS Received 6
        MARAudioIDTweetSent,                    // Tweet Sent
        MARAudioIDAnticipate,                   // Anticipate
        MARAudioIDBloom,                        // Bloom
        MARAudioIDCalypso,                      // Calypso
        MARAudioIDChooChoo,                     // Choo Choo
        MARAudioIDDescent,                      // Descent
        MARAudioIDFanfare,                      // Fanfare
        MARAudioIDLadder,                       // Ladder
        MARAudioIDMinuet,                       // Minuet
        MARAudioIDNewsFlash,                    // News Flash
        MARAudioIDNoir,                         // Noir
        MARAudioIDSherwoodForest,               // Sherwood Forest
        MARAudioIDSpell,                        // Speel
        MARAudioIDSuspence,                     // Suspance
        MARAudioIDTelegraph,                    // Telegraph
        MARAudioIDTiptoes,                      // Tiptoes
        MARAudioIDTypewriters,                  // Typewriters
        MARAudioIDUpdate,                       // Update
        MARAudioIDUSSDAlert,                    // USSD Alert
        MARAudioIDSIMToolkitCallDropped,        // SIM Toolkit Call Dropped
        MARAudioIDSIMToolkitGeneralBeep,        // SIM Toolkit General Beep
        MARAudioIDSIMToolkitNegativeACK,        // SIM Toolkit Negative ACK
        MARAudioIDSIMToolkitPositiveACK,        // SIM Toolkit Positive ACK
        MARAudioIDSIMToolkitSMS ,               // SIM Toolkit SMS
        MARAudioIDTink ,                        // Tink
        MARAudioIDCTBusy,                       // CT Busy
        MARAudioIDCTCongestion,                 // CT Congestion
        MARAudioIDCTPathACK,                    // CT Pack ACK
        MARAudioIDCTError,                      // CT Error
        MARAudioIDCTCallWaiting,                // CT Call Waiting
        MARAudioIDCTKeytone,                    // CT Keytone
        MARAudioIDLock,                         // Lock
        MARAudioIDUnlock,                       // Unlock
        MARAudioIDFailedUnlock,                 // Failed Unlock
        MARAudioIDKeypressedTink,               // Keypressed Tink
        MARAudioIDKeypressedTock,               // Keypressed Tock
        MARAudioIDTock,                         // Tock
        MARAudioIDBeepBeep,                     // Beep Beep
        MARAudioIDRingerCharged,                // Ringer Charged
        MARAudioIDPhotoShutter,                 // Photo Shutter
        MARAudioIDShake,                        // Shake
        MARAudioIDJBLBegin,                     // JBL Begin
        MARAudioIDJBLConfirm,                   // JBL Confirm
        MARAudioIDJBLCancel,                    // JBL Cancel
        MARAudioIDBeginRecording,               // Begin Recording
        MARAudioIDEndRecording,                 // End Recording
        MARAudioIDJBLAmbiguous,                 // JBL Ambiguous
        MARAudioIDJBLNoMatch,                   // JBL No Match
        MARAudioIDBeginVideoRecord,             // Begin Video Record
        MARAudioIDEndVideoRecord,               // End Video Record
        MARAudioIDVCInvitationAccepted,         // VC Invitation Accepted
        MARAudioIDVCRinging,                    // VC Ringing
        MARAudioIDVCEnded,                      // VC Ended
        MARAudioIDVCCallWaiting,                // VC Call Waiting
        MARAudioIDVCCallUpgrade,                // VC Call Upgrade
        MARAudioIDTouchTone1,                   // Touch Tone 1
        MARAudioIDTouchTone2,                   // Touch Tone 2
        MARAudioIDTouchTone3,                   // Touch Tone 3
        MARAudioIDTouchTone4,                   // Touch Tone 4
        MARAudioIDTouchTone5,                   // Touch Tone 5
        MARAudioIDTouchTone6,                   // Touch Tone 6
        MARAudioIDTouchTone7,                   // Touch Tone 7
        MARAudioIDTouchTone8,                   // Touch Tone 8
        MARAudioIDTouchTone9,                   // Touch Tone 9
        MARAudioIDTouchTone10,                  // Touch Tone 10
        MARAudioIDTouchToneStar,                // Tone Star
        MARAudioIDTouchTonePound,               // Tone Pound
        MARAudioIDHeadsetStartCall,             // Headset Start Call
        MARAudioIDHeadsetRedial,                // Headset Redial
        MARAudioIDHeadsetAnswerCall,            // Headset Answer Call
        MARAudioIDHeadsetEndCall,               // Headset End Call
        MARAudioIDHeadsetCallWaitingActions,    // Headset Call Waiting
        MARAudioIDHeadsetTransitionEnd,         // Headset Transition End
        MARAudioIDVoicemail,                    // Voicemail
        MARAudioIDReceivedMessage,              // Received Message
        MARAudioIDNewMail2,                     // New Mail 2
        MARAudioIDMailSent2,                    // Email Sent 2
        MARAudioIDAlarm2,                       // Alarm 2
        MARAudioIDLock2,                        // Lock 2
        MARAudioIDTock2,                        // Tock 2
        MARAudioIDSMSReceived1_2,               // SMS Received 7
        MARAudioIDSMSReceived2_2,               // SMS Received 8
        MARAudioIDSMSReceived3_2,               // SMS Received 9
        MARAudioIDSMSReceived4_2,               // SMS Received 10
        MARAudioIDSMSReceivedVibrate,           // SMS Received Vibrate
        MARAudioIDSMSReceived1_3,               // SMS Received 11
        MARAudioIDSMSReceived5_3,               // SMS Received 12
        MARAudioIDSMSReceived6_3,               // SMS Received 13
        MARAudioIDVoicemail2,                   // Voicemail 2
        MARAudioIDAnticipate2,                  // Anticipate 2
        MARAudioIDBloom2,                       // Bloom 2
        MARAudioIDCalypso2,                     // Calypso 2
        MARAudioIDChooChoo2,                    // Choo Choo 2
        MARAudioIDDescent2,                     // Descent 2
        MARAudioIDFanfare2,                     // Fanfare 2
        MARAudioIDLadder2,                      // Ladder 2
        MARAudioIDMinuet2,                      // Minuet 2
        MARAudioIDNewsFlash2,                   // News Flash 2
        MARAudioIDNoir2,                        // Noir 2
        MARAudioIDSherwoodForest2,              // Sherwood Forest 2
        MARAudioIDSpell2,                       // Speel 2
        MARAudioIDSuspence2,                    // Suspence 2
        MARAudioIDTelegraph2,                   // Telegraph 2
        MARAudioIDTiptoes2,                     // Tiptoes 2
        MARAudioIDTypewriters2,                 // Typewriters 2
        MARAudioIDUpdate2,                      // Update 2
        MARAudioIDRingerVibeChanged,            // Ringer View Changed
        MARAudioIDSilentVibeChanged,            // Silent View Changed
        MARAudioIDVibrate                       // Vibrate
    };
    static int count = 0;
    NSInteger sumCount = sizeof(soundIds)/sizeof(soundIds[0]);
    if (count > sumCount) {
        count = 0;
        return;
    }
    [MARSystemSound playSystemSound:soundIds[count++ % (sumCount - 1)]];
    [self mar_gcdPerformAfterDelay:2 usingBlock:^(id  _Nonnull objSelf) {
        [objSelf testSoundIDS];
    }];
}

- (void)testRuntimeObj
{
    NSString *classStr = @"MARTestClass";
    Class class = NSClassFromString(classStr);
    if (!class) {
        class = objc_allocateClassPair([NSObject class], [classStr UTF8String], 0);
        [self addPropertyWithName:@"testProperty" clazz:class type:@encode(NSString *) typeStr:@"NSString"];
        objc_registerClassPair(class);
    }
    
    
    static int i = 0;
    if (class) {
        id instance  = [[class alloc] init];
        [instance setValue:[NSString stringWithFormat:@"nihao martin , %d", i++] forKey:@"testProperty"];
        NSLog(@"get value : %@", [instance valueForKey:@"testProperty"]);
    }
    
}

- (BOOL)addPropertyWithName:(NSString *)propertyName clazz:(Class)clazz type:(const char *)type typeStr:(NSString *)typeStr
{
    if (!propertyName || ![propertyName isKindOfClass:[NSString class]] || propertyName.length == 0 || !clazz) {
        return NO;
    }
    
    NSString *ivarName = [propertyName copy];
    if (![ivarName hasPrefix:@"_"]) {
        ivarName = [NSString stringWithFormat:@"_%@", ivarName];
    }
    NSUInteger size , alignment;
    NSGetSizeAndAlignment(type, &size, &alignment);
    BOOL addIvarRet = class_addIvar(clazz, [ivarName UTF8String], size, log2(alignment), type);
    if (!addIvarRet) {
        NSLog(@"add ivar '%@' failure", ivarName);
        return NO;
    }
    
    NSLog(@"add ivar '%@' sucess", ivarName);
    
    MAREncodingType encodeType = MAREncodingGetType(type);
    
    NSUInteger attrCount = 4;
    BOOL isRetain = NO;
    
    if ((encodeType & MAREncodingTypeObject) || (MAREncodingTypeObject & MAREncodingTypeBlock)) {
        isRetain = YES;
    }
    
    objc_property_attribute_t *cattrs = (objc_property_attribute_t*)calloc(attrCount + (isRetain ? 1 : 0), sizeof(objc_property_attribute_t));
    
    NSUInteger index = 0;
    
    cattrs[index].name = "T";
    if (isRetain) {
        NSString *encodeTypeAndName = [NSString stringWithFormat:@"%s%@", type, typeStr];
        type = [encodeTypeAndName UTF8String];
    }
    cattrs[index].value = type;
    index ++;
    
    
    if (isRetain) {
        cattrs[index].name = "&";
        cattrs[index].value= "";
        index ++;
    }
    
    cattrs[index].name = "N";
    cattrs[index].value= "";
    index ++;
    
    cattrs[index].name = "V";
    cattrs[index].value = [ivarName UTF8String];
    index ++;
    
    BOOL addPropertyRet = class_addProperty(clazz, [ivarName UTF8String], cattrs, (unsigned int )attrCount + (isRetain ? 1 : 0));
    if (!addPropertyRet) {
        MARInfoLog(@"add property '%@' failure", propertyName);
        return NO;
    }
    
    MARInfoLog(@"add property '%@' success", propertyName);
    
    
    // -------  add getter and setter --------
    SEL getFunSel = sel_registerName([ivarName UTF8String]);
    
    id getFunBlock = ^(__unsafe_unretained id objSelf) {
        Ivar ivar = class_getInstanceVariable([objSelf class], [ivarName UTF8String]);
        id testValue = object_getIvar(objSelf, ivar);
        MARInfoLog(@"getter function get value : %@", testValue);
        return testValue;
    };
    
    IMP getFunSelIMP = imp_implementationWithBlock(getFunBlock);
    
    BOOL addGetMethodRet = class_addMethod(clazz, getFunSel, getFunSelIMP, "@@:");
    if (!addGetMethodRet) {
        NSLog(@"add get method failuer");
        return NO;
    }
    NSLog(@"add get method succ");
    
    NSString *setFunStr = [NSString stringWithFormat:@"set%@%@:",[propertyName substringToIndex:1].uppercaseString, [propertyName substringFromIndex:1]];
    SEL setFunSel = sel_registerName([setFunStr UTF8String]);
    
    id setFunBlock = ^(__unsafe_unretained id objSelf, id value) {
        Ivar ivar = class_getInstanceVariable([objSelf class], [ivarName UTF8String]);
        object_setIvar(objSelf, ivar, value);
        MARInfoLog(@"setter function set value : %@", value);
    };
    
    IMP setFunSelIMP = imp_implementationWithBlock(setFunBlock);
    
    BOOL addSetMethodRet = class_addMethod(clazz, setFunSel, setFunSelIMP, "@@:@");
    if (!addSetMethodRet) {
        NSLog(@"add set method failuer");
        return NO;
    }
    NSLog(@"add set method succ");
    
    return YES;
    
}

@end
