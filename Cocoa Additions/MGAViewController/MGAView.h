//
//  MGAView.h
//  AufflickCocoaAdditions
//
//  Created by Mark Aufflick on 7/12/10.
//  Copyright 2010 Pumptheory. All rights reserved.
//
// Based on a concept by Matt Gallagher
// http://cocoawithlove.com/2008/07/better-integration-for-nsviewcontroller.html
//

#import <Cocoa/Cocoa.h>


@interface MGAView : NSView
{
    IBOutlet NSViewController *viewController;
}

@property (readonly) IBOutlet NSViewController *viewController; // will be set by NIB loader

@end
