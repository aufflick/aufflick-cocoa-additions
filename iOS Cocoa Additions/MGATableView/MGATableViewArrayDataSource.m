//
//  MGATableViewDataSource.m
//  LedgerBender
//
//  Created by Mark Aufflick on 26/08/10.
//  Copyright 2010 pumptheory.com. All rights reserved.
//

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
    NSArray *sectionContent = [self contentArrayForSection:indexPath.section];
    
    return [sectionContent objectAtIndex:indexPath.row];
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
    return [[self alloc] initWithString:string];
}

@end

@implementation MGATableFooter

+ (id) footerWithString:(NSString *)string
{
    return [[self alloc] initWithString:string];
}

@end

@implementation MGATableSectionBreak

+ (id) sectionBreak
{
    return [[self alloc] initWithString:@""];
}
@end