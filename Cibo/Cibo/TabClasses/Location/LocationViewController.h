//
//  LocationViewController.h
//  Cibo
//
//  Created by mithun ravi on 20/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MyCustomeClass.h"
#import "TableReservationViewController.h"
#import "WebSiteViewController.h"
#import "WebServiceHelper.h"

@class AppDelegate;
@interface LocationViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,WebServiceHelperDelegate>
{
    //int heightOFIphoneScreen;
    AppDelegate *appDelegate;
    NSUserDefaults *locationDefault;
    CLLocationManager *locationManager;
    float latitude,longitude;
    CLLocationCoordinate2D coordinate;
    double latiNear,longNear;
    
    IBOutlet UILabel *lblDriverCard;
    IBOutlet UILabel *lblCall;
    IBOutlet UILabel *lblBookATable;
    IBOutlet UILabel *lblWebSite;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *restaurentNameLabel;
    IBOutlet UILabel *addressOnlyLabel;
}

@property (nonatomic, strong)IBOutlet MKMapView *mapViewResturant;
@property (nonatomic, strong) IBOutlet UIButton *driveButton,*phoneButton,*webSiteVisitButton,*reservationButton;
@property (nonatomic,strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) IBOutlet UILabel *restaurentNameLabel,*addressLabel,*phoneNoLabel,*webSitelabel;
@property (nonatomic, strong) NSMutableDictionary *restaurentInfoDic;
@property (nonatomic, strong) NSString *countryString;
/////
@property (nonatomic, strong) IBOutlet UILabel *phoneLabel,*websiteLable;

-(IBAction)clickOnReservationButton:(id)sender;

@end



@interface DisplayAnnotation : NSObject <MKAnnotation>
{
    
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    
}
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) UIImageView *mapImage;
@end