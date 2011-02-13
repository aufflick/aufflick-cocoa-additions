//
//  MGAWindowController.m
//  DollyDriveApp
//
//  Created by Mark Aufflick on 10/01/11.
//

/*
 
 Copyright (c) 2011, Pumptheory Pty Ltd and Mark Aufflick
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
