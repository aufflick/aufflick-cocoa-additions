//
//  MGAGrepTask.h
//  AufflickCocoaAdditions
//
//  Created by Mark Aufflick on 10/12/10.
//  Copyright 2010 Pumptheory. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MGAGrepTask : NSObject
{
}

- (NSArray *)grepFile:(NSString *)filePath forRegex:(NSString *)regex;
- (NSArray *)egrepFile:(NSString *)filePath forRegex:(NSString *)regex;

@end
