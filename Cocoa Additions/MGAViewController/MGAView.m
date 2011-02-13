//
//  MGAView.m
//  AufflickCocoaAdditions
//
//  Created by Mark Aufflick on 7/12/10.
//  Copyright 2010 Pumptheory. All rights reserved.
//
// Based on a concept by Matt Gallagher
// http://cocoawithlove.com/2008/07/better-integration-for-nsviewcontroller.html
//

#import "MGAView.h"


@implementation MGAView

@synthesize viewController;

// not listed in header, but called by NIB loader
- (void)setViewController:(NSViewController *)newController
{
    // this is only strictly necessary if this method is made available
    // for general use, which you can if you really want to.
    if (viewController)
    {
        NSResponder *controllerNextResponder = [viewController nextResponder];
        [super setNextResponder:controllerNextResponder];
        [viewController setNextResponder:nil];
    }
    
    viewController = newController;
    
    if (newController)
    {
        NSResponder *ownNextResponder = [self nextResponder];
        [super setNextResponder: viewController];
        [viewController setNextResponder:ownNextResponder];
    }
}

- (void)setNextResponder:(NSResponder *)newNextResponder
{
    if (viewController)
    {
        [viewController setNextResponder:newNextResponder];
        return;
    }
    
    [super setNextResponder:newNextResponder];
}

@end
