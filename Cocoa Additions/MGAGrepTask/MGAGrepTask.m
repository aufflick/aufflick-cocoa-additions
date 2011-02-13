//
//  MGAGrepTask.m
//  AufflickCocoaAdditions
//
//  Created by Mark Aufflick on 10/12/10.
//

/*
 
 Copyright (c) 2010, Pumptheory Pty Ltd and Mark Aufflick
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 * Neither the name of the Mark Aufflick nor the
 names of contributors may be used to endorse or promote products
 derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY MARK AUFFLICK ''AS IS'' AND ANY
 EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL MARK AUFFLICK BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 */ 


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
