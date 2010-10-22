//
//  UIImage+ProportionalFill.h
//
//  Created by Mark Aufflick on 22/10/2010.
//  based on code from Stack Overflow user Jane Sales.
// http://stackoverflow.com/questions/185652/how-to-scale-a-uiimageview-proportionally/537697#537697
//  with a small change to automatically switch the target
//  width/height as appropriate.
//

#import "UIImage+MGAScale.h"


@implementation UIImage (MGAScale)

- (UIImage *)mga_imageScaledToFitSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    // do we have to swap target width/height?
    if (
        (width > height && targetSize.height > targetSize.width) ||
        (height > width && targetSize.width > targetSize.height)
        )
    {
        targetSize = CGSizeMake(targetSize.height, targetSize.width);
    }

    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
        
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor < heightFactor) 
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5; 
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    // this is actually the interesting part:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    return newImage ;    
}


@end
