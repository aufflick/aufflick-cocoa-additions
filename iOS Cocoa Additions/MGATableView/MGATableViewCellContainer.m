//
//  MGATableViewCellContainer.m
//  Aufflick iOS Cocoa Additions
//
//  Created by Mark Aufflick on 26/08/10.
//  Copyright 2010 pumptheory.com. All rights reserved.
//

#import "MGATableViewCellContainer.h"


@implementation MGATableViewCellContainer

@synthesize cell, didSelectActionBlock, accessoryTapActionBlock;

+(MGATableViewCellContainer *) containerWithCell:(UITableViewCell *)aCell
{
    return [[[MGATableViewCellContainer alloc] initWithCell:aCell] autorelease];
}

+(MGATableViewCellContainer *) containerWithCell:(UITableViewCell *)aCell
                         andDidSelectActionBlock:(void(^)(void))aDidSelectActionBlock
{
    MGATableViewCellContainer *ret = [[[MGATableViewCellContainer alloc] initWithCell:aCell] autorelease];
    ret.didSelectActionBlock = aDidSelectActionBlock;
    
    return ret;
}


-(MGATableViewCellContainer *)initWithCell:(UITableViewCell *)aCell
{
    self = [super init];
    self.cell = aCell;
    return self;
}


-(void)dealloc
{
    self.cell = nil;
    self.didSelectActionBlock = nil;
    self.accessoryTapActionBlock = nil;
    
    [super dealloc];
}

@end
