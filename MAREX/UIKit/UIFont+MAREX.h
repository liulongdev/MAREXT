//
//  UIFont+MAREX.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/18.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  All font family names available from iOS 7.0 to iOS 9.0
 */
typedef NS_ENUM(NSInteger, MARFamilyFontName) {
    /**
     *  Academy Engraved LET
     */
    MARFamilyFontNameAcademyEngravedLET = 0,
    /**
     *  Al Nile
     */
    MARFamilyFontNameAlNile,
    /**
     *  American Typewriter
     */
    MARFamilyFontNameAmericanTypewriter,
    /**
     *  Apple Color Emoji
     */
    MARFamilyFontNameAppleColorEmoji,
    /**
     *  Apple SD Gothic Neo
     */
    MARFamilyFontNameAppleSDGothicNeo,
    /**
     *  Arial
     */
    MARFamilyFontNameArial,
    /**
     *  Arial Hebrew
     */
    MARFamilyFontNameArialHebrew,
    /**
     *  Arial Rounded MT Bold
     */
    MARFamilyFontNameArialRoundedMTBold,
    /**
     *  Avenir
     */
    MARFamilyFontNameAvenir,
    /**
     *  Avenir Next
     */
    MARFamilyFontNameAvenirNext,
    /**
     *  Avenir Next Condensed
     */
    MARFamilyFontNameAvenirNextCondensed,
    /**
     *  Bangla Sangam MN
     */
    MARFamilyFontNameBanglaSangamMN NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Baskerville
     */
    MARFamilyFontNameBaskerville,
    /**
     *  Bodoni 72
     */
    MARFamilyFontNameBodoni72,
    /**
     *  Bodoni 72 Oldstyle
     */
    MARFamilyFontNameBodoni72Oldstyle,
    /**
     *  Bodoni 72 Smallcaps
     */
    MARFamilyFontNameBodoni72Smallcaps,
    /**
     *  Bodoni Ornaments
     */
    MARFamilyFontNameBodoniOrnaments,
    /**
     *  Bradley Hand
     */
    MARFamilyFontNameBradleyHand,
    /**
     *  Chalkboard SE
     */
    MARFamilyFontNameChalkboardSE,
    /**
     *  Chalkduster
     */
    MARFamilyFontNameChalkduster,
    /**
     *  Cochin
     */
    MARFamilyFontNameCochin,
    /**
     *  Copperplate
     */
    MARFamilyFontNameCopperplate,
    /**
     *  Courier
     */
    MARFamilyFontNameCourier,
    /**
     *  Courier New
     */
    MARFamilyFontNameCourierNew,
    /**
     *  Damascus
     */
    MARFamilyFontNameDamascus,
    /**
     *  Devanagari Sangam MN
     */
    MARFamilyFontNameDevanagariSangamMN,
    /**
     *  Didot
     */
    MARFamilyFontNameDidot,
    /**
     *  DIN Alternate
     */
    MARFamilyFontNameDINAlternate NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  DIN Condensed
     */
    MARFamilyFontNameDINCondensed NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Euphemia UCAS
     */
    MARFamilyFontNameEuphemiaUCAS,
    /**
     *  Farah
     */
    MARFamilyFontNameFarah,
    /**
     *  Futura
     */
    MARFamilyFontNameFutura,
    /**
     *  Geeza Pro
     */
    MARFamilyFontNameGeezaPro,
    /**
     *  Georgia
     */
    MARFamilyFontNameGeorgia,
    /**
     *  Gill Sans
     */
    MARFamilyFontNameGillSans,
    /**
     *  Gujarati Sangem MN
     */
    MARFamilyFontNameGujaratiSangemMN,
    /**
     *  Gurmukhi MN
     */
    MARFamilyFontNameGurmukhiMN,
    /**
     *  Heiti SC
     */
    MARFamilyFontNameHeitiSC,
    /**
     *  Heiti TC
     */
    MARFamilyFontNameHeitiTC,
    /**
     *  Helvetica
     */
    MARFamilyFontNameHelvetica,
    /**
     *  Helvetica Neue
     */
    MARFamilyFontNameHelveticaNeue,
    /**
     *  Hiragino Kaku Gothic Pro N
     */
    MARFamilyFontNameHiraginoKakuGothicProN,
    /**
     *  Hiragino Mincho Pro N
     */
    MARFamilyFontNameHiraginoMinchoProN,
    /**
     *  Hoefler Text
     */
    MARFamilyFontNameHoeflerText,
    /**
     *  Iowan OldStyle
     */
    MARFamilyFontNameIowanOldStyle NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Kailasa
     */
    MARFamilyFontNameKailasa,
    /**
     *  Kannada Sangam MN
     */
    MARFamilyFontNameKannadaSangamMN,
    /**
     *  Khmer Sangam MN
     */
    MARFamilyFontNameKhmerSangamMN NS_ENUM_AVAILABLE_IOS(8_0),
    /**
     *  Kohinoor Bangla
     */
    MARFamilyFontNameKohinoorBangla NS_ENUM_AVAILABLE_IOS(9_0),
    /**
     *  Kohinoor Devanagari
     */
    MARFamilyFontNameKohinoorDevanagari NS_ENUM_AVAILABLE_IOS(8_0),
    /**
     *  Lao Sangam MN
     */
    MARFamilyFontNameLaoSangamMN NS_ENUM_AVAILABLE_IOS(8_0),
    /**
     *  Malayam Sangam MN
     */
    MARFamilyFontNameMalayamSangamMN,
    /**
     *  Marion
     */
    MARFamilyFontNameMarion NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Marker Felt
     */
    MARFamilyFontNameMarkerFelt,
    /**
     *  Menlo
     */
    MARFamilyFontNameMenlo,
    /**
     *  Mishafi
     */
    MARFamilyFontNameMishafi,
    /**
     *  Noteworthy
     */
    MARFamilyFontNameNoteworthy,
    /**
     *  Optima
     */
    MARFamilyFontNameOptima,
    /**
     *  Oriya Sangem MN
     */
    MARFamilyFontNameOriyaSangemMN,
    /**
     *  Palatino
     */
    MARFamilyFontNamePalatino,
    /**
     *  Papyrus
     */
    MARFamilyFontNamePapyrus,
    /**
     *  Party LET
     */
    MARFamilyFontNamePartyLET,
    /**
     *  Savoye LET
     */
    MARFamilyFontNameSavoyeLET,
    /**
     *  Sinhala Sangam MN
     */
    MARFamilyFontNameSinhalaSangamMN,
    /**
     *  Snell Roundhand
     */
    MARFamilyFontNameSnellRoundhand,
    /**
     *  Superclarendon
     */
    MARFamilyFontNameSuperclarendon NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Symbol
     */
    MARFamilyFontNameSymbol,
    /**
     *  Tamil Sangam MN
     */
    MARFamilyFontNameTamilSangamMN,
    /**
     *  Telugu Sangam MN
     */
    MARFamilyFontNameTeluguSangamMN,
    /**
     *  Thonburi
     */
    MARFamilyFontNameThonburi,
    /**
     *  Times New Roman
     */
    MARFamilyFontNameTimesNewRoman,
    /**
     *  Trebuchet MS
     */
    MARFamilyFontNameTrebuchetMS,
    /**
     *  Verdana
     */
    MARFamilyFontNameVerdana,
    /**
     *  Zapf Ding Bats
     */
    MARFamilyFontNameZapfDingBats,
    /**
     *  Zapfino
     */
    MARFamilyFontNameZapfino
};

/**
 *  All font names for all family available from iOS 7.0 to iOS 9.0
 */
typedef NS_ENUM(NSInteger, MARFontName) {
    /**
     *  Academy Engraved Let Plain
     */
    MARFontNameAcademyEngravedLetPlain = 0,
    /**
     *  Al Nile
     */
    MARFontNameAlNile,
    /**
     *  Al Nile Bold
     */
    MARFontNameAlNileBold,
    /**
     *  American Typewriter
     */
    MARFontNameAmericanTypewriter,
    /**
     *  American Typewriter Bold
     */
    MARFontNameAmericanTypewriterBold,
    /**
     *  American Typewriter Condensed
     */
    MARFontNameAmericanTypewriterCondensed,
    /**
     *  American Typewriter Condensed Bold
     */
    MARFontNameAmericanTypewriterCondensedBold,
    /**
     *  American Typewriter Condensed Light
     */
    MARFontNameAmericanTypewriterCondensedLight,
    /**
     *  American Typewriter Light
     */
    MARFontNameAmericanTypewriterLight,
    /**
     *  Apple Color Emoji
     */
    MARFontNameAppleColorEmoji,
    /**
     *  Apple SD Gothic Neo Bold
     */
    MARFontNameAppleSDGothicNeoBold,
    /**
     *  Apple SD Gothic Neo Light
     */
    MARFontNameAppleSDGothicNeoLight,
    /**
     *  Apple SD Gothic Neo Medium
     */
    MARFontNameAppleSDGothicNeoMedium,
    /**
     *  Apple SD Gothic Neo Regular
     */
    MARFontNameAppleSDGothicNeoRegular,
    /**
     *  Apple SD Gothic Neo Semi Bold
     */
    MARFontNameAppleSDGothicNeoSemiBold,
    /**
     *  Apple SD Gothic Neo Thin
     */
    MARFontNameAppleSDGothicNeoThin,
    /*
     *  Apple SD Gothic Neo Ultra Light
     */
    MARFontNameAppleSDGothicNeoUltraLight NS_ENUM_AVAILABLE_IOS(9_0),
    /**
     *  Arial Bold Italic MT
     */
    MARFontNameArialBoldItalicMT,
    /**
     *  Arial Bold MT
     */
    MARFontNameArialBoldMT,
    /**
     *  Arial Hebrew
     */
    MARFontNameArialHebrew,
    /**
     *  Arial Hebrew Bold
     */
    MARFontNameArialHebrewBold,
    /**
     *  Arial Hebrew Light
     */
    MARFontNameArialHebrewLight,
    /**
     *  Arial Italic MT
     */
    MARFontNameArialItalicMT,
    /**
     *  Arial MT
     */
    MARFontNameArialMT,
    /**
     *  Arial Rounded MT Bold
     */
    MARFontNameArialRoundedMTBold,
    /**
     *  AST Heiti Light
     */
    MARFontNameASTHeitiLight,
    /**
     *  AST Heiti Medium
     */
    MARFontNameASTHeitiMedium,
    /**
     *  Avenir Black
     */
    MARFontNameAvenirBlack,
    /**
     *  Avenir Black Oblique
     */
    MARFontNameAvenirBlackOblique,
    /**
     *  Avenir Book
     */
    MARFontNameAvenirBook,
    /**
     *  Avenir Book Oblique
     */
    MARFontNameAvenirBookOblique,
    /**
     *  Avenir Heavy Oblique
     */
    MARFontNameAvenirHeavyOblique,
    /**
     *  Avenir Heavy
     */
    MARFontNameAvenirHeavy,
    /**
     *  Avenir Light
     */
    MARFontNameAvenirLight,
    /**
     *  Avenir Light Oblique
     */
    MARFontNameAvenirLightOblique,
    /**
     *  Avenir Medium
     */
    MARFontNameAvenirMedium,
    /**
     *  Avenir Medium Oblique
     */
    MARFontNameAvenirMediumOblique,
    /**
     *  Avenir Oblique
     */
    MARFontNameAvenirNextBold,
    /**
     *  Avenir Next Bold Italic
     */
    MARFontNameAvenirNextBoldItalic,
    /**
     *  Avenir Next Condensed Bold
     */
    MARFontNameAvenirNextCondensedBold,
    /**
     *  Avenir Next Condensed Bold Italic
     */
    MARFontNameAvenirNextCondensedBoldItalic,
    /**
     *  Avenir Next Condensed Demi Bold
     */
    MARFontNameAvenirNextCondensedDemiBold,
    /**
     *  Avenir Next Condensed Demi Bold Italic
     */
    MARFontNameAvenirNextCondensedDemiBoldItalic,
    /**
     *  Avenir Next Condensed Heavy
     */
    MARFontNameAvenirNextCondensedHeavy,
    /**
     *  Avenir Next Condensed Heavy Italic
     */
    MARFontNameAvenirNextCondensedHeavyItalic,
    /**
     *  Avenir Next Condensed Italic
     */
    MARFontNameAvenirNextCondensedItalic,
    /**
     *  Avenir Next Condensed Medium
     */
    MARFontNameAvenirNextCondensedMedium,
    /**
     *  Avenir Next Condensed Medium Italic
     */
    MARFontNameAvenirNextCondensedMediumItalic,
    /**
     *  Avenir Next Condensed Regular
     */
    MARFontNameAvenirNextCondensedRegular,
    /**
     *  Avenir Next Condensed Ultra Light
     */
    MARFontNameAvenirNextCondensedUltraLight,
    /**
     *  Avenir Next Condensed Ultra Light Italic
     */
    MARFontNameAvenirNextCondensedUltraLightItalic,
    /**
     *  Avenir Next Demi Bold
     */
    MARFontNameAvenirNextDemiBold,
    /**
     *  Avenir Next Demi Bold Italic
     */
    MARFontNameAvenirNextDemiBoldItalic,
    /**
     *  Avenir Next Heavy
     */
    MARFontNameAvenirNextHeavy,
    /**
     *  Avenir Next Italic
     */
    MARFontNameAvenirNextItalic,
    /**
     *  Avenir Next Medium
     */
    MARFontNameAvenirNextMedium,
    /**
     *  Avenir Next Medium Italic
     */
    MARFontNameAvenirNextMediumItalic,
    /**
     *  Avenir Next Regular
     */
    MARFontNameAvenirNextRegular,
    /**
     *  Avenir Next Ultra Light
     */
    MARFontNameAvenirNextUltraLight,
    /**
     *  Avenir Next Ultra Light Italic
     */
    MARFontNameAvenirNextUltraLightItalic,
    /**
     *  Avenir Oblique
     */
    MARFontNameAvenirOblique,
    /**
     *  Avenir Roman
     */
    MARFontNameAvenirRoman,
    /**
     *  Bangla Sangam MN
     */
    MARFontNameBanglaSangamMN NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Bangla Sangam MN Bold
     */
    MARFontNameBanglaSangamMNBold NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Baskerville
     */
    MARFontNameBaskerville,
    /**
     *  Baskerville Bold
     */
    MARFontNameBaskervilleBold,
    /**
     *  Baskerville Bold Italic
     */
    MARFontNameBaskervilleBoldItalic,
    /**
     *  Baskerville Italic
     */
    MARFontNameBaskervilleItalic,
    /**
     *  Baskerville Semi Bold
     */
    MARFontNameBaskervilleSemiBold,
    /**
     *  Baskerville Semi Bold Italic
     */
    MARFontNameBaskervilleSemiBoldItalic,
    /**
     *  Bodoni Ornaments ITCTT
     */
    MARFontNameBodoniOrnamentsITCTT,
    /**
     *  Bodoni Svty Two ITCTT Bold
     */
    MARFontNameBodoniSvtyTwoITCTTBold,
    /**
     *  Bodoni Svty Two ITCTT Book
     */
    MARFontNameBodoniSvtyTwoITCTTBook,
    /**
     *  Bodoni Svty Two ITCTT Book Ita
     */
    MARFontNameBodoniSvtyTwoITCTTBookIta,
    /**
     *  Bodoni Svty Two OS ITCTT Bold
     */
    MARFontNameBodoniSvtyTwoOSITCTTBold,
    /**
     *  Bodoni Svty Two OS ITCTT Book
     */
    MARFontNameBodoniSvtyTwoOSITCTTBook,
    /**
     *  Bodoni Svty Two OS ITCTT Book It
     */
    MARFontNameBodoniSvtyTwoOSITCTTBookIt,
    /**
     *  Bodoni Svty Two SC ITCTT Book
     */
    MARFontNameBodoniSvtyTwoSCITCTTBook,
    /**
     *  Bradley Hand ITCTT Bold
     */
    MARFontNameBradleyHandITCTTBold,
    /**
     *  Chalkboard SE Bold
     */
    MARFontNameChalkboardSEBold,
    /**
     *  Chalkboard SE Light
     */
    MARFontNameChalkboardSELight,
    /**
     *  Chalkboard SE Regular
     */
    MARFontNameChalkboardSERegular,
    /**
     *  Chalkduster
     */
    MARFontNameChalkduster,
    /**
     *  Cochin
     */
    MARFontNameCochin,
    /**
     *  Cochin Bold
     */
    MARFontNameCochinBold,
    /**
     *  Cochin Bold Italic
     */
    MARFontNameCochinBoldItalic,
    /**
     *  Cochin Italic
     */
    MARFontNameCochinItalic,
    /**
     *  Copperplate
     */
    MARFontNameCopperplate,
    /**
     *  Copperplate Bold
     */
    MARFontNameCopperplateBold,
    /**
     *  Copperplate Light
     */
    MARFontNameCopperplateLight,
    /**
     *  Courier
     */
    MARFontNameCourier,
    /**
     *  Courier Bold
     */
    MARFontNameCourierBold,
    /**
     *  Courier Bold Oblique
     */
    MARFontNameCourierBoldOblique,
    /**
     *  Courier New PS Bold Italic MT
     */
    MARFontNameCourierNewPSBoldItalicMT,
    /**
     *  Courier New PS Bold MT
     */
    MARFontNameCourierNewPSBoldMT,
    /**
     *  Courier New PS Italic MT
     */
    MARFontNameCourierNewPSItalicMT,
    /**
     *  Courier New PS MT
     */
    MARFontNameCourierNewPSMT,
    /**
     *  Courier Oblique
     */
    MARFontNameCourierOblique,
    /**
     *  Damascus
     */
    MARFontNameDamascus,
    /**
     *  Damascus Bold
     */
    MARFontNameDamascusBold,
    /**
     *  Damascus Medium
     */
    MARFontNameDamascusMedium,
    /**
     *  Damascus Semi Bold
     */
    MARFontNameDamascusSemiBold,
    /**
     *  Devanagari Sangam MN
     */
    MARFontNameDevanagariSangamMN,
    /**
     *  Devanagari Sangam MN Bold
     */
    MARFontNameDevanagariSangamMNBold,
    /**
     *  Didot
     */
    MARFontNameDidot,
    /**
     *  Didot Bold
     */
    MARFontNameDidotBold,
    /**
     *  Didot Italic
     */
    MARFontNameDidotItalic,
    /**
     *  DIN Alternate Bold
     */
    MARFontNameDINAlternateBold NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  DIN Condensed Bold
     */
    MARFontNameDINCondensedBold NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Diwan Mishafi
     */
    MARFontNameDiwanMishafi,
    /**
     *  Euphemia UCAS
     */
    MARFontNameEuphemiaUCAS,
    /**
     *  Euphemia UCAS Bold
     */
    MARFontNameEuphemiaUCASBold,
    /**
     *  Euphemia UCAS Italic
     */
    MARFontNameEuphemiaUCASItalic,
    /**
     *  Farah
     */
    MARFontNameFarah,
    /**
     *  Futura Condensed Extra Bold
     */
    MARFontNameFuturaCondensedExtraBold,
    /**
     *  Futura Condensed Medium
     */
    MARFontNameFuturaCondensedMedium,
    /**
     *  Futura Medium
     */
    MARFontNameFuturaMedium,
    /**
     *  Futura Medium Italicm
     */
    MARFontNameFuturaMediumItalicm,
    /**
     *  Geeza Pro
     */
    MARFontNameGeezaPro,
    /**
     *  Geeza Pro Bold
     */
    MARFontNameGeezaProBold,
    /**
     *  Geeza Pro Light
     */
    MARFontNameGeezaProLight,
    /**
     *  Georgia
     */
    MARFontNameGeorgia,
    /**
     *  Georgia Bold
     */
    MARFontNameGeorgiaBold,
    /**
     *  Georgia Bold Italic
     */
    MARFontNameGeorgiaBoldItalic,
    /**
     *  Georgia Italic
     */
    MARFontNameGeorgiaItalic,
    /**
     *  Gill Sans
     */
    MARFontNameGillSans,
    /**
     *  Gill Sans Bold
     */
    MARFontNameGillSansBold,
    /**
     *  Gill Sans Bold Italic
     */
    MARFontNameGillSansBoldItalic,
    /**
     *  Gill Sans Italic
     */
    MARFontNameGillSansItalic,
    /**
     *  Gill Sans Light
     */
    MARFontNameGillSansLight,
    /**
     *  Gill Sans Light Italic
     */
    MARFontNameGillSansLightItalic,
    /**
     *  Gujarati Sangam MN
     */
    MARFontNameGujaratiSangamMN,
    /**
     *  Gujarati Sangam MN Bold
     */
    MARFontNameGujaratiSangamMNBold,
    /**
     *  Gurmukhi MN
     */
    MARFontNameGurmukhiMN,
    /**
     *  Gurmukhi MN Bold
     */
    MARFontNameGurmukhiMNBold,
    /**
     *  Helvetica
     */
    MARFontNameHelvetica,
    /**
     *  Helvetica Bold
     */
    MARFontNameHelveticaBold,
    /**
     *  Helvetica Bold Oblique
     */
    MARFontNameHelveticaBoldOblique,
    /**
     *  Helvetica Light
     */
    MARFontNameHelveticaLight,
    /**
     *  Helvetica Light Oblique
     */
    MARFontNameHelveticaLightOblique,
    /**
     *  Helvetica Neue
     */
    MARFontNameHelveticaNeue,
    /**
     *  Helvetica Neue Bold
     */
    MARFontNameHelveticaNeueBold,
    /**
     *  Helvetica Neue Bold Italic
     */
    MARFontNameHelveticaNeueBoldItalic,
    /**
     *  Helvetica Neue Condensed Black
     */
    MARFontNameHelveticaNeueCondensedBlack,
    /**
     *  Helvetica Neue Condensed Bold
     */
    MARFontNameHelveticaNeueCondensedBold,
    /**
     *  Helvetica Neue Italic
     */
    MARFontNameHelveticaNeueItalic,
    /**
     *  Helvetica Neue Light
     */
    MARFontNameHelveticaNeueLight,
    /**
     *  Helvetica Neue Medium
     */
    MARFontNameHelveticaNeueMedium,
    /**
     *  Helvetica Neue Medium Italic
     */
    MARFontNameHelveticaNeueMediumItalic,
    /**
     *  Helvetica Neue Thin
     */
    MARFontNameHelveticaNeueThin,
    /**
     *  Helvetica Neue Thin Italic
     */
    MARFontNameHelveticaNeueThinItalic,
    /**
     *  Helvetica Neue Ultra Light
     */
    MARFontNameHelveticaNeueUltraLight,
    /**
     *  Helvetica Neue Ultra Light Italic
     */
    MARFontNameHelveticaNeueUltraLightItalic,
    /**
     *  Helvetica Oblique
     */
    MARFontNameHelveticaOblique,
    /**
     *  Hira Kaku Pro NW3
     */
    MARFontNameHiraKakuProNW3,
    /**
     *  Hira Kaku Pro NW6
     */
    MARFontNameHiraKakuProNW6,
    /**
     *  Hira Min Pro NW3
     */
    MARFontNameHiraMinProNW3,
    /**
     *  Hira Min Pro NW6
     */
    MARFontNameHiraMinProNW6,
    /**
     *  Hoefler Text Black
     */
    MARFontNameHoeflerTextBlack,
    /**
     *  Hoefler Text Black Italic
     */
    MARFontNameHoeflerTextBlackItalic,
    /**
     *  Hoefler Text Italic
     */
    MARFontNameHoeflerTextItalic,
    /**
     *  Hoefler Text Regular
     */
    MARFontNameHoeflerTextRegular,
    /**
     *  Iowan Old Style Bold
     */
    MARFontNameIowanOldStyleBold NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Iowan Old Style Bold Italic
     */
    MARFontNameIowanOldStyleBoldItalic NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Iowan Old Style Italic
     */
    MARFontNameIowanOldStyleItalic NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Iowan Old Style Roman
     */
    MARFontNameIowanOldStyleRoman NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Kailasa
     */
    MARFontNameKailasa,
    /**
     *  Kailasa Bold
     */
    MARFontNameKailasaBold,
    /**
     *  Kannada Sangam MN
     */
    MARFontNameKannadaSangamMN,
    /**
     *  Kannada Sangam MN Bold
     */
    MARFontNameKannadaSangamMNBold,
    /**
     *  Khmer Sangam MN
     */
    MARFontNameKhmerSangamMN NS_ENUM_AVAILABLE_IOS(8_0),
    /**
     *  Kohinoor Bangla Light
     */
    MARFontNameKohinoorBanglaLight NS_ENUM_AVAILABLE_IOS(9_0),
    /**
     *  Kohinoor Bangla Medium
     */
    MARFontNameKohinoorBanglaMedium NS_ENUM_AVAILABLE_IOS(9_0),
    /**
     *  Kohinoor Bangla Regular
     */
    MARFontNameKohinoorBanglaRegular NS_ENUM_AVAILABLE_IOS(9_0),
    /**
     *  Kohinoor Devanagari Light
     */
    MARFontNameKohinoorDevanagariLight NS_ENUM_AVAILABLE_IOS(8_0),
    /**
     *  Kohinoor Devanagari Medium
     */
    MARFontNameKohinoorDevanagariMedium NS_ENUM_AVAILABLE_IOS(8_0),
    /**
     *  Kohinoor Devanagari Book
     */
    MARFontNameKohinoorDevanagariBook NS_ENUM_AVAILABLE_IOS(8_0),
    /**
     *  Lao Sangam MN
     */
    MARFontNameLaoSangamMN NS_ENUM_AVAILABLE_IOS(8_0),
    /**
     *  Malayalam Sangam MN
     */
    MARFontNameMalayalamSangamMN,
    /**
     *  Malayalam Sangam MN Bold
     */
    MARFontNameMalayalamSangamMNBold,
    /**
     *  Marion Bold
     */
    MARFontNameMarionBold NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Marion Italic
     */
    MARFontNameMarionItalic NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Marion Regular
     */
    MARFontNameMarionRegular NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Marker Felt Thin
     */
    MARFontNameMarkerFeltThin,
    /**
     *  Marker Felt Wide
     */
    MARFontNameMarkerFeltWide,
    /**
     *  Menlo Bold
     */
    MARFontNameMenloBold,
    /**
     *  Menlo Bold Italic
     */
    MARFontNameMenloBoldItalic,
    /**
     *  Menlo Italic
     */
    MARFontNameMenloItalic,
    /**
     *  Menlo Regular
     */
    MARFontNameMenloRegular,
    /**
     *  Noteworthy Bold
     */
    MARFontNameNoteworthyBold,
    /**
     *  Noteworthy Light
     */
    MARFontNameNoteworthyLight,
    /**
     *  Optima Bold
     */
    MARFontNameOptimaBold,
    /**
     *  Optima Bold Italic
     */
    MARFontNameOptimaBoldItalic,
    /**
     *  Optima Extra Black
     */
    MARFontNameOptimaExtraBlack,
    /**
     *  Optima Italic
     */
    MARFontNameOptimaItalic,
    /**
     *  Optima Regular
     */
    MARFontNameOptimaRegular,
    /**
     *  Oriya Sangam MN
     */
    MARFontNameOriyaSangamMN,
    /**
     *  Oriya Sangam MN Bold
     */
    MARFontNameOriyaSangamMNBold,
    /**
     *  Palatino Bold
     */
    MARFontNamePalatinoBold,
    /**
     *  Palatino Bold Italic
     */
    MARFontNamePalatinoBoldItalic,
    /**
     *  Palatino Italic
     */
    MARFontNamePalatinoItalic,
    /**
     *  Palatino Roman
     */
    MARFontNamePalatinoRoman,
    /**
     *  Papyrus
     */
    MARFontNamePapyrus,
    /**
     *  Papyrus Condensed
     */
    MARFontNamePapyrusCondensed,
    /**
     *  Party Let Plain
     */
    MARFontNamePartyLetPlain,
    /**
     *  Savoye Let Plain
     */
    MARFontNameSavoyeLetPlain,
    /**
     *  Sinhala Sangam MN
     */
    MARFontNameSinhalaSangamMN,
    /**
     *  Sinhala Sangam MN Bold
     */
    MARFontNameSinhalaSangamMNBold,
    /**
     *  Snell Roundhand
     */
    MARFontNameSnellRoundhand,
    /**
     *  Snell Roundhand Black
     */
    MARFontNameSnellRoundhandBlack,
    /**
     *  Snell Roundhand Bold
     */
    MARFontNameSnellRoundhandBold,
    /**
     *  ST Heiti SC Light
     */
    MARFontNameSTHeitiSCLight,
    /**
     *  ST Heiti SC Medium
     */
    MARFontNameSTHeitiSCMedium,
    /**
     *  ST Heiti TC Light
     */
    MARFontNameSTHeitiTCLight,
    /**
     *  ST Heiti TC Medium
     */
    MARFontNameSTHeitiTCMedium,
    /**
     *  Superclarendon Black
     */
    MARFontNameSuperclarendonBlack NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Superclarendon Black Italic
     */
    MARFontNameSuperclarendonBlackItalic NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Superclarendon Bold
     */
    MARFontNameSuperclarendonBold NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Superclarendon Bold Italic
     */
    MARFontNameSuperclarendonBoldItalic NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Superclarendon Italic
     */
    MARFontNameSuperclarendonItalic NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Superclarendon Light
     */
    MARFontNameSuperclarendonLight NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Superclarendon Light Italic
     */
    MARFontNameSuperclarendonLightItalic NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Superclarendon Regular
     */
    MARFontNameSuperclarendonRegular NS_ENUM_DEPRECATED_IOS(7_0, 8_0, "This font is not available after iOS 8"),
    /**
     *  Symbol
     */
    MARFontNameSymbol,
    /**
     *  Tamil Sangam MN
     */
    MARFontNameTamilSangamMN,
    /**
     *  Tamil Sangam MN Bold
     */
    MARFontNameTamilSangamMNBold,
    /**
     *  Telugu Sangam MN
     */
    MARFontNameTeluguSangamMN,
    /**
     *  Telugu Sangam MN Bold
     */
    MARFontNameTeluguSangamMNBold,
    /**
     *  Thonburi
     */
    MARFontNameThonburi,
    /**
     *  Thonburi Bold
     */
    MARFontNameThonburiBold,
    /**
     *  Thonburi Light
     */
    MARFontNameThonburiLight,
    /**
     *  Times New Roman PS Bold Italic MT
     */
    MARFontNameTimesNewRomanPSBoldItalicMT,
    /**
     *  Times New Roman PS Bold MT
     */
    MARFontNameTimesNewRomanPSBoldMT,
    /**
     *  Times New Roman PS Italic MT
     */
    MARFontNameTimesNewRomanPSItalicMT,
    /**
     *  Times New Roman PS MT
     */
    MARFontNameTimesNewRomanPSMT,
    /**
     *  Trebuchet Bold Italic
     */
    MARFontNameTrebuchetBoldItalic,
    /**
     *  Trebuchet MS
     */
    MARFontNameTrebuchetMS,
    /**
     *  Trebuchet MS Bold
     */
    MARFontNameTrebuchetMSBold,
    /**
     *  Trebuchet MS Italic
     */
    MARFontNameTrebuchetMSItalic,
    /**
     *  Verdana
     */
    MARFontNameVerdana,
    /**
     *  Verdana Bold
     */
    MARFontNameVerdanaBold,
    /**
     *  Verdana Bold Italic
     */
    MARFontNameVerdanaBoldItalic,
    /**
     *  Verdana Italic
     */
    MARFontNameVerdanaItalic,
    /**
     *  Zapf Dingbats ITC
     */
    MARFontNameZapfDingbatsITC,
    /**
     *  Zapfino
     */
    MARFontNameZapfino
};


/**
 *  This category adds some useful methods to UIFont
 */

@interface UIFont (MAREX)

/**
 *  Print in console all family and font names
 *
 *  @return Returns all the font family names
 */
+ (NSDictionary * _Nonnull)mar_allFamilyAndFonts;


/**
 *  Print in console all font names for a given family
 *
 *  @param familyFontName Family to print the fonts
 *
 *  @return Returns all the fonts for the given family
 */
+ (NSArray * _Nonnull)mar_fontsNameForFamilyName:(MARFamilyFontName)familyFontName;;

/**
 *  Create an UIFont object from the given font name and size
 *
 *  @param fontName Font name
 *  @param fontSize Size of the font
 *
 *  @return Returns an UIFont from the given font name and size
 */
+ (UIFont * _Nonnull)mar_fontForFontName:(MARFontName)fontName
                                size:(CGFloat)fontSize;

/**
 *  Static light font to use in App
 *
 *  @return Returns light font to use in App
 */
+ (UIFont * _Nullable)mar_lightFont;

/**
 *  Set the new light font for the App
 *
 *  @param lightFont The new font
 */
+ (void)setMar_lightFont:(UIFont * _Nullable)lightFont;

/**
 *  Static regular font to use in App
 *
 *  @return Returns regular font to use in App
 */
+ (UIFont * _Nullable)mar_regularFont;

/**
 *  Set the new regular font for the App
 *
 *  @param regularFont The new font
 */
+ (void)setMar_regularFont:(UIFont * _Nullable)regularFont;

/**
 *  Static bold font to use in App
 *
 *  @return Returns bold font to use in App
 */
+ (UIFont * _Nullable)mar_boldFont;

/**
 *  Set the new bold font for the App
 *
 *  @param boldFont The new font
 */
+ (void)setMar_boldFont:(UIFont * _Nullable)boldFont;

@end
