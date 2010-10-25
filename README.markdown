Aufflick Cocoa Additions
========================

This project will hold various helpful* Cocoa/Objective-C classes and other related things.

There are two sub-directories. "Cocoa Additions" has general Objective-C classes as well as Mac-specific classes. "iOS Cocoa Additions" has iOS/UIKit specific classes.

At the moment all files are standalone classes, but they are included in the respective projects so they can be bundled with tests, demos etc.

    * I must have found them helpful, otherwise I wouldn't have bothered. YMMV.

iOS Cocoa Additions
-------------------

* [MGATableView](aufflick-cocoa-additions/tree/master/iOS Cocoa Additions/MGATableView)
    * Makes generating simple table views, well simple. Eg. make a grouped table view menu with no datasource or delegate
* [UIImage+MGAScale](aufflick-cocoa-additions/tree/master/iOS Cocoa Additions/Categories)
    * `- (UIImage *)mga_imageScaledToFitSize:(CGSize)targetSize`

Cocoa Additions
---------------

* [NSString+Levenshtein](aufflick-cocoa-additions/tree/master/Cocoa Additions/NSString+Levenshtein)
    * do fuzzy string matching with Levenshtein distance on NSStrings
    * `- (float) asciiLevenshteinDistanceWithString: (NSString *)stringB`
    * `- (float) asciiLevenshteinDistanceWithString: (NSString *)stringB skippingCharacterSet: (NSCharacterSet *)charset`
* [MGAAutoScrollTo(TextField|Button)](aufflick-cocoa-additions/tree/master/Cocoa Additions/MGAAutoScroll)
    * scroll a parent scrollview to show a control when it becomes the firstResponder (eg. by tabbing)
    * `- (BOOL)becomeFirstResponder`
* [NSData+Aufflick](aufflick-cocoa-additions/tree/master/Cocoa Additions/NSData+Aufflick)
    * `- (unsigned char *) MGA_md5CharStar` - generate md5 (binary) from NSData
    * `- (NSString *) MGA_md5NSString` - generate md5 (NSString) from NSData
* [NSDate+Aufflick](aufflick-cocoa-additions/tree/master/Cocoa Additions/NSDate+Aufflick)
    * `- (NSDate *)MGA_stripTimeComponent`
    * `- (NSDate *)MGA_addMonths:(NSInteger)months`
