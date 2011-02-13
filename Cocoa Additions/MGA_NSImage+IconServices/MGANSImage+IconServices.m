//
//  MGANSImage+IconServices.m
//  DollyDriveApp
//
//  Created by Mark Aufflick on 24/01/11.
//  Copyright 2011 Pumptheory. All rights reserved.
//

#import "MGANSImage+IconServices.h"


@implementation NSImage (MGANSImage_IconServices)

+ (NSImage *)mga_imageWithIconServicesConstant:(OSType)hfsFileTypeCode;
{
    return [[NSWorkspace sharedWorkspace] iconForFileType:NSFileTypeForHFSTypeCode(hfsFileTypeCode)];
}

@end
