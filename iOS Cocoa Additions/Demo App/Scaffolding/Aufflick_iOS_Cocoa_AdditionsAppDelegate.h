//
//  Aufflick_iOS_Cocoa_AdditionsAppDelegate.h
//  Aufflick iOS Cocoa Additions
//
//  Created by Mark Aufflick on 26/08/10.
//  Copyright pumptheory.com 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Aufflick_iOS_Cocoa_AdditionsAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

