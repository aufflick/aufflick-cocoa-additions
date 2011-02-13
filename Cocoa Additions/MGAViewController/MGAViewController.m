//
//  MGAViewController.m
//  AufflickCocoaAdditions
//
//  Created by Mark Aufflick on 7/12/10.
//  Copyright 2010 Pumptheory. All rights reserved.
//

#import "MGAViewController.h"

@implementation MGAViewController

@synthesize windowController;

// give UIKit like handling of nil nibName
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!nibNameOrNil)
    {
        const char * className = object_getClassName(self);
        nibNameOrNil = [NSString stringWithCString:className encoding:NSASCIIStringEncoding];
    }
    
    id ret = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (![ret view])
        NSLog(@"%@ didn't connect view to viewController. Perhaps connections are missing in nib or nib has bad bindings somewhere?");
    
    return ret;
}

- (void)windowWillClose:(NSNotification *)notification
{
    
}

- (void)windowWillShow
{
    
}

@end
