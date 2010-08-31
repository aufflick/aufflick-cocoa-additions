//
//  DemoOfMGATableView.h
//  Aufflick iOS Cocoa Additions
//
//  Created by Mark Aufflick on 27/08/10.
//  Copyright 2010 pumptheory.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DemoOfMGATableView : UIViewController <UITableViewDelegate>
{
    IBOutlet UITableViewCell *cell3;
    IBOutlet UISlider *cell3Slider;
    IBOutlet UITableViewCell *cell4;
    IBOutlet UILabel *cell4Label;
}

-(IBAction) sliderValueChanged:(id)sender;

@end
