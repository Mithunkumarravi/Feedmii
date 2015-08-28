//
//  AppDelegate.h
//  Cibo
//
//  Created by mithun ravi on 15/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomeClass.h"
#import "Reachability1.h"
#import "IndexPageViewController.h"
#import "Constant.h"
#import "ShareViewController.h"
#import "RootViewController.h"
#import "WebServiceHelper.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import <CoreBluetooth/CoreBluetooth.h>
//#import "ESTBeacon.h"
//#import "ESTBeaconManager.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <AVFoundation/AVFoundation.h>
//#import "SBKBeaconManager.h"
#define FONT_Ragular @"Ubuntu-L"
#define FONT_Bold @"Ubuntu-L"

#define DOCUMENTS_FOLDER1 [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

@class ViewController;
@class ShareViewController;
@class RootViewController;


typedef enum : int
{
    ESTScanTypeBluetooth,
    ESTScanTypeBeacon
    
} ESTScanType;
// strip payment gateway
extern NSString *const StripePublishableKey;
extern NSString *const BackendChargeURLString;
extern NSString *const AppleMerchantId;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate,UITabBarControllerDelegate,WebServiceHelperDelegate,AVSpeechSynthesizerDelegate/*,SBKBeaconManagerDelegate*//*,ESTBeaconManagerDelegate*/,CBCentralManagerDelegate>
{
    int iPhoneScreenSize;
    NSUserDefaults *appDelegateDefault;
    int badgeNumebr;
    int allBeaconInfoCount;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property(strong,nonatomic)UINavigationController *navigation;

@property (strong, nonatomic) UITabBarController *tabBarController;
@property (nonatomic, strong) Reachability1 *netReachability,*hostReachability;
@property (nonatomic, assign) int tabSelectedIndex;
@property (nonatomic, strong) NSMutableDictionary *userInfoDictionary;
@property (nonatomic, strong) ShareViewController *shareView;

@property (nonatomic, strong) NSString *loginISSHOWORNOT,*menuLoginChecking,*moveTabWithoutLogin;
@property (nonatomic, strong) NSString *cardOpenFromOrder;
@property (nonatomic, strong) NSString *openandPaymentWay;

@property (nonatomic, strong) NSString *bookedTable,*tableNumber;
@property (nonatomic, assign) BOOL orderSelected;
@property (nonatomic, strong) NSMutableArray *beaconCompainingArray;

@property (nonatomic, strong) NSMutableArray *sBbeacons;

@property (nonatomic, assign) int firstTime;



@property (strong,nonatomic)NSString *Token;

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UIButton *btn4;
@property (nonatomic, strong) UIButton *btn5;

@property(strong, nonatomic)CLLocationManager * locationManager;
@property(strong, nonatomic)CBCentralManager * CM;


- (void)customTabbarController;

-(void)tabBarHide;
-(void)tabBarShow;

-(BOOL)rootViewControllerLoading;


/////// beacons
//@property (nonatomic, strong) ESTBeaconManager *beaconManager;
//@property (nonatomic, strong) ESTBeaconRegion *beaconRegion;
@property (nonatomic, strong) NSMutableArray *beaconsArray;
@property (nonatomic, strong) NSMutableArray *registeredBeaconArray;

@property (nonatomic, strong) AVSpeechSynthesizer *avSpeechSynthesizer;


-(void)speechOfGivenText:(NSString *)messageText;
-(void)SBBeaconStart;
+(AppDelegate *)appDelegateDataAccess;


@end
