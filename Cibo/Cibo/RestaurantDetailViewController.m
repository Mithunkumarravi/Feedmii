//
//  RestaurantDetailViewController.m
//  Reataurant Cibo
//
//  Created by mithun ravi on 15/01/15.
//  Copyright (c) 2015 mithun ravi. All rights reserved.
//

#import "RestaurantDetailViewController.h"

@interface RestaurantDetailViewController ()

@end

@implementation RestaurantDetailViewController
@synthesize detailDic;
@synthesize mapViewResturant;
@synthesize latidue;
@synthesize longitude;

- (void)viewDidLoad {
    [super viewDidLoad];
    titleLabel.text=[detailDic valueForKey:@"rname"];
    descriptionLabel.text=[detailDic valueForKey:@"description"];
         addressLabel.text=[NSString stringWithFormat:@"%@,%@,%@-%@",[detailDic objectForKey:@"address"],[detailDic objectForKey:@"city"],[detailDic objectForKey:@"country"],[detailDic objectForKey:@"zipcode"]];
    [self addLocationOnMap];
    
    titleLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [titleLabel setFont: [titleLabel.font fontWithSize: 12.0]];

    addressLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [addressLabel setFont: [addressLabel.font fontWithSize: 12.0]];

    lblCall.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [lblCall setFont: [lblCall.font fontWithSize: 12.0]];

    lblDriverCard.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [lblDriverCard setFont: [lblDriverCard.font fontWithSize: 12.0]];

    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)clickONDriveCardButton:(id)sender
{
    NSString *currentLatitudeMera =[NSString stringWithFormat:@"%f",latidue];
    NSString *currentLongitudeMera = [NSString stringWithFormat:@"%f",longitude];
    NSString *url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%@,%@&daddr=%@,%@",currentLatitudeMera,currentLongitudeMera,[NSString stringWithFormat:@"%@",[detailDic valueForKey:@"lat"]],[NSString stringWithFormat:@"%@",[detailDic valueForKey:@"lon"]]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(IBAction)clickOnCallButton:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[MyCustomeClass languageSelectedStringForKey:@"Want to be call "] message:[MyCustomeClass languageSelectedStringForKey:[NSString stringWithFormat:@"on %@",[detailDic objectForKey:@"phone"]]] delegate:self cancelButtonTitle:[MyCustomeClass languageSelectedStringForKey:@"Cancel"] otherButtonTitles:[MyCustomeClass languageSelectedStringForKey:@"Call"], nil];
    [alert show];
}

#pragma mark - alertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:[MyCustomeClass languageSelectedStringForKey:@"Call"]])
    {
        NSURL *dialingURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"tel:%@",[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"phone"]]]];
        
        [[UIApplication sharedApplication] openURL:dialingURL];
    }
}

-(IBAction)clickOnCancelButton:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - map connection method list.
-(void)addLocationOnMap
{
    float latitude=[[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"lat"]] floatValue];
    float longitude2=[[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"lon"]] floatValue];
    NSLog(@"%f",latitude);
    
    NSMutableArray* annotations=[[NSMutableArray alloc] init];
    
    CLLocationCoordinate2D theCoordinate1;
    theCoordinate1.latitude = latitude;
    theCoordinate1.longitude =longitude2;
    
    
    DisplayAnnotation * myAnnotation=[[DisplayAnnotation alloc] init];
    
    myAnnotation.coordinate=theCoordinate1;
    myAnnotation.title=titleLabel.text;
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


@end
