//
//  NSDate+Aufflick.m
//
//  Created by Mark Aufflick on 13/08/10.
//  Copyright 2010 Pumptheory. All rights reserved.
//

#import "NSDate+Aufflick.h"


@implementation NSDate (Aufflick)

- (NSDate *)MGA_stripTimeComponent
{
    NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *components = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit)
                                                fromDate:self];
    
    return [gregorian dateFromComponents:components];
}

- (NSDate *)MGA_addMonths:(NSInteger)months
{
    NSDateComponents *components = [[[NSDateComponents alloc] init] autorelease];
    components.month = months;

    NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    
    return [gregorian dateByAddingComponents:components toDate:self options:kCFCalendarComponentsWrap];
}

@end
