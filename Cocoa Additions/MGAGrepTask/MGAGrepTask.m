//
//  MGAGrepTask.m
//  AufflickCocoaAdditions
//
//  Created by Mark Aufflick on 10/12/10.
//  Copyright 2010 Pumptheory. All rights reserved.
//

#import "MGAGrepTask.h"

@interface MGAGrepTask (Private)

- (NSArray *)grepCommand:(NSString *)grepPath file:(NSString *)filePath regex:(NSString *)regex;

@end

@implementation MGAGrepTask

- (NSArray *)grepFile:(NSString *)filePath forRegex:(NSString *)regex
{
    return [self grepCommand:@"/usr/bin/grep" file:filePath regex:regex];
}
- (NSArray *)egrepFile:(NSString *)filePath forRegex:(NSString *)regex
{
    return [self grepCommand:@"/usr/bin/egrep" file:filePath regex:regex];
}

- (NSArray *)grepCommand:(NSString *)grepPath file:(NSString *)filePath regex:(NSString *)regex
{
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:grepPath];
    
    NSArray *arguments = [NSArray arrayWithObjects:regex, filePath, nil];
    [task setArguments: arguments];
    
    NSPipe *grepPipe = [NSPipe pipe];
    [task setStandardOutput:grepPipe];
    
    NSFileHandle *file = [grepPipe fileHandleForReading];
    
    [task launch];
    
    NSData *data = [file readDataToEndOfFile];
	
	[task waitUntilExit];
    
    NSArray *ret;
    
    if ([task terminationStatus] == 2)
    {
        // grep reported an error (as opposed to not found, which is 1
        // and we will show as an empty array
        ret = nil;
    }
    else if ([data length] == 0)
	{
		ret = [NSArray arrayWithObjects:nil];
	}
	else 
    {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        ret = [string componentsSeparatedByString:@"\n"];
        // inexplicably, NSTask's pipe recieves a final newline
        if ([(NSString *)[ret lastObject] isEqualToString:@""])
            ret = [ret subarrayWithRange:NSMakeRange(0, [ret count]-1)];
        [string release];
    }
    
    [task release];
    
    return ret;
}

@end
