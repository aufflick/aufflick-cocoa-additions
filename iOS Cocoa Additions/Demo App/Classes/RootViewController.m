//
//  RootViewController.m
//  Aufflick iOS Cocoa Additions
//
//  Created by Mark Aufflick on 26/08/10.
//  Copyright pumptheory.com 2010. All rights reserved.
//

#import "RootViewController.h"

#import "MGATableView.h"

@implementation RootViewController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableViewCell *cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    cell1.textLabel.text = @"Foo1";
    UITableViewCell *cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
    cell2.textLabel.text = @"Bar2";
    UITableViewCell *cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
    cell3.textLabel.text = @"Foo3";
    UITableViewCell *cell4 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
    cell4.textLabel.text = @"Bar4";
    
    MGATableView *tableView = (MGATableView *)self.view;
    
    tableView.mgaDataSource.delegate = self;
    
    tableView.mgaDataSource.dataArray = [[NSArray alloc] initWithObjects:
                            
                                  [MGATableHeader headerWithString:@"Section 1 Header"],
                                  cell1,
                                  cell2,
                                  [MGATableFooter footerWithString:@"Section 1 Footer"],
                            
                                  [MGATableHeader headerWithString:@"Section 2 Header"],
                                  cell3,
                            
                                  [MGATableSectionBreak sectionBreak],
                                  cell4,
                                  [MGATableFooter footerWithString:@"Section 3 Footer"],
                            
                                  nil];
    
    [cell1 release];
    [cell2 release];
    [cell3 release];
    [cell4 release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


- (void)dealloc {
    [super dealloc];
}


@end

