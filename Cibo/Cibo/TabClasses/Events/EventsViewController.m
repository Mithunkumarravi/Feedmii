//
//  EventsViewController.m
//  Cibo
//
//  Created by mithun ravi on 20/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "EventsViewController.h"

@interface EventsViewController ()

@end

@implementation EventsViewController
@synthesize eventTableView;
@synthesize actionSheet;
@synthesize cancelButton,doneButton;
@synthesize datePicker;
@synthesize monthLabel;
@synthesize titleLabel;
@synthesize selectedDate;
@synthesize eventCollectionArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    eventDefault=[NSUserDefaults standardUserDefaults];
    eventCollectionArray=[[NSMutableArray alloc] init];
    titleLabel.text=ciboRestaurantName;//[eventDefault objectForKey:@"Restaurantname"];
    lblTitle.font=[UIFont fontWithName:FONT_Ragular size:20.0];
    [lblTitle setFont: [lblTitle.font fontWithSize: 20.0]];

    monthLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [monthLabel setFont: [monthLabel.font fontWithSize: 12.0]];


    if (IS_IPHONE5)
    {
        eventTableView.frame=CGRectMake(0, 88, 320, 510-49);
    }
    else
    {
        eventTableView.frame=CGRectMake(0, 88, 320, 460);
        
    }
    
    
    /////////// current month in string ......../////////////
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    titleLabel.text=ciboRestaurantName;//[MyCustomeClass languageSelectedStringForKey:[NSString stringWithFormat:@"%@",[eventDefault objectForKey:@"Restaurantname"]]];
    
    eventTableView.backgroundColor=[UIColor clearColor];
    NSDate *currentDate=[NSDate date];
    monthLabel.text=[MyCustomeClass currentMonthInString:currentDate];
    
    NSDateFormatter *formate=[[NSDateFormatter alloc] init];
    [formate setDateFormat:@"yyyy-mm-dd"];
    NSString *dateString=[formate stringFromDate:currentDate];
    selectedDate=[formate dateFromString:dateString];
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Event Loading..."]];
    
    monthLabel.text=[MyCustomeClass languageSelectedStringForKey:[NSString stringWithFormat:@"%@",[MyCustomeClass currentMonthInString:currentDate]]];
    [self galleryInfoRequest];
    
    [appDelegate tabBarHide];
}

#pragma mark - Action method list
-(IBAction)clickOnCellPlusButton:(id)sender
{
    if (IS_IOS8)
    {
        eventCell = (EventCell *)[[sender superview] superview] ;
        
    }else
    {
        eventCell = (EventCell *)[[[sender superview] superview] superview];
    }
    NSIndexPath *clickedButtonPath = [self.eventTableView indexPathForCell:eventCell];
    NSLog(@"%ld",(long)clickedButtonPath.row);
    NSString *eventTitle=[NSString stringWithFormat:@"%@",eventCell.titleLable.text];
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:eventTitle message:[MyCustomeClass languageSelectedStringForKey:@"Do you want to attend this event."] delegate:self cancelButtonTitle:[MyCustomeClass languageSelectedStringForKey:@"Cancel"] otherButtonTitles:[MyCustomeClass languageSelectedStringForKey:@"Yes I Want"], nil];
    [alert show];
}

-(IBAction)clickOnCalendarButton:(id)sender
{
    if (timeBackgroundView==nil)
    {
        if(eventCollectionArray.count>0)
            [self addDatePickerWithDoneAndCancelButton];
        else
        {
            [[[UIAlertView alloc]initWithTitle:@"Alert !" message:@"Event not available now." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil] show];
        }

    }
}
-(IBAction)clickOnHomeButton:(id)sender
{
    UIApplication *application=nil;
    NSDictionary *dic=nil;
    [eventDefault setValue:@"Home" forKey:@"RootView"];
    [eventDefault setValue:@"Home" forKey:@"Logout"];
    
    [appDelegate application:application didFinishLaunchingWithOptions:dic];
}

#pragma mark - Webservics Response classes
-(void)galleryInfoRequest
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Event Loading..."]];
    
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    
    NSString *postData=[NSString stringWithFormat:@"%@/eventDate/%@",[eventDefault objectForKey:@"Restaurantid"],selectedDate];
    NSLog(@"%@",postData);
    NSArray *dateFormatingArray=[MyCustomeClass seprateStringFromStringUsingArrray:postData :@" "];
    
    [helper gettingEvents:[NSString stringWithFormat:@"%@",[dateFormatingArray objectAtIndex:0]]];
}
-(void)gettingEvents:(NSString *)response
{
    [eventCollectionArray removeAllObjects];
    // NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    // NSLog(@"%@",dataDic);
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"FAIL"])
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Some connection issue."] :1.00];
    }
    else
    {
        NSMutableArray *localEventList=[[NSMutableArray alloc] init];
        localEventList=[dataDic objectForKey:@"eventInfo"];
        if(localEventList.count>0)
        {
            eventCollectionArray=(NSMutableArray *)[[localEventList reverseObjectEnumerator] allObjects];
            [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Successfully done."] :1.00];
        }
        else
        {
            [MyCustomeClass SVProgressMessageDismissWithError:@"Not available now." :1.0];
        }
    }
    
    [eventTableView reloadData];
}

-(void)gettingFail:(NSString*)error
{
    NSLog(@"%@",error);
    [MyCustomeClass SVProgressMessageDismissWithSuccess:error :1.00];
    
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return eventCollectionArray.count;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 69;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier=@"EventCell";
    eventCell = (EventCell *)[eventTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (eventCell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"EventCell" owner:self options:nil];
        
        eventCell = [cellArray objectAtIndex:0];
    }
    if (eventCollectionArray.count>indexPath.row)
    {
        eventCell.titleLable.text=[NSString stringWithFormat:@"%@",[[eventCollectionArray objectAtIndex:indexPath.row]objectForKey:@"event_name"]];
        eventCell.descriptionLabel.text=[self stripTags:[NSString stringWithFormat:@"%@",[[eventCollectionArray objectAtIndex:indexPath.row]objectForKey:@"event_desc"]]];
        NSURL *imageurl=[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/events/thumb/%@",[eventDefault objectForKey:@"Restaurantid"],[[eventCollectionArray objectAtIndex:indexPath.row]objectForKey:@"event_image"]]];
        NSLog(@"%@",imageurl);
        [eventCell.foodImage setImageWithURL:imageurl];
        eventCell.descriptionLabel.backgroundColor=[UIColor clearColor];
        eventCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [eventCell.plusButton addTarget:self action:@selector(clickOnCellPlusButton:) forControlEvents:UIControlEventTouchUpInside];
        [MyCustomeClass roundedImageView:eventCell.foodImage];
        
        titleLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];

        if( [indexPath row] % 2)
            [eventCell setBackgroundColor:[UIColor whiteColor]];
        else
            [eventCell setBackgroundColor:[UIColor colorWithRed:179/255.0 green:206.0/255.0 blue:0.0/255.0 alpha:1.0]];;

    }
    return eventCell;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
- (NSString *)stripTags:(NSString *)str
{
    NSMutableString *html = [NSMutableString stringWithCapacity:[str length]];
    
    NSScanner *scanner = [NSScanner scannerWithString:str];
    scanner.charactersToBeSkipped = NULL;
    NSString *tempText = nil;
    
    while (![scanner isAtEnd])
    {
        [scanner scanUpToString:@"<" intoString:&tempText];
        
        if (tempText != nil)
            [html appendString:tempText];
        
        [scanner scanUpToString:@">" intoString:NULL];
        
        if (![scanner isAtEnd])
            [scanner setScanLocation:[scanner scanLocation] + 1];
        
        tempText = nil;
    }
    
    return html;
}
#pragma  mark - date picker with acction sheet

-(void)addDatePickerWithDoneAndCancelButton
{
    /* actionSheet = [[UIActionSheet alloc] initWithTitle:[MyCustomeClass languageSelectedStringForKey:@"Select Date"]
     delegate:nil
     cancelButtonTitle:nil
     destructiveButtonTitle:nil
     otherButtonTitles:nil];
     
     [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
     
     CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
     datePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
     //  myPickerView.showsSelectionIndicator = YES;
     //myPickerView.dataSource = self;
     //myPickerView.delegate = self;
     
     cancelButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:[MyCustomeClass languageSelectedStringForKey:@"Cancel"]]];
     cancelButton.momentary = YES;
     cancelButton.frame = CGRectMake(10, 7.0f, 50.0f, 30.0f);
     cancelButton.segmentedControlStyle = UISegmentedControlStyleBar;
     cancelButton.tintColor = [UIColor grayColor];
     [cancelButton addTarget:self action:@selector(clickOnCancelButtonOnActionSheet:) forControlEvents:UIControlEventValueChanged];
     //////////////////////////////////////////////
     doneButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:[MyCustomeClass languageSelectedStringForKey:@"Done"]]];
     doneButton.momentary = YES;
     doneButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
     doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
     doneButton.tintColor = [UIColor grayColor];
     [doneButton addTarget:self action:@selector(clickOnDoneButtonOnActionSheet:) forControlEvents:UIControlEventValueChanged];
     
     [actionSheet addSubview:cancelButton];
     [actionSheet addSubview:doneButton];
     [actionSheet addSubview:datePicker];
     [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
     [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
     
     return actionSheet;*/
    NSDate *date = [NSDate date];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.hidden = NO;
    datePicker.date = date;
    [datePicker setMinimumDate:[NSDate date]];
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    pickerToolbar.tintColor = [UIColor whiteColor];
    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(clickOnCancelButtonOnActionSheet:)];
    
    [cancelBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                       NSForegroundColorAttributeName,
                                       nil] forState:UIControlStateNormal];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *titleButton;
    float pickerMarginHeight = 168;
    titleButton = [[UIBarButtonItem alloc] initWithTitle:@"Select Date" style:UIBarButtonItemStylePlain target: nil action: nil];
    
    [titleButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                         NSForegroundColorAttributeName,
                                         nil] forState:UIControlStateNormal];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(clickOnDoneButtonOnActionSheet:)];
    
    [doneBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                     NSForegroundColorAttributeName,
                                     nil] forState:UIControlStateNormal];
    
    NSArray *itemArray = [[NSArray alloc] initWithObjects:cancelBtn, flexSpace, titleButton, flexSpace, doneBtn, nil];
    
    [pickerToolbar setItems:itemArray animated:YES];
    
    if(IS_IPAD)
    {
        [pickerToolbar setFrame:CGRectMake(0, 0, 320, 44)];
        
        UIViewController* popoverContent = [[UIViewController alloc] init];
        popoverContent.preferredContentSize = CGSizeMake(320, 216);
        UIView* popoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
        popoverView.backgroundColor = [UIColor whiteColor];
        [popoverView addSubview:datePicker];
        [popoverView addSubview:pickerToolbar];
        popoverContent.view = popoverView;
        UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
        [popoverController presentPopoverFromRect:CGRectMake(0, pickerMarginHeight, 320, 216) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    else
    {
        timeBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 568-240, 320, 246)];
        [timeBackgroundView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
        [timeBackgroundView addSubview:pickerToolbar];
        [timeBackgroundView addSubview:datePicker];
        [appDelegate.window addSubview:timeBackgroundView];
        timeBackgroundView.hidden=NO;
    }
}

-(IBAction)clickOnCancelButtonOnActionSheet:(id)sender
{
    timeBackgroundView.hidden=YES;
    [timeBackgroundView removeFromSuperview];
    timeBackgroundView=nil;
}
-(IBAction)clickOnDoneButtonOnActionSheet:(id)sender
{
    NSDate *changeDate=datePicker.date;
    monthLabel.text=[MyCustomeClass languageSelectedStringForKey:[NSString stringWithFormat:@"%@",[MyCustomeClass currentMonthInString:changeDate]]];
    NSDateFormatter *formate=[[NSDateFormatter alloc] init];
    [formate setDateFormat:@"yyyy-mm-dd"];
    NSString *dateString=[formate stringFromDate:changeDate];
    selectedDate=[formate dateFromString:dateString];
    [self galleryInfoRequest];
    timeBackgroundView.hidden=YES;
    [timeBackgroundView removeFromSuperview];
    timeBackgroundView=nil;
    
}
#pragma mark - alertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:[MyCustomeClass languageSelectedStringForKey:@"Cancel"]])
    {
        
    }
    else if([title isEqualToString:[MyCustomeClass languageSelectedStringForKey:@"Yes I Want"]])
    {
        
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            
            SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            [controller setInitialText:[NSString stringWithFormat:@"%@\n\n %@",eventCell.titleLable.text,eventCell.descriptionLabel.text]];
            [controller addURL:[NSURL URLWithString:@"http://www.cibo.com"]];
            [controller addImage:eventCell.foodImage.image];
            
            [self presentViewController:controller animated:YES completion:Nil];
            
        }
        else
        {
            [MyCustomeClass alertMessage:@"Please go in device setting and add your" :@"facebook account after that you can share" :@"OK"];
        }
        
    }
}


@end
