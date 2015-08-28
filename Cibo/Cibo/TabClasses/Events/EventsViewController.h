//
//  EventsViewController.h
//  Cibo
//
//  Created by mithun ravi on 20/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomeClass.h"
#import "EventCell.h"
#import "WebServiceHelper.h"
#import "UIImageView+WebCache.h"


@class AppDelegate;
@interface EventsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,WebServiceHelperDelegate>

{
    EventCell *eventCell;
    AppDelegate *appDelegate;
    NSUserDefaults *eventDefault;
    UIView *timeBackgroundView;
    IBOutlet UILabel *lblTitle;
}

@property (nonatomic, strong) IBOutlet UITableView *eventTableView;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) UISegmentedControl *cancelButton,*doneButton;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) IBOutlet UILabel *monthLabel,*titleLabel;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) NSMutableArray *eventCollectionArray;

@end
