//
//  RootViewController.m
//  Aufflick iOS Cocoa Additions
//
//  Created by Mark Aufflick on 26/08/10.
//  Copyright pumptheory.com 2010. All rights reserved.
//

#import "RootViewController.h"

#import "MGATableView.h"
#import "DemoOfMGATableView.h"

@implementation RootViewController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Demo Menu";
        
    MGATableView *tableView = (MGATableView *)self.view;
        
    tableView.mgaDataSource.dataArray = [NSArray arrayWithObjects:
                            
                                         [MGATableHeader headerWithString:@"Demo Screens"],
                                         [MGATableViewCellSubMenu subMenuWithTitle:@"MGATableView"
                                                            viewControllerClass:[DemoOfMGATableView class]],
                            
                                         nil];
    
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

