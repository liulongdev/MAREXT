//
//  NSFileManager+MAREX.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/18.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Directory type enum
 */
typedef NS_ENUM(NSInteger, MARDirectoryType) {
    /**
     *  Main bundle directory
     */
    MARDirectoryTypeMainBundle = 0,
    /**
     *  Library directory
     */
    MARDirectoryTypeLibrary,
    /**
     *  Documents directory
     */
    MARDirectoryTypeDocuments,
    /**
     *  Cache directory
     */
    MARDirectoryTypeCache
};

/**
 *  This category adds some useful methods to NSFileManager
 */
@interface NSFileManager (MAREX)

/**
 *  Read a file an returns the content as NSString
 *
 *  @param file File name
 *  @param type File type
 *
 *  @return Returns the content of the file a NSString
 */
+ (NSString * _Nullable)mar_readTextFile:(NSString * _Nonnull)file
                              ofType:(NSString * _Nonnull)type;

/**
 *  Save a given array into a PLIST with the given filename
 *
 *  @param directory     Path of the PLIST
 *  @param fileName PLIST filename
 *  @param array    Array to save into PLIST
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)mar_saveArrayToPath:(MARDirectoryType)directory
           withFilename:(NSString * _Nonnull)fileName
                  array:(NSArray * _Nonnull)array;

/**
 *  Load array from a PLIST with the given filename
 *
 *  @param directory     Path of the PLIST
 *  @param fileName PLIST filename
 *
 *  @return Returns the loaded array
 */
+ (NSArray * _Nullable)mar_loadArrayFromPath:(MARDirectoryType)directory
                            withFilename:(NSString * _Nonnull)fileName;

/**
 *  Get the Bundle path for a filename
 *
 *  @param fileName Filename
 *
 *  @return Returns the path as a NSString
 */
+ (NSString * _Nonnull)mar_getBundlePathForFile:(NSString * _Nonnull)fileName;

/**
 *  Get the Documents directory for a filename
 *
 *  @param fileName Filename
 *
 *  @return Returns the directory as a NSString
 */
+ (NSString * _Nonnull)mar_getDocumentsDirectoryForFile:(NSString * _Nonnull)fileName;
+ (NSString * _Nonnull)mar_documentsDirectoryPath;

/**
 *  Get the Library directory for a filename
 *
 *  @param fileName Filename
 *
 *  @return Returns the directory as a NSString
 */
+ (NSString * _Nonnull)mar_getLibraryDirectoryForFile:(NSString * _Nonnull)fileName;
+ (NSString * _Nonnull)mar_libraryDirectoryPath;

/**
 *  Get the Cache directory for a filename
 *
 *  @param fileName Filename
 *
 *  @return Returns the directory as a NSString
 */
+ (NSString * _Nonnull)mar_getCacheDirectoryForFile:(NSString * _Nonnull)fileName;
+ (NSString * _Nonnull)mar_cacheDirectoryPath;

/**
 *  Returns the size of the file
 *
 *  @param fileName  Filename
 *  @param directory Directory of the file
 *
 *  @return Returns the file size
 */
+ (NSNumber * _Nullable)mar_fileSize:(NSString * _Nonnull)fileName
                   fromDirectory:(MARDirectoryType)directory;

/**
 *  Delete a file with the given filename
 *
 *  @param fileName     Filename to delete
 *  @param directory    Directory of the file
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)mar_deleteFile:(NSString * _Nonnull)fileName
     fromDirectory:(MARDirectoryType)directory;

/**
 *  Move a file from a directory to another
 *
 *  @param fileName    Filename to move
 *  @param origin      Origin directory of the file
 *  @param destination Destination directory of the file
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)mar_moveLocalFile:(NSString * _Nonnull)fileName
        fromDirectory:(MARDirectoryType)origin
          toDirectory:(MARDirectoryType)destination;

/**
 *  Move a file from a directory to another
 *
 *  @param fileName    Filename to move
 *  @param origin      Origin directory of the file
 *  @param destination Destination directory of the file
 *  @param folderName  Folder name where to move the file. If folder not exist it will be created automatically
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)mar_moveLocalFile:(NSString * _Nonnull)fileName
        fromDirectory:(MARDirectoryType)origin
          toDirectory:(MARDirectoryType)destination
       withFolderName:(NSString * _Nullable)folderName;

/**
 *  Duplicate a file into another directory
 *
 *  @param origin      Origin path
 *  @param destination Destination path
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)mar_duplicateFileAtPath:(NSString * _Nonnull)origin
                  toNewPath:(NSString * _Nonnull)destination;

/**
 *  Rename a file with another filename
 *
 *  @param origin  Origin path
 *  @param path    Subdirectory path
 *  @param oldName Old filename
 *  @param newName New filename
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)mar_renameFileFromDirectory:(MARDirectoryType)origin
                         atPath:(NSString * _Nonnull)path
                    withOldName:(NSString * _Nonnull)oldName
                     andNewName:(NSString * _Nonnull)newName;

/**
 *  Get the App settings for a given key
 *
 *  @param objKey Key to get the object
 *
 *  @return Returns the object for the given key
 */
+ (id _Nullable)mar_getAppSettingsForObjectWithKey:(NSString * _Nonnull)objKey;

/**
 *  Set the App settings for a given object and key. The file will be saved in the Library directory
 *
 *  @param value  Object to set
 *  @param objKey Key to set the object
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)mar_setAppSettingsForObject:(id _Nonnull)value
                         forKey:(NSString * _Nonnull)objKey;

/**
 *  Get the given settings for a given key
 *
 *  @param settings Settings filename
 *  @param objKey   Key to set the object
 *
 *  @return Returns the object for the given key
 */
+ (id _Nullable)mar_getSettings:(NSString * _Nonnull)settings
               objectForKey:(NSString * _Nonnull)objKey;

/**
 *  Set the given settings for a given object and key. The file will be saved in the Library directory
 *
 *  @param settings Settings filename
 *  @param value    Object to set
 *  @param objKey   Key to set the object
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)mar_setSettings:(NSString * _Nonnull)settings
             object:(id _Nonnull)value
             forKey:(NSString * _Nonnull)objKey;


/**
 return the total byte size of folder
 */
+ (NSInteger)mar_contentsByteSizeWithDirectoryPath:(NSString * _Nonnull)folderPath;

@end
