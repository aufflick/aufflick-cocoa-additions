//
//  MGATableViewCellSubMenu.m
//  Aufflick iOS Cocoa Additions
//
//  Created by Mark Aufflick on 27/08/10.
//  Copyright 2010 pumptheory.com. All rights reserved.
//

/*
 
 Copyright (c) 2010, Mark Aufflick
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


#import "MGATableViewCellSubMenu.h"


@implementation MGATableViewCellSubMenu

+(MGATableViewCellSubMenu *)subMenuWithTitle:(NSString *)title viewControllerClass:(Class)viewControllerClass
{
    return [[[MGATableViewCellSubMenu alloc] initWithTitle:title viewControllerClass:viewControllerClass] autorelease];
}

-(id)initWithTitle:(NSString *)title viewControllerClass:(Class)viewControllerClass
{
    // the app delegate must have the navigationController as a property - as per the standard template
    // this is informal - your code will die if it is not honoured!

    self = [super initWithTitle:title];

    self.didSelectActionBlock = ^(id data){
        UINavigationController *navc = [[[UIApplication sharedApplication] delegate] performSelector:@selector(navigationController)];
        
        // the vc must be able to be loaded with nil nibName and bundle - ie. matching filename
        UIViewController *vc = [viewControllerClass alloc];
        [vc initWithNibName:nil bundle:nil];
        
        [navc pushViewController:vc animated:YES];
        
        [vc release];
        
        self.cell.selected = NO;
    };
    
    self.cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    return self;
}


@end
