//
//  LocationViewController.m
//  Cibo
//
//  Created by mithun ravi on 20/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "LocationViewController.h"


@implementation DisplayAnnotation

@synthesize coordinate,title,subtitle;
@synthesize mapImage;

@end


@interface LocationViewController ()

@end

@implementation LocationViewController

@synthesize mapViewResturant;
@synthesize driveButton,phoneButton,webSiteVisitButton,reservationButton;
@synthesize actionSheet;
@synthesize restaurentNameLabel,addressLabel,phoneNoLabel,webSitelabel;
@synthesize restaurentInfoDic;
@synthesize phoneLabel,websiteLable;
@synthesize countryString;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    locationDefault=[NSUserDefaults standardUserDefaults];
    restaurentInfoDic=[[NSMutableDictionary alloc] init];
    
    /// Set Layout
    titleLabel.font=[UIFont fontWithName:FONT_Ragular size:20.0];
    [titleLabel setFont: [titleLabel.font fontWithSize: 20.0]];
    restaurentNameLabel.font=[UIFont fontWithName:FONT_Ragular size:18.0];
    [restaurentNameLabel setFont: [restaurentNameLabel.font fontWithSize: 18.0]];
    addressLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [addressLabel setFont: [addressLabel.font fontWithSize: 12.0]];
    lblBookATable.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [lblBookATable setFont: [lblBookATable.font fontWithSize: 12.0]];
    lblCall.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [lblCall setFont: [lblCall.font fontWithSize: 12.0]];
    lblDriverCard.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [lblDriverCard setFont: [lblDriverCard.font fontWithSize: 12.0]];
    lblWebSite.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [lblWebSite setFont: [lblWebSite.font fontWithSize: 12.0]];
    titleLabel.text=[MyCustomeClass languageSelectedStringForKey:@"VORES PLACERING"];
    addressOnlyLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Address:"];
    [MyCustomeClass drawBorder:mapViewResturant];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self findCurrentLocation];
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:@"RestaurantDetail"];
    restaurentInfoDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    restaurentNameLabel.text=ciboRestaurantName;
    [appDelegate tabBarHide];
    [self addLocationOnMap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark - Button action methods
-(IBAction)clickOnHomeButton:(id)sender
{
    UIApplication *application=nil;
    NSDictionary *dic=nil;
    [locationDefault setValue:@"Home" forKey:@"RootView"];
    [locationDefault setValue:@"Home" forKey:@"Logout"];
    [appDelegate application:application didFinishLaunchingWithOptions:dic];
}


-(IBAction)clickONDriveCardButton:(id)sender
{
    if (latitude>0)
    {
        NSString *currentLatitudeMera =[NSString stringWithFormat:@"%f",latiNear];
        NSString *currentLongitudeMera = [NSString stringWithFormat:@"%f",longNear];
        NSString *url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%@,%@&daddr=%@,%@",currentLatitudeMera,currentLongitudeMera,[NSString stringWithFormat:@"%f",latitude],[NSString stringWithFormat:@"%f",longitude]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"Restaurant location is not available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
}

-(void)findCurrentLocation
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    if (IS_IOS8)
    {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    [self deviceLocation];
}

- (void)deviceLocation
{
    latiNear= locationManager.location.coordinate.latitude;
    longNear=locationManager.location.coordinate.longitude;
    if (latitude<=0)
    {
        // latitude=24.4607833;
    }
    if (longitude<=0)
    {
        // longitude=54.3807539;
    }
    [locationManager stopUpdatingLocation];
}
-(IBAction)clickOnCallButton:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[MyCustomeClass languageSelectedStringForKey:@"Want to be call "] message:[MyCustomeClass languageSelectedStringForKey:[NSString stringWithFormat:@"on %@",[restaurentInfoDic objectForKey:@"phone"]]] delegate:self cancelButtonTitle:[MyCustomeClass languageSelectedStringForKey:@"Cancel"] otherButtonTitles:[MyCustomeClass languageSelectedStringForKey:@"Call"], nil];
    [alert show];
}

-(IBAction)clickOnReservationButton:(id)sender
{
    if ([[locationDefault objectForKey:@"Email"] length]>0)
    {
        int tableFlag = [[restaurentInfoDic valueForKey:@"tablebooking"] intValue];
        if (tableFlag)
        {
            appDelegate.bookedTable=nil;
            TableReservationViewController *tableReservation=[[TableReservationViewController alloc] initWithNibName:@"TableReservationViewController" bundle:nil];
            [self.navigationController pushViewController:tableReservation animated:true];
        }
        else
        {
             [MyCustomeClass alertMessage:[MyCustomeClass languageSelectedStringForKey:@"Table booking not available in this restaurant."] :[MyCustomeClass languageSelectedStringForKey:@"Restaurent"] :[MyCustomeClass languageSelectedStringForKey:@"OK"]];
        }
    }
    else
    {
        [appDelegate tabBarHide];
        ViewController *viewController=[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        [self presentViewController:viewController animated:true completion:nil];
    }
}
-(IBAction)clickOnWebSiteButton:(id)sender
{
    WebSiteViewController *tableReservation=[[WebSiteViewController alloc] initWithNibName:@"WebSiteViewController" bundle:nil];
    if ([[restaurentInfoDic objectForKey:@"domain"] length]>0)
    {
        [tableReservation setWebString:[restaurentInfoDic objectForKey:@"domain"]];
         [self.navigationController pushViewController:tableReservation animated:true];
    }
    else
    {
        [MyCustomeClass alertMessage:[MyCustomeClass languageSelectedStringForKey:@"No website available in this "] :[MyCustomeClass languageSelectedStringForKey:@"Restaurent"] :[MyCustomeClass languageSelectedStringForKey:@"OK"]];
    }
}

-(IBAction)clickOnCalendarButton:(id)sender
{
    [self addDatePickerWithDoneAndCancelButton];
}

-(void)gettingFail:(NSString*)error
{
    NSLog(@"%@",error);
    [MyCustomeClass SVProgressMessageDismissWithSuccess:error :1.00];
}
#pragma mark - Date Picker methods
-(UIActionSheet *)addDatePickerWithDoneAndCancelButton
{
   actionSheet = [[UIActionSheet alloc] initWithTitle:[MyCustomeClass languageSelectedStringForKey:@"Date"]
                                              delegate:nil
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    [actionSheet addSubview:datePicker];
    
    UISegmentedControl *cancelButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:[MyCustomeClass languageSelectedStringForKey:@"Cancel"]]];
    cancelButton.momentary = YES;
    cancelButton.frame = CGRectMake(10, 7.0f, 50.0f, 30.0f);
    cancelButton.segmentedControlStyle = UISegmentedControlStyleBar;
    cancelButton.tintColor = [UIColor grayColor];
    [cancelButton addTarget:self action:@selector(clickOnCancelButtonOnActionSheet:) forControlEvents:UIControlEventValueChanged];
    //////////////////////////////////////////////
    UISegmentedControl *doneButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:[MyCustomeClass languageSelectedStringForKey:@"Done"]]];
    doneButton.momentary = YES;
    doneButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
    doneButton.tintColor = [UIColor grayColor];
    [doneButton addTarget:self action:@selector(clickOnDoneButtonOnActionSheet:) forControlEvents:UIControlEventValueChanged];
    
    [actionSheet addSubview:cancelButton];
    [actionSheet addSubview:doneButton];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
    return actionSheet;
}


-(IBAction)clickOnCancelButtonOnActionSheet:(id)sender
{
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}
-(IBAction)clickOnDoneButtonOnActionSheet:(id)sender
{
    [actionSheet dismissWithClickedButtonIndex:1 animated:YES];
}

#pragma mark - map connection method list.
-(void)addLocationOnMap
{
    NSString *address=[NSString stringWithFormat:@"%@,%@,%@-%@",[restaurentInfoDic objectForKey:@"address"],[restaurentInfoDic objectForKey:@"city"],[restaurentInfoDic objectForKey:@"country"],[restaurentInfoDic objectForKey:@"zipcode"]];
    addressLabel.text=address;
    phoneNoLabel.text=[NSString stringWithFormat:@"%@",[restaurentInfoDic objectForKey:@"phone"]];
    NSString *webString=[NSString stringWithFormat:@"%@",[restaurentInfoDic objectForKey:@"domain"]];
    if (webString.length>0)
        webSitelabel.text=[NSString stringWithFormat:@"%@",[restaurentInfoDic objectForKey:@"domain"]];
    else
        webSitelabel.text=@"              No Website";
    
    
    /// setting latitude
    latitude=[[NSString stringWithFormat:@"%@",[restaurentInfoDic objectForKey:@"lat"]] floatValue];
    longitude=[[NSString stringWithFormat:@"%@",[restaurentInfoDic objectForKey:@"lon"]] floatValue];

    NSMutableArray* annotations=[[NSMutableArray alloc] init];
    
    CLLocationCoordinate2D theCoordinate1;
    theCoordinate1.latitude = latitude;
    theCoordinate1.longitude =longitude;
    
   
     DisplayAnnotation * myAnnotation=[[DisplayAnnotation alloc] init];
     
     myAnnotation.coordinate=theCoordinate1;
     myAnnotation.title=restaurentNameLabel.text;
     myAnnotation.subtitle=addressLabel.text;
       
     
     [mapViewResturant addAnnotation:myAnnotation];
     
     
     [annotations addObject:myAnnotation];
     
     MKMapRect flyTo = MKMapRectNull;
     for (id <MKAnnotation> annotation in annotations)
     {
         NSLog(@"fly to on");
         MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
         MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
     
         if (MKMapRectIsNull(flyTo))
         {
             flyTo = pointRect;
         }
         else
         {
                flyTo = MKMapRectUnion(flyTo, pointRect);
         }
     }
    mapViewResturant.visibleMapRect = flyTo;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(theCoordinate1, 1000, 0);
    MKCoordinateRegion adjustedRegion = [self.mapViewResturant regionThatFits:viewRegion];
    [self.mapViewResturant setRegion:adjustedRegion animated:YES];
}


-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:
(id <MKAnnotation>)annotation
{
    
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKPinAnnotationView* pinView = [[MKPinAnnotationView alloc]
                                    initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
    pinView.animatesDrop=YES;
    pinView.canShowCallout=YES;
    pinView.pinColor=MKPinAnnotationColorPurple;
    pinView.annotation=annotation;
    return pinView;
}

#pragma mark - alertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
	if ([title isEqualToString:[MyCustomeClass languageSelectedStringForKey:@"Cancel"]])
    {
        
    }
    else if([title isEqualToString:[MyCustomeClass languageSelectedStringForKey:@"Call"]])
    {
        NSURL *dialingURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"tel:%@",[NSString stringWithFormat:@"%@",[restaurentInfoDic objectForKey:@"phone"]]]];
        
        [[UIApplication sharedApplication] openURL:dialingURL];

    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations objectAtIndex:0];
    //[locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             countryString = [[NSString alloc]initWithString:placemark.country];
             if (countryString.length>0)
             {
                 [locationManager stopUpdatingLocation];
             }
         }
         else
         {
             NSLog(@"Geocode failed with error %@", error);
             NSLog(@"\nCurrent Location Not Detected\n");
         }
     }];
}




@end
