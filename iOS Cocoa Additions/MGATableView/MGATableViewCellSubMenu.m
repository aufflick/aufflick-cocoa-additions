//
//  MGATableViewCellSubMenu.m
//  Aufflick iOS Cocoa Additions
//
//  Created by Mark Aufflick on 27/08/10.
//  Copyright 2010 pumptheory.com. All rights reserved.
//

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

    self = [super initWithTitle:title didSelectActionBlock:^(id data){
        UINavigationController *navc = [[[UIApplication sharedApplication] delegate] performSelector:@selector(navigationController)];
        
        // the vc must be able to be loaded with nil nibName and bundle - ie. matching filename
        UIViewController *vc = [viewControllerClass alloc];
        [vc initWithNibName:nil bundle:nil];
        
        [navc pushViewController:vc animated:YES];
        
        [vc release];
        
        self.cell.selected = NO;
    }];
    
    self.cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    return self;
}


@end
