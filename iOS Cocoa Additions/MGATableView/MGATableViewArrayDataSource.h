//
//  MGATableViewDataSource.h
//  LedgerBender
//
//  Created by Mark Aufflick on 26/08/10.
//  Copyright 2010 pumptheory.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MGATableViewCellContainer.h"

@interface MGATableViewArrayDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>
{
}

@property (retain) NSArray *dataArray;
@property (assign) id <UITableViewDelegate> delegate;

- (NSArray *)contentRanges;
- (NSRange)contentRangeForSection:(NSInteger)section;
- (NSArray *)contentArrayForSection:(NSInteger)section;
- (id)objectForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MGATableString : NSObject {}

@property (retain) NSString *string;

- (id) initWithString:(NSString *)string;

@end

@interface MGATableHeader : MGATableString {}

+ (id) headerWithString:(NSString *)string;

@end

@interface MGATableFooter : MGATableString {}

+ (id) footerWithString:(NSString *)string;

@end

@interface MGATableSectionBreak : MGATableString {}

+ (id) sectionBreak;

@end