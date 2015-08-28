//
//  MuiltpleViewController.h
//  Reataurant Cibo
//
//  Created by mithun ravi on 10/01/15.
//  Copyright (c) 2015 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultipleCollectionViewCell.h"
#import "MyCustomeClass.h"
#import "WebServiceHelper.h"
#import "RestaurantDetailViewController.h"
#import "UIImageView+WebCache.h"
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "MyOrderListCell.h"
#import "ProductCell.h"
#import "BillOverviewController.h"

@interface MuiltpleViewController : UIViewController<WebServiceHelperDelegate,CLLocationManagerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UICollectionView *multiCollection, *collectionViewSorter;
    IBOutlet UIButton *allRest,*locationRest,*favRest;
    CLLocationManager *locationManager;
    IBOutlet UITextField *searchtext;
    IBOutlet UIImageView *searchImage;
    NSString *clickedButton;
    IBOutlet UIView *newView;
    IBOutlet UIView *sorterView;
    IBOutlet UITableView *typeTableView;
    NSString *countryString;
    NSString *foodType;
    IBOutlet UILabel *restaruantFilterLabel,*sorterFilterLabel;
    IBOutlet UILabel *lblRestauranter, *lblSorter, *lblFavoritter, *lblTilbud, *lblKuponer, *lblProfile;
    IBOutlet UILabel *lblTitle;
    IBOutlet UIButton *btnSix;
    AppDelegate *appDelegate;
    IBOutlet UIView *vwMyOrder;
    //////////////
    IBOutlet UITableView *orderTable;
    IBOutlet UIView *itemView;
    IBOutlet UITableView *itemTable;
    MyOrderListCell *orderCell;
    IBOutlet UILabel *orderNameLabel;
    IBOutlet UILabel *lblMyWallet;
    IBOutlet UILabel *lblPrice;
    IBOutlet UILabel *lblSelect;
    NSUserDefaults *openDefault;
    NSString *move,*orderId;
    NSString *temprestaurantID;
    
    NSString *selectedOrderName;
    NSString *orderLocation;
    float selectedOrderAmount;
    int qunatityOfitems;
    NSDictionary *selectedOrderDetail;
}

@property (nonatomic, strong) NSMutableArray *multiRestaurantArray;
@property (nonatomic, strong) NSMutableArray *favRestaurntArray;
@property (nonatomic, strong) NSMutableArray *locationRestaurantArray;
@property (nonatomic, strong) NSMutableArray *loadedArray;
@property (nonatomic, strong) NSMutableArray *fetchfavAFterChangeArray;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) NSMutableArray *typeArray,*typeFilArray;
@property (nonatomic, strong) NSMutableArray *eventArray;
@property (nonatomic, strong) NSMutableArray *couponArray;
@property (nonatomic, strong) NSMutableArray *profileArray;

//////////////
@property (nonatomic, strong) NSMutableArray *orderArrayList,*productListArray;
@property (nonatomic, strong) NSMutableArray *resturantArray;
@property (nonatomic, strong) NSMutableArray *sortedArray;
@property (nonatomic, strong) NSString *temprestaurantID;



@end
