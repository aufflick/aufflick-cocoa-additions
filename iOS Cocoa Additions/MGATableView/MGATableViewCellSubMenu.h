//
//  MGATableViewCellSubMenu.h
//  Aufflick iOS Cocoa Additions
//
//  Created by Mark Aufflick on 27/08/10.
//  Copyright 2010 pumptheory.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGATableViewCellLabel.h"

@interface MGATableViewCellSubMenu : MGATableViewCellLabel
{
}

+(MGATableViewCellSubMenu *)subMenuWithTitle:(NSString *)title viewControllerClass:(Class)viewControllerClass;
-(id)initWithTitle:(NSString *)title viewControllerClass:(Class)viewControllerClass;

@end
