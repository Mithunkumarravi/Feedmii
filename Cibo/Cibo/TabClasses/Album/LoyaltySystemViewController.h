//
//  LoyaltySystemViewController.h
//  Cibo
//
//  Created by mithun ravi on 30/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoyaltyCell.h"
#import "MyCustomeClass.h"
#import "ScanLoyaltyCell.h"
#import "NoRebanLoyaltyCell.h"
#import "ScanViewController.h"
#import "WebServiceHelper.h"
//#import "FileManager.h"
#import "LoyalCollectionCell.h"

//#import "Barcode.h"
#import "UIImage+QRCodeGenerator.h"



@class AppDelegate;
@interface LoyaltySystemViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,WebServiceHelperDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSUserDefaults *loyaltyDefault;
    AppDelegate *appDelegate;
    BOOL moveupDown,moveLeftRight;
    LoyaltyCell *loyaltyCell;
    ScanLoyaltyCell *scanLoyaltyCell;
    NoRebanLoyaltyCell *noRebanLoyaltyCell;
    int redeemingPoints,increasePoint,cellValue;
    NSString *couponID;

    NSString *redeemingPointsID;
    NSString *choosedMunchPoint;
    int discountCoupenId;
    IBOutlet UICollectionViewFlowLayout *flowLayout;
    
    IBOutlet UILabel *lblTitle;
}

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) IBOutlet UITableView *loyaltyTable;
@property (nonatomic, strong) IBOutlet UIView *pointListView;
@property (nonatomic, strong) NSMutableArray *offerArray,*userMunchPoints,*userselectedOffter;
@property (nonatomic, strong) IBOutlet UILabel *totalPoints,*qrCode,*titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *myTotalPoint,*redemptionLabel;
@property (nonatomic, strong) IBOutlet UIImageView *generatedQRCodeImage;

-(IBAction)clickOnRightUpperConrnerButton:(id)sender;

@end
