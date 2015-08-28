//
//  AppDelegate.m
//  Cibo
//
//  Created by mithun ravi on 15/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
//#import "SBKBeaconManager+Cloud.h"


// This can be found at https://dashboard.stripe.com/account/apikeys
NSString *const StripePublishableKey = @"pk_test_6pRNASCoBOKtIshFeQd4XMUh"; // TODO: replace nil with your own value

// To set this up, check out https://github.com/stripe/example-ios-backend
// This should be in the format https://my-shiny-backend.herokuapp.com
NSString *const BackendChargeURLString = nil; // TODO: replace nil with your own value

// To learn how to obtain an Apple Merchant ID, head to https://stripe.com/docs/mobile/apple-pay
NSString *const AppleMerchantId = nil; // TODO: replace nil with your own value

@implementation AppDelegate

@synthesize navigation;
@synthesize tabBarController;
@synthesize netReachability,hostReachability;
@synthesize btn1,btn2,btn3,btn4,btn5;
@synthesize tabSelectedIndex;
@synthesize userInfoDictionary;
@synthesize shareView;
@synthesize loginISSHOWORNOT;
@synthesize menuLoginChecking;
@synthesize moveTabWithoutLogin;
@synthesize cardOpenFromOrder;
@synthesize openandPaymentWay;
@synthesize bookedTable,tableNumber;
@synthesize orderSelected;

///
//@synthesize beaconManager;
@synthesize beaconsArray;
//@synthesize beaconRegion;
@synthesize registeredBeaconArray;
@synthesize beaconCompainingArray;
@synthesize avSpeechSynthesizer;
@synthesize firstTime;

@synthesize sBbeacons;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    firstTime=1;
    if (!self.CM) {
        self.CM = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    }
    beaconsArray=[[NSMutableArray alloc] init];
    beaconCompainingArray=[[NSMutableArray alloc] init];
    registeredBeaconArray=[[NSMutableArray alloc] init];
    sBbeacons=[[NSMutableArray alloc] init];
    NSString *length = [[NSUserDefaults standardUserDefaults] valueForKey:@"CheckInMessage"];
    
    NSError *error = NULL;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:&error];
    if(error) {
        // Do some error handling
    }
    [session setActive:YES error:&error];
    if (error) {
        // Do some error handling
    }

    /////////  internet connection checking code /////////
    appDelegateDefault=[NSUserDefaults standardUserDefaults];
    [appDelegateDefault setValue:ciboRestaurantId forKey:@"Restaurantid"];
    //[appDelegateDefault setValue:@"94122239" forKey:@"Member"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    netReachability=[Reachability1 reachabilityForInternetConnection];
    [netReachability startNotifier];
    hostReachability = [Reachability1 reachabilityWithHostName: @"www.apple.com"];
    //[SBKBeaconManager sharedInstance];

    [hostReachability startNotifier];
    badgeNumebr=0;
    
    if ([[appDelegateDefault objectForKey:@"Logout"] isEqualToString:@"Logout"])
    {
        [appDelegateDefault setValue:@"" forKey:@"Email"];
    }
    else
    {
        [appDelegateDefault setValue:@"1" forKey:@"Language"];
    }
   
    if([[appDelegateDefault objectForKey:@"RootView"] isEqualToString:@"Home"])
    {
       [self rootViewControllerLoading];
    }
    else if([[appDelegateDefault objectForKey:@"RootView"] isEqualToString:@"Login"])
    {
        userInfoDictionary=[[NSMutableDictionary alloc] init];
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        navigation=[[UINavigationController alloc]initWithRootViewController:self.viewController];
        self.navigation.navigationBarHidden=YES;
        self.window.rootViewController = self.viewController;
        self.window.rootViewController=self.navigation;
    }
    else
    {
         [self rootViewControllerLoading];
    }
    [self.window makeKeyAndVisible];
    
    if (IS_IOS8)
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    else
    {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    if ([length length]>2)
    {
        if(ciboRestaurantId==nil)
            return YES;
        
        [self SBBeaconStart];

    }
    return YES;
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"])
    {
        
    }
    else if ([identifier isEqualToString:@"answerAction"])
    {
        
    }
}
#endif

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

+(AppDelegate *)appDelegateDataAccess
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    application.applicationIconBadgeNumber=badgeNumebr;
    //[[MPMusicPlayerController applicationMusicPlayer] setVolume:1];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    application.applicationIconBadgeNumber = 0;
    badgeNumebr=0;
    [self deviceIDUpdateRequest];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     //[self check];
    
    [FBSDKAppEvents activateApp];
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Push Notification

-(void)deviceIDUpdateRequest
{
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    helper.delegate=self;
    [helper deviceIDUpdate:[NSString stringWithFormat:@"restId/%@/device_id/%@/memberId/%@/badge/%d",ciboRestaurantId,[appDelegateDefault valueForKey:@"DeviceToken"],[appDelegateDefault valueForKey:@"Member"],0]];
}

-(void)deviceIDUpdate:(NSString *)response
{
    NSLog(@"%@",response);
}
-(void)gettingFail:(NSString *)error
{
    NSLog(@"%@",error);
}
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
	NSLog(@"Received notification: %@", userInfo);
   // application.applicationIconBadgeNumber = 0;
    NSLog(@"userInfo %@",userInfo);
    
    for (id key in userInfo)
    {
        NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
    }
    badgeNumebr=badgeNumebr+[[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] intValue];
    [application setApplicationIconBadgeNumber:badgeNumebr];
    NSLog(@"Badge %d",badgeNumebr);
}

/*- (void)addMessageFromRemoteNotification:(NSDictionary*)userInfo updateUI:(BOOL)updateUI
{
    application.applicationIconBadgeNumber = 0;
    NSLog(@"userInfo %@",userInfo);
    
    for (id key in userInfo) {
        NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
    }
    
    [application setApplicationIconBadgeNumber:[[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] intValue]];
    NSLog(@"Badge %d",[[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] intValue]);
}*/



#pragma mark - custome tabbar
- (void)customTabbarController
{
     EventsViewController *event=[[EventsViewController alloc] initWithNibName:@"EventsViewController" bundle:[NSBundle mainBundle]];
   
    UINavigationController *navigationLatest = [[UINavigationController alloc] initWithRootViewController:event];
    navigationLatest.navigationBarHidden=TRUE;
    
    
    MenuViewController *menuView= [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:[NSBundle mainBundle]];
    UINavigationController *navigationTopVideo = [[UINavigationController alloc] initWithRootViewController:menuView];
    navigationTopVideo.navigationBarHidden=TRUE;
    
     LoyaltySystemViewController *loyaltyView = [[LoyaltySystemViewController alloc] initWithNibName:@"LoyaltySystemViewController" bundle:[NSBundle mainBundle]];
  
    UINavigationController *navigationCameraCapture= [[UINavigationController alloc] initWithRootViewController:loyaltyView];
    navigationCameraCapture.navigationBarHidden=TRUE;
    
    
     AlbumViewController *albumView = [[AlbumViewController alloc] initWithNibName:@"AlbumViewController" bundle:[NSBundle mainBundle]];
    UINavigationController *navigationUserSales = [[UINavigationController alloc] initWithRootViewController:albumView];
    navigationUserSales.navigationBarHidden=TRUE;
    
    
    LocationViewController *locationView = [[LocationViewController alloc] initWithNibName:@"LocationViewController" bundle:[NSBundle mainBundle]];
    UINavigationController *navigationSettings = [[UINavigationController alloc] initWithRootViewController:locationView];
    navigationSettings.navigationBarHidden=TRUE;
    
    
    
    NSArray *tabArray1 = [[NSArray alloc] initWithObjects:navigationLatest,navigationTopVideo,navigationCameraCapture,navigationUserSales,navigationSettings, nil];
    
    tabBarController = [[UITabBarController alloc] init];
    tabBarController.delegate=self;
    tabBarController.viewControllers=tabArray1;
    
    //self.tabBarController.tabBar.tintColor=[UIColor redColor];
    //self.tabBarController.tabBar.barTintColor=[UIColor  redColor];
    
   // tabBarController.tabBar.translucent=NO;
    
    /*UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bottum_bg.png"]];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.9) {
        //iOS 5
        [self.tabBarController.tabBar insertSubview:imageView atIndex:1];
    }
    else {
        //iOS 4.whatever and below
        [self.tabBarController.tabBar insertSubview:imageView atIndex:0];
    }*/
    
    tabBarController.customizableViewControllers = nil;
    tabBarController.moreNavigationController.navigationBar.topItem.rightBarButtonItem.enabled = false;
    [navigation pushViewController:tabBarController animated:YES];
    self.tabBarController.tabBar.hidden=YES;
    
    [self.window addSubview:navigation.view];
    
    if (IS_IPHONE5)
    {
        iPhoneScreenSize=88;
    }
    else
    {
        iPhoneScreenSize=0;
    }
	
    
	self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
	btn1.frame = CGRectMake(10, 431+iPhoneScreenSize+10, 40, 35);
	[btn1 setBackgroundImage:[UIImage imageNamed:@"eventunselected.png"] forState:UIControlStateNormal];
	[btn1 setBackgroundImage:[UIImage imageNamed:@"eventselected.png"] forState:UIControlStateSelected];
	[btn1 setTag:0];
	
	self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
	btn2.frame = CGRectMake(64+10, 431+iPhoneScreenSize+10, 40, 35);
	[btn2 setBackgroundImage:[UIImage imageNamed:@"menuunselected.png"] forState:UIControlStateNormal];
	[btn2 setBackgroundImage:[UIImage imageNamed:@"menuselected.png"] forState:UIControlStateSelected];
	[btn2 setTag:1];
	
	self.btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
	btn3.frame = CGRectMake(128+10, 431+iPhoneScreenSize+10, 40, 35);
	[btn3 setBackgroundImage:[UIImage imageNamed:@"favouriteunselected.png"] forState:UIControlStateNormal];
	[btn3 setBackgroundImage:[UIImage imageNamed:@"favouriteselected.png"] forState:UIControlStateSelected];
	[btn3 setTag:2];
	
	self.btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
	btn4.frame = CGRectMake(192+10, 431+iPhoneScreenSize+10, 40, 35);
	[btn4 setBackgroundImage:[UIImage imageNamed:@"albumunselected.png"] forState:UIControlStateNormal];
	[btn4 setBackgroundImage:[UIImage imageNamed:@"albumselected.png"] forState:UIControlStateSelected];
	[btn4 setTag:3];
    
	self.btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
	btn5.frame = CGRectMake(256+10, 431+iPhoneScreenSize+10, 35, 35);
	[btn5 setBackgroundImage:[UIImage imageNamed:@"locationunselected.png"] forState:UIControlStateNormal];
	[btn5 setBackgroundImage:[UIImage imageNamed:@"locationselected.png"] forState:UIControlStateSelected];
	[btn5 setTag:4];
	
	// Add my new buttons to the view
    self.window.rootViewController=self.tabBarController;

	[self.window addSubview:btn1];
	[self.window addSubview:btn2];
	[self.window addSubview:btn3];
	[self.window addSubview:btn4];
    [self.window addSubview:btn5];
    
    [btn1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[btn2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[btn3 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[btn4 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn5 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    

    self.tabBarController.selectedIndex = tabSelectedIndex;
    
    if (tabSelectedIndex==0)
    {
        [btn1 setSelected:true];
    }
    else if (tabSelectedIndex==1)
    {
        [btn2 setSelected:true];
    }
    else if (tabSelectedIndex==2)
    {
        [btn3 setSelected:true];
    }
    else if (tabSelectedIndex==3)
    {
        [btn4 setSelected:true];
    }
    else
    {
        orderSelected=NO;
        [btn5 setSelected:true];
    }
    
    [SVProgressHUD dismiss];
}
//Pk: i need this method
-(void)tabBarHide
{
    // NSLog(@"tab bar hide method called");
    btn1.hidden=YES;
    btn2.hidden=YES;
    btn3.hidden=YES;
    btn4.hidden=YES;
    btn5.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
}
-(void)tabBarShow
{
    //NSLog(@"show tab bar method called");
    btn1.hidden=NO;
    btn2.hidden=NO;
    btn3.hidden=NO;
    btn4.hidden=NO;
    btn5.hidden=NO;
    //self.tabBarController.tabBar.hidden=NO;
}



- (void)buttonClicked:(id)sender
{
	int tagNum = (int)[sender tag];
	[self selectTab:tagNum];
}
-(void)hideNavBar
{
    // NSLog(@"hide nav bar");
    
    navigation.navigationBarHidden = YES;
}
-(void)showNavBar
{
    // NSLog(@"show nav bar");
    [navigation.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    navigation.navigationBarHidden = NO;
    
}

- (void)selectTab:(int)tabID
{
    NSArray *buttonArray = [[NSArray alloc] initWithObjects:btn1,btn2,btn3,btn4,btn5,nil];
    for(int i = 0; i < 5; i++)
    {
        [(UIButton *)[buttonArray objectAtIndex:i] setSelected:(tabID == i ? true : false)];
    }
    orderSelected=NO;

    [self.tabBarController setSelectedIndex:tabID];
}
#pragma mark - weibo url method
//for ios version below 4.2

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return TRUE;
}

#pragma mark - menu
-(BOOL)rootViewControllerLoading
{
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    IndexPageViewController *homeVC =[[IndexPageViewController alloc] init];
   // SettingsViewController *settings=[[SettingsViewController alloc] init];
   // RootViewController *menuController = [[RootViewController alloc] initWithViewControllers:@[homeVC] andMenuTitles:@[@"",@""]];
                                           
    self.window.rootViewController = homeVC;//menuController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
    
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSLog(@"My token is: %@", deviceToken);
    self.Token = [[[[deviceToken description]
                    stringByReplacingOccurrencesOfString: @"<" withString: @""]
                   stringByReplacingOccurrencesOfString: @">" withString: @""]
                  stringByReplacingOccurrencesOfString: @" " withString: @""];
	if ([self.Token isEqualToString:@"(null)"])
    {
        self.Token = @"";
    }
	NSLog(@"Device Token: %@", self.Token);
    //64a44c9d3d0015b0f1c114baaf4f2ac8d8e0f146c1743362c156f758188d41de // mithun's iphone
    [[NSUserDefaults standardUserDefaults] setObject:self.Token forKey:@"DeviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
   /* UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive)
    {
          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reminder"
         message:notification.alertBody
         delegate:self cancelButtonTitle:@"OK"
         otherButtonTitles:nil];
        //[alert show];
    }
    
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    // Set icon badge number to zero
    application.applicationIconBadgeNumber = 1;*/
}

/*
#pragma mark - Beacon Stuff
-(void)beaconStart
{
    UIApplication *application = [UIApplication sharedApplication];
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
 
     // * BeaconManager setup.
    NSData* data1 = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"Beacon%d",1]];
    NSMutableArray  *fetchedBeaconArray =[[NSMutableArray alloc] init];
    fetchedBeaconArray =[NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSString *uuidString =[[[fetchedBeaconArray objectAtIndex:0] objectAtIndex:0] valueForKey:@"uudid"];
    NSString *majorString =[[[fetchedBeaconArray objectAtIndex:0] objectAtIndex:0] valueForKey:@"major"];
    NSString *minorString =[[[fetchedBeaconArray objectAtIndex:0] objectAtIndex:0] valueForKey:@"minor"];
    
    NSUUID *proximityUUID=[[NSUUID alloc] initWithUUIDString:uuidString];

 
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:proximityUUID
                                                                 major:[majorString intValue]
                                                                 minor:[minorString intValue]
                                                            identifier:@"RegionIdentifier"];
    self.beaconRegion.notifyOnEntry = YES;
    self.beaconRegion.notifyOnExit = YES;
    
    [self.beaconManager startMonitoringForRegion:self.beaconRegion];
}

- (void)beaconManager:(ESTBeaconManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    //if (self.scanType == ESTScanTypeBeacon)
    {
        [self startRangingBeacons];
    }
}
-(void)startRangingBeacons
{
    if ([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
    {
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
 
            // * No need to explicitly request permission in iOS < 8, will happen automatically when starting ranging.
 
            [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
        } else {
 
            // * Request permission to use Location Services. (new in iOS 8)
            // * We ask for "always" authorization so that the Notification Demo can benefit as well.
            // * Also requires NSLocationAlwaysUsageDescription in Info.plist file.
            // *
            // * For more details about the new Location Services authorization model refer to:
            // * https://community.estimote.com/hc/en-us/articles/203393036-Estimote-SDK-and-iOS-8-Location-Services
 
            [self.beaconManager requestAlwaysAuthorization];
        }
    }
    else if([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [ESTBeaconManager authorizationStatus] ==kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
    }
    else if([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Access Denied"
                                                        message:@"You have denied access to location services. Change this in app settings."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        
        [alert show];
    }
    else if([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusRestricted)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Not Available"
                                                        message:@"You have no access to location services."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

#pragma mark - ESTBeaconManager delegate

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    
}

- (void)beaconManager:(ESTBeaconManager *)manager didDiscoverBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    //[self.beaconsArray  removeAllObjects];
    //self.beaconsArray =(NSMutableArray *)beacons;
}

#pragma mark - ESTBeaconManager delegate
- (void)beaconManager:(ESTBeaconManager *)manager didEnterRegion:(ESTBeaconRegion *)region
{
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"Welcome !";
    [self speechOfGivenText:[[NSUserDefaults standardUserDefaults] valueForKey:@"CheckInMessage"]];
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)beaconManager:(ESTBeaconManager *)manager didExitRegion:(ESTBeaconRegion *)region
{
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"Good bye !";
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    [self speechOfGivenText:[[NSUserDefaults standardUserDefaults] valueForKey:@"CheckOutMessage"]];
}

-(NSMutableDictionary *)beaconOnServer:(NSString *)beaconName beaconUUiD:(NSString *)beaconUUiD major:(NSString *)major minor:(NSString *)minor
{
    NSMutableDictionary *beaconDic = [[NSMutableDictionary alloc] init];
    for (int i=0; i<registeredBeaconArray.count; i++)
    {
        if ([[[registeredBeaconArray objectAtIndex:i] valueForKey:@"uudid"] isEqualToString:beaconUUiD])
        {
            if ([[[registeredBeaconArray objectAtIndex:i] valueForKey:@"major"] isEqualToString:major] && [[[registeredBeaconArray objectAtIndex:i] valueForKey:@"minor"] isEqualToString:minor])
            {
                [beaconDic setValue:[[registeredBeaconArray objectAtIndex:i] valueForKey:@"beacon_id"] forKey:@"beacon_id"];
                [beaconDic setValue:[[registeredBeaconArray objectAtIndex:i] valueForKey:@"beacon_name"] forKey:@"beacon_name"];
                [beaconDic setValue:[[registeredBeaconArray objectAtIndex:i] valueForKey:@"major"] forKey:@"major"];
                [beaconDic setValue:[[registeredBeaconArray objectAtIndex:i] valueForKey:@"minor"] forKey:@"minor"];
                break;
            }
            else
            {
                
            }
        }
    }
    return beaconDic;
}

-(NSMutableArray *)fatchBeaconsInfo
{
    NSMutableArray *beaconIdArray=[[NSMutableArray alloc] init];
    
    for (int i=0; i<beaconsArray.count;i++)
    {
        ESTBeacon *beacon = [beaconsArray objectAtIndex:i];
        NSArray *fetchiDentifier=[MyCustomeClass seprateStringFromStringUsingArrray:[NSString stringWithFormat:@"%@", beacon.proximityUUID]:@"> "];
        [beaconIdArray addObject:[self beaconOnServer:beacon.name beaconUUiD:[fetchiDentifier objectAtIndex:1] major:[NSString stringWithFormat:@"%@",beacon.major] minor:[NSString stringWithFormat:@"%@",beacon.minor]]];
    }
    return beaconIdArray;
}
*/

#pragma mark - siri supported method using for speaching
-(void)speechOfGivenText:(NSString *)messageText
{
    avSpeechSynthesizer=[[AVSpeechSynthesizer alloc] init];
    AVSpeechSynthesizer *synthesizer = avSpeechSynthesizer;
    synthesizer.delegate = self;
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:messageText];
    // utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"ar-SA"];
    [utterance setRate:0.1f];
    [synthesizer speakUtterance:utterance];
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance
{
    
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
    
}

-(void)stopSpeaking
{
    AVSpeechSynthesizer *synthesizer = avSpeechSynthesizer;
    [synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

#pragma mark - Save Beacon Locally
#pragma mark - SBBeaconManager delegate

-(void)SBBeaconStart
{
   /*
    NSData* data1 = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"Beacon%d",1]];
    NSMutableArray  *fetchedBeaconArray =[[NSMutableArray alloc] init];
    fetchedBeaconArray =[NSKeyedUnarchiver unarchiveObjectWithData:data1];
    //NSString *uuidString =[[[fetchedBeaconArray objectAtIndex:0] objectAtIndex:0] valueForKey:@"uudid"];
    //NSString *majorString =[[[fetchedBeaconArray objectAtIndex:0] objectAtIndex:0] valueForKey:@"major"];
    //NSString *minorString =[[[fetchedBeaconArray objectAtIndex:0] objectAtIndex:0] valueForKey:@"minor"];
    
    for (int i=0; i<fetchedBeaconArray.count; i++)
    {
        NSString *serialNumber =[[[fetchedBeaconArray objectAtIndex:i] objectAtIndex:0] valueForKey:@"serial_no"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:serialNumber];
    }
    //NSUUID *proximityUUID=[[NSUUID alloc] initWithUUIDString:uuidString];
    //SBKBeaconID *beaconID = [SBKBeaconID beaconIDWithProximityUUID:proximityUUID major:(CLBeaconMajorValue *)[majorString intValue] minor:(CLBeaconMinorValue *)[minorString intValue]];
    SBKBeaconID *beaconID = [SBKBeaconID beaconIDWithProximityUUID:SBKSensoroDefaultProximityUUID];
    [[SBKBeaconManager sharedInstance] startRangingBeaconsWithID:beaconID
                                               wakeUpApplication:YES];
    
    [[SBKBeaconManager sharedInstance] requestAlwaysAuthorization];
    [SBKBeaconManager sharedInstance].delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beacon:) name:SBKBeaconInRangeStatusUpdatedNotification object:nil];
    [[SBKBeaconManager sharedInstance]addBroadcastKey:@"7b4b5ff594fdaf8f9fc7f2b494e400016f461205"];
    [[SBKBeaconManager sharedInstance] setCloudServiceEnable:YES];*/
}
/*
- (void)beaconInRangeStatusUpdated:(NSNotification *)notification
{
    SBKBeacon * beacon = notification.object;
    if (beacon.inRange)
    {
      //  [self speechOfGivenText:[[NSUserDefaults standardUserDefaults] valueForKey:@"CheckInMessage"]];
    }
    else
    {
      //  [self speechOfGivenText:[[NSUserDefaults standardUserDefaults] valueForKey:@"CheckOutMessage"]];
    }
}

- (void)beacon:(NSNotification *)notification
{
    SBKBeacon *beacon = notification.object;
    //[[NSUserDefaults standardUserDefaults] setBool:YES forKey:beacon.serialNumber];

    if (!beacon.serialNumber)
    {
        return;
    }
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:beacon.serialNumber])
    {
        return;
    }
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
    {
        if (beacon.inRange)
        {
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            NSString * message = [NSString stringWithFormat:@"Cibo IN:%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"CheckInMessage"]];
            notification.alertBody = message;
            notification.soundName=UILocalNotificationDefaultSoundName;
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
            
            [self speechOfGivenText:[[NSUserDefaults standardUserDefaults] valueForKey:@"CheckInMessage"]];
            [self checkINBeaconRequest];
            [self beaconCouponFire];
        }
        else
        {
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            NSString * message = [NSString stringWithFormat:@"Cibo OUT:%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"CheckOutMessage"]];
            notification.alertBody = message;
            notification.soundName=UILocalNotificationDefaultSoundName;
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
            [self speechOfGivenText:[[NSUserDefaults standardUserDefaults] valueForKey:@"CheckOutMessage"]];
            [self checkOutBeaconRequest];
        }
    }
    else
    {
        if (beacon.inRange)
        {
            //NSString * message = [NSString stringWithFormat:@"\U0001F603 IN:%@",beacon.serialNumber];
        }
        else
        {
           // NSString * message = [NSString stringWithFormat:@"\U0001F628 OUT:%@",beacon.serialNumber];
        }
    }
}

- (void)setBeacon:(SBKBeacon *)beacon
{
    if (!beacon.serialNumber)
        return;
}

- (void)beaconManager:(SBKBeaconManager *)beaconManager didRangeNewBeacon:(SBKBeacon *)beacon
{
    [sBbeacons addObject:beacon];
    [self setBeacon:beacon];
}

- (void)beaconManager:(SBKBeaconManager *)beaconManager beaconDidGone:(SBKBeacon *)beacon
{
    [sBbeacons removeObject:beacon];
}

- (void)beaconManager:(SBKBeaconManager *)beaconManager scanDidFinishWithBeacons:(NSArray *)beacons
{
    
}

- (void)startRangingBeaconsWithID:(SBKBeaconID *)beaconID wakeUpApplication:(BOOL)wakeUpApplication
{
    //[self speechOfGivenText:[[NSUserDefaults standardUserDefaults] valueForKey:@"CheckInMessage"]];
}

- (BOOL)checkLocationServices
{
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        self.locationManager.distanceFilter=100.0f;
    }
    BOOL enable=[CLLocationManager locationServicesEnabled];//定位服务是否可用
    int status=[CLLocationManager authorizationStatus];//是否具有定位权限
    if(!enable || status<3){
        [self.locationManager requestAlwaysAuthorization];//请求权限
        return NO;//需求请求定位权限
    }
    return YES;
}

- (BOOL)checkBluetoothServices
{
    if (!self.CM) {
        self.CM = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    }
    
    if (self.CM.state == CBCentralManagerStatePoweredOff) {
        return NO;
    }
    else if(self.CM.state == CBCentralManagerStatePoweredOn){
        return YES;
    }
    return YES;
}


- (void)check{
    
    if ([self checkBluetoothServices]&&[self checkLocationServices]) {
        
    }
    else
    {
        
    }
}
*/
#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
  //  [self check];
}
 
/*
#pragma mark - WebService For Beacond
-(void)checkINBeaconRequest
{
    NSString *member_id = [[NSUserDefaults standardUserDefaults] valueForKey:@"Member"];
    if (member_id.length>6)
    {
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *checkinDate = [dateFormatter stringFromDate:date];
        
        NSDateFormatter *timeFormatter =[[NSDateFormatter alloc]init];
        [timeFormatter setDateFormat:@"hh:mm"];
        NSString *checkinTime = [timeFormatter stringFromDate:date];
        
        WebServiceHelper *helper =[[WebServiceHelper alloc] init];
        helper.delegate=self;
        
        NSString *data =[NSString stringWithFormat:@"memberId=%@&check_in_date=%@&check_in_time=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Member"],checkinDate,checkinTime ];
        NSString *urlString = [NSString stringWithFormat:@"check_in/restId/%@/",@"64672688"];
        [helper checkINCheckOUTBeacon:urlString postData:data];
    }
}

-(void)checkOutBeaconRequest
{
    NSString *member_id = [[NSUserDefaults standardUserDefaults] valueForKey:@"Member"];
    if (member_id.length>6)
    {
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *checkinDate = [dateFormatter stringFromDate:date];
        NSDateFormatter *timeFormatter =[[NSDateFormatter alloc]init];
        [timeFormatter setDateFormat:@"hh:mm"];
        NSString *checkinTime = [timeFormatter stringFromDate:date];
        WebServiceHelper *helper =[[WebServiceHelper alloc] init];
        helper.delegate=self;
        NSString *checkInId = [[NSUserDefaults standardUserDefaults] valueForKey:@"CheckInID"];
        NSString *data =[NSString stringWithFormat:@"memberId=%@&check_out_date=%@&check_out_time=%@cvrId=%@",member_id,checkinDate,checkinTime,checkInId ];
         NSString *urlString = [NSString stringWithFormat:@"check_out/restId/%@/",ciboRestaurantId];
        [helper checkINCheckOUTBeacon:urlString postData:data];
    }
}

-(void)checkINCheckOUTBeacon:(NSString *)response
{
    if (response.length>10)
    {
        NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
        dataDic=[MyCustomeClass jsonDictionary:response];
        if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCCESS"])
        {
            NSString *checkInId =[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"ID"]];
            [[NSUserDefaults standardUserDefaults] setValue:checkInId forKey:@"CheckInID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"CheckInID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

-(void)beaconCouponFire
{
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:@"BeaconCoupen"];
    NSMutableArray *beaconCoupenArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    for (NSArray *couponArray in beaconCoupenArray)
    {
        NSDictionary * dataDic =[couponArray objectAtIndex:0];
        if ([[dataDic objectForKey:@"coupon_status"] isEqualToString:@"1"])
        {
            int fireminute=0;
            int fireHour=0;
            int fireSecond=0;
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [[NSDateComponents alloc] init];
            [components setDay: [[MyCustomeClass currentDayInInteger:[NSDate date]] intValue]];
            [components setMonth:[[MyCustomeClass currentMonthInInteger:[NSDate date]] intValue]];
            [components setYear: [[MyCustomeClass currentYearInInteger:[NSDate date]] intValue]];
            
            NSString *string =[dataDic objectForKey:@"certain_time"];
            NSArray *timeArray =[MyCustomeClass seprateStringFromStringUsingArrray:string :@" "];
            if ([[timeArray objectAtIndex:1] isEqualToString:@"minutes"])
            {
                fireminute = [[timeArray objectAtIndex:0] intValue];
            }
            else if ([[timeArray objectAtIndex:1] isEqualToString:@"hours"])
            {
                fireHour = [[timeArray objectAtIndex:0] intValue];
            }
            else
            {
                fireSecond = [[timeArray objectAtIndex:0] intValue];
            }
            NSString * message=nil;
            UILocalNotification *localNotification = [[UILocalNotification alloc] init];
            if ([[dataDic objectForKey:@"discount"] intValue]<=0)
            {
                message = [NSString stringWithFormat:@"Offer:%@ with %@ %@",[dataDic objectForKey:@"coupon_name"],[dataDic objectForKey:@"amount"],@"OFF"];
            }
            else
            {
                message = [NSString stringWithFormat:@"Offer:%@ with %@%@ %@",[dataDic objectForKey:@"coupon_name"],[dataDic objectForKey:@"discount"],@"%",@"OFF"];
            }
            
            if (fireHour!=0)
                [components setHour: fireHour];
            else
                [components setHour:[MyCustomeClass currentHour:[NSDate date]]];
            
            if (fireminute!=0)
                [components setMinute:fireminute];
            else
                [components setMinute:[MyCustomeClass currentHour:[NSDate date]]];
            
            if (fireSecond!=0)
                [components setSecond:fireSecond];
            else
                [components setSecond: [MyCustomeClass currentHour:[NSDate date]]];
            
            [calendar setTimeZone: [NSTimeZone defaultTimeZone]];
            NSDate *dateToFire = [calendar dateFromComponents:components];
            
            [localNotification setFireDate: dateToFire];
            [localNotification setTimeZone: [NSTimeZone defaultTimeZone]];
            [localNotification setRepeatInterval: kCFCalendarUnitDay];
            localNotification.alertBody = message;
            localNotification.repeatInterval=0;
            localNotification.soundName=UILocalNotificationDefaultSoundName;
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        }
    }
}*/



@end
