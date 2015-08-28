//
//  ViewController.h
//  Cibo
//
//  Created by mithun ravi on 15/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomeClass.h"
#import "RegisterViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#define DOCUMENTS_FOLDER1 [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

@class AppDelegate;
@interface ViewController : UIViewController<WebServiceHelperDelegate>
{
    NSUserDefaults *loginDefault;
    AppDelegate *appDelegate;
    
    IBOutlet UILabel *lblForgot, *lblPasswor;
    IBOutlet UILabel *lblCreate, *lblAnAccount;
    IBOutlet UILabel *lblSignin;
    
    NSDictionary *facebookInfoDic;

}


@property(nonatomic,strong)IBOutlet UITextField *userNameText,*passwordText;
@property(nonatomic,strong)IBOutlet UIButton *loginButton, *btnFacebook;
//@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePic;
//@property (strong, nonatomic) id<FBGraphUser> loggedInUser;

@property (nonatomic,strong) IBOutlet UILabel *usernamelabel,*passwordLable;



-(IBAction)clickonloginbutton:(id)sender;

@end
