//
//  MGATableView.h
//  Aufflick iOS Cocoa Additions
//
//  Created by Mark Aufflick on 26/08/10.
//  Copyright 2010 pumptheory.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MGATableViewArrayDataSource.h"

@interface MGATableView : UITableView
{
    MGATableViewArrayDataSource *_mgaDataSource;
}

@property (readonly) MGATableViewArrayDataSource *mgaDataSource;

@end
