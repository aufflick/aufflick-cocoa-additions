//
//  MGAAutoScrollToButton.m
//  AufflickCocoaAdditions
//
//  Created by Mark Aufflick on 2/06/10.
//  Copyright 2010 pumptheory.com. All rights reserved.
//

#import "MGAAutoScrollToButton.h"


@implementation MGAAutoScrollToButton

- (BOOL)becomeFirstResponder
{
    BOOL ret = [super becomeFirstResponder];
    
    if (ret)
        [[self superview] scrollRectToVisible:[self frame]];
    
    return ret;
}


@end
