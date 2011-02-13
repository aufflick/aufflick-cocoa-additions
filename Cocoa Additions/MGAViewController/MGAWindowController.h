//
//  MGAWindowController.h
//  DollyDriveApp
//
//  Created by Mark Aufflick on 10/01/11.
//  Copyright 2011 Pumptheory. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "MGAViewController.h"

@interface MGAWindowController : NSWindowController
{
    IBOutlet NSView *view;
    MGAViewController *_viewController;
}

@property (readonly) IBOutlet NSView *view;
@property (retain) MGAViewController *_viewController;
@property (retain) MGAViewController *viewController;

- (void)resizeToViewHeight:(CGFloat)height fromHeight:(CGFloat)oldHeight animate:(BOOL)animate;
- (void)sizeToViewAnimate:(BOOL)animate;

@end
