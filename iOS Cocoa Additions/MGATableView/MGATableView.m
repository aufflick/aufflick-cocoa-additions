//
//  MGATableView.m
//  Aufflick iOS Cocoa Additions
//
//  Created by Mark Aufflick on 26/08/10.
//  Copyright 2010 pumptheory.com. All rights reserved.
//

#import "MGATableView.h"

#import "MGATableViewArrayDataSource.h"


@implementation MGATableView

-(MGATableViewArrayDataSource *) mgaDataSource
{
    if (!_mgaDataSource)
    {
        _mgaDataSource = [[MGATableViewArrayDataSource alloc] init];
        self.dataSource = _mgaDataSource;
        
        if (self.delegate) {
            NSLog(@"MGATableView: stomping on existing delegate (%@) - you should set a delegate on the mgaDataSource instead", self.delegate);
        }
        
        self.delegate = _mgaDataSource;
    }
    
    return _mgaDataSource;
}

-(void) dealloc
{
    [_mgaDataSource release];
    
    [super dealloc];
}

@end
