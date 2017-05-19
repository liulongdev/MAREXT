//
//  NSData+MAREX_Type.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/19.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "NSData+MAREX_Type.h"
#import "NSData+MAREX.h"

const CFStringRef kUTTypeNotKnown = (__bridge CFStringRef)@"kUTTypeNotKnown";

NSString * const kMARFileDataTypeNotKnown               = @"kMARFileDataTypeNotKnown";
NSString * const kMARFileDataType_rpm                   = @"kMARFileDataType_rpm";
NSString * const kMARFileDataType_bin                   = @"kMARFileDataType_bin";
NSString * const kMARFileDataType_pic_pif_sea_ytr       = @"kMARFileDataType_pic_pif_sea_ytr";
NSString * const kMARFileDataType_pdb                   = @"kMARFileDataType_pdb";
NSString * const kMARFileDataType_dba__CalendarArchive  = @"kMARFileDataType_dba__CalendarArchive";
NSString * const kMARFileDataType_dba__NormalArchive    = @"kMARFileDataType_dba__NormalArchive";
NSString * const kMARFileDataType_tda                   = @"kMARFileDataType_tda";
NSString * const kMARFileDataTypePalmDestopFile         = @"kMARFileDataTypePalmDestopFile";
NSString * const kMARFileDataType_ico                   = @"kMARFileDataType_ico";
NSString * const kMARFileDataType_3gp_3g2               = @"kMARFileDataType_3gp_3g2";
NSString * const kMARFileDataType_z_tarz                = @"kMARFileDataType_z_tarz";
NSString * const kMARFileDataType_z_tarz__UsingLZHalgorithm = @"kMARFileDataType_z_tarz__UsingLZHalgorithm";
NSString * const kMARFileDataType_bac                   = @"kMARFileDataType_bac";
NSString * const kMARFileDataType_bz2                   = @"kMARFileDataType_bz2";
NSString * const kMARFileDataType_gif                   = @"kMARFileDataType_gif";
NSString * const kMARFileDataType_tif_tiff              = @"kMARFileDataType_tif_tiff";
NSString * const kMARFileDataType_cr2                   = @"kMARFileDataType_cr2";
NSString * const kMARFileDataType_cin                   = @"kMARFileDataType_cin";
NSString * const kMARFileDataTypeBobNorthenCompression  = @"kMARFileDataTypeBobNorthenCompression";
NSString * const kMARFileDataType_dpx                   = @"kMARFileDataType_dpx";
NSString * const kMARFileDataType_exr                   = @"kMARFileDataType_exr";
NSString * const kMARFileDataType_bpg                   = @"kMARFileDataType_bpg";
NSString * const kMARFileDataType_jpg_jpeg              = @"kMARFileDataType_jpg_jpeg";
NSString * const kMARFileDataType_ilbm_lbm_ibm_iff      = @"kMARFileDataType_ilbm_lbm_ibm_iff";
NSString * const kMARFileDataType_8svx_8sv_svx_snd_iff  = @"kMARFileDataType_8svx_8sv_svx_snd_iff";
NSString * const kMARFileDataType_acbm_iff              = @"kMARFileDataType_acbm_iff";
NSString * const kMARFileDataType_anbm_iff              = @"kMARFileDataType_anbm_iff";
NSString * const kMARFileDataType_anim_iff              = @"kMARFileDataType_anim_iff";
NSString * const kMARFileDataType_faxx_fax_iff          = @"kMARFileDataType_faxx_fax_iff";
NSString * const kMARFileDataType_ftxt_txt_iff          = @"kMARFileDataType_ftxt_txt_iff";
NSString * const kMARFileDataType_smus_smu_mus_iff      = @"kMARFileDataType_smus_smu_mus_iff";
NSString * const kMARFileDataType_cmus_mus_iff          = @"kMARFileDataType_cmus_mus_iff";
NSString * const kMARFileDataType_yuvn_yuv_iff          = @"kMARFileDataType_yuvn_yuv_iff";
NSString * const kMARFileDataType_iff                   = @"kMARFileDataType_iff";
NSString * const kMARFileDataType_aiff_aif_aifc_snd_iff = @"kMARFileDataType_aiff_aif_aifc_snd_iff";
NSString * const kMARFileDataType_idx                   = @"kMARFileDataType_idx";
NSString * const kMARFileDataType_lz                    = @"kMARFileDataType_lz";
NSString * const kMARFileDataType_exe                   = @"kMARFileDataType_exe";
NSString * const kMARFileDataType_zip_jar_odt_ods_odp_docx_xlsx_pptx_vsdx_apk   = @"kMARFileDataType_zip_jar_odt_ods_odp_docx_xlsx_pptx_vsdx_apk";
NSString * const kMARFileDataType_rar__1_5              = @"kMARFileDataType_rar__1_5";
NSString * const kMARFileDataType_rar__5_0              = @"kMARFileDataType_rar__5_0";
NSString * const kMARFileDataTypeExecutableLinkableFormat   = @"kMARFileDataTypeExecutableLinkableFormat";
NSString * const kMARFileDataType_png                   = @"kMARFileDataType_png";
NSString * const kMARFileDataType_class                 = @"kMARFileDataType_class";
NSString * const kMARFileDataTypeEncodedUnicode         = @"kMARFileDataTypeEncodedUnicode";
NSString * const kMARFileDataTypeMachOBinary32          = @"kMARFileDataTypeMachOBinary32";
NSString * const kMARFileDataTypeMachOBinary64          = @"kMARFileDataTypeMachOBinary64";
NSString * const kMARFileDataTypeMachOBinaryReverse32   = @"kMARFileDataTypeMachOBinaryReverse32";
NSString * const kMARFileDataTypeMachOBinaryReverse64   = @"kMARFileDataTypeMachOBinaryReverse64";
NSString * const kMARFileDataTypeEncoded16bitUnicode    = @"kMARFileDataTypeEncoded16bitUnicode";
NSString * const kMARFileDataTypeEncoded32bitUnicode    = @"kMARFileDataTypeEncoded32bitUnicode";
NSString * const kMARFileDataType_ps                    = @"kMARFileDataType_ps";
NSString * const kMARFileDataType_pdf                   = @"kMARFileDataType_pdf";
NSString * const kMARFileDataType_asf_wma_wmv           = @"kMARFileDataType_asf_wma_wmv";
NSString * const kMARFileDataTypeSystemDeploymentImage  = @"kMARFileDataTypeSystemDeploymentImage";
NSString * const kMARFileDataType_ogg_oga_ogv           = @"kMARFileDataType_ogg_oga_ogv";
NSString * const kMARFileDataType_psd                   = @"kMARFileDataType_psd";
NSString * const kMARFileDataType_wav                   = @"kMARFileDataType_wav";
NSString * const kMARFileDataType_avi                   = @"kMARFileDataType_avi";
NSString * const kMARFileDataType_mp3                   = @"kMARFileDataType_mp3";
NSString * const kMARFileDataType_mp3__v2                 = @"kMARFileDataType_mp3v2";
NSString * const kMARFileDataType_bmp_dib               = @"kMARFileDataType_bmp_dib";
NSString * const kMARFileDataType_iso                   = @"kMARFileDataType_iso";
NSString * const kMARFileDataType_fits                  = @"kMARFileDataType_fits";
NSString * const kMARFileDataType_flac                  = @"kMARFileDataType_flac";
NSString * const kMARFileDataType_mid_midi              = @"kMARFileDataType_mid_midi";
NSString * const kMARFileDataType_doc_xls__ppt_msg_otheroffice  = @"kMARFileDataType_doc_xls__ppt_msg_otheroffice";
NSString * const kMARFileDataType_dex                   = @"kMARFileDataType_dex";
NSString * const kMARFileDataType_vmdk                  = @"kMARFileDataType_vmdk";
NSString * const kMARFileDataType_crx                   = @"kMARFileDataType_crx";
NSString * const kMARFileDataType_fh8                   = @"kMARFileDataType_fh8";
NSString * const kMARFileDataType_cwk__5                = @"kMARFileDataType_cwk__5";
NSString * const kMARFileDataType_cwk__6                = @"kMARFileDataType_cwk__6";
NSString * const kMARFileDataType_toast                 = @"kMARFileDataType_toast";
NSString * const kMARFileDataType_dmg                   = @"kMARFileDataType_dmg";
NSString * const kMARFileDataType_xar                   = @"kMARFileDataType_xar";
NSString * const kMARFileDataType_dat                   = @"kMARFileDataType_dat";
NSString * const kMARFileDataType_nes                   = @"kMARFileDataType_nes";
NSString * const kMARFileDataType_tar                   = @"kMARFileDataType_tar";
NSString * const kMARFileDataType_tox                   = @"kMARFileDataType_tox";
NSString * const kMARFileDataType_MLV                   = @"kMARFileDataType_MLV";
NSString * const kMARFileDataTypeWindowsUpdateBinaryCompression = @"kMARFileDataTypeWindowsUpdateBinaryCompression";
NSString * const kMARFileDataType_7z                    = @"kMARFileDataType_7z";
NSString * const kMARFileDataType_gz_targz              = @"kMARFileDataType_gz_targz";
NSString * const kMARFileDataType_lz4                   = @"kMARFileDataType_lz4";
NSString * const kMARFileDataType_cab                   = @"kMARFileDataType_cab";
NSString * const kMARFileDataType_Various               = @"kMARFileDataType_Various";
NSString * const kMARFileDataType_flif                  = @"kMARFileDataType_flif";
NSString * const kMARFileDataType_mkv_mka_mks_mk3d_webm = @"kMARFileDataType_mkv_mka_mks_mk3d_webm";
NSString * const kMARFileDataType_stg                   = @"kMARFileDataType_stg";
NSString * const kMARFileDataType_djvu_djv              = @"kMARFileDataType_djvu_djv";
NSString * const kMARFileDataType_der                   = @"kMARFileDataType_der";
NSString * const kMARFileDataType_dcm                   = @"kMARFileDataType_dcm";
NSString * const kMARFileDataType_woff                  = @"kMARFileDataType_woff";
NSString * const kMARFileDataType_woff2                 = @"kMARFileDataType_woff2";
NSString * const kMARFileDataType_XML                   = @"kMARFileDataType_XML";
NSString * const kMARFileDataType_wasm                  = @"kMARFileDataType_wasm";
NSString * const kMARFileDataType_lep                   = @"kMARFileDataType_lep";
NSString * const kMARFileDataType_swf                   = @"kMARFileDataType_swf";
NSString * const kMARFileDataType_deb                   = @"kMARFileDataType_deb";
NSString * const kMARFileDataType_webp                  = @"kMARFileDataType_webp";
NSString * const kMARFileDataTypeUBootOrUImage          = @"kMARFileDataTypeUBootOrUImage";

@implementation NSData (MAREX_Type)

static NSDictionary *typeDiac;

- (NSDictionary *)mar_specialTypeDic
{
    static NSDictionary *specialTypeDic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        specialTypeDic = @{
                          kMARFileDataType_pic_pif_sea_ytr       : @[@"00"]
                          };
    });
    return specialTypeDic;
}

- (NSDictionary *)mar_typeDic
{
    static NSDictionary *typeDic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        typeDic = @{
                    kMARFileDataType_rpm                   : @[@"ed ab ee db"],
                    kMARFileDataType_bin                   : @[@"53 50 30 31"],
// may be cover kMARFileDataType_pdb、kMARFileDataType_dba__NormalArchive、kMARFileDataType_tda、kMARFileDataTypePalmDestopFile、kMARFileDataType_ico so need handle alone
//                    kMARFileDataType_pic_pif_sea_ytr       : @[@"00"],
                    kMARFileDataType_pdb                   : @[@"00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00"],
                    kMARFileDataType_dba__CalendarArchive  : @[@"BE BA FE CA"],
                    kMARFileDataType_dba__NormalArchive    : @[@"00 01 42 44"],
                    kMARFileDataType_tda                   : @[@"00 01 44 54"],
                    kMARFileDataTypePalmDestopFile         : @[@"00 01 00 00"],
                    kMARFileDataType_ico                   : @[@"00 00 01 00"],
                    kMARFileDataType_3gp_3g2               : @[@"66 74 79 70 33 67"],
                    kMARFileDataType_z_tarz                : @[@"1F 9D"],
                    kMARFileDataType_z_tarz__UsingLZHalgorithm : @[@"1F A0"],
                    kMARFileDataType_bac                   : @[@"42 41 43 4B 4D 49 4B 45 44 49 53 4B"],
                    kMARFileDataType_bz2                   : @[@"42 5A 68"],
                    kMARFileDataType_gif                   : @[@"47 49 46 38 37 61", @"47 49 46 38 37 61"],
                    kMARFileDataType_tif_tiff              : @[@"49 49 2A 00", @"4D 4D 00 2A"],
                    kMARFileDataType_cr2                   : @[@"49 49 2A 00 10 00 00 00 43 52"],
                    kMARFileDataType_cin                   : @[@"80 2A 5F D7"],
                    kMARFileDataTypeBobNorthenCompression  : @[@"52 4E 43 01", @"52 4E 43 02"],
                    kMARFileDataType_dpx                   : @[@"53 44 50 58", @"58 50 44 53"],
                    kMARFileDataType_exr                   : @[@"76 2F 31 01"],
                    kMARFileDataType_bpg                   : @[@"42 50 47 FB"],
                    kMARFileDataType_jpg_jpeg              : @[@"FF D8 FF DB", @"FF D8 FF E0 nn nn 4A 46 49 46 00 01", @"FF D8 FF E1 nn nn 45 78 69 66 00 00"],
                    kMARFileDataType_ilbm_lbm_ibm_iff      : @[@"46 4F 52 4D nn nn nn nn 49 4C 42 4D"],
                    kMARFileDataType_8svx_8sv_svx_snd_iff  : @[@"46 4F 52 4D nn nn nn nn 38 53 56 58"],
                    kMARFileDataType_acbm_iff              : @[@"46 4F 52 4D nn nn nn nn 41 43 42 4D"],
                    kMARFileDataType_anbm_iff              : @[@"46 4F 52 4D nn nn nn nn 41 4E 42 4D"],
                    kMARFileDataType_anim_iff              : @[@"46 4F 52 4D nn nn nn nn 41 4E 49 4D"],
                    kMARFileDataType_faxx_fax_iff          : @[@"46 4F 52 4D nn nn nn nn 46 41 58 58"],
                    kMARFileDataType_ftxt_txt_iff          : @[@"46 4F 52 4D nn nn nn nn 46 54 58 54"],
                    kMARFileDataType_smus_smu_mus_iff      : @[@"46 4F 52 4D nn nn nn nn 53 4D 55 53"],
                    kMARFileDataType_cmus_mus_iff          : @[@"46 4F 52 4D nn nn nn nn 43 4D 55 53"],
                    kMARFileDataType_yuvn_yuv_iff          : @[@"46 4F 52 4D nn nn nn nn 59 55 56 4E"],
                    kMARFileDataType_iff                   : @[@"46 4F 52 4D nn nn nn nn 46 41 4E 54"],
                    kMARFileDataType_aiff_aif_aifc_snd_iff : @[@"46 4F 52 4D nn nn nn nn 41 49 46 46"],
                    kMARFileDataType_idx                   : @[@"49 4E 44 58"],
                    kMARFileDataType_lz                    : @[@"4C 5A 49 50"],
                    kMARFileDataType_exe                   : @[@"4D 5A"],
                    kMARFileDataType_zip_jar_odt_ods_odp_docx_xlsx_pptx_vsdx_apk   : @[@"50 4B 03 04", @"50 4B 05 06", @"50 4B 07 08"],
                    kMARFileDataType_rar__1_5              : @[@"52 61 72 21 1A 07 00"],
                    kMARFileDataType_rar__5_0              : @[@"52 61 72 21 1A 07 01 00"],
                    kMARFileDataTypeExecutableLinkableFormat : @[@"7F 45 4C 46"],
                    kMARFileDataType_png                   : @[@"89 50 4E 47 0D 0A 1A 0A"],
                    kMARFileDataType_class                 : @[@"CA FE BA BE"],
                    kMARFileDataTypeEncodedUnicode         : @[@"EF BB BF"],
                    kMARFileDataTypeMachOBinary32          : @[@"FE ED FA CE"],
                    kMARFileDataTypeMachOBinary64          : @[@"FE ED FA CF"],
                    kMARFileDataTypeMachOBinaryReverse32   : @[@"CE FA ED FE"],
                    kMARFileDataTypeMachOBinaryReverse64   : @[@"CF FA ED FE"],
                    kMARFileDataTypeEncoded16bitUnicode    : @[@"FF FE"],
                    kMARFileDataTypeEncoded32bitUnicode    : @[@"FF FE 00 00"],
                    kMARFileDataType_ps                    : @[@"25 21 50 53"],
                    kMARFileDataType_pdf                   : @[@"25 50 44 46"],
                    kMARFileDataType_asf_wma_wmv           : @[@"30 26 B2 75 8E 66 CF 11 A6 D9 00 AA 00 62 CE 6C"],
                    kMARFileDataTypeSystemDeploymentImage  : @[@"24 53 44 49 30 30 30 31"],
                    kMARFileDataType_ogg_oga_ogv           : @[@"4F 67 67 53"],
                    kMARFileDataType_psd                   : @[@"38 42 50 53"],
                    kMARFileDataType_wav                   : @[@"52 49 46 46 nn nn nn nn 57 41 56 45"],
                    kMARFileDataType_avi                   : @[@"52 49 46 46 nn nn nn nn 41 56 49 20"],
                    kMARFileDataType_mp3                   : @[@"FF FB"],
                    kMARFileDataType_mp3__v2               : @[@"49 44 33"],
                    kMARFileDataType_bmp_dib               : @[@"42 4D"],
                    kMARFileDataType_iso                   : @[@"43 44 30 30 31"],
                    kMARFileDataType_fits                  : @[@"53 49 4D 50 4C 45 20 20", @"3D 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 54"],
                    kMARFileDataType_flac                  : @[@"66 4C 61 43"],
                    kMARFileDataType_mid_midi              : @[@"4D 54 68 64"],
                    kMARFileDataType_doc_xls__ppt_msg_otheroffice  : @[@"D0 CF 11 E0 A1 B1 1A E1"],
                    kMARFileDataType_dex                   : @[@"64 65 78 0A 30 33 35 00"],
                    kMARFileDataType_vmdk                  : @[@"4B 44 4D"],
                    kMARFileDataType_crx                   : @[@"43 72 32 34"],
                    kMARFileDataType_fh8                   : @[@"41 47 44 33"],
                    kMARFileDataType_cwk__5                : @[@"05 07 00 00 42 4F 42 4F 05 07 00 00 00 00 00 00 00 00 00 00 00 01"],
                    kMARFileDataType_cwk__6                : @[@"06 07 E1 00 42 4F 42 4F 06 07 E1 00 00 00 00 00 00 00 00 00 00 01"],
                    kMARFileDataType_toast                 : @[@"45 52 02 00 00 00", @"8B 45 52 02 00 00 00"],
                    kMARFileDataType_dmg                   : @[@"78 01 73 0D 62 62 60"],
                    kMARFileDataType_xar                   : @[@"78 61 72 21"],
                    kMARFileDataType_dat                   : @[@"50 4D 4F 43 43 4D 4F 43"],
                    kMARFileDataType_nes                   : @[@"4E 45 53 1A"],
                    kMARFileDataType_tar                   : @[@"75 73 74 61 72 00 30 30", @"75 73 74 61 72 20 20 00"],
                    kMARFileDataType_tox                   : @[@"74 6F 78 33"],
                    kMARFileDataType_MLV                   : @[@"4D 4C 56 49"],
                    kMARFileDataTypeWindowsUpdateBinaryCompression : @[@"44 43 4D 01 50 41 33 30"],
                    kMARFileDataType_7z                    : @[@"37 7A BC AF 27 1C"],
                    kMARFileDataType_gz_targz              : @[@"1F 8B"],
                    kMARFileDataType_lz4                   : @[@"04 22 4D 18"],
                    kMARFileDataType_cab                   : @[@"4D 53 43 46"],
                    kMARFileDataType_Various               : @[@"53 5A 44 44 88 F0 27 33"],
                    kMARFileDataType_flif                  : @[@"46 4C 49 46"],
                    kMARFileDataType_mkv_mka_mks_mk3d_webm : @[@"1A 45 DF A3"],
                    kMARFileDataType_stg                   : @[@"4D 49 4C 20"],
                    kMARFileDataType_djvu_djv              : @[@"41 54 26 54 46 4F 52 4D nn nn nn nn 44 4A 56"],
                    kMARFileDataType_der                   : @[@"30 82"],
                    kMARFileDataType_dcm                   : @[@"44 49 43 4D"],
                    kMARFileDataType_woff                  : @[@"77 4F 46 46"],
                    kMARFileDataType_woff2                 : @[@"77 4F 46 32"],
                    kMARFileDataType_XML                   : @[@"3c 3f 78 6d 6c 20"],
                    kMARFileDataType_wasm                  : @[@"6d 73 61 00"],
                    kMARFileDataType_lep                   : @[@"cf 84 01"],
                    kMARFileDataType_swf                   : @[@"43 57 53 46 57 53"],
                    kMARFileDataType_deb                   : @[@"21 3C 61 72 63 68 3E"],
                    kMARFileDataType_webp                  : @[@"52 49 46 46 nn nn nn nn 57 45 42 50"],
                    kMARFileDataTypeUBootOrUImage          : @[@"27 05 19 56"]
                    };
    });
    return typeDic;
}

- (NSString *)mar_dataType
{
    NSString *dataType = kMARFileDataTypeNotKnown;
    for (NSString *key in [self mar_typeDic]) {
        NSArray *array = [self mar_typeDic][key];
        for (NSString *magicNumber in array) {
            if ([self mar_isTypeMatchMagicNumber:magicNumber]) {
                dataType = key;
                break;
            }
        }
    }
    if ([dataType isEqualToString:kMARFileDataTypeNotKnown]) {
        for (NSString *key in [self mar_specialTypeDic]) {
            NSArray *array = [self mar_specialTypeDic][key];
            for (NSString *magicNumber in array) {
                if ([self mar_isTypeMatchMagicNumber:magicNumber]) {
                    dataType = key;
                    break;
                }
            }
        }
    }
    return dataType;
}

- (BOOL)mar_isTypeMatchMagicNumber:(NSString *)magicNumber
{
    if (!([magicNumber isKindOfClass:[NSString class]] && magicNumber.length > 0)) {
        NSLog(@"error Magic Number is Wrong");
        return NO;
    }
    magicNumber = [magicNumber uppercaseString];
    NSInteger length = (magicNumber.length + 1)/3;
    if (self.length >= length)
    {
        NSRange subRange = NSMakeRange(0, length);
        NSString *thisMagicNumber = [[self subdataWithRange:subRange] p_mar_hexUppercaseStringAddSpace];
        return [thisMagicNumber isEqualToString:magicNumber];
    }
    return NO;
}

- (NSString *)p_mar_hexUppercaseStringAddSpace
{
    NSUInteger length = self.length;
    NSMutableString *result = [NSMutableString stringWithCapacity:length * 2];
    const unsigned char *bytes = self.bytes;
    for (int i = 0; i < length; i++, bytes++) {
        if (i == length - 1) {
            [result appendFormat:@"%02X", *bytes];
        }
        else
            [result appendFormat:@"%02X ", *bytes];
    }
    return result;
}


@end
