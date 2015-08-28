//
//  AddCardViewController.m
//  Boldo
//
//  Created by mithun ravi on 03/07/14.
//  Copyright (c) 2014 mithun ravi. All rights reserved.
//

#import "AddCardViewController.h"

@interface AddCardViewController ()

@end

@implementation AddCardViewController
@synthesize editString;

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
    lblTitle.font=[UIFont fontWithName:FONT_Ragular size:20.0];
    [lblTitle setFont: [lblTitle.font fontWithSize: 20.0]];

    [name becomeFirstResponder];
    if ([editString isEqualToString:@"Edit"])
    {
        cardNumber.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"CraditCardNumber"];
        expDate.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"ExpDate"];
        cvvNumber.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"CCV2"];
        name.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"CardHolderName"];

    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)clickOnCrossButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:true];
    [self dismissViewControllerAnimated:true completion:nil];
    
}
-(IBAction)clickOnProceedButton:(id)sender
{
    if (name.text.length<=0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"Please enter card holder name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil] show];
    }
    else if((cardNumber.text.length < 14) || (cardNumber.text.length > 19))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"Card Number must be between 14 to 19 numeric digits only." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if (cardNumber.text.length<=0)
    {
         [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"Please enter cardNumber" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil] show];
    }
    else if(expDate.text.length<=0)
    {
         [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"Please enter expire date" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil] show];
    }
    else if (cvvNumber.text.length<=0)
    {
         [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"Please enter CVV Number" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil] show];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setValue:cardNumber.text forKey:@"CraditCardNumber"];
        [[NSUserDefaults standardUserDefaults] setValue:expDate.text forKey:@"ExpDate"];
        [[NSUserDefaults standardUserDefaults] setValue:cvvNumber.text forKey:@"CCV2"];
        [[NSUserDefaults standardUserDefaults] setValue:name.text forKey:@"CardHolderName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.navigationController popViewControllerAnimated:true];
        [self dismissViewControllerAnimated:true completion:nil];

    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length==0)
        return YES;
    
    
    if (cardNumber==textField)
    {
        if ([string isEqualToString:@"0"])
        {
            return YES;
        }
        if ([string intValue])
        {
            
            return YES;
        }
        
       
        
        return NO;
        
    }
    if (expDate==textField)
    {
        if (textField.text.length<5)
        {
            
            if (textField.text.length==2)
            {
                if ([string isEqualToString:@"/"])
                {
                    return YES;
                }
                return NO;
            }
            if ([string isEqualToString:@"0"])
            {
                return YES;
            }
           
            if ([string intValue])
            {
                return YES;
            }
        }
       
        return NO;
    }
    if (cvvNumber==textField)
    {
        if (textField.text.length<3)
        {
            if ([string isEqualToString:@"0"])
            {
                return YES;
            }
            if ([string intValue])
            {
                return YES;
            }
            
        }
        return NO;
    }
    return YES;
}


///////////////////////////////////////// for heartland
/*
 //Method to do iput validation, prefer to use it befor sending the message to the Gateway.
 -(BOOL) validateInput
 {
 
 //Get the current month and year to validate expiration date of the card.
 NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
 NSInteger currentMonth = [components month];
 NSInteger currentYear = [components year];
 
 //Check all fields are filled out atleast to their min length.
 if((cardNumber.length < 1)||(exp_Date.length < 1)||(exp_Date.length < 1))
 {
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"All Fields must be filled." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
 [alert show];
 return FALSE;
 }
 //Validate Card Number Length
 if((cardNumber.length < 14) || (cardNumber.length > 19))
 {
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"Card Number must be between 14 to 19 numeric digits only." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
 [alert show];
 return FALSE;
 }
 //Converting Exp Month into integer form in order to compare for validation.
 NSNumberFormatter * mf = [[NSNumberFormatter alloc] init];
 [mf setNumberStyle:NSNumberFormatterDecimalStyle];
 NSNumber * myMonthNumber = [mf numberFromString:exp_Date];
 
 //Converting Exp. Year into integer form in order to compare for validation.
 NSNumberFormatter * yf = [[NSNumberFormatter alloc] init];
 [yf setNumberStyle:NSNumberFormatterDecimalStyle];
 NSNumber * myYearNumber = [yf numberFromString:exp_Date];
 
 //Checking the month field contains valid data or not.
 if(([myMonthNumber integerValue] < 1) || ([myMonthNumber integerValue] > 12)){
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"Exp. Month field must be in range of (01-12)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
 [alert show];
 return FALSE;
 }
 //Checking the Card date is expired or not
 int fourDigitExpYear = [myYearNumber integerValue] +2014;
 NSLog(@"Entered Year: %d", fourDigitExpYear);
 if((([myMonthNumber integerValue] < currentMonth) && (fourDigitExpYear == currentYear)) || (fourDigitExpYear < currentYear)){
 
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Validation Error" message:@"Invalid Expiration Date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
 [alert show];
 return FALSE;
 }
 
 return TRUE;    //Return TRUE if all the inputs are good to go to the Gateway.
 
 }*/



@end
