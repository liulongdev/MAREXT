//
//  NSFileManager+MAREX.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/18.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "NSFileManager+MAREX.h"

#ifndef APPDisplayName
#define APPDisplayName          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#endif
@implementation NSFileManager (MAREX)

+ (NSString * _Nullable)mar_readTextFile:(NSString * _Nonnull)file ofType:(NSString * _Nonnull)type {
    return [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:type] encoding:NSUTF8StringEncoding error:nil];
}

+ (BOOL)mar_saveArrayToPath:(MARDirectoryType)path withFilename:(NSString * _Nonnull)fileName array:(NSArray * _Nonnull)array {
    NSString *_path;
    
    switch (path) {
        case MARDirectoryTypeMainBundle:
            _path = [self mar_getBundlePathForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case MARDirectoryTypeLibrary:
            _path = [self mar_getLibraryDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case MARDirectoryTypeDocuments:
            _path = [self mar_getDocumentsDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case MARDirectoryTypeCache:
            _path = [self mar_getCacheDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
    }
    
    return [NSKeyedArchiver archiveRootObject:array toFile:_path];
}

+ (NSArray * _Nullable)mar_loadArrayFromPath:(MARDirectoryType)path withFilename:(NSString * _Nonnull)fileName {
    NSString *_path;
    
    switch (path) {
        case MARDirectoryTypeMainBundle:
            _path = [self mar_getBundlePathForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case MARDirectoryTypeLibrary:
            _path = [self mar_getLibraryDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case MARDirectoryTypeDocuments:
            _path = [self mar_getDocumentsDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case MARDirectoryTypeCache:
            _path = [self mar_getCacheDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
    }
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:_path];
}

+ (NSString * _Nonnull)mar_getBundlePathForFile:(NSString * _Nonnull)fileName {
    NSString *fileExtension = [fileName pathExtension];
    return [[NSBundle mainBundle] pathForResource:[fileName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@", fileExtension] withString:@""] ofType:fileExtension];
}

+ (NSString *)mar_documentsDirectoryPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString * _Nonnull)mar_getDocumentsDirectoryForFile:(NSString * _Nonnull)fileName {
    NSString *documentsDirectory = [self mar_documentsDirectoryPath];
    return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/", fileName]];
}

+ (NSString *)mar_libraryDirectoryPath
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString * _Nonnull)mar_getLibraryDirectoryForFile:(NSString * _Nonnull)fileName {
    NSString *libraryDirectory = [self mar_libraryDirectoryPath];
    return [libraryDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/", fileName]];
}

+ (NSString *)mar_cacheDirectoryPath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];;
}

+ (NSString * _Nonnull)mar_getCacheDirectoryForFile:(NSString * _Nonnull)fileName {
    NSString *cacheDirectory = [self mar_cacheDirectoryPath];
    return [cacheDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/", fileName]];
}

+ (NSNumber * _Nullable)mar_fileSize:(NSString * _Nonnull)fileName fromDirectory:(MARDirectoryType)directory {
    if (fileName.length > 0) {
        NSString *path;
        
        switch (directory) {
            case MARDirectoryTypeMainBundle:
                path = [self mar_getBundlePathForFile:fileName];
                break;
            case MARDirectoryTypeLibrary:
                path = [self mar_getLibraryDirectoryForFile:fileName];
                break;
            case MARDirectoryTypeDocuments:
                path = [self mar_getDocumentsDirectoryForFile:fileName];
                break;
            case MARDirectoryTypeCache:
                path = [self mar_getCacheDirectoryForFile:fileName];
                break;
        }
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
            NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:fileName error:nil];
            if (fileAttributes) {
                return [fileAttributes objectForKey:NSFileSize];
            }
        }
    }
    
    return nil;
}

+ (BOOL)mar_deleteFile:(NSString * _Nonnull)fileName fromDirectory:(MARDirectoryType)directory {
    if (fileName.length > 0) {
        NSString *path;
        
        switch (directory) {
            case MARDirectoryTypeMainBundle:
                path = [self mar_getBundlePathForFile:fileName];
                break;
            case MARDirectoryTypeLibrary:
                path = [self mar_getLibraryDirectoryForFile:fileName];
                break;
            case MARDirectoryTypeDocuments:
                path = [self mar_getDocumentsDirectoryForFile:fileName];
                break;
            case MARDirectoryTypeCache:
                path = [self mar_getCacheDirectoryForFile:fileName];
                break;
        }
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
    }
    
    return NO;
}

+ (BOOL)mar_moveLocalFile:(NSString * _Nonnull)fileName fromDirectory:(MARDirectoryType)origin toDirectory:(MARDirectoryType)destination {
    return [self mar_moveLocalFile:fileName fromDirectory:origin toDirectory:destination withFolderName:nil];
}

+ (BOOL)mar_moveLocalFile:(NSString * _Nonnull)fileName fromDirectory:(MARDirectoryType)origin toDirectory:(MARDirectoryType)destination withFolderName:(NSString * _Nullable)folderName {
    NSString *originPath;
    
    switch (origin) {
        case MARDirectoryTypeMainBundle:
            originPath = [self mar_getBundlePathForFile:fileName];
            break;
        case MARDirectoryTypeLibrary:
            originPath = [self mar_getDocumentsDirectoryForFile:fileName];
            break;
        case MARDirectoryTypeDocuments:
            originPath = [self mar_getLibraryDirectoryForFile:fileName];
            break;
        case MARDirectoryTypeCache:
            originPath = [self mar_getCacheDirectoryForFile:fileName];
            break;
    }
    
    NSString *destinationPath;
    if (folderName) {
        destinationPath = [NSString stringWithFormat:@"%@/%@", folderName, fileName];
    } else {
        destinationPath = fileName;
    }
    
    switch (destination) {
        case MARDirectoryTypeMainBundle:
            destinationPath = [self mar_getBundlePathForFile:destinationPath];
            break;
        case MARDirectoryTypeLibrary:
            destinationPath = [self mar_getLibraryDirectoryForFile:destinationPath];
            break;
        case MARDirectoryTypeDocuments:
            destinationPath = [self mar_getDocumentsDirectoryForFile:destinationPath];
            break;
        case MARDirectoryTypeCache:
            destinationPath = [self mar_getCacheDirectoryForFile:destinationPath];
            break;
    }
    
    if (folderName) {
        NSString *folderPath = [NSString stringWithFormat:@"%@/%@", destinationPath, folderName];
        if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
    }
    
    BOOL copied = NO, deleted = NO;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:originPath]) {
        if ([[NSFileManager defaultManager] copyItemAtPath:originPath toPath:destinationPath error:nil]) {
            copied = YES;
        }
    }
    
    if (destination != MARDirectoryTypeMainBundle) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:originPath])
            if ([[NSFileManager defaultManager] removeItemAtPath:originPath error:nil]) {
                deleted = YES;
            }
    }
    
    if (copied && deleted) {
        return YES;
    }
    return NO;
}

+ (BOOL)mar_duplicateFileAtPath:(NSString * _Nonnull)origin toNewPath:(NSString * _Nonnull)destination {
    if ([[NSFileManager defaultManager] fileExistsAtPath:origin]) {
        return [[NSFileManager defaultManager] copyItemAtPath:origin toPath:destination error:nil];
    }
    return NO;
}

+ (BOOL)mar_renameFileFromDirectory:(MARDirectoryType)origin atPath:(NSString * _Nonnull)path withOldName:(NSString * _Nonnull)oldName andNewName:(NSString * _Nonnull)newName {
    NSString *originPath;
    
    switch (origin) {
        case MARDirectoryTypeMainBundle:
            originPath = [self mar_getBundlePathForFile:path];
            break;
        case MARDirectoryTypeLibrary:
            originPath = [self mar_getDocumentsDirectoryForFile:path];
            break;
        case MARDirectoryTypeDocuments:
            originPath = [self mar_getLibraryDirectoryForFile:path];
            break;
        case MARDirectoryTypeCache:
            originPath = [self mar_getCacheDirectoryForFile:path];
            break;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:originPath]) {
        NSString *newNamePath = [originPath stringByReplacingOccurrencesOfString:oldName withString:newName];
        if ([[NSFileManager defaultManager] copyItemAtPath:originPath toPath:newNamePath error:nil]) {
            if ([[NSFileManager defaultManager] removeItemAtPath:originPath error:nil]) {
                return YES;
            }
        }
    }
    return NO;
}

+ (id _Nullable)mar_getSettings:(NSString * _Nonnull)settings objectForKey:(NSString * _Nonnull)objKey {
    NSString *path = [self mar_getLibraryDirectoryForFile:@""];
    path = [path stringByAppendingString:@"/Preferences/"];
    path = [path stringByAppendingString:[NSString stringWithFormat:@"%@-Settings.plist", settings]];
    
    NSMutableDictionary *loadedPlist;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        loadedPlist = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    } else {
        return nil;
    }
    
    return loadedPlist[objKey];
}

+ (BOOL)mar_setSettings:(NSString * _Nonnull)settings object:(id _Nonnull)value forKey:(NSString * _Nonnull)objKey {
    NSString *path = [self mar_getLibraryDirectoryForFile:@""];
    path = [path stringByAppendingString:@"/Preferences/"];
    path = [path stringByAppendingString:[NSString stringWithFormat:@"%@-Settings.plist", settings]];
    
    NSMutableDictionary *loadedPlist;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        loadedPlist = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    } else {
        loadedPlist = [[NSMutableDictionary alloc] init];
    }
    
    [loadedPlist setObject:value forKey:objKey];
    
    return [loadedPlist writeToFile:path atomically:YES];
}

+ (id _Nullable)mar_getAppSettingsForObjectWithKey:(NSString * _Nonnull)objKey {
    return [self mar_getSettings:APPDisplayName objectForKey:objKey];
}

+ (BOOL)mar_setAppSettingsForObject:(id _Nonnull)value forKey:(NSString * _Nonnull)objKey {
    return [self mar_setSettings:APPDisplayName object:value forKey:objKey];
}

+ (NSInteger)mar_contentsByteSizeWithDirectoryPath:(NSString * _Nonnull)folderPath
{
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
    if (!contents || contents.count == 0) {
        return 0;
    }
    NSEnumerator *contentsEnumurator = [contents objectEnumerator];
    
    NSString *file;
    unsigned long long folderSize = 0;
    
    while (file = [contentsEnumurator nextObject]) {
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:file] error:nil];
        folderSize += [[fileAttributes objectForKey:NSFileSize] intValue];
    }
    return folderSize;
}

@end
