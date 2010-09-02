//
//  MGATableViewCellLabel.h
//  Aufflick iOS Cocoa Additions
//
//  Created by Mark Aufflick on 2/09/10.
//  Copyright 2010 pumptheory.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGATableViewCellContainer.h"

@interface MGATableViewCellLabel : MGATableViewCellContainer
{
}

+(MGATableViewCellLabel *)containerWithTitle:(NSString *)title;
+(MGATableViewCellLabel *)containerWithTitle:(NSString *)title didSelectActionBlock:(void(^)(id data))didSelectActionBlock;

-(id)initWithTitle:(NSString *)title;

@end
