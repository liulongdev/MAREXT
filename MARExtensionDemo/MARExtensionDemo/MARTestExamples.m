//
//  MARTestExamples.m
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2017/5/20.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "MARTestExamples.h"
#import "MARCategory.h"
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

@end
