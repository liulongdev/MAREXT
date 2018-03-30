//
//  UIFont+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/18.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "UIFont+MAREX.h"
#import "NSMutableArray+MAREX.h"

@implementation UIFont (MAREX)

static UIFont * _Nullable mar_lightFont;
static UIFont * _Nullable mar_regularFont;
static UIFont * _Nullable mar_boldFont;

+ (UIFont *)mar_lightFont {
    return UIFont.mar_lightFont;
}

+ (void)setMar_lightFont:(UIFont *)lightFont {
    UIFont.mar_lightFont = lightFont;
}

+ (UIFont *)mar_regularFont {
    return UIFont.mar_regularFont;
}

+ (void)setMar_regularFont:(UIFont *)regularFont {
    UIFont.mar_regularFont = regularFont;
}

+ (UIFont *)mar_boldFont {
    return UIFont.mar_boldFont;
}

+ (void)setMar_boldFont:(UIFont *)boldFont {
    UIFont.mar_boldFont = boldFont;
}

+ (NSDictionary * _Nonnull)mar_allFamilyAndFonts {
    NSMutableArray *fontFamilies = (NSMutableArray *)[UIFont familyNames];
    fontFamilies = [NSMutableArray mar_sortArrayByKey:@"" array:fontFamilies ascending:YES];
    
    NSMutableDictionary *fontFamilyDic = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < [fontFamilies count]; i++) {
        NSString *fontFamily = [fontFamilies objectAtIndex:i];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:fontFamily];
        [fontFamilyDic setObject:fontNames forKey:fontFamily];
    }
    
    NSLog(@"%@", fontFamilyDic);
    
    return fontFamilyDic;
}

+ (NSArray * _Nonnull)mar_fontsNameForFamilyName:(MARFamilyFontName)familyFontName {
    NSArray *fontNames;
    
    switch (familyFontName) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        case MARFamilyFontNameBanglaSangamMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Bangla Sangam MN"];
            break;
        case MARFamilyFontNameDINAlternate:
            fontNames = [UIFont fontNamesForFamilyName:@"DIN Alternate"];
            break;
        case MARFamilyFontNameDINCondensed:
            fontNames = [UIFont fontNamesForFamilyName:@"DIN Condensed"];
            break;
        case MARFamilyFontNameIowanOldStyle:
            fontNames = [UIFont fontNamesForFamilyName:@"Iowan Old Style"];
            break;
        case MARFamilyFontNameMarion:
            fontNames = [UIFont fontNamesForFamilyName:@"Marion"];
            break;
        case MARFamilyFontNameSuperclarendon:
            fontNames = [UIFont fontNamesForFamilyName:@"Superclarendon"];
            break;
#pragma clang diagnostic pop
        case MARFamilyFontNameAcademyEngravedLET:
            fontNames = [UIFont fontNamesForFamilyName:@"Academy Engraved LET"];
            break;
        case MARFamilyFontNameAlNile:
            fontNames = [UIFont fontNamesForFamilyName:@"Al Nile"];
            break;
        case MARFamilyFontNameAmericanTypewriter:
            fontNames = [UIFont fontNamesForFamilyName:@"American Typewriter"];
            break;
        case MARFamilyFontNameAppleColorEmoji:
            fontNames = [UIFont fontNamesForFamilyName:@"Apple Color Emoji"];
            break;
        case MARFamilyFontNameAppleSDGothicNeo:
            fontNames = [UIFont fontNamesForFamilyName:@"Apple SD Gothic Neo"];
            break;
        case MARFamilyFontNameArial:
            fontNames = [UIFont fontNamesForFamilyName:@"Arial"];
            break;
        case MARFamilyFontNameArialHebrew:
            fontNames = [UIFont fontNamesForFamilyName:@"Arial Hebrew"];
            break;
        case MARFamilyFontNameArialRoundedMTBold:
            fontNames = [UIFont fontNamesForFamilyName:@"Arial Rounded MT Bold"];
            break;
        case MARFamilyFontNameAvenir:
            fontNames = [UIFont fontNamesForFamilyName:@"Avenir"];
            break;
        case MARFamilyFontNameAvenirNext:
            fontNames = [UIFont fontNamesForFamilyName:@"Avenir Next"];
            break;
        case MARFamilyFontNameAvenirNextCondensed:
            fontNames = [UIFont fontNamesForFamilyName:@"Avenir Next Condensed"];
            break;
        case MARFamilyFontNameBaskerville:
            fontNames = [UIFont fontNamesForFamilyName:@"Baskerville"];
            break;
        case MARFamilyFontNameBodoni72:
            fontNames = [UIFont fontNamesForFamilyName:@"Bodoni 72"];
            break;
        case MARFamilyFontNameBodoni72Oldstyle:
            fontNames = [UIFont fontNamesForFamilyName:@"Bodoni 72 Oldstyle"];
            break;
        case MARFamilyFontNameBodoni72Smallcaps:
            fontNames = [UIFont fontNamesForFamilyName:@"Bodoni 72 Smallcaps"];
            break;
        case MARFamilyFontNameBodoniOrnaments:
            fontNames = [UIFont fontNamesForFamilyName:@"Bodoni Ornaments"];
            break;
        case MARFamilyFontNameBradleyHand:
            fontNames = [UIFont fontNamesForFamilyName:@"Bradley Hand"];
            break;
        case MARFamilyFontNameChalkboardSE:
            fontNames = [UIFont fontNamesForFamilyName:@"Chalkboard SE"];
            break;
        case MARFamilyFontNameChalkduster:
            fontNames = [UIFont fontNamesForFamilyName:@"Chalkduster"];
            break;
        case MARFamilyFontNameCochin:
            fontNames = [UIFont fontNamesForFamilyName:@"Cochin"];
            break;
        case MARFamilyFontNameCopperplate:
            fontNames = [UIFont fontNamesForFamilyName:@"Copperplate"];
            break;
        case MARFamilyFontNameCourier:
            fontNames = [UIFont fontNamesForFamilyName:@"Courier"];
            break;
        case MARFamilyFontNameCourierNew:
            fontNames = [UIFont fontNamesForFamilyName:@"Courier New"];
            break;
        case MARFamilyFontNameDamascus:
            fontNames = [UIFont fontNamesForFamilyName:@"Damascus"];
            break;
        case MARFamilyFontNameDevanagariSangamMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Devanagari Sangam MN"];
            break;
        case MARFamilyFontNameDidot:
            fontNames = [UIFont fontNamesForFamilyName:@"Didot"];
            break;
        case MARFamilyFontNameEuphemiaUCAS:
            fontNames = [UIFont fontNamesForFamilyName:@"Euphemia UCAS"];
            break;
        case MARFamilyFontNameFarah:
            fontNames = [UIFont fontNamesForFamilyName:@"Farah"];
            break;
        case MARFamilyFontNameFutura:
            fontNames = [UIFont fontNamesForFamilyName:@"Futura"];
            break;
        case MARFamilyFontNameGeezaPro:
            fontNames = [UIFont fontNamesForFamilyName:@"Geeza Pro"];
            break;
        case MARFamilyFontNameGeorgia:
            fontNames = [UIFont fontNamesForFamilyName:@"Georgia"];
            break;
        case MARFamilyFontNameGillSans:
            fontNames = [UIFont fontNamesForFamilyName:@"Gill Sans"];
            break;
        case MARFamilyFontNameGujaratiSangemMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Gujarati Sangam MN"];
            break;
        case MARFamilyFontNameGurmukhiMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Gurmukhi MN"];
            break;
        case MARFamilyFontNameHeitiSC:
            fontNames = [UIFont fontNamesForFamilyName:@"Heiti SC"];
            break;
        case MARFamilyFontNameHeitiTC:
            fontNames = [UIFont fontNamesForFamilyName:@"Heiti TC"];
            break;
        case MARFamilyFontNameHelvetica:
            fontNames = [UIFont fontNamesForFamilyName:@"Helvetica"];
            break;
        case MARFamilyFontNameHelveticaNeue:
            fontNames = [UIFont fontNamesForFamilyName:@"Helvetica Neue"];
            break;
        case MARFamilyFontNameHiraginoKakuGothicProN:
            fontNames = [UIFont fontNamesForFamilyName:@"Hiragino Kaku Gothic ProN"];
            break;
        case MARFamilyFontNameHiraginoMinchoProN:
            fontNames = [UIFont fontNamesForFamilyName:@"Hiragino Mincho ProN"];
            break;
        case MARFamilyFontNameHoeflerText:
            fontNames = [UIFont fontNamesForFamilyName:@"Hoefler Text"];
            break;
        case MARFamilyFontNameKailasa:
            fontNames = [UIFont fontNamesForFamilyName:@"Kailasa"];
            break;
        case MARFamilyFontNameKannadaSangamMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Kannada Sangam MN"];
            break;
        case MARFamilyFontNameKhmerSangamMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Khmer Sangam MN"];
            break;
        case MARFamilyFontNameKohinoorBangla:
            fontNames = [UIFont fontNamesForFamilyName:@"Kohinoor Bangla"];
            break;
        case MARFamilyFontNameKohinoorDevanagari:
            fontNames = [UIFont fontNamesForFamilyName:@"Kohinoor Devanagari"];
            break;
        case MARFamilyFontNameLaoSangamMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Lao Sangam MN"];
            break;
        case MARFamilyFontNameMalayamSangamMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Malayalam Sangam MN"];
            break;
        case MARFamilyFontNameMarkerFelt:
            fontNames = [UIFont fontNamesForFamilyName:@"Marker Felt"];
            break;
        case MARFamilyFontNameMenlo:
            fontNames = [UIFont fontNamesForFamilyName:@"Menlo"];
            break;
        case MARFamilyFontNameMishafi:
            fontNames = [UIFont fontNamesForFamilyName:@"Mishafi"];
            break;
        case MARFamilyFontNameNoteworthy:
            fontNames = [UIFont fontNamesForFamilyName:@"Noteworthy"];
            break;
        case MARFamilyFontNameOptima:
            fontNames = [UIFont fontNamesForFamilyName:@"Optima"];
            break;
        case MARFamilyFontNameOriyaSangemMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Oriya Sangam MN"];
            break;
        case MARFamilyFontNamePalatino:
            fontNames = [UIFont fontNamesForFamilyName:@"Palatino"];
            break;
        case MARFamilyFontNamePapyrus:
            fontNames = [UIFont fontNamesForFamilyName:@"Papyrus"];
            break;
        case MARFamilyFontNamePartyLET:
            fontNames = [UIFont fontNamesForFamilyName:@"Party LET"];
            break;
        case MARFamilyFontNameSavoyeLET:
            fontNames = [UIFont fontNamesForFamilyName:@"Savoye LET"];
            break;
        case MARFamilyFontNameSinhalaSangamMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Sinhala Sangam MN"];
            break;
        case MARFamilyFontNameSnellRoundhand:
            fontNames = [UIFont fontNamesForFamilyName:@"Snell Roundhand"];
            break;
        case MARFamilyFontNameSymbol:
            fontNames = [UIFont fontNamesForFamilyName:@"Symbol"];
            break;
        case MARFamilyFontNameTamilSangamMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Tamil Sangam MN"];
            break;
        case MARFamilyFontNameTeluguSangamMN:
            fontNames = [UIFont fontNamesForFamilyName:@"Telugu Sangam MN"];
            break;
        case MARFamilyFontNameThonburi:
            fontNames = [UIFont fontNamesForFamilyName:@"Thonburi"];
            break;
        case MARFamilyFontNameTimesNewRoman:
            fontNames = [UIFont fontNamesForFamilyName:@"Times New Roman"];
            break;
        case MARFamilyFontNameTrebuchetMS:
            fontNames = [UIFont fontNamesForFamilyName:@"Trebuchet MS"];
            break;
        case MARFamilyFontNameVerdana:
            fontNames = [UIFont fontNamesForFamilyName:@"Verdana"];
            break;
        case MARFamilyFontNameZapfDingBats:
            fontNames = [UIFont fontNamesForFamilyName:@"Zapf Dingbats"];
            break;
        case MARFamilyFontNameZapfino:
            fontNames = [UIFont fontNamesForFamilyName:@"Zapfino"];
            break;
    }
    
    NSLog(@"%@", fontNames);
    
    return fontNames;
}

+ (UIFont * _Nonnull)mar_fontForFontName:(MARFontName)fontName size:(CGFloat)fontSize {
    switch (fontName) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        case MARFontNameBanglaSangamMN:
            return [UIFont fontWithName:@"BanglaSangamMN" size:fontSize];
        case MARFontNameBanglaSangamMNBold:
            return [UIFont fontWithName:@"BanglaSangamMN-Bold" size:fontSize];
        case MARFontNameDINAlternateBold:
            return [UIFont fontWithName:@"DINAlternate-Bold" size:fontSize];
        case MARFontNameDINCondensedBold:
            return [UIFont fontWithName:@"DINCondensed-Bold" size:fontSize];
        case MARFontNameIowanOldStyleBold:
            return [UIFont fontWithName:@"IowanOldStyle-Bold" size:fontSize];
        case MARFontNameIowanOldStyleBoldItalic:
            return [UIFont fontWithName:@"IowanOldStyle-BoldItalic" size:fontSize];
        case MARFontNameIowanOldStyleItalic:
            return [UIFont fontWithName:@"IowanOldStyle-Italic" size:fontSize];
        case MARFontNameIowanOldStyleRoman:
            return [UIFont fontWithName:@"IowanOldStyle-Roman" size:fontSize];
        case MARFontNameMarionBold:
            return [UIFont fontWithName:@"Marion-Bold" size:fontSize];
        case MARFontNameMarionItalic:
            return [UIFont fontWithName:@"Marion-Italic" size:fontSize];
        case MARFontNameMarionRegular:
            return [UIFont fontWithName:@"Marion-Regular" size:fontSize];
        case MARFontNameSuperclarendonBlack:
            return [UIFont fontWithName:@"Superclarendon-Black" size:fontSize];
        case MARFontNameSuperclarendonBlackItalic:
            return [UIFont fontWithName:@"Superclarendon-BalckItalic" size:fontSize];
        case MARFontNameSuperclarendonBold:
            return [UIFont fontWithName:@"Superclarendon-Bold" size:fontSize];
        case MARFontNameSuperclarendonBoldItalic:
            return [UIFont fontWithName:@"Superclarendon-BoldItalic" size:fontSize];
        case MARFontNameSuperclarendonItalic:
            return [UIFont fontWithName:@"Superclarendon-Italic" size:fontSize];
        case MARFontNameSuperclarendonLight:
            return [UIFont fontWithName:@"Superclarendon-Light" size:fontSize];
        case MARFontNameSuperclarendonLightItalic:
            return [UIFont fontWithName:@"Superclarendon-LightItalic" size:fontSize];
        case MARFontNameSuperclarendonRegular:
            return [UIFont fontWithName:@"Superclarendon-Regular" size:fontSize];
#pragma clang diagnostic pop
        case MARFontNameAcademyEngravedLetPlain:
            return [UIFont fontWithName:@"AcademyEngravedLetPlain" size:fontSize];
        case MARFontNameAlNile:
            return [UIFont fontWithName:@"AlNile" size:fontSize];
        case MARFontNameAlNileBold:
            return [UIFont fontWithName:@"AlNile-Bold" size:fontSize];
        case MARFontNameAmericanTypewriter:
            return [UIFont fontWithName:@"AmericanTypewriter" size:fontSize];
        case MARFontNameAmericanTypewriterBold:
            return [UIFont fontWithName:@"AmericanTypewriter-Bold" size:fontSize];
        case MARFontNameAmericanTypewriterCondensed:
            return [UIFont fontWithName:@"AmericanTypewriter-Condensed" size:fontSize];
        case MARFontNameAmericanTypewriterCondensedBold:
            return [UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:fontSize];
        case MARFontNameAmericanTypewriterCondensedLight:
            return [UIFont fontWithName:@"AmericanTypewriter-CondensedLight" size:fontSize];
        case MARFontNameAmericanTypewriterLight:
            return [UIFont fontWithName:@"AmericanTypewriter-Light" size:fontSize];
        case MARFontNameAppleColorEmoji:
            return [UIFont fontWithName:@"AppleColorEmoji" size:fontSize];
        case MARFontNameAppleSDGothicNeoBold:
            return [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:fontSize];
        case MARFontNameAppleSDGothicNeoLight:
            return [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:fontSize];
        case MARFontNameAppleSDGothicNeoMedium:
            return [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:fontSize];
        case MARFontNameAppleSDGothicNeoRegular:
            return [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:fontSize];
        case MARFontNameAppleSDGothicNeoSemiBold:
            return [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:fontSize];
        case MARFontNameAppleSDGothicNeoThin:
            return [UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:fontSize];
        case MARFontNameAppleSDGothicNeoUltraLight:
            return [UIFont fontWithName:@"AppleSDGothicNeo-UltraLight" size:fontSize];
        case MARFontNameArialBoldItalicMT:
            return [UIFont fontWithName:@"Arial-BoldItalicMT" size:fontSize];
        case MARFontNameArialBoldMT:
            return [UIFont fontWithName:@"Arial-BoldMT" size:fontSize];
        case MARFontNameArialHebrew:
            return [UIFont fontWithName:@"ArialHebrew" size:fontSize];
        case MARFontNameArialHebrewBold:
            return [UIFont fontWithName:@"ArialHebrew-Bold" size:fontSize];
        case MARFontNameArialHebrewLight:
            return [UIFont fontWithName:@"ArialHebrew-Light" size:fontSize];
        case MARFontNameArialItalicMT:
            return [UIFont fontWithName:@"Arial-ItalicMT" size:fontSize];
        case MARFontNameArialMT:
            return [UIFont fontWithName:@"ArialMT" size:fontSize];
        case MARFontNameArialRoundedMTBold:
            return [UIFont fontWithName:@"ArialRoundedMTBold" size:fontSize];
        case MARFontNameASTHeitiLight:
            return [UIFont fontWithName:@"ASTHeiti-Light" size:fontSize];
        case MARFontNameASTHeitiMedium:
            return [UIFont fontWithName:@"ASTHeiti-Medium" size:fontSize];
        case MARFontNameAvenirBlack:
            return [UIFont fontWithName:@"Avenir-Black" size:fontSize];
        case MARFontNameAvenirBlackOblique:
            return [UIFont fontWithName:@"Avenir-BlackOblique" size:fontSize];
        case MARFontNameAvenirBook:
            return [UIFont fontWithName:@"Avenir-Book" size:fontSize];
        case MARFontNameAvenirBookOblique:
            return [UIFont fontWithName:@"Avenir-BookOblique" size:fontSize];
        case MARFontNameAvenirHeavyOblique:
            return [UIFont fontWithName:@"Avenir-HeavyOblique" size:fontSize];
        case MARFontNameAvenirHeavy:
            return [UIFont fontWithName:@"Avenir-Heavy" size:fontSize];
        case MARFontNameAvenirLight:
            return [UIFont fontWithName:@"Avenir-Light" size:fontSize];
        case MARFontNameAvenirLightOblique:
            return [UIFont fontWithName:@"Avenir-LightOblique" size:fontSize];
        case MARFontNameAvenirMedium:
            return [UIFont fontWithName:@"Avenir-Medium" size:fontSize];
        case MARFontNameAvenirMediumOblique:
            return [UIFont fontWithName:@"Avenir-MediumOblique" size:fontSize];
        case MARFontNameAvenirNextBold:
            return [UIFont fontWithName:@"AvenirNext-Bold" size:fontSize];
        case MARFontNameAvenirNextBoldItalic:
            return [UIFont fontWithName:@"AvenirNext-BoldItalic" size:fontSize];
        case MARFontNameAvenirNextCondensedBold:
            return [UIFont fontWithName:@"AvenirNextCondensed-Bold" size:fontSize];
        case MARFontNameAvenirNextCondensedBoldItalic:
            return [UIFont fontWithName:@"AvenirNextCondensed-BoldItalic" size:fontSize];
        case MARFontNameAvenirNextCondensedDemiBold:
            return [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:fontSize];
        case MARFontNameAvenirNextCondensedDemiBoldItalic:
            return [UIFont fontWithName:@"AvenirNextCondensed-DemiBoldItalic" size:fontSize];
        case MARFontNameAvenirNextCondensedHeavy:
            return [UIFont fontWithName:@"AvenirNextCondensed-Heavy" size:fontSize];
        case MARFontNameAvenirNextCondensedHeavyItalic:
            return [UIFont fontWithName:@"AvenirNextCondensed-HeavyItalic" size:fontSize];
        case MARFontNameAvenirNextCondensedItalic:
            return [UIFont fontWithName:@"AvenirNextCondensed-Italic" size:fontSize];
        case MARFontNameAvenirNextCondensedMedium:
            return [UIFont fontWithName:@"AvenirNextCondensed-Medium" size:fontSize];
        case MARFontNameAvenirNextCondensedMediumItalic:
            return [UIFont fontWithName:@"AvenirNextCondensed-MediumItalic" size:fontSize];
        case MARFontNameAvenirNextCondensedRegular:
            return [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:fontSize];
        case MARFontNameAvenirNextCondensedUltraLight:
            return [UIFont fontWithName:@"AvenirNextCondensed-UltraLight" size:fontSize];
        case MARFontNameAvenirNextCondensedUltraLightItalic:
            return [UIFont fontWithName:@"AvenirNextCondensed-UltraLightItalic" size:fontSize];
        case MARFontNameAvenirNextDemiBold:
            return [UIFont fontWithName:@"AvenirNext-DemiBold" size:fontSize];
        case MARFontNameAvenirNextDemiBoldItalic:
            return [UIFont fontWithName:@"AvenirNext-DemiBoldItalic" size:fontSize];
        case MARFontNameAvenirNextHeavy:
            return [UIFont fontWithName:@"AvenirNext-Heavy" size:fontSize];
        case MARFontNameAvenirNextItalic:
            return [UIFont fontWithName:@"AvenirNext-Italic" size:fontSize];
        case MARFontNameAvenirNextMedium:
            return [UIFont fontWithName:@"AvenirNext-Medium" size:fontSize];
        case MARFontNameAvenirNextMediumItalic:
            return [UIFont fontWithName:@"AvenirNext-MediumItalic" size:fontSize];
        case MARFontNameAvenirNextRegular:
            return [UIFont fontWithName:@"AvenirNext-Regular" size:fontSize];
        case MARFontNameAvenirNextUltraLight:
            return [UIFont fontWithName:@"AvenirNext-UltraLight" size:fontSize];
        case MARFontNameAvenirNextUltraLightItalic:
            return [UIFont fontWithName:@"AvenirNext-UltraLightItalic" size:fontSize];
        case MARFontNameAvenirOblique:
            return [UIFont fontWithName:@"Avenir-Oblique" size:fontSize];
        case MARFontNameAvenirRoman:
            return [UIFont fontWithName:@"Avenir-Roman" size:fontSize];
        case MARFontNameBaskerville:
            return [UIFont fontWithName:@"Baskerville" size:fontSize];
        case MARFontNameBaskervilleBold:
            return [UIFont fontWithName:@"Baskerville-Bold" size:fontSize];
        case MARFontNameBaskervilleBoldItalic:
            return [UIFont fontWithName:@"Baskerville-BoldItalic" size:fontSize];
        case MARFontNameBaskervilleItalic:
            return [UIFont fontWithName:@"Baskerville-Italic" size:fontSize];
        case MARFontNameBaskervilleSemiBold:
            return [UIFont fontWithName:@"Baskerville-SemiBold" size:fontSize];
        case MARFontNameBaskervilleSemiBoldItalic:
            return [UIFont fontWithName:@"Baskerville-SemiBoldItalic" size:fontSize];
        case MARFontNameBodoniOrnamentsITCTT:
            return [UIFont fontWithName:@"BodoniOrnamentsITCTT" size:fontSize];
        case MARFontNameBodoniSvtyTwoITCTTBold:
            return [UIFont fontWithName:@"BodoniSvtyTwoITCTT-Bold" size:fontSize];
        case MARFontNameBodoniSvtyTwoITCTTBook:
            return [UIFont fontWithName:@"BodoniSvtyTwoITCTT-Book" size:fontSize];
        case MARFontNameBodoniSvtyTwoITCTTBookIta:
            return [UIFont fontWithName:@"BodoniSvtyTwoITCTT-BookIta" size:fontSize];
        case MARFontNameBodoniSvtyTwoOSITCTTBold:
            return [UIFont fontWithName:@"BodoniSvtyTwoOSITCTT-Bold" size:fontSize];
        case MARFontNameBodoniSvtyTwoOSITCTTBook:
            return [UIFont fontWithName:@"BodoniSvtyTwoOSITCTT-Book" size:fontSize];
        case MARFontNameBodoniSvtyTwoOSITCTTBookIt:
            return [UIFont fontWithName:@"BodoniSvtyTwoOSITCTT-BookIt" size:fontSize];
        case MARFontNameBodoniSvtyTwoSCITCTTBook:
            return [UIFont fontWithName:@"BodoniSvtyTwoSCITCTT-Book" size:fontSize];
        case MARFontNameBradleyHandITCTTBold:
            return [UIFont fontWithName:@"BradleyHandITCTT-Bold" size:fontSize];
        case MARFontNameChalkboardSEBold:
            return [UIFont fontWithName:@"ChalkboardSE-Bold" size:fontSize];
        case MARFontNameChalkboardSELight:
            return [UIFont fontWithName:@"ChalkboardSE-Light" size:fontSize];
        case MARFontNameChalkboardSERegular:
            return [UIFont fontWithName:@"ChalkboardSE-Regular" size:fontSize];
        case MARFontNameChalkduster:
            return [UIFont fontWithName:@"Chalkduster" size:fontSize];
        case MARFontNameCochin:
            return [UIFont fontWithName:@"Cochin" size:fontSize];
        case MARFontNameCochinBold:
            return [UIFont fontWithName:@"Cochin-Bold" size:fontSize];
        case MARFontNameCochinBoldItalic:
            return [UIFont fontWithName:@"Cochin-BoldItalic" size:fontSize];
        case MARFontNameCochinItalic:
            return [UIFont fontWithName:@"Cochin-Italic" size:fontSize];
        case MARFontNameCopperplate:
            return [UIFont fontWithName:@"Copperplate" size:fontSize];
        case MARFontNameCopperplateBold:
            return [UIFont fontWithName:@"Copperplate-Bold" size:fontSize];
        case MARFontNameCopperplateLight:
            return [UIFont fontWithName:@"Copperplate-Light" size:fontSize];
        case MARFontNameCourier:
            return [UIFont fontWithName:@"Courier" size:fontSize];
        case MARFontNameCourierBold:
            return [UIFont fontWithName:@"Courier-Bold" size:fontSize];
        case MARFontNameCourierBoldOblique:
            return [UIFont fontWithName:@"Courier-BoldOblique" size:fontSize];
        case MARFontNameCourierNewPSBoldItalicMT:
            return [UIFont fontWithName:@"CourierNewPS-BoldItalicMT" size:fontSize];
        case MARFontNameCourierNewPSBoldMT:
            return [UIFont fontWithName:@"CourierNewPS-BoldMT" size:fontSize];
        case MARFontNameCourierNewPSItalicMT:
            return [UIFont fontWithName:@"CourierNewPS-ItalicMT" size:fontSize];
        case MARFontNameCourierNewPSMT:
            return [UIFont fontWithName:@"CourierNewPSMT" size:fontSize];
        case MARFontNameCourierOblique:
            return [UIFont fontWithName:@"Courier-Oblique" size:fontSize];
        case MARFontNameDamascus:
            return [UIFont fontWithName:@"Damascus" size:fontSize];
        case MARFontNameDamascusBold:
            return [UIFont fontWithName:@"DamascusBold" size:fontSize];
        case MARFontNameDamascusMedium:
            return [UIFont fontWithName:@"DamascusMedium" size:fontSize];
        case MARFontNameDamascusSemiBold:
            return [UIFont fontWithName:@"DamascusSemiBold" size:fontSize];
        case MARFontNameDevanagariSangamMN:
            return [UIFont fontWithName:@"DevanagariSangamMN" size:fontSize];
        case MARFontNameDevanagariSangamMNBold:
            return [UIFont fontWithName:@"DevanagariSangamMN-Bold" size:fontSize];
        case MARFontNameDidot:
            return [UIFont fontWithName:@"Didot" size:fontSize];
        case MARFontNameDidotBold:
            return [UIFont fontWithName:@"Didot-Bold" size:fontSize];
        case MARFontNameDidotItalic:
            return [UIFont fontWithName:@"Didot-Italic" size:fontSize];
        case MARFontNameDiwanMishafi:
            return [UIFont fontWithName:@"DiwanMishafi" size:fontSize];
        case MARFontNameEuphemiaUCAS:
            return [UIFont fontWithName:@"EuphemiaUCAS" size:fontSize];
        case MARFontNameEuphemiaUCASBold:
            return [UIFont fontWithName:@"EuphemiaUCAS-Bold" size:fontSize];
        case MARFontNameEuphemiaUCASItalic:
            return [UIFont fontWithName:@"EuphemiaUCAS-Italic" size:fontSize];
        case MARFontNameFarah:
            return [UIFont fontWithName:@"Farah" size:fontSize];
        case MARFontNameFuturaCondensedExtraBold:
            return [UIFont fontWithName:@"Futura-ExtraBold" size:fontSize];
        case MARFontNameFuturaCondensedMedium:
            return [UIFont fontWithName:@"Futura-CondensedMedium" size:fontSize];
        case MARFontNameFuturaMedium:
            return [UIFont fontWithName:@"Futura-Medium" size:fontSize];
        case MARFontNameFuturaMediumItalicm:
            return [UIFont fontWithName:@"Futura-MediumItalic" size:fontSize];
        case MARFontNameGeezaPro:
            return [UIFont fontWithName:@"GeezaPro" size:fontSize];
        case MARFontNameGeezaProBold:
            return [UIFont fontWithName:@"GeezaPro-Bold" size:fontSize];
        case MARFontNameGeezaProLight:
            return [UIFont fontWithName:@"GeezaPro-Light" size:fontSize];
        case MARFontNameGeorgia:
            return [UIFont fontWithName:@"Georgia" size:fontSize];
        case MARFontNameGeorgiaBold:
            return [UIFont fontWithName:@"Georgia-Bold" size:fontSize];
        case MARFontNameGeorgiaBoldItalic:
            return [UIFont fontWithName:@"Georgia-BoldItalic" size:fontSize];
        case MARFontNameGeorgiaItalic:
            return [UIFont fontWithName:@"Georgia-Italic" size:fontSize];
        case MARFontNameGillSans:
            return [UIFont fontWithName:@"GillSans" size:fontSize];
        case MARFontNameGillSansBold:
            return [UIFont fontWithName:@"GillSans-Bold" size:fontSize];
        case MARFontNameGillSansBoldItalic:
            return [UIFont fontWithName:@"GillSans-BoldItalic" size:fontSize];
        case MARFontNameGillSansItalic:
            return [UIFont fontWithName:@"GillSans-Italic" size:fontSize];
        case MARFontNameGillSansLight:
            return [UIFont fontWithName:@"GillSans-Light" size:fontSize];
        case MARFontNameGillSansLightItalic:
            return [UIFont fontWithName:@"GillSans-LightItalic" size:fontSize];
        case MARFontNameGujaratiSangamMN:
            return [UIFont fontWithName:@"GujaratiSangamMN" size:fontSize];
        case MARFontNameGujaratiSangamMNBold:
            return [UIFont fontWithName:@"GujaratiSangamMN-Bold" size:fontSize];
        case MARFontNameGurmukhiMN:
            return [UIFont fontWithName:@"GurmukhiMN" size:fontSize];
        case MARFontNameGurmukhiMNBold:
            return [UIFont fontWithName:@"GurmukhiMN-Bold" size:fontSize];
        case MARFontNameHelvetica:
            return [UIFont fontWithName:@"Helvetica" size:fontSize];
        case MARFontNameHelveticaBold:
            return [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
        case MARFontNameHelveticaBoldOblique:
            return [UIFont fontWithName:@"Helvetica-BoldOblique" size:fontSize];
        case MARFontNameHelveticaLight:
            return [UIFont fontWithName:@"Helvetica-Light" size:fontSize];
        case MARFontNameHelveticaLightOblique:
            return [UIFont fontWithName:@"Helvetica-LightOblique" size:fontSize];
        case MARFontNameHelveticaNeue:
            return [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
        case MARFontNameHelveticaNeueBold:
            return [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize];
        case MARFontNameHelveticaNeueBoldItalic:
            return [UIFont fontWithName:@"HelveticaNeue-BoldItalic" size:fontSize];
        case MARFontNameHelveticaNeueCondensedBlack:
            return [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:fontSize];
        case MARFontNameHelveticaNeueCondensedBold:
            return [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:fontSize];
        case MARFontNameHelveticaNeueItalic:
            return [UIFont fontWithName:@"HelveticaNeue-Italic" size:fontSize];
        case MARFontNameHelveticaNeueLight:
            return [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
        case MARFontNameHelveticaNeueMedium:
            return [UIFont fontWithName:@"HelveticaNeue-Medium" size:fontSize];
        case MARFontNameHelveticaNeueMediumItalic:
            return [UIFont fontWithName:@"HelveticaNeue-MediumItalic" size:fontSize];
        case MARFontNameHelveticaNeueThin:
            return [UIFont fontWithName:@"HelveticaNeue-Thin" size:fontSize];
        case MARFontNameHelveticaNeueThinItalic:
            return [UIFont fontWithName:@"HelveticaNeue-ThinItalic" size:fontSize];
        case MARFontNameHelveticaNeueUltraLight:
            return [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:fontSize];
        case MARFontNameHelveticaNeueUltraLightItalic:
            return [UIFont fontWithName:@"HelveticaNeue-UltraLightItalic" size:fontSize];
        case MARFontNameHelveticaOblique:
            return [UIFont fontWithName:@"Helvetica-Oblique" size:fontSize];
        case MARFontNameHiraKakuProNW3:
            return [UIFont fontWithName:@"HiraKakuProN-W3" size:fontSize];
        case MARFontNameHiraKakuProNW6:
            return [UIFont fontWithName:@"HiraKakuProN-W6" size:fontSize];
        case MARFontNameHiraMinProNW3:
            return [UIFont fontWithName:@"HiraMinProN-W3" size:fontSize];
        case MARFontNameHiraMinProNW6:
            return [UIFont fontWithName:@"HiraMinProN-W6" size:fontSize];
        case MARFontNameHoeflerTextBlack:
            return [UIFont fontWithName:@"HoeflerText-Black" size:fontSize];
        case MARFontNameHoeflerTextBlackItalic:
            return [UIFont fontWithName:@"HoeflerText-BlackItalic" size:fontSize];
        case MARFontNameHoeflerTextItalic:
            return [UIFont fontWithName:@"HoeflerText-Italic" size:fontSize];
        case MARFontNameHoeflerTextRegular:
            return [UIFont fontWithName:@"HoeflerText-Regular" size:fontSize];
        case MARFontNameKailasa:
            return [UIFont fontWithName:@"Kailasa" size:fontSize];
        case MARFontNameKailasaBold:
            return [UIFont fontWithName:@"Kailasa-Bold" size:fontSize];
        case MARFontNameKannadaSangamMN:
            return [UIFont fontWithName:@"KannadaSangamMN" size:fontSize];
        case MARFontNameKannadaSangamMNBold:
            return [UIFont fontWithName:@"KannadaSangamMN-Bold" size:fontSize];
        case MARFontNameKhmerSangamMN:
            return [UIFont fontWithName:@"KhmerSangamMN" size:fontSize];
        case MARFontNameKohinoorBanglaLight:
            return [UIFont fontWithName:@"KohinoorBangla-Light" size:fontSize];
        case MARFontNameKohinoorBanglaMedium:
            return [UIFont fontWithName:@"KohinoorBangla-Medium" size:fontSize];
        case MARFontNameKohinoorBanglaRegular:
            return [UIFont fontWithName:@"KohinoorBangla-Regular" size:fontSize];
        case MARFontNameKohinoorDevanagariLight:
            return [UIFont fontWithName:@"KohinoorDevanagari-Light" size:fontSize];
        case MARFontNameKohinoorDevanagariMedium:
            return [UIFont fontWithName:@"KohinoorDevanagari-Medium" size:fontSize];
        case MARFontNameKohinoorDevanagariBook:
            return [UIFont fontWithName:@"KohinoorDevanagari-Book" size:fontSize];
        case MARFontNameLaoSangamMN:
            return [UIFont fontWithName:@"LaoSangamMN" size:fontSize];
        case MARFontNameMalayalamSangamMN:
            return [UIFont fontWithName:@"MalayalamSangamMN" size:fontSize];
        case MARFontNameMalayalamSangamMNBold:
            return [UIFont fontWithName:@"MalayalamSangamMN-Bold" size:fontSize];
        case MARFontNameMarkerFeltThin:
            return [UIFont fontWithName:@"MarkerFelt-Thin" size:fontSize];
        case MARFontNameMarkerFeltWide:
            return [UIFont fontWithName:@"MarkerFelt-Wide" size:fontSize];
        case MARFontNameMenloBold:
            return [UIFont fontWithName:@"Menlo-Bold" size:fontSize];
        case MARFontNameMenloBoldItalic:
            return [UIFont fontWithName:@"Menlo-BoldItalic" size:fontSize];
        case MARFontNameMenloItalic:
            return [UIFont fontWithName:@"Menlo-Italic" size:fontSize];
        case MARFontNameMenloRegular:
            return [UIFont fontWithName:@"Menlo-Regular" size:fontSize];
        case MARFontNameNoteworthyBold:
            return [UIFont fontWithName:@"Noteworthy-Bold" size:fontSize];
        case MARFontNameNoteworthyLight:
            return [UIFont fontWithName:@"Noteworthy-Light" size:fontSize];
        case MARFontNameOptimaBold:
            return [UIFont fontWithName:@"Optima-Bold" size:fontSize];
        case MARFontNameOptimaBoldItalic:
            return [UIFont fontWithName:@"Optima-BoldItalic" size:fontSize];
        case MARFontNameOptimaExtraBlack:
            return [UIFont fontWithName:@"Optima-ExtraBold" size:fontSize];
        case MARFontNameOptimaItalic:
            return [UIFont fontWithName:@"Optima-Italic" size:fontSize];
        case MARFontNameOptimaRegular:
            return [UIFont fontWithName:@"Optima-Regular" size:fontSize];
        case MARFontNameOriyaSangamMN:
            return [UIFont fontWithName:@"OriyaSangamMN" size:fontSize];
        case MARFontNameOriyaSangamMNBold:
            return [UIFont fontWithName:@"OriyaSangamMN-Bold" size:fontSize];
        case MARFontNamePalatinoBold:
            return [UIFont fontWithName:@"Palatino-Bold" size:fontSize];
        case MARFontNamePalatinoBoldItalic:
            return [UIFont fontWithName:@"Palatino-BoldItalic" size:fontSize];
        case MARFontNamePalatinoItalic:
            return [UIFont fontWithName:@"Palatino-Italic" size:fontSize];
        case MARFontNamePalatinoRoman:
            return [UIFont fontWithName:@"Palatino-Roman" size:fontSize];
        case MARFontNamePapyrus:
            return [UIFont fontWithName:@"Papyrus" size:fontSize];
        case MARFontNamePapyrusCondensed:
            return [UIFont fontWithName:@"Papyrus-Condensed" size:fontSize];
        case MARFontNamePartyLetPlain:
            return [UIFont fontWithName:@"PartyLetPlain" size:fontSize];
        case MARFontNameSavoyeLetPlain:
            return [UIFont fontWithName:@"SavoyeLetPlain" size:fontSize];
        case MARFontNameSinhalaSangamMN:
            return [UIFont fontWithName:@"SinhalaSangamMN" size:fontSize];
        case MARFontNameSinhalaSangamMNBold:
            return [UIFont fontWithName:@"SinhalaSangamMN-Bold" size:fontSize];
        case MARFontNameSnellRoundhand:
            return [UIFont fontWithName:@"SnellRoundhand" size:fontSize];
        case MARFontNameSnellRoundhandBlack:
            return [UIFont fontWithName:@"SnellRoundhand-Black" size:fontSize];
        case MARFontNameSnellRoundhandBold:
            return [UIFont fontWithName:@"SnellRoundhand-Bold" size:fontSize];
        case MARFontNameSTHeitiSCLight:
            return [UIFont fontWithName:@"STHeitiSC-Light" size:fontSize];
        case MARFontNameSTHeitiSCMedium:
            return [UIFont fontWithName:@"STHeitiSC-Medium" size:fontSize];
        case MARFontNameSTHeitiTCLight:
            return [UIFont fontWithName:@"STHeitiTC-Light" size:fontSize];
        case MARFontNameSTHeitiTCMedium:
            return [UIFont fontWithName:@"STHeitiTC-Medium" size:fontSize];
        case MARFontNameSymbol:
            return [UIFont fontWithName:@"Symbol" size:fontSize];
        case MARFontNameTamilSangamMN:
            return [UIFont fontWithName:@"TamilSangamMN" size:fontSize];
        case MARFontNameTamilSangamMNBold:
            return [UIFont fontWithName:@"TamilSangamMN-Bold" size:fontSize];
        case MARFontNameTeluguSangamMN:
            return [UIFont fontWithName:@"TeluguSangamMN" size:fontSize];
        case MARFontNameTeluguSangamMNBold:
            return [UIFont fontWithName:@"TeluguSangamMN-Bold" size:fontSize];
        case MARFontNameThonburi:
            return [UIFont fontWithName:@"Thonburi" size:fontSize];
        case MARFontNameThonburiBold:
            return [UIFont fontWithName:@"Thonburi-Bold" size:fontSize];
        case MARFontNameThonburiLight:
            return [UIFont fontWithName:@"Thonburi-Light" size:fontSize];
        case MARFontNameTimesNewRomanPSBoldItalicMT:
            return [UIFont fontWithName:@"TimesNewRomanPS-BoldItalic" size:fontSize];
        case MARFontNameTimesNewRomanPSBoldMT:
            return [UIFont fontWithName:@"TimesNewRomanPS-Bold" size:fontSize];
        case MARFontNameTimesNewRomanPSItalicMT:
            return [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:fontSize];
        case MARFontNameTimesNewRomanPSMT:
            return [UIFont fontWithName:@"TimesNewRomanPSMT" size:fontSize];
        case MARFontNameTrebuchetBoldItalic:
            return [UIFont fontWithName:@"Trebuchet-BoldItalic" size:fontSize];
        case MARFontNameTrebuchetMS:
            return [UIFont fontWithName:@"TrebuchetMS" size:fontSize];
        case MARFontNameTrebuchetMSBold:
            return [UIFont fontWithName:@"TrebuchetMS-Bold" size:fontSize];
        case MARFontNameTrebuchetMSItalic:
            return [UIFont fontWithName:@"TrebuchetMS-Italic" size:fontSize];
        case MARFontNameVerdana:
            return [UIFont fontWithName:@"Verdana" size:fontSize];
        case MARFontNameVerdanaBold:
            return [UIFont fontWithName:@"Verdana-Bold" size:fontSize];
        case MARFontNameVerdanaBoldItalic:
            return [UIFont fontWithName:@"Verdana-BoldItalic" size:fontSize];
        case MARFontNameVerdanaItalic:
            return [UIFont fontWithName:@"Verdana-Italic" size:fontSize];
        case MARFontNameZapfDingbatsITC:
            return [UIFont fontWithName:@"ZapfDingbatsITC" size:fontSize];
        case MARFontNameZapfino:
            return [UIFont fontWithName:@"Zapfino" size:fontSize];
    }
}


@end
