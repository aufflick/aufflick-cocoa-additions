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
                            didSelectActionBlock:(void(^)(void))didSelectActionBlock;
+(MGATableViewCellContainer *) containerWithCell:(UITableViewCell *)cell
                                            data:(id)data
                            didSelectActionBlock:(void(^)(id data))didSelectActionBlock;

-(id)initWithCell:(UITableViewCell *)cell;

@property (retain) UITableViewCell *cell;
@property (retain) id data;
@property (copy) void(^didSelectActionBlock)(id data);
@property (copy) void(^accessoryTapActionBlock)(id data);

@end
