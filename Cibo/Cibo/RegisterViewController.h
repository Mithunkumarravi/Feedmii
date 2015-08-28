//
//  RegisterViewController.h
//  Cibo
//
//  Created by mithun ravi on 26/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomeClass.h"
#import "WebServiceHelper.h"

#define PlaceholderColor [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] 

@interface RegisterViewController : UIViewController<WebServiceHelperDelegate>
{
    NSUserDefaults *registerDefault;
    UITextField *currentTextField;
    BOOL keyboardVisible;
    IBOutlet UILabel *lblSignUp;
}
@property (nonatomic, strong) IBOutlet UIScrollView *detailScrollView;
@property (nonatomic,strong) IBOutlet UITextField *firstName;
@property (nonatomic,strong) IBOutlet UITextField *surName;
@property (nonatomic,strong) IBOutlet UITextField *address;
@property (nonatomic,strong) IBOutlet UITextField *email;
@property (nonatomic,strong) IBOutlet UITextField *dOB;
@property (nonatomic,strong) IBOutlet UITextField *city;
@property (nonatomic,strong) IBOutlet UITextField *state;
@property (nonatomic,strong) IBOutlet UITextField *country;
@property (nonatomic,strong) IBOutlet UITextField *phonenumber;
@property (nonatomic,strong) IBOutlet UITextField *mobilenumber;
@property (nonatomic,strong) IBOutlet UITextField *postcode;
@property (nonatomic,strong) IBOutlet UITextField *password;
@property (nonatomic, strong) IBOutlet UITextField *username;

@property (nonatomic,strong) IBOutlet UITextField *craditNumber;
@property (nonatomic,strong) IBOutlet UITextField *ccv2Number;
@property (nonatomic, strong) IBOutlet UITextField *cardExDate;
@property (nonatomic, strong) NSDictionary *facebookDic;


/////////////////////////////////////////////////////////////
@property (nonatomic, strong) IBOutlet UILabel *titelLabel,*firstnameLabel,*surNameLabel,*addressLabel,*emailLabel,*dobLabel,*cityLabel,*stateLabel,*countryLabel,*phoneLabel,*mobileLabel,*postcodeLabel,*passwordLabel,*usernameLbale,*subtitleLabel;
@property (nonatomic, strong) IBOutlet UIButton *backButton,*registerButton;



@end
