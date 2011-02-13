//
//  MGANSImage+IconServices.h
//  DollyDriveApp
//
//  Created by Mark Aufflick on 24/01/11.
//  Copyright 2011 Pumptheory. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface  NSImage (MGANSImage_IconServices)

// see file:///System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Headers/IconsCore.h
// for constants you can use with this. If it's not there, try spotlight for "kAlertNoteIcon".

+ (NSImage *)mga_imageWithIconServicesConstant:(OSType)hfsFileTypeCode;

@end
