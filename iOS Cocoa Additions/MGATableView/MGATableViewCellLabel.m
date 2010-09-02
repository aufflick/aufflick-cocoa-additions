//
//  MGATableViewCellLabel.m
//  Aufflick iOS Cocoa Additions
//
//  Created by Mark Aufflick on 2/09/10.
//  Copyright 2010 pumptheory.com. All rights reserved.
//

#import "MGATableViewCellLabel.h"


@implementation MGATableViewCellLabel

+(MGATableViewCellLabel *)containerWithTitle:(NSString *)title
{
    return [[[MGATableViewCellLabel alloc] initWithTitle:title] autorelease];
}

+(MGATableViewCellLabel *)containerWithTitle:(NSString *)title didSelectActionBlock:(void(^)(id data))aDidSelectActionBlock
{
    MGATableViewCellLabel *ret = [[[MGATableViewCellLabel alloc] initWithTitle:title] autorelease];
    ret.didSelectActionBlock = aDidSelectActionBlock;
    
    return ret;
}

-(id)initWithTitle:(NSString *)title
{
    self = [super init];
    
    NSString *uniqueIdentifier = [NSString stringWithFormat:@"%@ withTitle:%@", title];
    
    UITableViewCell *aCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:uniqueIdentifier];
    
    aCell.textLabel.text = title;
    self.cell = aCell;
    [aCell release];
    
    return self;
}

@end
