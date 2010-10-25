//
//  DemoOfMGATableView.m
//  Aufflick iOS Cocoa Additions
//
//  Created by Mark Aufflick on 27/08/10.
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


#import "DemoOfMGATableView.h"
#import "MGATableView.h"

@implementation DemoOfMGATableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"MGATableView";
    
    /*
     * code created cell with block select action
     */
    UITableViewCell *cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    cell1.textLabel.text = @"NSLog(@\"FTW!\")";
    
    MGATableViewCellContainer *cont1 = [MGATableViewCellContainer containerWithCell:cell1 didSelectActionBlock:^{
        NSLog(@"FTW!");
        //cell1.selected = NO;
    }];
    [cell1 release];
    
    
    /*
     * demonstrating no selection when there is no block or delegate action
     */
    UITableViewCell *cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
    cell2.textLabel.text = @"This does nothing";
    
    /*
     * cell3 is a nib-based cell used directly
     */

    cell3Slider.value = 0;
    
    
    /*
     * cell4 is nib-based, wrapped in an MGATableViewCellContainer
     */
    MGATableViewCellContainer *cont4 = [MGATableViewCellContainer
                                        containerWithCell:cell4 didSelectActionBlock:^{
        [cell3Slider setValue:0 animated:YES];
        cell4Label.text = @"0";
        cell4.selected = NO;
    }];
    
    cell4Label.text = @"0";
    
    /*
     * cell5 demonstrates using an image
     */
    
    MGATableViewCellLabel *cont5 = [MGATableViewCellLabel containerWithTitle:@"Clarus"];
    cont5.didSelectActionBlock = ^(id data){
        NSLog(@"Moof");
        cont5.cell.selected = NO;
    };
    cont5.cell.imageView.image = [UIImage imageNamed:@"clarus.png"];
    
    MGATableView *tableView = (MGATableView *)self.view;
    
    tableView.mgaDataSource.delegate = self;
    
    tableView.mgaDataSource.dataArray = [NSArray arrayWithObjects:
                                         
                                         [MGATableHeader headerWithString:@"Section 1 Header"],
                                         cont1,
                                         cell2,
                                         [MGATableViewCellLabel containerWithTitle:@"Also does nothing"],
                                         [MGATableFooter footerWithString:@"Section 1 Footer"],
                                         
                                         [MGATableHeader headerWithString:@"Section 2 Header"],
                                         cell3,
                                         
                                         [MGATableSectionBreak sectionBreak],
                                         cont4,
                                         cont5,
                                         [MGATableFooter footerWithString:@"Section 3 Footer"],
                                         
                                         nil];
    
    [cell2 release];
}

- (IBAction)sliderValueChanged:(id)sender
{
    cell4Label.text = [NSString stringWithFormat:@"%0.1f", cell3Slider.value];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
