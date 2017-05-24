//
//  MARSystemSound.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/18.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import <Foundation/Foundation.h>

/**
 *  Audio IDs enum - http://iphonedevwiki.net/index.php/AudioServices
 */
typedef NS_ENUM(NSInteger, MARAudioID) {
    /**
     *  New Mail
     */
    MARAudioIDNewMail = 1000,
    /**
     *  Mail Sent
     */
    MARAudioIDMailSent = 1001,
    /**
     *  Voice Mail
     */
    MARAudioIDVoiceMail = 1002,
    /**
     *  Recived Message
     */
    MARAudioIDRecivedMessage = 1003,
    /**
     *  Sent Message
     */
    MARAudioIDSentMessage = 1004,
    /**
     *  Alerm
     */
    MARAudioIDAlarm = 1005,
    /**
     *  Low pPower
     */
    MARAudioIDLowPower = 1006,
    /**
     *  SMS Received 1
     */
    MARAudioIDSMSReceived1 = 1007,
    /**
     *  SMS Received 2
     */
    MARAudioIDSMSReceived2 = 1008,
    /**
     *  SMS Received 3
     */
    MARAudioIDSMSReceived3 = 1009,
    /**
     *  SMS Received 4
     */
    MARAudioIDSMSReceived4 = 1010,
    /**
     *  SMS Received 5
     */
    MARAudioIDSMSReceived5 = 1013,
    /**
     *  SMS Received 6
     */
    MARAudioIDSMSReceived6 = 1014,
    /**
     *  Tweet Sent
     */
    MARAudioIDTweetSent = 1016,
    /**
     *  Anticipate
     */
    MARAudioIDAnticipate = 1020,
    /**
     *  Bloom
     */
    MARAudioIDBloom = 1021,
    /**
     *  Calypso
     */
    MARAudioIDCalypso = 1022,
    /**
     *  Choo Choo
     */
    MARAudioIDChooChoo = 1023,
    /**
     *  Descent
     */
    MARAudioIDDescent = 1024,
    /**
     *  Fanfare
     */
    MARAudioIDFanfare = 1025,
    /**
     *  Ladder
     */
    MARAudioIDLadder = 1026,
    /**
     *  Minuet
     */
    MARAudioIDMinuet = 1027,
    /**
     *  News Flash
     */
    MARAudioIDNewsFlash = 1028,
    /**
     *  Noir
     */
    MARAudioIDNoir = 1029,
    /**
     *  Sherwood Forest
     */
    MARAudioIDSherwoodForest = 1030,
    /**
     *  Speel
     */
    MARAudioIDSpell = 1031,
    /**
     *  Suspance
     */
    MARAudioIDSuspence = 1032,
    /**
     *  Telegraph
     */
    MARAudioIDTelegraph = 1033,
    /**
     *  Tiptoes
     */
    MARAudioIDTiptoes = 1034,
    /**
     *  Typewriters
     */
    MARAudioIDTypewriters = 1035,
    /**
     *  Update
     */
    MARAudioIDUpdate = 1036,
    /**
     *  USSD Alert
     */
    MARAudioIDUSSDAlert = 1050,
    /**
     *  SIM Toolkit Call Dropped
     */
    MARAudioIDSIMToolkitCallDropped = 1051,
    /**
     *  SIM Toolkit General Beep
     */
    MARAudioIDSIMToolkitGeneralBeep = 1052,
    /**
     *  SIM Toolkit Negative ACK
     */
    MARAudioIDSIMToolkitNegativeACK = 1053,
    /**
     *  SIM Toolkit Positive ACK
     */
    MARAudioIDSIMToolkitPositiveACK = 1054,
    /**
     *  SIM Toolkit SMS
     */
    MARAudioIDSIMToolkitSMS = 1055,
    /**
     *  Tink
     */
    MARAudioIDTink = 1057,
    /**
     *  CT Busy
     */
    MARAudioIDCTBusy = 1070,
    /**
     *  CT Congestion
     */
    MARAudioIDCTCongestion = 1071,
    /**
     *  CT Pack ACK
     */
    MARAudioIDCTPathACK = 1072,
    /**
     *  CT Error
     */
    MARAudioIDCTError = 1073,
    /**
     *  CT Call Waiting
     */
    MARAudioIDCTCallWaiting = 1074,
    /**
     *  CT Keytone
     */
    MARAudioIDCTKeytone = 1075,
    /**
     *  Lock
     */
    MARAudioIDLock = 1100,
    /**
     *  Unlock
     */
    MARAudioIDUnlock = 1101,
    /**
     *  Failed Unlock
     */
    MARAudioIDFailedUnlock = 1102,
    /**
     *  Keypressed Tink
     */
    MARAudioIDKeypressedTink = 1103,
    /**
     *  Keypressed Tock
     */
    MARAudioIDKeypressedTock = 1104,
    /**
     *  Tock
     */
    MARAudioIDTock = 1105,
    /**
     *  Beep Beep
     */
    MARAudioIDBeepBeep = 1106,
    /**
     *  Ringer Charged
     */
    MARAudioIDRingerCharged = 1107,
    /**
     *  Photo Shutter
     */
    MARAudioIDPhotoShutter = 1108,
    /**
     *  Shake
     */
    MARAudioIDShake = 1109,
    /**
     *  JBL Begin
     */
    MARAudioIDJBLBegin = 1110,
    /**
     *  JBL Confirm
     */
    MARAudioIDJBLConfirm = 1111,
    /**
     *  JBL Cancel
     */
    MARAudioIDJBLCancel = 1112,
    /**
     *  Begin Recording
     */
    MARAudioIDBeginRecording = 1113,
    /**
     *  End Recording
     */
    MARAudioIDEndRecording = 1114,
    /**
     *  JBL Ambiguous
     */
    MARAudioIDJBLAmbiguous = 1115,
    /**
     *  JBL No Match
     */
    MARAudioIDJBLNoMatch = 1116,
    /**
     *  Begin Video Record
     */
    MARAudioIDBeginVideoRecord = 1117,
    /**
     *  End Video Record
     */
    MARAudioIDEndVideoRecord = 1118,
    /**
     *  VC Invitation Accepted
     */
    MARAudioIDVCInvitationAccepted = 1150,
    /**
     *  VC Ringing
     */
    MARAudioIDVCRinging = 1151,
    /**
     *  VC Ended
     */
    MARAudioIDVCEnded = 1152,
    /**
     *  VC Call Waiting
     */
    MARAudioIDVCCallWaiting = 1153,
    /**
     *  VC Call Upgrade
     */
    MARAudioIDVCCallUpgrade = 1154,
    /**
     *  Touch Tone 1
     */
    MARAudioIDTouchTone1 = 1200,
    /**
     *  Touch Tone 2
     */
    MARAudioIDTouchTone2 = 1201,
    /**
     *  Touch Tone 3
     */
    MARAudioIDTouchTone3 = 1202,
    /**
     *  Touch Tone 4
     */
    MARAudioIDTouchTone4 = 1203,
    /**
     *  Touch Tone 5
     */
    MARAudioIDTouchTone5 = 1204,
    /**
     *  Touch Tone 6
     */
    MARAudioIDTouchTone6 = 1205,
    /**
     *  Touch Tone 7
     */
    MARAudioIDTouchTone7 = 1206,
    /**
     *  Touch Tone 8
     */
    MARAudioIDTouchTone8 = 1207,
    /**
     *  Touch Tone 9
     */
    MARAudioIDTouchTone9 = 1208,
    /**
     *  Touch Tone 10
     */
    MARAudioIDTouchTone10 = 1209,
    /**
     *  Tone Star
     */
    MARAudioIDTouchToneStar = 1210,
    /**
     *  Tone Pound
     */
    MARAudioIDTouchTonePound = 1211,
    /**
     *  Headset Start Call
     */
    MARAudioIDHeadsetStartCall = 1254,
    /**
     *  Headset Redial
     */
    MARAudioIDHeadsetRedial = 1255,
    /**
     *  Headset Answer Call
     */
    MARAudioIDHeadsetAnswerCall = 1256,
    /**
     *  Headset End Call
     */
    MARAudioIDHeadsetEndCall = 1257,
    /**
     *  Headset Call Waiting Actions
     */
    MARAudioIDHeadsetCallWaitingActions = 1258,
    /**
     *  Headset Transition End
     */
    MARAudioIDHeadsetTransitionEnd = 1259,
    /**
     *  Voicemail
     */
    MARAudioIDVoicemail = 1300,
    /**
     *  Received Message
     */
    MARAudioIDReceivedMessage = 1301,
    /**
     *  New Mail 2
     */
    MARAudioIDNewMail2 = 1302,
    /**
     *  Email Sent 2
     */
    MARAudioIDMailSent2 = 1303,
    /**
     *  Alarm 2
     */
    MARAudioIDAlarm2 = 1304,
    /**
     *  Lock 2
     */
    MARAudioIDLock2 = 1305,
    /**
     *  Tock 2
     */
    MARAudioIDTock2 = 1306,
    /**
     *  SMS Received 7
     */
    MARAudioIDSMSReceived1_2 = 1307,
    /**
     *  SMS Received 8
     */
    MARAudioIDSMSReceived2_2 = 1308,
    /**
     *  SMS Received 9
     */
    MARAudioIDSMSReceived3_2 = 1309,
    /**
     *  SMS Received 10
     */
    MARAudioIDSMSReceived4_2 = 1310,
    /**
     *  SMS Received Vibrate
     */
    MARAudioIDSMSReceivedVibrate = 1311,
    /**
     *  SMS Received 11
     */
    MARAudioIDSMSReceived1_3 = 1312,
    /**
     *  SMS Received 12
     */
    MARAudioIDSMSReceived5_3 = 1313,
    /**
     *  SMS Received 13
     */
    MARAudioIDSMSReceived6_3 = 1314,
    /**
     *  Voicemail 2
     */
    MARAudioIDVoicemail2 = 1315,
    /**
     *  Anticipate 2
     */
    MARAudioIDAnticipate2 = 1320,
    /**
     *  Bloom 2
     */
    MARAudioIDBloom2 = 1321,
    /**
     *  Calypso 2
     */
    MARAudioIDCalypso2 = 1322,
    /**
     *  Choo Choo 2
     */
    MARAudioIDChooChoo2 = 1323,
    /**
     *  Descent 2
     */
    MARAudioIDDescent2 = 1324,
    /**
     *  Fanfare 2
     */
    MARAudioIDFanfare2 = 1325,
    /**
     *  Ladder 2
     */
    MARAudioIDLadder2 = 1326,
    /**
     *  Minuet 2
     */
    MARAudioIDMinuet2 = 1327,
    /**
     *  News Flash 2
     */
    MARAudioIDNewsFlash2 = 1328,
    /**
     *  Noir 2
     */
    MARAudioIDNoir2 = 1329,
    /**
     *  Sherwood Forest 2
     */
    MARAudioIDSherwoodForest2 = 1330,
    /**
     *  Speel 2
     */
    MARAudioIDSpell2 = 1331,
    /**
     *  Suspence 2
     */
    MARAudioIDSuspence2 = 1332,
    /**
     *  Telegraph 2
     */
    MARAudioIDTelegraph2 = 1333,
    /**
     *  Tiptoes 2
     */
    MARAudioIDTiptoes2 = 1334,
    /**
     *  Typewriters 2
     */
    MARAudioIDTypewriters2 = 1335,
    /**
     *  Update 2
     */
    MARAudioIDUpdate2 = 1336,
    /**
     *  Ringer View Changed
     */
    MARAudioIDRingerVibeChanged = 1350,
    /**
     *  Silent View Changed
     */
    MARAudioIDSilentVibeChanged = 1351,
    /**
     *  Vibrate
     */
    MARAudioIDVibrate = 4095
};

NS_ASSUME_NONNULL_BEGIN

/**
 *  This class adds some useful methods to play system sounds
 */
@interface MARSystemSound : NSObject

/**
 *  Play a system sound from the ID
 *
 *  @param audioID ID of system audio from the AudioID enum
 */
+ (void)playSystemSound:(MARAudioID)audioID;

/**
 *  Play system sound vibrate
 */
+ (void)playSystemSoundVibrate;

/**
 *  Play custom sound with url
 *
 *  @param soundURL Sound URL
 *
 *  @return Returns the SystemSoundID
 */
+ (SystemSoundID)playCustomSound:(NSURL * _Nonnull)soundURL;

/**
 *  Dispose custom sound
 *
 *  @param soundID SystemSoundID
 *
 *  @return Returns YES if has been disposed, otherwise NO
 */
+ (BOOL)disposeSound:(SystemSoundID)soundID;


@property (nonatomic, assign) MARAudioID audioID;

@property (nullable, nonatomic, strong) NSURL *soundURL;

- (void)play;

@end

NS_ASSUME_NONNULL_END
