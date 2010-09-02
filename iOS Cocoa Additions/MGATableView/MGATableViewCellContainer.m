//
//  MGATableViewCellContainer.m
//  Aufflick iOS Cocoa Additions
//
//  Created by Mark Aufflick on 26/08/10.
//  Copyright 2010 pumptheory.com. All rights reserved.
//

#import "MGATableViewCellContainer.h"


@implementation MGATableViewCellContainer

@synthesize cell, data, didSelectActionBlock, accessoryTapActionBlock;

+(MGATableViewCellContainer *) containerWithCell:(UITableViewCell *)aCell
{
    return [[[MGATableViewCellContainer alloc] initWithCell:aCell] autorelease];
}

+(MGATableViewCellContainer *) containerWithCell:(UITableViewCell *)aCell
                            didSelectActionBlock:(void(^)(void))aDidSelectActionBlock
{
    return [self containerWithCell:aCell data:nil didSelectActionBlock:^(id data){
        aDidSelectActionBlock();
    }];
}

+(MGATableViewCellContainer *) containerWithCell:(UITableViewCell *)aCell
                                            data:(id)aData
                         didSelectActionBlock:(void(^)(id data))aDidSelectActionBlock
{
    MGATableViewCellContainer *ret = [[[MGATableViewCellContainer alloc] initWithCell:aCell] autorelease];
    ret.didSelectActionBlock = aDidSelectActionBlock;
    ret.data = aData;
    
    return ret;
}

-(id)initWithCell:(UITableViewCell *)aCell
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
