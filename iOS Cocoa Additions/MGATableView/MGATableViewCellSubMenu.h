//
//  MGATableViewCellSubMenu.h
//  Aufflick iOS Cocoa Additions
//
//  Created by Mark Aufflick on 27/08/10.
//  Copyright 2010 pumptheory.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGATableViewCellContainer.h"

@interface MGATableViewCellSubMenu : MGATableViewCellContainer
{
}

+(MGATableViewCellSubMenu *)subMenuWithTitle:(NSString *)title andViewControllerClass:(Class)viewControllerClass;
-(MGATableViewCellSubMenu *)initWithTitle:(NSString *)title andViewControllerClass:(Class)viewControllerClass;

@end
