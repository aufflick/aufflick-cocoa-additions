//
//  MGATableViewCellSubMenu.m
//  Aufflick iOS Cocoa Additions
//
//  Created by Mark Aufflick on 27/08/10.
//  Copyright 2010 pumptheory.com. All rights reserved.
//

#import "MGATableViewCellSubMenu.h"


@implementation MGATableViewCellSubMenu

+(MGATableViewCellSubMenu *)subMenuWithTitle:(NSString *)title andViewControllerClass:(Class)viewControllerClass
{
    return [[[MGATableViewCellSubMenu alloc] initWithTitle:title andViewControllerClass:viewControllerClass] autorelease];
}

-(MGATableViewCellSubMenu *)initWithTitle:(NSString *)title andViewControllerClass:(Class)viewControllerClass
{
    self = [super init];
    
    NSString *uniqueIdentifier = [NSString stringWithFormat:@"MGATableViewCellSubMenu withTitle:%@ andViewControllerClass:%@", title, viewControllerClass];
    
    UITableViewCell *aCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:uniqueIdentifier];
    
    aCell.textLabel.text = title;
    aCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.cell = aCell;
    [aCell release];
        
    // the app delegate must have the navigationController as a property - as per the standard template
    // this is informal - your code will die if it is not honoured!
    self.didSelectActionBlock = ^{
        UINavigationController *navc = [[[UIApplication sharedApplication] delegate] performSelector:@selector(navigationController)];
        
        // the vc must be able to be loaded with nil nibName and bundle - ie. matching filename
        UIViewController *vc = [viewControllerClass alloc];
        [vc initWithNibName:nil bundle:nil];

        [navc pushViewController:vc animated:YES];
        
        [vc release];
        
        self.cell.selected = NO;
    };
        
    return self;
}


@end
