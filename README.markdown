Aufflick Cocoa Additions
========================

This project will hold various helpful* Cocoa/Objective-C classes and other related things.

There are two sub-directories. "Cocoa Additions" has general Objective-C classes as well as Mac-specific classes. "iOS Cocoa Additions" has iOS/UIKit specific classes.

At the moment all files are standalone classes, but they are included in the respective projects so they can be bundled with tests, demos etc.

* I must have found them helpful, otherwise I wouldn't have bothered. YMMV.

iOS Cocoa Additions
-------------------

* [MGATableView](aufflick-cocoa-additions/tree/master/iOS Cocoa Additions/MGATableView) - makes generating simple table views, well simple. Eg. make a grouped table view menu with no datasource or delegate

Cocoa Additions
---------------

* [NSString+Levenshtein](aufflick-cocoa-additions/tree/master/Cocoa Additions/NSString+Levenshtein) - do fuzzy string matching with Levenshtein distance on NSStrings
* [MGAAutoScrollTo(TextField|Button)](aufflick-cocoa-additions/tree/master/Cocoa Additions/MGAAutoScroll) - scroll a parent scrollview to show a control when it becomes the firstResponder (eg. by tabbing)
