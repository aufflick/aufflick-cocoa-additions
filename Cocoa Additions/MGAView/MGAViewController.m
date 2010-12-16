//
//  MGAViewController.m
//  AufflickCocoaAdditions
//
//  Created by Mark Aufflick on 7/12/10.
//  Copyright 2010 Pumptheory. All rights reserved.
//

#import "MGAViewController.h"

@implementation MGAViewController

// give UIKit like handling of nil nibName
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!nibNameOrNil)
    {
        const char * className = object_getClassName(self);
        nibNameOrNil = [NSString stringWithCString:className encoding:NSASCIIStringEncoding];
    }
    
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

@end
