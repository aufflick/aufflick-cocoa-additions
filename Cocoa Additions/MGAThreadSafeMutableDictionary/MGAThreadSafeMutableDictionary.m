//
//  MGAThreadSafeMutableDictionary.m
//  DollyDriveApp
//
//  Created by Mark Aufflick on 19/01/11.
//  Copyright 2011 Pumptheory. All rights reserved.
//

#import "MGAThreadSafeMutableDictionary.h"

@implementation MGAThreadSafeMutableDictionary

- (id)initWithCapacity:(NSUInteger)cap
{
    if ((self = [super init])) {
        lock = [[NSLock alloc] init];
        underlyingDict = [[NSMutableDictionary alloc] initWithCapacity:cap];
    }
    return self;
}

- (void) dealloc
{
    [lock release];
    [underlyingDict release];
    [super dealloc];
}

- (void)setObject:(id)anObject forKey:(id)aKey
{
    [lock lock];
    @try {
        return [underlyingDict setObject:anObject forKey:aKey];
    }
    @finally {
        [lock unlock];
    }
}

- (id)objectForKey:(id)aKey
{
    id obj = nil;
    [lock lock];
    @try {
        obj = [underlyingDict objectForKey:aKey];
    }
    @finally {
        [lock unlock];
    }
    
    return obj;
}

- (id)forwardingTargetForSelector:(SEL)sel {
    return underlyingDict;
}

@end
