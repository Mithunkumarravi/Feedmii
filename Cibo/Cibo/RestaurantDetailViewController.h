//
//  RestaurantDetailViewController.h
//  Reataurant Cibo
//
//  Created by mithun ravi on 15/01/15.
//  Copyright (c) 2015 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyCustomeClass.h"

@interface RestaurantDetailViewController : UIViewController<MKMapViewDelegate>
{
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *addressLabel;
    IBOutlet UILabel *lblCall;
    IBOutlet UILabel *lblDriverCard;
    IBOutlet UITextView *descriptionLabel;
    
}
@property (nonatomic, strong) NSMutableDictionary *detailDic;
@property (nonatomic, strong)IBOutlet MKMapView *mapViewResturant;
@property (nonatomic, assign) float latidue,longitude;

@end
