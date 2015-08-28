//
//  RootViewController.h
//  ContarCalorias
//
//  Created by mithun ravi on 14/10/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewCell.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "MyCustomeClass.h"
#import "SettingsViewController.h"
#import "MyOpenOrderViewController.h"

@class AppDelegate;
@interface RootViewController : UIViewController<WebServiceHelperDelegate>
{
    AppDelegate *appDelegate;
    NSUserDefaults *rootDefault;
    IBOutlet UILabel *USERNAMELABEL;
    IBOutlet UIImageView *profileImage;
    NSString *munchPoint;
    NSMutableDictionary *restaurentInfoDic;
}
@property (nonatomic, strong) IBOutlet UITableView *rootTableView;
@property (nonatomic, strong) NSMutableArray *nameArray,*imageArray;
/////////////////////////////////////
@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, assign) NSInteger indexOfVisibleController;
@property (nonatomic, assign) BOOL isMenuVisible;

- (id)initWithViewControllers:(NSArray *)viewControllers andMenuTitles:(NSArray *)titles; // (2)

@end
