//
//  RegisterViewController.m
//  Cibo
//
//  Created by mithun ravi on 26/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize detailScrollView;
@synthesize firstName,state,surName,address,email,dOB,city,country,phonenumber,mobilenumber,postcode,password;
@synthesize username;
@synthesize titelLabel,firstnameLabel,surNameLabel,addressLabel,emailLabel,dobLabel,cityLabel,stateLabel,countryLabel,phoneLabel,mobileLabel,postcodeLabel,passwordLabel,usernameLbale,subtitleLabel;
@synthesize backButton,registerButton;
@synthesize cardExDate;
@synthesize ccv2Number;
@synthesize craditNumber;
@synthesize facebookDic;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    lblSignUp.font=[UIFont fontWithName:FONT_Ragular size:20.0];
    [lblSignUp setFont: [lblSignUp.font fontWithSize: 20.0]];


    registerDefault=[NSUserDefaults standardUserDefaults];
    [self languageTextOnObjct];
    
    // [self clearAllField];
    
    if (IS_IPHONE5)
    {
        detailScrollView.frame=CGRectMake(0, 52, 320, 480);
        detailScrollView.contentSize = CGSizeMake(320, 704);
        
    }
    else
    {
        detailScrollView.frame=CGRectMake(0, 52, 320, 400);
        detailScrollView.contentSize = CGSizeMake(320, 750);
        
        
    }
    
    // Do any additional setup after loading the view from its nib.
}

-(void)languageTextOnObjct
{
    [registerButton setTitle:[MyCustomeClass languageSelectedStringForKey:@"Register"] forState:UIControlStateNormal] ;
    
    titelLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Registration"];
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
    subtitleLabel.text=[MyCustomeClass languageSelectedStringForKey:@"Personal Details:"];
    [backButton setTitle:[MyCustomeClass languageSelectedStringForKey:@"Back"] forState:UIControlStateNormal];
    [firstName setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [surName setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [address setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [email setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [dOB setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [city setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [state setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [country setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [phonenumber setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [mobilenumber setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [firstName setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [postcode setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [password setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [username setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [cardExDate setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [ccv2Number setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [craditNumber setValue:PlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];


    //[editBUtton setTitle:[MyCustomeClass languageSelectedStringForKey:@"Edit"] forState:UIControlStateNormal];
    //[saveButton setTitle:[MyCustomeClass languageSelectedStringForKey:@"Save"] forState:UIControlStateNormal];
    //[firstName setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"First name*:"]];
    //[surName setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"Sur name*:"]];
    //[password setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"Password*:"]];
    //[phonenumber setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"Phone Number*:"]];
    //[mobilenumber setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"Mobile Number*:"]];
    //[email setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"Email*:"]];
    //[dOB setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"DOB*:"]];
    //[city setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"City*:"]];
    //[country setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"Country*:"]];
    //[state setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"State*:"]];
    //[postcode setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"Post Code*:"]];
    //[address setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"Address*:"]];
    if (facebookDic.count>0)
    {
        firstName.text=[facebookDic objectForKey:@"first_name"];
        surName.text=[facebookDic objectForKey:@"last_name"];
        password.text=[facebookDic objectForKey:@"id"];
        password.enabled=NO;
        username.enabled=NO;
        
        username.text = [facebookDic objectForKey:@"id"];
        username.secureTextEntry=YES;
        email.text=[facebookDic objectForKey:@"email"];
        email.enabled=NO;
        
    }

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action method list..
-(IBAction)clickOnBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:true completion:nil];
}
-(IBAction)clicOnRegisterButton:(id)sender
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Register..." ]];
    if (firstName.text==nil || [firstName.text length]<=0)
    {
        [firstName becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter first name." ] :1.000];
    }
    else if (surName.text==nil || [surName.text length]<=0)
    {
        [surName becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter sur name." ] :1.000];
    }
    else if (email.text==nil || [email.text length]<=0)
    {
        [email becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter email address." ] :1.000];
    }
    else if (dOB.text==nil || [dOB.text length]<=0)
    {
        [dOB becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter date of birth." ] :1.000];
    }
    else if (city.text==nil || [city.text length]<=0)
    {
        [city becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter city."] :1.000];
    }
    else if (state.text==nil || [state.text length]<=0)
    {
        [state becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter state." ] :1.000];
    }
    else if (country.text==nil || [country.text length]<=0)
    {
        [country becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter country." ] :1.000];
    }
    else if (mobilenumber.text==nil || [mobilenumber.text length]<=0)
    {
        [mobilenumber becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter mobile number."] :1.000];
    }
    else if (password.text==nil || [password.text length]<=0)
    {
        [password becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter password."] :1.000];
    }
    else
    {
        if ([MyCustomeClass validateEmail:email.text])
        {
            if ([MyCustomeClass checkInternetConnection])
            {
                //[self registrationRequest];
                [self checkUserNameRequest];
            }
            else
            {
                [MyCustomeClass SVProgressMessageDismissWithError:@"internet not connected with device." :1.000];
            }
        }
        else
        {
            [email becomeFirstResponder];
            [MyCustomeClass SVProgressMessageDismissWithError:@"Please valid email address." :1.000];
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
    [username resignFirstResponder];
    
    
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
    username.text=nil;
    
    
}
#pragma mark - Webservics Response classes
-(void)registrationRequest
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Registering..."];
    
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postData=[NSString stringWithFormat:@"firstname=%@&lastname=%@&email=%@&pass=%@&address=%@&city=%@&state=%@&zipcode=%@&country=%@&mobile=%@&dob=%@&username=%@&phone=%@",firstName.text,surName.text,email.text,password.text,address.text,city.text,state.text,postcode.text,country.text,mobilenumber.text,dOB.text,username.text,phonenumber.text];
    
    NSLog(@"%@",postData);
    [helper registrationApi:postData];
}
-(void)registrationApi:(NSString *)response
{
    NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSLog(@"%@",dataDic);
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"FAIL"])
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Some connection issue." :1.00];
        
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setValue:craditNumber.text forKeyPath:@"CraditCardNumber"];
        [[NSUserDefaults standardUserDefaults] setValue:cardExDate.text forKeyPath:@"ExpDate"];
        [[NSUserDefaults standardUserDefaults] setValue:ccv2Number.text forKeyPath:@"CCV2"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Successfully done." :1.00];
        [self clearAllField];
        [self.navigationController popViewControllerAnimated:true];
        [self dismissViewControllerAnimated:true completion:nil];
        
    }
}

-(void)gettingFail:(NSString*)error
{
    NSLog(@"%@",error);
    [MyCustomeClass SVProgressMessageDismissWithSuccess:error :1.00];
    
    
}



-(void) moveViewUp:(BOOL)up
{
    CGFloat distance;
    
    if (IS_IPHONE5)
    {
        distance = (currentTextField == state)? 44: 44;
    }
    else
    {
        distance = (currentTextField == state || currentTextField == password)? 150: 0;
    }
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= distance * (up? 1: -1);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.25];
    self.view.frame = viewFrame;
    
    [UIView commitAnimations];
    
}



- (void)viewDidAppear:(BOOL)animated
{
    /* [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(keyboardWillShow:)
     name:UIKeyboardWillShowNotification
     object:nil];
     
     [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(keyboardWillHide:)
     name:UIKeyboardWillHideNotification
     object:nil];*/
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:NO];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.view resignFirstResponder];
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
-(void)checkUserNameRequest
{
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postData=[NSString stringWithFormat:@"username=%@",username.text];
    NSLog(@"%@",postData);
    [helper checkUserName:postData];
}
-(void)checkUserName:(NSString *)response
{
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSLog(@"%@",dataDic);
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"FAIL"])
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Username already exist please change it." :2.0];
    }
    else
    {
        [self registrationRequest];
        
    }
    
}





@end
