//
//  MoveBillOverView_ViewController.h
//  Restaurant Cibo
//
//  Created by Naveen Rajput on 25/07/15.
//  Copyright (c) 2015 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobeBillViewCell.h"
#import "MoveBillCollectionViewCell.h"
#import "SplitBillViewController.h"
#import "MyCustomeClass.h"
#import "WebServiceHelper.h"

@interface MoveBillOverView_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,WebServiceHelperDelegate>
{
    IBOutlet UITableView *tblMoveBill;
    MobeBillViewCell *moveBillViewCell;
    IBOutlet UICollectionView *collectionViewBill;
    IBOutlet UIImageView *imgBGPatti, *imgBottomBG;
    NSIndexPath *selectedIndex;
    IBOutlet UILabel *lblOrderAmount;
    IBOutlet UIButton *checkoutButton;
    NSString *selectedBill;
    WebServiceHelper *helper;
    NSUserDefaults *moveBillDefault;
    float customerDiscountInFloat;
    NSString *subTotal;
    int orderListCounter;
}

@property (nonatomic, strong) NSMutableArray *fakeBillArray;
@property (nonatomic, assign) int splitCount;

@property (nonatomic, strong) NSMutableArray *numberOfBillArray;
@property (nonatomic, strong) NSMutableArray *mainArray;
@property (nonatomic, strong) NSMutableArray *loadedArray;
@property (nonatomic, strong) NSMutableArray *bill1Array;
@property (nonatomic, strong) NSMutableArray *bill2Array;
@property (nonatomic, strong) NSMutableArray *bill3Array;
@property (nonatomic, strong) NSMutableArray *bill4Array;
@property (nonatomic, strong) NSMutableArray *bill5Array;
@property (nonatomic, strong) NSMutableArray *bill6Array;
@property (nonatomic, strong) NSMutableArray *bill7Array;
@property (nonatomic, strong) NSMutableArray *bill8Array;
@property (nonatomic, strong) NSMutableArray *bill9Array;
@property (nonatomic, strong) NSMutableArray *bill10Array;
@property (nonatomic, strong) NSString *orderID,*order_location;
@property (nonatomic, strong) NSDictionary *selectedOrderDetail;
@property (nonatomic, strong) NSMutableArray *selectedOrderArray;
@property (nonatomic, strong) NSMutableArray *taxArray;
@property (nonatomic, strong) NSMutableArray  *finalOrderArray;

@property(assign,nonatomic)float orderAmount;


@end
