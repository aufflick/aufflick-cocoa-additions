//
//  MGAWindowController.m
//  DollyDriveApp
//
//  Created by Mark Aufflick on 10/01/11.
//  Copyright 2011 Pumptheory. All rights reserved.
//

#import "MGAWindowController.h"


@implementation MGAWindowController

@synthesize _viewController;
@synthesize view;

- (id) init
{
    const char * className = object_getClassName(self);
    NSString *nibName = [NSString stringWithCString:className encoding:NSASCIIStringEncoding];
    return [self initWithWindowNibName:nibName];
}

- (void)awakeFromNib
{
    [self.viewController windowWillShow];
}

CGFloat titleBarHeight()
{
    NSRect frame = NSMakeRect (0, 0, 100, 100);
    
    NSRect contentRect;
    contentRect = [NSWindow contentRectForFrameRect: frame
                                          styleMask: NSTitledWindowMask];
    
    return (frame.size.height - contentRect.size.height);
    
}

- (void)setViewController:(MGAViewController *)theVC
{
    [self willChangeValueForKey:@"viewController"];
    
    if (self._viewController)
    {
        // can send some sort of viewWIllDisappear notification here
        [self._viewController.view removeFromSuperview];
        self._viewController.windowController = nil;
    }
    
    self._viewController = theVC;
    theVC.windowController = self;
    
    [self.view addSubview:theVC.view];
    
    [self synchronizeWindowTitleWithDocumentName];
    [self.view setNeedsDisplay:YES];
    
    [self didChangeValueForKey:@"viewController"];
}

- (MGAViewController *)viewController
{
    return self._viewController;
}

- (void)sizeToViewAnimate:(BOOL)animate
{
    NSRect windowFrame = [self.window frame];
    windowFrame.size.height = [self.viewController.view bounds].size.height + titleBarHeight();
    
    [self.window setFrame:windowFrame display:NO animate:animate];
    [self.view setNeedsDisplay:YES];
}

- (void)resizeToViewHeight:(CGFloat)height fromHeight:(CGFloat)oldHeight animate:(BOOL)animate
{
    // all frames are the same width
    NSRect windowFrame = [self.window frame];
    
    windowFrame.size.height = height + titleBarHeight();
    if (oldHeight != -1)
    {
        CGFloat delta = height - oldHeight;
        windowFrame.origin.y -= delta;
    }
    
    if (windowFrame.origin.y < 0)
        windowFrame.origin.y = 0;
    
    [self.window setFrame:windowFrame display:YES animate:animate];
    [self.view setNeedsDisplay:YES];
}

- (void)windowWillClose:(NSNotification *)notification
{
    [self.viewController windowWillClose:notification];
}

- (IBAction)showWindow:(id)sender
{
    [self.viewController windowWillShow];
    [super showWindow:sender];
}

- (void)dealloc
{
    [_viewController release];
    _viewController = nil;
    
    [super dealloc];
}

@end
