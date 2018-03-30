//
//  NSData+MAREX_Type.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/19.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MobileCoreServices/UTCoreTypes.h>


extern const CFStringRef kUTTypeNotKnown;

extern NSString * const kMARFileDataTypeNotKnown;
extern NSString * const kMARFileDataType_rpm;               // RedHat Package Manager (RPM) package [1];   ed ab ee db
extern NSString * const kMARFileDataType_bin;               // Amazon Kindle Update Package;   53 50 30 31
extern NSString * const kMARFileDataType_pic_pif_sea_ytr;   // IBM Storyboard bitmap file;Windows Program Information File;Mac Stuffit Self-Extracting Archive;IRIS OCR data file; 00
extern NSString * const kMARFileDataType_pdb;               // PalmPilot Database/Document File
extern NSString * const kMARFileDataType_dba__CalendarArchive;  // Palm Desktop Calendar Archive
extern NSString * const kMARFileDataType_dba__NormalArchive;    // Palm Desktop To Do Archive
extern NSString * const kMARFileDataType_tda;               // Desktop Calendar Archive
extern NSString * const kMARFileDataTypePalmDestopFile;     // Palm Desktop Data File (Access format)
extern NSString * const kMARFileDataType_ico;               // Computer icon encoded in ICO file format[3]
extern NSString * const kMARFileDataType_3gp_3g2;           // ftyp3g ftyp 3g;[offset is 4 ?whether has space?]     3rd Generation Partnership Project 3GPP and 3GPP2 multimedia files
extern NSString * const kMARFileDataType_z_tarz;            // compressed file (often tar zip)using Lempel-Ziv-Welch algorithm
extern NSString * const kMARFileDataType_z_tarz__UsingLZHalgorithm;  // Compressed file (often tar zip); using LZH algorithm
extern NSString * const kMARFileDataType_bac;               // File or tape containing a backup done with AmiBack on an Amiga.It typically is paired with an index file (idx) with the table of contents.
extern NSString * const kMARFileDataType_bz2;               // Compressed file using Bzip2 algorithm
extern NSString * const kMARFileDataType_gif;               // Image file encoded in the Graphics Interchange Format (GIF)[4]
extern NSString * const kMARFileDataType_tif_tiff;          // Tagged Image File Format
extern NSString * const kMARFileDataType_cr2;               // Canon RAW Format Version 2[5] Canon's RAW format is based on the TIFF file format[6]
extern NSString * const kMARFileDataType_cin;               // Kodak Cineon image
extern NSString * const kMARFileDataTypeBobNorthenCompression;  // Compressed file using Rob Northen Compression (version 1 and 2) algorithm
extern NSString * const kMARFileDataType_dpx;               // SMPTE DPX image
extern NSString * const kMARFileDataType_exr;               // OpenEXR image
extern NSString * const kMARFileDataType_bpg;               // Better Portable Graphics format[7]
extern NSString * const kMARFileDataType_jpg_jpeg;          // JPEG raw or in the JFIF or Exif file format
extern NSString * const kMARFileDataType_ilbm_lbm_ibm_iff;  // FORM....ILBM;[offset is any?] IFF Interleaved Bitmap Image
extern NSString * const kMARFileDataType_8svx_8sv_svx_snd_iff;  // FORM....8SVX;[offset is any?] IFF 8-Bit Sampled Voice
extern NSString * const kMARFileDataType_acbm_iff;          // FORM....ACBM;[offset is any?] Amiga Contiguous Bitmap
extern NSString * const kMARFileDataType_anbm_iff;          // FORM....ANBM;[offset is any?] IFF Animated Bitmap
extern NSString * const kMARFileDataType_anim_iff;          // FORM....ANIM;[offset is any?] IFF CEL Animation
extern NSString * const kMARFileDataType_faxx_fax_iff;      // FORM....FAXX;[offset is any?] IFF Facsimile Image
extern NSString * const kMARFileDataType_ftxt_txt_iff;      // FORM....FTXT;[offset is any?] IFF Formatted Text
extern NSString * const kMARFileDataType_smus_smu_mus_iff;  // FORM....SMUS;[offset is any?] IFF Simple Musical Score
extern NSString * const kMARFileDataType_cmus_mus_iff;      // FORM....CMUS;[offset is any?] IFF Musical Score
extern NSString * const kMARFileDataType_yuvn_yuv_iff;      // FORM....YUVN;[offset is any?] IFF YUV Image
extern NSString * const kMARFileDataType_iff;               // FORM....FANT;[offset is any?] Amiga Fantavision Movie
extern NSString * const kMARFileDataType_aiff_aif_aifc_snd_iff; // FORM....AIFF;[offset is any?] Audio Interchange File Format
extern NSString * const kMARFileDataType_idx;               // Index file to a file or tape containing a backup done with AmiBack on an Amiga.
extern NSString * const kMARFileDataType_lz;                // lzip compressed file
extern NSString * const kMARFileDataType_exe;               // DOS MZ executable file format and its descendants (including NE and PE)
extern NSString * const kMARFileDataType_zip_jar_odt_ods_odp_docx_xlsx_pptx_vsdx_apk;   //zip file format and formats based on it, such as JAR, ODF, OOXML
extern NSString * const kMARFileDataType_rar__1_5;          // RAR archive version 1.50 onwards[8]
extern NSString * const kMARFileDataType_rar__5_0;          // RAR archive version 5.0 onwards[9]
extern NSString * const kMARFileDataTypeExecutableLinkableFormat;   // Executable and Linkable Format
extern NSString * const kMARFileDataType_png;               // Image encoded in the Portable Network Graphics format[10]
extern NSString * const kMARFileDataType_class;             // Java class file, Mach-O Fat Binary
extern NSString * const kMARFileDataTypeEncodedUnicode;     // UTF-8 encoded Unicode byte order mark, commonly seen in text files.
extern NSString * const kMARFileDataTypeMachOBinary32;      // Mach-O binary (32-bit)
extern NSString * const kMARFileDataTypeMachOBinary64;      // Mach-O binary (64-bit)
extern NSString * const kMARFileDataTypeMachOBinaryReverse32;   // Mach-O binary (reverse byte ordering scheme, 32-bit)[11]
extern NSString * const kMARFileDataTypeMachOBinaryReverse64;   // Mach-O binary (reverse byte ordering scheme, 64-bit)[11]
extern NSString * const kMARFileDataTypeEncoded16bitUnicode;    // Byte-order mark for text file encoded in little-endian 16-bit Unicode Transfer Format
extern NSString * const kMARFileDataTypeEncoded32bitUnicode;    // Byte-order mark for text file encoded in little-endian 32-bit Unicode Transfer Format
extern NSString * const kMARFileDataType_ps;                // PostScript document
extern NSString * const kMARFileDataType_pdf;               // PDF document
extern NSString * const kMARFileDataType_asf_wma_wmv;       // Advanced Systems Format[12]
extern NSString * const kMARFileDataTypeSystemDeploymentImage;  // System Deployment Image, a disk image format used by Microsoft
extern NSString * const kMARFileDataType_ogg_oga_ogv;       // Ogg, an open source media container format
extern NSString * const kMARFileDataType_psd;               // Photoshop Document file, Adobe Photoshop's native file format
extern NSString * const kMARFileDataType_wav;               // Waveform Audio File Format
extern NSString * const kMARFileDataType_avi;               // Audio Video Interleave video format
extern NSString * const kMARFileDataType_mp3;               // MPEG-1 Layer 3 file without an ID3 tag or with an ID3v1 tag (which's appended at the end of the file)
extern NSString * const kMARFileDataType_mp3__v2;             // MP3 file with an ID3v2 container
extern NSString * const kMARFileDataType_bmp_dib;           // BMP file, a bitmap format used mostly in the Windows world
extern NSString * const kMARFileDataType_iso;               // [offset is 0x8001 0x8801 0x9001?] ISO9660 CD/DVD image file[13]
extern NSString * const kMARFileDataType_fits;              // Flexible Image Transport System (FITS)[14]
extern NSString * const kMARFileDataType_flac;              // Free Lossless Audio Codec[15]
extern NSString * const kMARFileDataType_mid_midi;          // MIDI sound file[16]
extern NSString * const kMARFileDataType_doc_xls__ppt_msg_otheroffice; // Compound File Binary Format, a container format used for document by older versions of Microsoft Office.[17] It is however an open format used by other programs as well.
extern NSString * const kMARFileDataType_dex;               // Dalvik Executable
extern NSString * const kMARFileDataType_vmdk;              // VMDK files[18][19]
extern NSString * const kMARFileDataType_crx;               // Google Chrome extension[20] or packaged app[21]
extern NSString * const kMARFileDataType_fh8;               // FreeHand 8 document[22][23][24]
extern NSString * const kMARFileDataType_cwk__5;              // AppleWorks 5 document
extern NSString * const kMARFileDataType_cwk__6;              // AppleWorks 6 document
extern NSString * const kMARFileDataType_toast;             // Roxio Toast disc image file, also some .dmg-files begin with same bytes
extern NSString * const kMARFileDataType_dmg;               // Apple Disk Image file
extern NSString * const kMARFileDataType_xar;               // eXtensible ARchive format[25]
extern NSString * const kMARFileDataType_dat;               // Windows Files And Settings Transfer Repository[26] See also USMT 3.0 (Win XP)[27] and USMT 4.0 (Win 7)[28] User Guides
extern NSString * const kMARFileDataType_nes;               // Nintendo Entertainment System ROM file[29]
extern NSString * const kMARFileDataType_tar;               // tar archive[30]
extern NSString * const kMARFileDataType_tox;               // Open source portable voxel file[31]
extern NSString * const kMARFileDataType_MLV;               // Magic Lantern Video file[32]
extern NSString * const kMARFileDataTypeWindowsUpdateBinaryCompression; // Windows Update Binary Delta Compression[33]
extern NSString * const kMARFileDataType_7z;                // 7-Zip File Format
extern NSString * const kMARFileDataType_gz_targz;          // GZIP
extern NSString * const kMARFileDataType_lz4;               // LZ4 Frame Format[34] Remark: LZ4 block format does not offer any magic bytes.[35]
extern NSString * const kMARFileDataType_cab;               // Microsoft Cabinet file
extern NSString * const kMARFileDataType_Various;           // Various. (Replacing the last character of the original file extension with an underscore, e.g. setup.exe becomes setup.ex_) ; Microsoft compressed file in Quantum format, used prior to Windows XP. File can be decompressed using Extract.exe or Expand.exe distributed with earlier versions of Windows.
extern NSString * const kMARFileDataType_flif;              // Free Lossless Image Format
extern NSString * const kMARFileDataType_mkv_mka_mks_mk3d_webm; // Matroska media container, including WebM
extern NSString * const kMARFileDataType_stg;               // "SEAN : Session Analysis" Training file. Also used in compatible software "Rpw : Rowperfect for Windows" and "RP3W : ROWPERFECT3 for Windows".
extern NSString * const kMARFileDataType_djvu_djv;          // DjVu document The following byte is either 55 (U) for single-page or 4D (M) for multi-page documents.
extern NSString * const kMARFileDataType_der;               // DER encoded X.509 certificate
extern NSString * const kMARFileDataType_dcm;               // DICOM Medical File Format
extern NSString * const kMARFileDataType_woff;              // WOFF File Format 1.0
extern NSString * const kMARFileDataType_woff2;             // WOFF File Format 2.0
extern NSString * const kMARFileDataType_XML;               // XML (ASCII) eXtensible Markup Language when using the ASCII character encoding
extern NSString * const kMARFileDataType_wasm;              // WebAssembly binary format[36]
extern NSString * const kMARFileDataType_lep;               // Lepton compressed JPEG image[37]
extern NSString * const kMARFileDataType_swf;               // flash .swf
extern NSString * const kMARFileDataType_deb;               // linux deb file
extern NSString * const kMARFileDataType_webp;              // Google WebP image file
extern NSString * const kMARFileDataTypeUBootOrUImage;      // U-Boot / uImage. Das U-Boot Universal Boot Loader.[38]

/*
 This category is in order to determine the file type
 reference magic number list https://en.wikipedia.org/wiki/List_of_file_signatures
 */
@interface NSData (MAREX_Type)

- (NSString *)mar_dataType;

- (BOOL)mar_isTypeMatchMagicNumber:(NSString *)magicNumber;

@end
