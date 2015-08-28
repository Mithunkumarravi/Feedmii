//
//  IndexPageViewController.m
//  Cibo
//
//  Created by mithun ravi on 16/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "IndexPageViewController.h"

@interface IndexPageViewController ()

@end


@implementation IndexPageViewController
@synthesize indexTebleView;
@synthesize iconArray,textArray;
@synthesize titleLabel;
@synthesize logoutButton;
@synthesize eventButton,foodButton,munchPointsButton,MunchPointButton,galleryButton,ourVenuButton;

@synthesize myMunchPoints,middlemunchPoint,leftLowerCorner;
@synthesize settingbutton,sharebutton,infoButton;
@synthesize lowerTab;
@synthesize backgroundImage,menuImage;
@synthesize beaconCompainingArray;
@synthesize gallaryArray;
@synthesize categoryArray;
@synthesize pickerView;
@synthesize isTableBooking;
 

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
    indexDefault = [NSUserDefaults standardUserDefaults];
    _videoBuffer = [[GPUImageBuffer alloc] init];
    [_videoBuffer setBufferSize:1];
    beaconCompainingArray=[[NSMutableArray alloc] init];
    gallaryArray=[[NSMutableArray alloc] init];
    categoryArray=[[NSMutableArray alloc] init];
    catButton.hidden = YES;
   
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [MyCustomeClass addSwipGestureFromRightToLeft:self.view action:@selector(nextImage) target:self];
    [MyCustomeClass addSwipGestureFromLeftToRight:self.view action:@selector(previewImage) target:self];
    
    onlineLabel.font=[UIFont fontWithName:FONT_Ragular size:14.0];
    [onlineLabel setFont: [onlineLabel.font fontWithSize: 14.0]];
    
    eventLabel.font=[UIFont fontWithName:FONT_Ragular size:14.0];
    [eventLabel setFont: [eventLabel.font fontWithSize: 14.0]];
    
    ourLabel.font=[UIFont fontWithName:FONT_Ragular size:14.0];
    [ourLabel setFont: [ourLabel.font fontWithSize: 14.0]];
    
    offerLabel.font=[UIFont fontWithName:FONT_Ragular size:14.0];
    [offerLabel setFont: [offerLabel.font fontWithSize: 14.0]];
    
    bookTableLabel.font=[UIFont fontWithName:FONT_Ragular size:14.0];
    [bookTableLabel setFont: [bookTableLabel.font fontWithSize: 14.0]];
    
    myOrderLabel.font=[UIFont fontWithName:FONT_Ragular size:14.0];
    [myOrderLabel setFont: [myOrderLabel.font fontWithSize: 14.0]];

    restuantNameLabel.font=[UIFont fontWithName:FONT_Ragular size:20.0];
    [restuantNameLabel setFont: [restuantNameLabel.font fontWithSize: 20.0]];
}

-(void)moviePlayer
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *moviePath = [bundle pathForResource:@"Video" ofType:@"m4v"];
    NSURL *movieURL = [NSURL fileURLWithPath:moviePath] ;
    
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    moviePlayer.view.transform = CGAffineTransformConcat(moviePlayer.view.transform, CGAffineTransformMakeRotation(M_PI_2));
    
    UIWindow *backgroundWindow = [[UIApplication sharedApplication] keyWindow];
    [moviePlayer.view setFrame:backgroundWindow.frame];
    [backgroundImage addSubview:moviePlayer.view];
    [moviePlayer setRepeatMode:MPMovieRepeatModeOne];
    [MyCustomeClass addSwipGestureFromLeftToRight:self.view action:@selector(nextImage) target:self];
    [MyCustomeClass addSwipGestureFromRightToLeft:self.view action:@selector(previewImage) target:self];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [moviePlayer stop];
    moviePlayer=nil;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (ciboRestaurantId.length<=0)
    {
        MuiltpleViewController *multi=[[MuiltpleViewController alloc] initWithNibName:@"MuiltpleViewController" bundle:nil];
        [self presentViewController:multi animated:true completion:nil];
         return ;
    }
    restuantNameLabel.text =ciboRestaurantName;
    
    if([appDelegate.cardOpenFromOrder isEqualToString:@"OutOffRestaurant"])
    {
        if ([[indexDefault objectForKey:@"Email"] length]>0)
        {
            CardViewController *card=[[CardViewController alloc] initWithNibName:@"CardViewController" bundle:nil];
            [self presentViewController:card animated:true completion:nil];;
            appDelegate.cardOpenFromOrder=@"";
        }
        else
        {
            ViewController *view=[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
            [self presentViewController:view animated:true completion:nil];
        }
    }

    
}

-(void)viewWillAppear:(BOOL)animated
{
    if (ciboRestaurantId.length<=0)
    {
        MuiltpleViewController *multi=[[MuiltpleViewController alloc] initWithNibName:@"MuiltpleViewController" bundle:nil];
        [self presentViewController:multi animated:true completion:nil];
        // return ;
    }
    else
    {
        [self galleryInfoRequest];
    }
    
    [logoutButton setTitle:[MyCustomeClass languageSelectedStringForKey:@"Logout"] forState:UIControlStateNormal];
    titleLabel.text=[MyCustomeClass languageSelectedStringForKey:[NSString stringWithFormat:@"%@",[indexDefault objectForKey:@"Restaurantname"]]];
    if ([[indexDefault objectForKey:@"Email"] length]>0)
    {
       logoutButton.hidden=NO;
    }
    else
    {
        logoutButton.hidden=YES;
    }
    
    if (ciboRestaurantId.length>0)
    {
        [self beaconCompainingRequest];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Action method list..
-(IBAction)clickONInfoButton:(id)sender
{
    InfoViewController *infoVC=[[InfoViewController alloc]initWithNibName:@"InfoViewController" bundle:nil];
    [self presentViewController:infoVC animated:YES completion:nil];
}

-(IBAction)clicOnLogoutButton:(id)sender
{
    [indexDefault setValue:@"Logout" forKey:@"Logout"];
    [indexDefault setValue:@"view" forKey:@"RootView"];
    UIApplication *application;
    [appDelegate application:application didFinishLaunchingWithOptions:nil];
    [self.navigationController popViewControllerAnimated:true];
    [indexDefault setValue:@"" forKey:@"Email"];
    logoutButton.hidden=YES;
}

-(IBAction)clickOnShare:(id)sender
{
    ShareViewController *shareVC=[[ShareViewController alloc]initWithNibName:@"ShareViewController" bundle:nil];
    [self presentViewController:shareVC animated:YES completion:nil];
}

-(IBAction)clickOnSettingsButton:(id)sender
{
    if ([[indexDefault objectForKey:@"Email"] length]>0)
    {
        SettingsViewController *settingVC=[[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
        [self presentViewController:settingVC animated:YES completion:nil];
        
    }
    else
    {
        ViewController *viewController=[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        [self presentViewController:viewController animated:true completion:nil];
    }
}
-(IBAction)clickOnCheckOutButton:(id)sender
{
    //CardViewController *cardView=[[CardViewController alloc] initWithNibName:@"CardViewController" bundle:nil];
    //[self.navigationController pushViewController:cardView animated:true];
    appDelegate.openandPaymentWay=@"Payment";
    appDelegate.tabSelectedIndex=1;
    [appDelegate customTabbarController];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //appDelegate.tabSelectedIndex=indexPath.row;
    //[appDelegate customTabbarController];
    
}

-(IBAction)clickOnEventButton:(id)sender
{
    appDelegate.tabSelectedIndex=0;
    [appDelegate customTabbarController];
}

-(IBAction)clickOnMenuButton:(id)sender
{
    appDelegate.openandPaymentWay=@"Menu";
    appDelegate.tabSelectedIndex=1;
    [appDelegate customTabbarController];
}
-(IBAction)clickOnLoyalityButton:(id)sender
{
    appDelegate.tabSelectedIndex=2;
    [appDelegate customTabbarController];
}
-(IBAction)clickOnGalleryButton:(id)sender
{
    appDelegate.tabSelectedIndex=3;
    [appDelegate customTabbarController];
}
-(IBAction)clickOnLocationButton:(id)sender
{
    appDelegate.orderSelected=NO;
    appDelegate.tabSelectedIndex=4;
    [appDelegate customTabbarController];
}

-(IBAction)clickOnRestaurantListButton:(id)sender
{
    MuiltpleViewController *multi=[[MuiltpleViewController alloc] initWithNibName:@"MuiltpleViewController" bundle:nil];
    [self presentViewController:multi animated:true completion:nil];
}

#pragma mark - compaining saving ....

-(void)beaconCompainingRequest
{
    WebServiceHelper *helper =[[WebServiceHelper alloc] init];
    helper.delegate=self;
    [helper beaconCompaining:ciboRestaurantId];
}

-(void)beaconCompaining:(NSString *)response
{
    [beaconCompainingArray removeAllObjects];
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSLog(@"%@",dataDic);
    beaconCompainingArray=[dataDic valueForKey:@"beaconCampaignInfo"];
    //[self coupenBeaconRequest:@"34"];
    //[self happyHourBeaconRequest:@"46"];
    allBeaconInfoCount=0;
    if (beaconCompainingArray.count>0)
    {
        // ESTBeacon *beacon = [[beaconsArray objectAtIndex:0] objectForKey:@"UUID"];
       /* NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:[[beaconsArray objectAtIndex:0] objectForKey:@"UUID"]];
        self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:uuid major:(CLBeaconMajorValue)[[beaconsArray objectAtIndex:0] objectForKey:@"Major"] minor:(CLBeaconMajorValue)[[beaconsArray objectAtIndex:0] objectForKey:@"Minor"] identifier:@"NotificationIdentifier"];
        self.beaconManager.delegate = self;
        self.beaconRegion.notifyOnEntry = YES;
        self.beaconRegion.notifyOnExit = YES;
        [self.beaconManager startMonitoringForRegion:self.beaconRegion];*/
        [self allBeaconInfoWithCompainingIDRequest:[[beaconCompainingArray objectAtIndex:0] objectForKey:@"campaign_id"]];
    }
}

#pragma mark - Beacon Detail ....
-(void)allBeaconInfoWithCompainingIDRequest:(NSString *)compainingID
{
    WebServiceHelper *helper =[[WebServiceHelper alloc] init];
    helper.delegate=self;
    NSString *requestString = [NSString stringWithFormat:@"restId/%@/campaignId/%@",ciboRestaurantId,compainingID];
    [helper allBeaconDetailWithCompainingID:requestString];
}

-(void)allBeaconDetailWithCompainingID:(NSString* )response
{
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSLog(@"%@",dataDic);
    
    allBeaconInfoCount++;
    NSData* data=[NSKeyedArchiver archivedDataWithRootObject:[dataDic objectForKey:@"beaconInfo"]];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:[NSString stringWithFormat:@"Beacon%d",allBeaconInfoCount]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if([[dataDic objectForKey:@"notificationInfo"] count]>0)
    {
        NSMutableArray *notifyArray=[[NSMutableArray alloc] init];
        notifyArray = [dataDic objectForKey:@"notificationInfo"];
        for(int i=0;i<notifyArray.count;i++)
        {
            NSMutableArray *innerNotifArray = [[NSMutableArray alloc] init];
            [innerNotifArray addObjectsFromArray:[notifyArray objectAtIndex:i]];
            if ([[[innerNotifArray objectAtIndex:0] valueForKey:@"check_in"] intValue]==1)
            {
                [[NSUserDefaults standardUserDefaults] setObject:[[innerNotifArray objectAtIndex:0] valueForKey:@"text"] forKey:@"CheckInMessage"];
            }
            else
            {
                [[NSUserDefaults standardUserDefaults] setObject:[[innerNotifArray objectAtIndex:0] valueForKey:@"text"] forKey:@"CheckOutMessage"];
            }
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        if(ciboRestaurantId==nil)
            return;
        
        [appDelegate SBBeaconStart];
    }
    if([[dataDic objectForKey:@"couponInfo"] count]>0)
    {
        NSMutableArray *couponInfoArray=[[NSMutableArray alloc] init];
        couponInfoArray = [dataDic objectForKey:@"couponInfo"];
        NSData* data=[NSKeyedArchiver archivedDataWithRootObject:couponInfoArray];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"BeaconCoupen"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    /*if (allBeaconInfoCount<beaconCompainingArray.count)
    {
        [self allBeaconInfoWithCompainingIDRequest:[[beaconCompainingArray objectAtIndex:allBeaconInfoCount] objectForKey:@"campaign_id"]];
    }
    
    NSData* data1 = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"Beacon%d",allBeaconInfoCount]];
    NSLog(@"%@",[NSKeyedUnarchiver unarchiveObjectWithData:data1]);
   // [self beaconStart];*/
}
-(void)gettingFail:(NSString *)error
{
    [MyCustomeClass SVProgressMessageDismissWithError:@"Please try again." :1.0];
}



#pragma mark - Webservics Request method
-(void)gettingGalleryCategroyList :(NSString *) categoryIDLocal
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Fetch Gallery data..."]];
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postData=[NSString stringWithFormat:@"/gallery/viewGallery/restId/%@/galleryCatId/%@",ciboRestaurantId,categoryIDLocal];
    NSLog(@"%@",postData);
    [helper galleryCategoryFromServer:postData];
    
}
-(void)galleryInfoRequest
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Loading..."]];
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postData=[NSString stringWithFormat:@"%@",ciboRestaurantId];
    NSLog(@"%@",postData);
    [helper gettingGallery:postData];
}

#pragma mark - Webservics Response method

-(void)gettingGallery:(NSString *)response
{
    NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSLog(@"%@",dataDic);
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"FAIL"])
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Some connection issue." ]:1.00];
    }
    else
    {
        categoryArray= [dataDic objectForKey:@"galleryCatInfo"];
        if (categoryArray.count>0)
        {
            [self gettingGalleryCategroyList:[NSString stringWithFormat:@"%@",[[categoryArray objectAtIndex:0] objectForKey:@"id"]]];
            [catButton setTitle:[[categoryArray objectAtIndex:0] objectForKey:@"cat_name"] forState:UIControlStateNormal];
        }
        else
        {
            [catButton setTitle:@"No Category" forState:UIControlStateNormal];
            galleryImageView.image =[UIImage imageNamed:@""];
            [MyCustomeClass SVProgressMessageDismissWithError:@"No Data." :1.0];
            galleryImageView.image = [UIImage imageNamed:@"logo1111.png"];

        }
    }
}

-(void)galleryCategoryFromServer:(NSString *)response
{
    [gallaryArray removeAllObjects];
    NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSLog(@"%@",dataDic);
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"FAIL"])
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Some connection issue."] :1.00];
    }
    else
    {
        gallaryArray= [dataDic objectForKey:@"galleryInfo"];
        if (gallaryArray.count>0)
        {
            [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey: @""] :0.00];
            nextImageInteger=0;
            NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/gallery/thumb/%@",ciboRestaurantId,[[gallaryArray objectAtIndex:nextImageInteger] objectForKey:@"path"]]];
            [galleryImageView setImageWithURL:url];
        }
        else
        {
            [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey: @"No data."] :1.00];
        }
    }
    //[catButton setTitle:[[categoryArray objectAtIndex:displayCategoryCount] objectForKey:@"cat_name"] forState:UIControlStateNormal];
}

#pragma mark - Message api
-(void)previewImage
{
    nextImageInteger--;
    if (nextImageInteger>=0 && nextImageInteger<gallaryArray.count)
    {
        NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/gallery/thumb/%@",ciboRestaurantId,[[gallaryArray objectAtIndex:nextImageInteger] objectForKey:@"path"]]];
        [galleryImageView setImageWithURL:url];
    }
    else
    {
        nextImageInteger=0;
    }
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [galleryImageView.layer addAnimation:transition forKey:nil];
}

-(void)nextImage
{
    nextImageInteger++;
    if (nextImageInteger<gallaryArray.count && nextImageInteger>0)
    {
        NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://ciboapp.com/admin/img/%@/gallery/thumb/%@",ciboRestaurantId,[[gallaryArray objectAtIndex:nextImageInteger] objectForKey:@"path"]]];
        [galleryImageView setImageWithURL:url];
    }
    else
    {
        nextImageInteger=0;
    }
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [galleryImageView.layer addAnimation:transition forKey:nil];
    
}
-(void)moveRightToLeft
{
    [MyCustomeClass myMovingAnimationLeftRight:galleryImageView direction:1 :320];
}
-(void)moveLeftToRight
{
    [MyCustomeClass myMovingAnimationLeftRight:galleryImageView direction:0 :320];
}


#pragma mark - Data Picker methods
-(IBAction)clickOnMyOrderList:(id)sender
{
   
    if ([[indexDefault objectForKey:@"Email"] length]>0)
    {
        MyOpenOrderViewController *order=[[MyOpenOrderViewController alloc] initWithNibName:@"MyOpenOrderViewController" bundle:nil];
        
        [self presentViewController:order animated:true completion:nil];
    }
    else
    {
        [appDelegate tabBarHide];
        ViewController *viewController=[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        [self presentViewController:viewController animated:true completion:nil];
    }
}
-(IBAction)clickOnReservationButton:(id)sender
{
    //if (isTableBooking==1)
    {
        if ([[indexDefault objectForKey:@"Email"] length]>0)
        {
            appDelegate.bookedTable=nil;
            appDelegate.orderSelected = NO;
            TableReservationViewController *tableReservation=[[TableReservationViewController alloc] initWithNibName:@"TableReservationViewController" bundle:nil];
            [self presentViewController:tableReservation animated:true completion:nil];
        }
        else
        {
            [appDelegate tabBarHide];
            ViewController *viewController=[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
            [self presentViewController:viewController animated:true completion:nil];
        }
    }
   /* else
    {
        [[[UIAlertView alloc] initWithTitle:@"No Table Booking" message:@"" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil] show];
    }*/
    
}
-(IBAction)clickOnCategoryButton:(id)sender
{
    [self addDataPickerWithDoneAndCancelButton];
}

-(void)addDataPickerWithDoneAndCancelButton
{
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 200);
    
    pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
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
    titleButton = [[UIBarButtonItem alloc] initWithTitle:@"Category" style:UIBarButtonItemStylePlain target: nil action: nil];
    
    [titleButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                         NSForegroundColorAttributeName,
                                         nil] forState:UIControlStateNormal];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(clickOnDoneButtonOnActionData:)];
    
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
        [popoverView addSubview:pickerView];
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
        [timeBackgroundView addSubview:pickerView];
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
-(IBAction)clickOnDoneButtonOnActionData:(id)sender
{
    [self gettingGalleryCategroyList:categoryID];
    timeBackgroundView.hidden=YES;
    [timeBackgroundView removeFromSuperview];
    timeBackgroundView=nil;
}

#pragma mark
#pragma mark PickrView datasource methods


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return categoryArray.count;
    
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[categoryArray objectAtIndex:row] objectForKey:@"cat_name"];
    
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    categoryID=[[categoryArray objectAtIndex:row] objectForKey:@"id"];
}


@end
