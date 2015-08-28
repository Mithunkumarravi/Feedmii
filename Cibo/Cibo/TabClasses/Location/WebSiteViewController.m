//
//  WebSiteViewController.m
//  Cibo
//
//  Created by mithun ravi on 21/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "WebSiteViewController.h"

@interface WebSiteViewController ()

@end

@implementation WebSiteViewController
@synthesize webString;
@synthesize webViewResturant;
@synthesize webSiteName;
@synthesize backbutton;

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
    webSiteName.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [webSiteName setFont: [webSiteName.font fontWithSize: 12.0]];


    webDefault=[NSUserDefaults standardUserDefaults];
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];

    if (IS_IPHONE5)
    {
        webViewResturant.frame=CGRectMake(0, 88, 320, 460-49);
    }
    else
    {
        webViewResturant.frame=CGRectMake(0, 88, 320, 372-49);

    }
    webSiteName.text=webString;
    NSRange range = [webString rangeOfString:@"http://"];
    if (range.location == NSNotFound)
        webString =[NSString stringWithFormat:@"http://%@",webString];

    [webViewResturant loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webString]]];
    webSiteName.text=webString;
    webViewResturant.exclusiveTouch=YES;
    webViewResturant.multipleTouchEnabled = YES;

    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [backbutton setTitle:[MyCustomeClass languageSelectedStringForKey:@"Back"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Button action methods
-(IBAction)clickONBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:true];
    [self dismissViewControllerAnimated:true completion:nil];
}
-(IBAction)clickOnHomeButton:(id)sender
{
    [webDefault setValue:@"Home" forKey:@"RootView"];
    [webDefault setValue:@"Home" forKey:@"Logout"];
    UIApplication *application = nil;
    NSDictionary *dictionary = nil;
    [appDelegate application:application didFinishLaunchingWithOptions:dictionary];
}

#pragma mark WebView Delegate method

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Loading...."];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Loading done." :1.00];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MyCustomeClass SVProgressMessageDismissWithError:@"Not Loaded" :1.00];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}


@end
