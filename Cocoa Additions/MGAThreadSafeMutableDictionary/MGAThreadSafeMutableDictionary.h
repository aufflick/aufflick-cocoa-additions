//
//  MGAThreadSafeMutableDictionary.h
//  DollyDriveApp
//
//  Created by Mark Aufflick on 19/01/11.
//  Copyright 2011 Pumptheory. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MGAThreadSafeMutableDictionary : NSMutableDictionary
{
    NSLock *lock;
    NSMutableDictionary *underlyingDict;
}

@end
