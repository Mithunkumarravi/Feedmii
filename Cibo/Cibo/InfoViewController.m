//
//  InfoViewController.m
//  Cibo
//
//  Created by mithun ravi on 25/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "InfoViewController.h"
#import "MyCustomeClass.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize infoTextView;
@synthesize backButton;
@synthesize titelLable;

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
    infoDefault=[NSUserDefaults standardUserDefaults];
    if (IS_IPHONE5)
    {
        infoTextView.frame=CGRectMake(0, 44, 320, 504);
    }
    else
    {
        //infoTextView=infoTextView480;
    }
    [self getRestaurantInformation];
    
    titelLable.font=[UIFont fontWithName:FONT_Ragular size:20.0];
    [titelLable setFont: [titelLable.font fontWithSize: 20.0]];


    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    titelLable.text=[MyCustomeClass languageSelectedStringForKey:@"Information"];
    [backButton setTitle:[MyCustomeClass languageSelectedStringForKey:@"Back"] forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action method list..
-(IBAction)clickOnBackButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)getRestaurantInformation
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Login..."]] ;
    
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postData=[infoDefault objectForKey:@"Restaurantid"];
    NSLog(@"%@",postData);
    [helper restaurantInformation:postData];
}

#pragma mark - Webservics Response classes

-(void)restaurantInformation:(NSString*)response
{
    // NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
   // NSLog(@"%@",dataDic);
    
    if ([[dataDic objectForKey:@"mobile_app"] count]>0)
    {
        for (NSDictionary *array in [dataDic objectForKey:@"mobile_app"])
        {
            NSLog(@"arrayarray=\%@",[array objectForKey:@"page_description"]);
            
            
            infoTextView.text=[NSString stringWithFormat:@"\t\t\t\t%@\n\n%@\n\n\n\nRestaurant name: %@",[array objectForKey:@"page_title"],[array objectForKey:@"page_description"],[infoDefault objectForKey:@"Restaurantname"]];
        }
        
    
       [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Successfully done." :1.0];
    }
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Information is not available in database." :1.0];
    }
    
    
}

-(void)gettingFail:(NSString*)error
{
    NSLog(@"%@",error);
    [MyCustomeClass SVProgressMessageDismissWithSuccess:error :1.00];
    
    
}


@end
