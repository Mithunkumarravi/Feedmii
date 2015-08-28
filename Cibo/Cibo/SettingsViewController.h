//
//  SettingsViewController.h
//  Cibo
//
//  Created by mithun ravi on 25/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomeClass.h"
#import "WebServiceHelper.h"

@interface SettingsViewController : UIViewController<WebServiceHelperDelegate,UIAlertViewDelegate>
{
    NSUserDefaults *settingsDefault;
  
}
@property (nonatomic,strong) IBOutlet UIScrollView *detailScrollView;
@property (nonatomic,strong) IBOutlet UITextField *firstName;
@property (nonatomic,strong) IBOutlet UITextField *username;

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
@property (nonatomic,strong) IBOutlet UIImageView *navi;

//////////////////
@property (nonatomic, strong) IBOutlet UILabel *titelLabel,*firstnameLabel,*surNameLabel,*addressLabel,*emailLabel,*dobLabel,*cityLabel,*stateLabel,*countryLabel,*phoneLabel,*mobileLabel,*postcodeLabel,*passwordLabel,*usernameLbale,*subtitleLabel;
@property (nonatomic, strong ) IBOutlet UIButton *backButton,*editBUtton,*saveButton,*languageTitle;

@end
