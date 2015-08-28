//
//  ViewController.m
//  Cibo
//
//  Created by mithun ravi on 15/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "ViewController.h"
#import "IndexPageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize userNameText,passwordText;
@synthesize loginButton;
///facebook integration ////
//@synthesize profilePic ;
//@synthesize loggedInUser;
@synthesize usernamelabel,passwordLable;
@synthesize btnFacebook;


- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    //userNameText.text=@"mithunfeedmii";//@"farry007";//
    //passwordText.text=@"1234";//@"farry0301";//
    loginDefault=[NSUserDefaults standardUserDefaults];
	// Do any additional setup after loading the view, typically from a nib.
    //facebook integration ///////
    //usernamelabel.text=NSLocalizedString(@"USERNAME", nil);
    usernamelabel.text=[MyCustomeClass languageSelectedStringForKey:@"USERNAME"];
    passwordLable.text=[MyCustomeClass languageSelectedStringForKey:@"PASSWORD" ];

    
    [userNameText setValue:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
     [passwordText setValue:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    
    lblAnAccount.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [lblAnAccount setFont: [lblAnAccount.font fontWithSize: 14.0]];

    lblCreate.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [lblCreate setFont: [lblCreate.font fontWithSize: 14.0]];

    lblForgot.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [lblForgot setFont: [lblForgot.font fontWithSize: 14.0]];

    lblPasswor.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [lblPasswor setFont: [lblPasswor.font fontWithSize: 14.0]];

    lblSignin.font=[UIFont fontWithName:FONT_Ragular size:20.0];
    [lblSignin setFont: [lblSignin.font fontWithSize: 20.0]];
    
    [loginButton.titleLabel setFont:[UIFont fontWithName:FONT_Ragular size:20.0]];

}

-(IBAction)clicKonCrossButton:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
    
    /*if ([appDelegate.moveTabWithoutLogin isEqualToString:@"Menu"])
    {
        appDelegate.tabSelectedIndex=0;
        [appDelegate customTabbarController];
    }
    else
    {
       appDelegate.tabSelectedIndex=2;
      [appDelegate customTabbarController];
    }*/
    UIApplication *application=nil;
    NSDictionary *dic=nil;
    [loginDefault setValue:@"Home" forKey:@"RootView"];
    [loginDefault setValue:@"Home" forKey:@"Logout"];
    [appDelegate application:application didFinishLaunchingWithOptions:dic];
    
}
-(IBAction)keyboardDismiss:(id)sender
{
    [userNameText resignFirstResponder];
    [passwordText resignFirstResponder];
}

-(IBAction)clickonloginbutton:(id)sender
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Login..."]];
    if (userNameText.text==nil || [userNameText.text length]<=0)
    {
        [userNameText becomeFirstResponder];
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter username." ]:1.000];
    }
    else if (passwordText.text==nil || [passwordText.text length]<=0)

    {
        [passwordText becomeFirstResponder];

        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"Please enter password." ]:1.00];

    }
    else
    {
//        if ([MyCustomeClass validateEmail:userNameText.text])
//        {
            if ([MyCustomeClass checkInternetConnection])
            {
                WebServiceHelper *helper=[[WebServiceHelper alloc] init];
                [helper setDelegate:self];
                NSString *postData=[NSString stringWithFormat:@"username=%@&pass=%@",userNameText.text,passwordText.text];
                NSLog(@"%@",postData);
                [helper login1:postData];
            }
            else
            {
                 [MyCustomeClass SVProgressMessageDismissWithError:@"Internet connection is not available." :2.00];
            }
//        }
//        else
//        {
//            [MyCustomeClass SVProgressMessageDismissWithError:@"email is not validate" :1.00];
//        }
      
    }
}

-(IBAction)clickOnRegisterButton:(id)sender
{
    RegisterViewController *registerVC=[[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
   // [self.navigationController pushViewController:registerVC animated:true];
    [self presentViewController:registerVC animated:true completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginSuccess:(NSString*)response
{
    // NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSLog(@"%@",dataDic);
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCCESS"])
    {
        NSMutableArray *loginDataDic=[[NSMutableArray alloc] init];
        loginDataDic=[dataDic objectForKey:@"member_data"];
        NSLog(@"%@",loginDataDic);
        
        [loginDefault setValue:[[loginDataDic  objectAtIndex:0] objectForKey:@"member_id"] forKey:@"Member"];
        //[loginDefault setValue:[[loginDataDic  objectAtIndex:0] objectForKey:@"restaurant_id"] forKey:@"Restaurantid"];
        
        [loginDefault setValue:[[loginDataDic  objectAtIndex:0] objectForKey:@"username"] forKey:@"Username"];
        appDelegate.userInfoDictionary=[[loginDataDic objectAtIndex:0] copy];
        [loginDefault setValue:[[loginDataDic  objectAtIndex:0] objectForKey:@"email"] forKey:@"Email"];
        //[loginDefault setValue:[[loginDataDic  objectAtIndex:0] objectForKey:@"phone"] forKey:@"Phone"];
        
        //[loginDefault setValue:[[loginDataDic  objectAtIndex:0] objectForKey:@"address"] forKey:@"address"];
        //[loginDefault setValue:[[loginDataDic  objectAtIndex:0] objectForKey:@"city"] forKey:@"city"];
        //[loginDefault setValue:[[loginDataDic  objectAtIndex:0] objectForKey:@"country"] forKey:@"country"];
        //[loginDefault setValue:[[loginDataDic  objectAtIndex:0] objectForKey:@"firstname"] forKey:@"firstname"];
        //[loginDefault setValue:[[loginDataDic  objectAtIndex:0] objectForKey:@"lastname"] forKey:@"lastname"];
        [loginDefault setValue:[[loginDataDic  objectAtIndex:0] objectForKey:@"mobile"] forKey:@"mobile"];
        [loginDefault setValue:[[loginDataDic  objectAtIndex:0] objectForKey:@"countrycode"] forKey:@"countrycode"];
        //[loginDefault setValue:[[loginDataDic  objectAtIndex:0] objectForKey:@"zipcode"] forKey:@"zipcode"];
        //[loginDefault setValue:[[loginDataDic  objectAtIndex:0] objectForKey:@"discount"] forKey:@"CustomerDiscount"];
        //[loginDefault setValue:[[loginDataDic  objectAtIndex:0] objectForKey:@"points"] forKey:@"points"];
        //[loginDefault setValue:[[loginDataDic  objectAtIndex:0] objectForKey:@"state"] forKey:@"state"];
        
        [self dismissViewControllerAnimated:true completion:nil];
        
        [MyCustomeClass SVProgressMessageDismissWithSuccess:[MyCustomeClass languageSelectedStringForKey:@"Successfully Login." ]:1.00];
        //[loginDefault setValue:@"Boldo" forKey:@"Restaurantname"];
        [loginDefault synchronize];
        [self deviceIDUpdateRequest];
        /*}
         else
         {
         [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"You are not a member of this restaurant. please register. " ]:2.00];
         RegisterViewController *registerVC=[[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
         [self presentViewController:registerVC animated:true completion:nil];
         
         }*/
    }
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithError:[MyCustomeClass languageSelectedStringForKey:@"username/password is not correct" ]:1.50];
    }
    
}

-(void)deviceIDUpdateRequest
{
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    helper.delegate=self;
    [helper deviceIDUpdate:[NSString stringWithFormat:@"restId/%@/device_id/%@/memberId/%@/badge/%d",ciboRestaurantId,[loginDefault valueForKey:@"DeviceToken"],[loginDefault valueForKey:@"Member"],0]];
    
}
-(void)deviceIDUpdate:(NSString *)response
{
    NSLog(@"%@",response);
}

-(void)gettingFail:(NSString*)error
{
    NSLog(@"%@",error);
    [MyCustomeClass SVProgressMessageDismissWithSuccess:error :1.00];
}

-(IBAction)clickonCrossButton:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}


-(void)updateDeviceRequest
{
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    helper.delegate=self;
    [helper updateDeviceToken:[NSString stringWithFormat:@"device_id/%@",[loginDefault valueForKey:@"DeviceToken"]]];
}

-(void)updateDeviceToken:(NSString *)response
{
    NSLog(@"%@",response);
}

-(IBAction)enterPasswordAlert:(id)sender
{
    UIAlertView *passwordAlertView = [[UIAlertView alloc] initWithTitle:@"Forgot Password" message:@"Enter username" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send", nil];
    [passwordAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [passwordAlertView show];
    
}

#pragma mark - Alert View delegate method
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Send"])
    {
        UITextField *username = [alertView textFieldAtIndex:0];
        [self forgotPasswordRequest:username.text];
    }
}


-(void)forgotPasswordRequest:(NSString *)username
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Sending..."];
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    helper.delegate=self;
    [helper forgotPassword:username];
}
-(void)forgotPassword:(NSString *)response
{
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCCESS"])
    {
        [MyCustomeClass SVProgressMessageDismissWithError:@"Please please check your email id." :2.0];
        
    }
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithError:@"Please enter valid username." :2.0];
    }
    NSLog(@"%@",dataDic);
}

//////////////Facebook Login

-(IBAction)clickOnfacebookButton:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setValue:@"Yes" forKey:@"isFacebookLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     {
         if (error)
         {
             // Process error
         }
         else if (result.isCancelled)
         {
             // Handle cancellations
         }
         else
         {
             // If you ask for multiple permissions at once, you
             // should check if specific permissions missing
             if ([result.grantedPermissions containsObject:@"email"])
             {
                 [self userInfoFromFacebook];
             }
         }
     }];
}

-(void)userInfoFromFacebook
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Login...."];
    if ([FBSDKAccessToken currentAccessToken])
    {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 NSLog(@"fetched user:%@", result);
                 facebookInfoDic = result;
                 [self loginWithFacebook];
                 
             }
         }];
    }
}

-(void)loginWithFacebook
{
    if (facebookInfoDic.count>0)
    {
        //NSString *email = [facebookInfoDic objectForKey:@"email"];
        NSString *username = [facebookInfoDic objectForKey:@"id"];
        NSString *passowrd = [facebookInfoDic objectForKey:@"id"];
        
        WebServiceHelper *helper=[[WebServiceHelper alloc] init];
        [helper setDelegate:self];
        NSString *postData=[NSString stringWithFormat:@"username=%@&pass=%@",username,passowrd];
        NSLog(@"%@",postData);
        [helper login1:postData];
    }
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithError:@"Your Facbook data is protected. please try normal register." :3.0];
    }
    
}

-(void)registerWithFacebook
{
    
}




@end
