//
//  MGAFastFolderSize.m
//  DollyDriveApp
//
//  Created by Mark Aufflick on 19/01/11.
//  Copyright 2011 Pumptheory. All rights reserved.
//

#import "MGAFastFolderSize.h"
#import <limits.h>

const ItemCount kMGAFastFolderSizeMaxEntriesPerFetch = 256;
const size_t kMGAFastFolderSizeDirectoryRefsResizeCount = 1024 * 25; // about 2Mb worth®

const unsigned long long MGAFastFolderSizeNoValue = ULLONG_MAX - 2;
const unsigned long long MGAFastFolderSizeErr = ULLONG_MAX - 3;

unsigned long long MGAFastFolderSizeAtFSRef(FSRef *theFileRef,
                                            FSRef *fetchedRefs,
                                            FSCatalogInfo *fetchedInfos,
                                            size_t *directoryRefsOffsetRef,
                                            size_t *directoryRefsCountRef,
                                            FSRef **directoryRefsHandle,
                                            NSDictionary *cache,
                                            BOOL *stop);


unsigned long long MGAFastFolderSizeForPath(NSString *path, BOOL *stop)
{
    return MGAFastFolderSizeForPathWithCache(path, nil, stop);
}

unsigned long long MGAFastFolderSizeForPathWithCache(NSString *path, NSDictionary *cache, BOOL *stop)
{
    FSRef theFileRef;
    Boolean isDirectory;
    
    if (noErr != (FSPathMakeRef(
                                (const UInt8 *)[path UTF8String], // const UInt8 *path,
                                &theFileRef, //FSRef *ref,
                                &isDirectory // Boolean *isDirectory                                
                                )))
        return MGAFastFolderSizeErr;
    
    FSRef *fetchedRefs = malloc(sizeof(FSRef) * kMGAFastFolderSizeMaxEntriesPerFetch);
    FSCatalogInfo *fetchedInfos = malloc(sizeof(FSCatalogInfo) * kMGAFastFolderSizeMaxEntriesPerFetch);
    size_t _directoryRefsCount = kMGAFastFolderSizeDirectoryRefsResizeCount;
    FSRef *_directoryRefs = malloc(sizeof(FSRef) * _directoryRefsCount);
    size_t _directoryRefsOffset = 0;
    
    if (!fetchedRefs || !_directoryRefs || !fetchedInfos)
    {
        NSLog(@"Unable to get memory in fastFolderSizeForPath() - aborting");
        abort();
    }    
    
    unsigned long long ret = MGAFastFolderSizeAtFSRef(&theFileRef,
                                                      fetchedRefs,
                                                      fetchedInfos,
                                                      &_directoryRefsOffset,
                                                      &_directoryRefsCount,
                                                      &_directoryRefs,
                                                      cache,
                                                      stop);
    
    free(fetchedRefs);
    free(fetchedInfos);
    free(_directoryRefs);
    
    return ret;
}

#define directoryRefs (*directoryRefsHandle)
#define directoryRefsCount (*directoryRefsCountRef)
#define directoryRefsOffset (*directoryRefsOffsetRef)

unsigned long long MGAFastFolderSizeAtFSRef(FSRef *theFileRef,
                                            FSRef *fetchedRefs,
                                            FSCatalogInfo *fetchedInfos,
                                            size_t *directoryRefsOffsetRef,
                                            size_t *directoryRefsCountRef,
                                            FSRef **directoryRefsHandle,
                                            NSDictionary *cache,
                                            BOOL *stop)
{
    if (*stop)
        return MGAFastFolderSizeNoValue;
    
    // look for dir in cache
    NSString *path = MGACreatePathFromFSRef(*theFileRef);
    NSNumber *cachedSize;

    if ((cachedSize = [cache objectForKey:path]))
    {
        [path release];
        return [cachedSize unsignedLongLongValue];
    }
    
    [path release];
    
    FSIterator thisDirEnum = NULL;
    unsigned long long totalSize = 0;
    
    size_t numDirectories = 0;
    
    // Iterate the directory contents, recursing as necessary
    
    if (FSOpenIterator(theFileRef, kFSIterateFlat, &thisDirEnum) ==
        noErr)
    {
        if (*stop)
            return MGAFastFolderSizeNoValue;
                
        ItemCount actualFetched;
        
        OSErr fsErr = FSGetCatalogInfoBulk(thisDirEnum,
                                           kMGAFastFolderSizeMaxEntriesPerFetch,
                                           &actualFetched,
                                           NULL,
                                           kFSCatInfoDataSizes | kFSCatInfoNodeFlags | kFSCatInfoRsrcSizes,
                                           fetchedInfos,
                                           fetchedRefs,
                                           NULL,
                                           NULL);
        
        while ((fsErr == noErr) || (fsErr == errFSNoMoreItems))
        {                        
            ItemCount thisIndex;
            for (thisIndex = 0; thisIndex < actualFetched; thisIndex++)
            {
                if (*stop)
                {
                    FSCloseIterator(thisDirEnum);
                    return MGAFastFolderSizeNoValue;
                }
                
                if (fetchedInfos[thisIndex].nodeFlags & kFSNodeIsDirectoryMask)
                {
                    // need to recurse if it's a folder, but need to do it after visiting all entries in arrays since the arrays are re-used

                    if (directoryRefsOffset + numDirectories >= directoryRefsCount)
                    {
                        directoryRefsCount += kMGAFastFolderSizeDirectoryRefsResizeCount;
                        FSRef *origDirectoryRefs = directoryRefs;
                        
                        directoryRefs = realloc(origDirectoryRefs, sizeof(FSRef) * directoryRefsCount);
                        if (!directoryRefs)
                        {
                            // ouch - either out of mem or mem getting very fragmented - try reallocing a smaller chunk
                            directoryRefsCount -= kMGAFastFolderSizeDirectoryRefsResizeCount / 2;
                            directoryRefs = realloc(origDirectoryRefs, sizeof(FSRef) * directoryRefsCount);
                        }
                        
                        if (!directoryRefs)
                        {
                            NSLog(@"Unable to get more memory in fastFolderSizeAtFSRef() - aborting");
                            abort();
                        }
                    }
                    FSRef *ourDirectoryRefs = directoryRefs+directoryRefsOffset;
                    
                    ourDirectoryRefs[numDirectories] = fetchedRefs[thisIndex];
                    numDirectories++;
                }
                else
                {
                    // add the size for this item
                    totalSize += fetchedInfos[thisIndex].dataPhysicalSize +
                    fetchedInfos[thisIndex].rsrcPhysicalSize;
                }
            }
            
            if (fsErr == errFSNoMoreItems)
            {
                break;
            }
            else
            {
                // get more items
                fsErr = FSGetCatalogInfoBulk(thisDirEnum,
                                             kMGAFastFolderSizeMaxEntriesPerFetch,
                                             &actualFetched,
                                             NULL,
                                             kFSCatInfoDataSizes | kFSCatInfoNodeFlags | kFSCatInfoRsrcSizes,
                                             fetchedInfos,
                                             fetchedRefs,
                                             NULL,
                                             NULL);
            }
        }
        FSCloseIterator(thisDirEnum);
    }
    
    size_t ourDirectoryRefsOffset = directoryRefsOffset;
    directoryRefsOffset += numDirectories;
    
    for (uint dirIndex = 0 ; dirIndex < numDirectories ; dirIndex++)
    {
        if (*stop)
            return MGAFastFolderSizeNoValue;

        FSRef *ourDirectoryRefs = directoryRefs+ourDirectoryRefsOffset;
        *theFileRef = ourDirectoryRefs[dirIndex];
        totalSize += MGAFastFolderSizeAtFSRef(theFileRef,
                                              fetchedRefs,
                                              fetchedInfos,
                                              directoryRefsOffsetRef,
                                              directoryRefsCountRef,
                                              directoryRefsHandle,
                                              cache,
                                              stop);
    }
    
    return totalSize;
}

NSString * MGACreatePathFromFSRef(const FSRef theRef)
{
    CFURLRef url = CFURLCreateFromFSRef(NULL, &theRef);
    
    if (!url)
        return nil;
    
    NSString *ret = [[(NSURL *)url path] copy];
    
    CFRelease(url);
    
    return ret;
}
