//
//  MGATableViewDataSource.m
//  LedgerBender
//
//  Created by Mark Aufflick on 26/08/10.
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


#import "MGATableViewArrayDataSource.h"

@implementation MGATableViewArrayDataSource

@synthesize dataArray, delegate;


- (id)forwardingTargetForSelector:(SEL)sel
{
    return delegate;
}

- (NSArray *)contentRanges
{
    NSMutableArray *ret = [[NSMutableArray alloc] initWithCapacity:5];
    
    BOOL prevCellWasContent = NO;
    NSUInteger start = -1;
    
    NSInteger i=0;
    for (id obj in self.dataArray)
    {
        if (!prevCellWasContent && ![obj isKindOfClass:[MGATableString class]])
        {
            prevCellWasContent = YES;
            start = i;
        }
        
        if ([obj isKindOfClass:[MGATableString class]])
        {
            prevCellWasContent = NO;
            if (start != -1)
            {
                [ret addObject:[NSValue valueWithRange:NSMakeRange(start, i - start)]];
                start = -1;
            }
        }
        
        i++;
    }
    
    // special case - if the last section has no footer
    if (start != -1)
        [ret addObject:[NSValue valueWithRange:NSMakeRange(start, i - start)]];
        
    return [ret autorelease];
}

- (NSRange)contentRangeForSection:(NSInteger)section
{
    return [(NSValue *)[[self contentRanges] objectAtIndex:section] rangeValue];
}

- (NSArray *)contentArrayForSection:(NSInteger)section
{
    return [self.dataArray subarrayWithRange:[self contentRangeForSection:section]];
}

- (id)objectForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionContent = [self contentArrayForSection:indexPath.section];
    
    return [sectionContent objectAtIndex:indexPath.row];
}

#pragma mark -
#pragma mark UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self contentRanges] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self contentArrayForSection:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id obj = [self objectForRowAtIndexPath:(NSIndexPath *)indexPath];
    
    if ([obj isKindOfClass:[MGATableViewCellContainer class]])
        return ((MGATableViewCellContainer *)obj).cell;
    
    return obj;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSRange contentRange = [self contentRangeForSection:section];
    
    if (contentRange.location == 0)
        return nil;
    
    id obj = [self.dataArray objectAtIndex:contentRange.location - 1];
    
    return [obj isKindOfClass:[MGATableHeader class]] ? [(MGATableHeader *)obj string] : nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSRange contentRange = [self contentRangeForSection:section];
    
    if (contentRange.location + contentRange.length > [self.dataArray count] - 1)
        return nil;
    
    id obj = [self.dataArray objectAtIndex:contentRange.location + contentRange.length];
    
    return [obj isKindOfClass:[MGATableFooter class]] ? [(MGATableFooter *)obj string] : nil;
}

#pragma mark -
#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    id obj = [self objectForRowAtIndexPath:indexPath];
    
    if (![obj isKindOfClass:[MGATableViewCellContainer class]])
    {
        if ([delegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)])
            [delegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
    else 
    {
        MGATableViewCellContainer *container = (MGATableViewCellContainer *)obj;
    
        if (container.accessoryTapActionBlock)
            container.accessoryTapActionBlock(container.data);
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id obj = [self objectForRowAtIndexPath:indexPath];
    
    if (![obj isKindOfClass:[MGATableViewCellContainer class]])
    {
        if ([delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
            [delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    else 
    {
        MGATableViewCellContainer *container = (MGATableViewCellContainer *)obj;
    
        if (container.didSelectActionBlock)
            container.didSelectActionBlock(container.data);
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // if there is nothing to handle the selection, we will reject it
    id obj = [self objectForRowAtIndexPath:indexPath];
    
    if (![obj isKindOfClass:[MGATableViewCellContainer class]])
    {
        if ([delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)])
            return [delegate tableView:tableView willSelectRowAtIndexPath:indexPath];
        
        if ([delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
            return indexPath;
    }
    else 
    {
        MGATableViewCellContainer *container = (MGATableViewCellContainer *)obj;
        
        if (container.didSelectActionBlock)
            return indexPath;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath].frame.size.height;
}

@end

#pragma mark -
#pragma mark MGATableString & subclasses

@implementation MGATableString

@synthesize string;

- (id) initWithString:(NSString *)aString
{
    self.string = aString;
    
    return self;
}

@end


@implementation MGATableHeader

+ (id) headerWithString:(NSString *)string
{
    return [[[self alloc] initWithString:string] autorelease];
}

@end

@implementation MGATableFooter

+ (id) footerWithString:(NSString *)string
{
    return [[[self alloc] initWithString:string] autorelease];
}

@end

@implementation MGATableSectionBreak

+ (id) sectionBreak
{
    return [[[self alloc] initWithString:@""] autorelease];
}
@end
