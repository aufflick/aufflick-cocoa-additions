//
//  UIImage+ProportionalFill.h
//
//  Created by Mark Aufflick on 22/10/2010.
//  based on code from Stack Overflow user Jane Sales.
// http://stackoverflow.com/questions/185652/how-to-scale-a-uiimageview-proportionally/537697#537697
//  with a small change to automatically switch the target
//  width/height as appropriate.
//

#import <UIKit/UIKit.h>

@interface UIImage (MGAScale)

- (UIImage *)mga_imageScaledToFitSize:(CGSize)targetSize;

@end
