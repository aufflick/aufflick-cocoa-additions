//
//  MGAViewController.h
//  AufflickCocoaAdditions
//
//  Created by Mark Aufflick on 7/12/10.
//  Copyright 2010 Pumptheory. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MGAView.h"

@class MGAWindowController;

@interface MGAViewController : NSViewController
{
    MGAWindowController *windowController;
}

@property (assign) MGAWindowController *windowController;

- (void)windowWillShow;
- (void)windowWillClose:(NSNotification *)notification;

@end
