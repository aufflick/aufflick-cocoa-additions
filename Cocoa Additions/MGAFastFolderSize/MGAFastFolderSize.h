//
//  MGAFastFolderSize.h
//  DollyDriveApp
//
//  Created by Mark Aufflick on 19/01/11.
//  Copyright 2011 Pumptheory. All rights reserved.
//

#import <Cocoa/Cocoa.h>


unsigned long long MGAFastFolderSizeForPath(NSString *path, BOOL *stop);
unsigned long long MGAFastFolderSizeForPathWithCache(NSString *path, NSDictionary *cache, BOOL *stop);
NSString * MGACreatePathFromFSRef(const FSRef theRef);

extern const unsigned long long MGAFastFolderSizeNoValue;
extern const unsigned long long MGAFastFolderSizeErr;
