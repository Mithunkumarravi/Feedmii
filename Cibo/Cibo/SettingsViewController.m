//
//  SettingsViewController.m
//  Cibo
//
//  Created by mithun ravi on 25/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize detailScrollView;
@synthesize firstName,state,surName,address,email,dOB,city,country,phonenumber,mobilenumber,postcode,password;
@synthesize titelLabel,firstnameLabel,surNameLabel,addressLabel,emailLabel,dobLabel,cityLabel,stateLabel,countryLabel,phoneLabel,mobileLabel,postcodeLabel,passwordLabel,usernameLbale,subtitleLabel;
@synthesize languageTitle;
@synthesize navi;
@synthesize username;

@synthesize backButton,editBUtton,saveButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self languageTextOnObjct];
    settingsDefault=[NSUserDefaults standardUserDefaults];
    //detailScrollView.frame=CGRectMake(0, 50, 320, 450);
    detailScrollView.contentSize=CGSizeMake(304,631);
    [self fieldEditableNo];
    if(IS_IPHONE5)
    {
        detailScrollView.frame=CGRectMake(8, 71, 304, 490);
        detailScrollView.contentSize = CGSizeMake(304, 704);
    }
    else
    {
        detailScrollView.frame=CGRectMake(8, 130, 320, 480);
        navi.frame=CGRectMake(0, 44, 320, 44+44);
    }
    if ([[settingsDefault objectForKey:@"Email"] length]>2)
    {
        //if (ciboRestaurantId>0)
        {
            [self gettingViewUserInfo];
        }
    }
    else
    {
        ViewController *viewController=[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        [self presentViewController:viewController animated:true completion:nil];
    }
    subtitleLabel.font=[UIFont fontWithName:FONT_Ragular size:20.0];
    [subtitleLabel setFont: [subtitleLabel.font fontWithSize: 20.0]];

    // Do any additional setup after loading the view from its nib.
}

-(void)languageTextOnObjct
{
    [languageTitle setTitle:[MyCustomeClass languageSelectedStringForKey:@"Language"] forState:UIControlStateNormal] ;

    titelLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Settings"];
    firstnameLabel.text=[MyCustomeClass languageSelectedStringForKey:@"First name*:"];
    surNameLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Sur Name*:"];
    passwordLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Password*:"];
    phoneLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Phone Number:"];
    mobileLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Mobile Number*:"];
    emailLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Email*:"];
    dobLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Date of Birth*:"];
    cityLabel.text=[MyCustomeClass languageSelectedStringForKey:@"City*:"];
    countryLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Country*:"];
    stateLabel.text=[MyCustomeClass languageSelectedStringForKey:@"State*:"];
    postcodeLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Postcode:"];
    addressLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Address:"];
    subtitleLabel.text=[MyCustomeClass languageSelectedStringForKey:@"PROFILE DETAIL"];
    
    [backButton setTitle:[MyCustomeClass languageSelectedStringForKey:@"Back"] forState:UIControlStateNormal];
    [editBUtton setTitle:[MyCustomeClass languageSelectedStringForKey:@"Edit"] forState:UIControlStateNormal];
   // [saveButton setTitle:[MyCustomeClass languageSelectedStringForKey:@"Save"] forState:UIControlStateNormal];
    
    
    [firstName setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"First name*:"]];
    [surName setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"sur name*:"]];
    [password setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"password*:"]];
    [phonenumber setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"phone number*:"]];
    [mobilenumber setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"mobile number*:"]];
    [email setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"email*:"]];
    [dOB setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"DOB*:"]];
    [city setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"City*:"]];
    [country setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"Country*:"]];
    [state setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"State*:"]];
    [postcode setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"Post code*:"]];
    [address setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"Address*:"]];
    
    [firstName setValue:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [surName setValue:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [password setValue:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [phonenumber setValue:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [mobilenumber setValue:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [email setValue:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
     [dOB setValue:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
     [city setValue:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
     [country setValue:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [state setValue:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];

    [postcode setValue:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
     [address setValue:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Action method list..
-(IBAction)clickOnLanguageChangeButton:(id)sender
{
    UIAlertView *alrt=[[UIAlertView alloc] initWithTitle:[MyCustomeClass languageSelectedStringForKey:@"Language Choose"] message:[MyCustomeClass languageSelectedStringForKey:@"Please select any language"] delegate:self cancelButtonTitle:[MyCustomeClass languageSelectedStringForKey:@"Cancel" ]otherButtonTitles:[MyCustomeClass languageSelectedStringForKey:@"English"],[MyCustomeClass languageSelectedStringForKey: @"Chinese"], nil];
    
    [alrt show];
}

-(IBAction)clickOnBackButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)clicOnSaveButton:(id)sender
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Update profile..."]];
    if (firstName.text==nil || [firstName.text length]<=0)
    {
        [firstName becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter first name."]:1.000];
    }
    else if (surName.text==nil || [surName.text length]<=0)
    {
        [surName becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter sur name."] :1.000];
    }
    else if (email.text==nil || [email.text length]<=0)
    {
        [email becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter email address."] :1.000];
    }
    else if (dOB.text==nil || [dOB.text length]<=0)
    {
        [dOB becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter date of birth."] :1.000];
    }
    else if (city.text==nil || [city.text length]<=0)
    {
        [city becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter city."] :1.000];
    }
    else if (state.text==nil || [state.text length]<=0)
    {
        [state becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter state."] :1.000];
    }
    else if (country.text==nil || [country.text length]<=0)
    {
        [country becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter country."] :1.000];
    }
    else if (mobilenumber.text==nil || [mobilenumber.text length]<=0)
    {
        [mobilenumber becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter mobile number."] :1.000];
    }
    else
    {
        if ([MyCustomeClass validateEmail:email.text])
        {
            if ([MyCustomeClass checkInternetConnection])
            {
                [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Your Info..."]];
                
                WebServiceHelper *helper=[[WebServiceHelper alloc] init];
                [helper setDelegate:self];
                
                NSString *urlString=[NSString stringWithFormat:@"/member/updateMemberDetails/memberId/%@",[settingsDefault objectForKey:@"Member"]];
                NSString *postData=[NSString stringWithFormat:@"firstname=%@&lastname=%@&email=%@&address=%@&city=%@&state=%@&zipcode=%@&country=%@&mobile=%@&dob=%@&phone=%@",firstName.text,surName.text,email.text,address.text,city.text,state.text,postcode.text,country.text,mobilenumber.text,dOB.text,phonenumber.text];
                NSLog(@"%@",postData);
                [helper updateUserDetail:urlString :postData];
            }
            else
            {
                [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"internet not connected with device."] :1.000];
            }
        }
        else
        {
            [email becomeFirstResponder];
            [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:[MyCustomeClass languageSelectedStringForKey:@"Please valid email address."]] :1.000];
        }
    }
    
}
-(IBAction)KeyboardGone:(id)sender
{
    [firstName resignFirstResponder];
    [surName resignFirstResponder];
    [address resignFirstResponder];
    [email resignFirstResponder];
    [dOB resignFirstResponder];
    [city resignFirstResponder];
    [country resignFirstResponder];
    [state resignFirstResponder];
    [postcode resignFirstResponder];
    [phonenumber resignFirstResponder];
    [mobilenumber resignFirstResponder];
    [password resignFirstResponder];
}

-(void)clearAllField
{
    firstName.text=nil;
    surName.text=nil;
    address.text=nil;
    email.text=nil;
    dOB.text=nil;
    city.text=nil;
    country.text=nil;
    state.text=nil;
    mobilenumber.text=nil;
    postcode.text=nil;
    phonenumber.text=nil;
    password.text=nil;
}

-(IBAction)fieldEditableYes:(id)sender
{
    firstName.enabled=YES;
    surName.enabled=YES;
    address.enabled=YES;
    email.enabled=YES;
    dOB.enabled=YES;
    city.enabled=YES;
    country.enabled=YES;
    state.enabled=YES;
    mobilenumber.enabled=YES;
    postcode.enabled=YES;
    phonenumber.enabled=YES;
    password.enabled=YES;
    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Alert !" message:@"Now you can edit your information." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    
}
-(void)fieldEditableNo
{
    /*firstName.enabled=NO;
     surName.enabled=NO;
     address.enabled=NO;
     email.enabled=NO;
     dOB.enabled=NO;
     city.enabled=NO;
     country.enabled=NO;
     state.enabled=NO;
     mobilenumber.enabled=NO;
     postcode.enabled=NO;
     phonenumber.enabled=NO;
     password.enabled=NO;*/
    
    firstName.enabled=YES;
    surName.enabled=YES;
    address.enabled=YES;
    email.enabled=YES;
    dOB.enabled=YES;
    city.enabled=YES;
    country.enabled=YES;
    state.enabled=YES;
    mobilenumber.enabled=YES;
    postcode.enabled=YES;
    phonenumber.enabled=YES;
    password.enabled=YES;
}


#pragma mark - web service Request method list..
-(void)gettingViewUserInfo
{
     [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"profile Info..."]];
    
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    
    NSString *postData=[NSString stringWithFormat:@"member/memberDetails/memberId/%@",[settingsDefault objectForKey:@"Member"]];
    NSLog(@"%@",postData);
    [helper viewUserDetail:postData];
}

#pragma mark - web service Response method list

-(void)viewUserDetail:(NSString *)response
{
    NSLog(@"responseresponse==%@",response);
    if ([response length] >4)
    {
        NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
        if (response!=nil)
            dataDic=[MyCustomeClass jsonDictionary:response];
        
        NSLog(@"%@",dataDic);
        
        NSMutableArray *loginDataDic=[[NSMutableArray alloc] init];
        loginDataDic=[dataDic objectForKey:@"memberInfo"];
        if(loginDataDic.count>0)
        {
            NSLog(@"%@",loginDataDic);
            firstName.text=[NSString stringWithFormat:@"%@",[[loginDataDic  objectAtIndex:0] objectForKey:@"firstname"]];
            surName.text=[NSString stringWithFormat:@"%@",[[loginDataDic  objectAtIndex:0] objectForKey:@"lastname"]];
            email.text=[NSString stringWithFormat:@"%@",[[loginDataDic  objectAtIndex:0] objectForKey:@"email"]];
            country.text=[NSString stringWithFormat:@"%@",[[loginDataDic  objectAtIndex:0] objectForKey:@"country"]];
            city.text=[NSString stringWithFormat:@"%@",[[loginDataDic  objectAtIndex:0] objectForKey:@"city"]];
            state.text=[NSString stringWithFormat:@"%@",[[loginDataDic  objectAtIndex:0] objectForKey:@"state"]];
            postcode.text=[NSString stringWithFormat:@"%@",[[loginDataDic  objectAtIndex:0] objectForKey:@"zipcode"]];
            address.text=[NSString stringWithFormat:@"%@",[[loginDataDic  objectAtIndex:0] objectForKey:@"address"]];
            dOB.text=[NSString stringWithFormat:@"%@",[[loginDataDic  objectAtIndex:0] objectForKey:@"dob"]];
            phonenumber.text=[NSString stringWithFormat:@"%@",[[loginDataDic  objectAtIndex:0] objectForKey:@"phone"]];
            mobilenumber.text=[NSString stringWithFormat:@"%@",[[loginDataDic  objectAtIndex:0] objectForKey:@"mobile"]];
            username.text=[NSString stringWithFormat:@"%@",[[loginDataDic  objectAtIndex:0] objectForKey:@"username"]];
            
            
            
            [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Successfully loaded."] :1.00];
        }
    }
}

-(void)updateUserDetail:(NSString *)response
{
    NSLog(@"responseresponse==%@",response);
    if ([response length] >4)
    {
        NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
        dataDic=[MyCustomeClass jsonDictionary:response];
        NSLog(@"%@",dataDic);
        if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCCESS"] || [[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCESS"])
        {
            [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Update successfully done." ]:1.00];
        }
        else
        {
            [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Try again."] :1.00];
        }
    }
}

-(void)gettingFail:(NSString*)error
{
    NSLog(@"%@",error);
    [MyCustomeClass SVProgressMessageDismissWithSuccess:error :1.00];
}

#pragma mark - alertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Cancel"])
    {
        
    }
    else if ([title isEqualToString:@"English"])
    {
        [settingsDefault setValue:@"1" forKey:@"Language"];
    }
    else if ([title isEqualToString:@"Chinese"])
    {
        [settingsDefault setValue:@"2" forKey:@"Language"];
    }
    [self languageTextOnObjct];
}


#pragma mark -
#pragma mark UITextFieldDelegate
- (void) scrollViewAdaptToStartEditingTextField:(UITextField*)textField
{
    CGPoint point = CGPointMake(0, textField.frame.origin.y - 1.5 * textField.frame.size.height);
    [detailScrollView setContentOffset:point animated:YES];
}

- (void) scrollVievEditingFinished:(UITextField*)textField
{
    CGPoint point = CGPointMake(0, 0);
    [detailScrollView setContentOffset:point animated:YES];
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    [self scrollViewAdaptToStartEditingTextField:textField];
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self scrollVievEditingFinished:textField];
    return YES;
}

-(IBAction)logoutButton:(id)sender
{
    [[NSUserDefaults  standardUserDefaults] setValue:@"Logout" forKey:@"Logout"];
    [[NSUserDefaults  standardUserDefaults]  setValue:@"view" forKey:@"RootView"];
    [[NSUserDefaults  standardUserDefaults]  setValue:@"" forKey:@"Email"];
    [self dismissViewControllerAnimated:true completion:nil];
}





@end
