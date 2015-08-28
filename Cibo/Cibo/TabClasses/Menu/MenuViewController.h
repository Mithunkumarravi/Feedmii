//
//  MenuViewController.h
//  Cibo
//
//  Created by mithun ravi on 20/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFOpenFlowView.h"
#import "MenuViewCell.h"
#import "MyCustomeClass.h"
#import "WebServiceHelper.h"
#import "OrderListCell.h"
#import "CardViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Reachability1.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "FocreModifierCell.h"
#import "OptionModifierCell.h"
#import "MKNumberBadgeView.h"
#import "TableReservationViewController.h"
#import "MenuCollectionCell.h"
#import "iCarousel.h"


#define ScrollColor [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:1.0]


@class AppDelegate;
@interface MenuViewController : UIViewController<UIScrollViewDelegate,AFOpenFlowViewDelegate,AFOpenFlowViewDataSource,UITableViewDataSource,UITableViewDelegate,WebServiceHelperDelegate,CLLocationManagerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,iCarouselDataSource,iCarouselDelegate>
{
    NSOperationQueue *loadImageOpreteion;
    MenuViewCell *menuCell;
    BOOL orderListShowAndHide;
    NSUserDefaults *menuDefault;
    AppDelegate *appDelegate;
    OrderListCell *orderListCell;
    int selectedCellIntegerValue,removeOrderCell,selectedItem,coverflowIndex;
    NSString *CategoryString;
    int finalPriceInInteger,orderListCounter;
    NSString *orderId;
    CLLocationManager *locationManager;
    float latitude,longitude,latitude1,longitude1;
    int distance;
    NSString *wifiName;
    
    ////// modifier
    IBOutlet UIView *modifierView;
    IBOutlet UILabel *modifierTitle;
    IBOutlet UITableView *modiferTable;
    float forceModifierPrice,optionModifierPrice;
    NSString *forceModifierString,*optionModifierString;
    NSString *multipleModifier;
    
    ////////
    FocreModifierCell *fmodifierCell;
    OptionModifierCell *omodifierCell;
    int choosedFModifierInt,choosedOModifierInt;
    
    ////
    IBOutlet UIView *pizzaView;
    IBOutlet UILabel *pizzaTitle;
    NSString *pizzaString;
    MKNumberBadgeView *mkv;
    IBOutlet UIButton *badgeButton;
    NSString *grandTotal,*subTotal111;
    IBOutlet UICollectionViewFlowLayout *flowLayout;
    IBOutlet UIButton *checkoutButton,*submit1Button,*submit2Button;
    IBOutlet UILabel *orderLabelTitle;
    IBOutlet UILabel *fmItam,*fmPrice;
    NSString *happyHourDiscount,*happyHourBuy,*happyHourGet,*happyhourPoint,*happyHourAmount;
    BOOL isHappyHour;
    IBOutlet UILabel *itemCountLabel;
    int sectionIndex;
    
}
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) IBOutlet UIScrollView *tabScrollView;
@property (nonatomic, strong) IBOutlet UIView *coverflowView,*itempriceView;
@property (nonatomic, strong) NSMutableArray *coverImageArray;
@property (nonatomic, strong) IBOutlet UITableView *menuTable,*pizzaTable;
@property (nonatomic, strong) IBOutlet UILabel *selectedItemLabel,*TotalPriceList,*centerFlowImageNameLabel,*selectedItemTitleList;
///////////////// selected order list ///////////////////////
@property (nonatomic, strong) IBOutlet UIView *orderListView;
@property (nonatomic, strong) IBOutlet UITableView *orderListTable;
@property (nonatomic, strong) NSMutableArray *orderListArray,*menuArray;
@property (nonatomic, strong) IBOutlet UILabel *subTotal,*servicesChargeLabel,*totelLable;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
//////////////////////////// end ////////////////////////////
@property (nonatomic, strong) NSMutableArray *categoryArray,*selectedOrderArray1,*selectedOrderArray2,*selectedOrderArray3,*selectedOrderArray4,*selectedOrderArray5;
@property (nonatomic, strong) NSMutableArray *subCategoryArray,*itemFromSubCategory;

///////////////// order selection //////////
@property (nonatomic, strong) NSMutableArray *selectedOrderArray,*finalArray,*finalArrayForDish,*finalArrayForDrink;
@property (nonatomic, strong) NSString *priceList;

//////////// for language change //////////////
@property (nonatomic, strong) IBOutlet UIButton *dishesButton,*dirnkButton,*pizzaButton,*setMenuButton,*offerButton,*orderClear,*covrflowbutton;
@property (nonatomic, strong) IBOutlet UILabel *subTotelLabelLabel,*serviceschargeLabelLabel,*totalLabelLabel;

/////////// order related object object
@property (nonatomic, strong) IBOutlet UIView *orderView;
@property (nonatomic, strong) IBOutlet UILabel *orderTitleLabel;
@property (nonatomic, strong) IBOutlet UITextField *firstNameText,*surNameText,*addrssNameText,*emailAddressText, *cityText,*stateText,*countryText,*mobileText,*postCodeText;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton,*nowOrderButton;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollViewOrder;

@property (nonatomic, strong) NSMutableArray *forceModifier,*optionModifier,*modifierSelectedItemsArray;
@property (nonatomic, strong) NSMutableArray *selectedFModifierList,*selectedOModifierList;
@property (nonatomic, strong) NSMutableArray *pizzaBaseArray,*pizzaToppingArray,*pizzaSizeArray,*selecetePizzaOption,*choosedPizzaDetail;
@property (nonatomic, strong) NSMutableArray *taxArray;
@property (nonatomic, strong) NSMutableArray *happyHourArray;
@property (nonatomic, strong) NSMutableArray *arrayForBool;

@property (nonatomic, strong) IBOutlet iCarousel *carousel;


-(float)addTaxWithDish:(float )tax price:(float) price;

@end
