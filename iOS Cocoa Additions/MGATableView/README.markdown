MGATableView
============

I often find myself writing a very thin data source and delegate object for a UITableView
simply to display a static menu. This class aims to be a data driven drop in object for
very simple cases.

Synopsis
--------

In this example, from the demo app, there is an MGATableView instance from the nib attached to
the tableView outlet of a UIViewController. (In Interface Builder it is just a normal
UITableView, but with the class set to MGATableView in the inspector):

    - (void)viewDidLoad {
        [super viewDidLoad];
        
        self.title = @"Demo Menu";
            
        MGATableView *tableView = (MGATableView *)self.view;
            
        tableView.mgaDataSource.dataArray = [NSArray arrayWithObjects:
                                
                                             [MGATableHeader headerWithString:@"Demo Screens"],
                                             [MGATableViewCellSubMenu subMenuWithTitle:@"MGATableView"
                                                                viewControllerClass:[DemoOfMGATableView class]],
                                             [MGATableViewCellLabel containerWithTitle:@"FTW" didSelectActionBlock:^{
                                                  NSLog(@"FTW!");
                                                  cell1.selected = NO;
                                             }];
                                
                                             nil];
    }
 
This is a classic UITableView menu - a header, a cell which, when tapped, will cause the desired
UIViewController class to be pushed onto the current UINavigationController, and a cell with a
custom tap action.


In Depth
--------

You can use these classes in a number of ways. The simplest is the convenience class
MGATableView, as shown in the Synopsis above. In this form, you simply supply an MGATableViewArrayDataSource
configure with an NSArray of headers, footers, separators and cells. You can also use a regular UITableView
and set the delegate and dataSource properties to the MGATableViewArrayDataSource yourself.

* cells - instances of UITableViewCell or a subclass
* cell containers - instances of MGATableViewCellContainer, one of the provided subclasses or your own
  * MGATableViewCellLabel
  * MGATableViewCellSubMenu
* headers or dividers - instances of:
  * MGATableHeader
  * MGATableFooter
  * MGATableSectionBreak

These instances can be used with MGATableView or directly with MGATableViewArrayDataSource.

TableView & Data Source Classes
-------------------------------

### MGATableView

This is a subclass of UITableView. You can create one programatically or in Interface Builder
(where you use the normal UITableView widget and change the class in the Inspector to MGATableView).

It defines one new property, mgaDataSource, otherwise it is a regular UITableView. This property
must be set to an instance of MGATableViewDataSource. When you set this property, the delegate
and data source of the UITableView will be automatically set to the mgaDataSource object.

### MGATableViewDataSource

Unlike its name suggests, this class can act as both a data source and a delegate to a UITableView.
It has two properties, dataArray and delegate. dataArray allows you to provide the NSArray
containing the cells, headers, etc. The optional delegate property allows you to provide a delegate
object to override the built in delegate functionality - primarily so you can handle any unhandled
delegate messages.

Content Classes
---------------

These are the classes you use to build content into the table view.

### UITableViewCell

You can provide a normal table view cell. Since you are (probably) not providing your own delegate
you have no way to intercept taps etc. so it's limited to providing a non-interactive cell.

### MGATableViewCellContainer

This wraps a UITableViewCell along with some user data and actions (as blocks) to perform when it is tapped
or its accessory view is tapped.

There are convenience methods to ease creating these containers, but you still have to create your own
UITableViewCell instance.

### MGATableViewCellLabel

This is a subclass of MGATableViewCellContainer which will create the UITableViewCell for you, using an
NSString to set the title of the cell. You can attach actions, since it's an MGATableViewCellContainer,
so it provides the functionality you commonly want very simply.

You can see an example in the Synopsis above.

### MGATableViewCellSubMenu

Warning - contains magic! To weave its magic, MGATableViewCellSubMenu makes an important assumption - that the
delegate object attached to [UIApplication sharedApplication] has a property navigationController.

You instantiate an MGATableViewCellSubMenu with an NSString title, and a class, which must be a subclass
of UIViewController which is suitable for pushing onto a UINavigationController. When the cell is tapped,
an instance of that class is instantiated and pushed onto the navigation. Finally the tapped cell is
deselected.

### MGATableHeader

An object with an NSString property for it's title. Wherever this appears in the array, a new section will
start with this header.

### MGATableFooter

Like MGATableHeader, except this creates a footer before starting a new section

### MGATableSectionBreak

If you provide either (or both) a header and footer, a new section will automatically be created. An
instance of this class is only necessary if you want a section break without either a header or a footer.

Further Info
------------

Please see the relevant headers and also the demo app for further examples and information. Failing that, feel
free to contact me:

    Mark Aufflick
      mark@pumptheory.com
      http://mark.aufflick.com
    
    Pumptheory
      http://pumptheory.com
