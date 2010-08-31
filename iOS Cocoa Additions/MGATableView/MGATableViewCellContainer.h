//
//  MGATableViewCellContainer.h
//  Aufflick iOS Cocoa Additions
//
//  Created by Mark Aufflick on 26/08/10.
//  Copyright 2010 pumptheory.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MGATableViewCellContainer : NSObject
{
}

+(MGATableViewCellContainer *) containerWithCell:(UITableViewCell *)cell;
+(MGATableViewCellContainer *) containerWithCell:(UITableViewCell *)cell
                         andDidSelectActionBlock:(void(^)(void))didSelectActionBlock;
-(MGATableViewCellContainer *)initWithCell:(UITableViewCell *)cell;

@property (retain) UITableViewCell *cell;
@property (copy) void(^didSelectActionBlock)(void);
@property (copy) void(^accessoryTapActionBlock)(void);

@end
