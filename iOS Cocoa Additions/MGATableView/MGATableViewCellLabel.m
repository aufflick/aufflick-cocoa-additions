//
//  MGATableViewCellLabel.m
//  Aufflick iOS Cocoa Additions
//
//  Created by Mark Aufflick on 2/09/10.
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
