//
//  NSDate+Aufflick.h
//
//  Created by Mark Aufflick on 13/08/10.
//  Copyright 2010 Pumptheory. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (Aufflick)

- (NSDate *)MGA_stripTimeComponent;
- (NSDate *)MGA_addMonths:(NSInteger)months;

@end
