//
//  ShareViewController.m
//  Cibo
//
//  Created by mithun ravi on 25/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController
@synthesize backButton;
@synthesize titelLable,subTitle;
@synthesize facebookButton,weiboButton;
@synthesize shareImage;
@synthesize weibo;

@synthesize weiboView,cancelButton,postButton,messageTextView,selectedImageView;

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
    subTitle.font=[UIFont fontWithName:FONT_Ragular size:12.0];
    [subTitle setFont: [subTitle.font fontWithSize: 12.0]];

    titelLable.font=[UIFont fontWithName:FONT_Ragular size:20.0];
    [titelLable setFont: [titelLable.font fontWithSize: 20.0]];


    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    titelLable.text=[MyCustomeClass languageSelectedStringForKey:@"Demoshop"];
    [backButton setTitle:[MyCustomeClass languageSelectedStringForKey:@"Back"] forState:UIControlStateNormal];
    subTitle.text= [MyCustomeClass languageSelectedStringForKey:@"Share"];
    weiboView.backgroundColor=[UIColor clearColor];
    messageTextView.backgroundColor=[UIColor clearColor];
    weiboView.hidden=YES;
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

-(IBAction)clickOnFacebookShare:(id)sender
{
    
          
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"Pleae write your message"];
        [controller addURL:[NSURL URLWithString:@"http://www.cibo.com"]];
        [controller addImage:[UIImage imageNamed:@"icon114.png"]];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
        }
        else
        {
            [MyCustomeClass alertMessage:@"Please go in device setting and add your" :@"facebook account after that you can share" :@"OK"];
        }
     

}


-(IBAction)clickOnPostButtonOnWeibo:(id)sender
{
    
}
-(IBAction)clickOnCancelButton:(id)sender
{
    weiboView.hidden=YES;

}
-(IBAction)clickOnWiboButton:(id)sender
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo])
    {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result)
        {
            if (result == SLComposeViewControllerResultCancelled)
            {
                NSLog(@"Cancelled");
            }
            else
            {
                NSLog(@"Done");
            }
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler =myBlock;
        [controller setInitialText:@"Pleae write your message"];
        [controller addURL:[NSURL URLWithString:@"http://www.cibo.com"]];
        [controller addImage:[UIImage imageNamed:@"icon114.png"]];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
    else
    {
        [MyCustomeClass alertMessage:@"Please go in device setting and add your" :@"facebook account after that you can share" :@"OK"];
    }
    /*if( weibo )
	{
		weibo = nil;
	}
	weibo = [[WeiBo alloc]initWithAppKey:SinaWeiBoSDKDemo_APPKey
						   withAppSecret:SinaWeiBoSDKDemo_APPSecret];
	weibo.delegate = self;
	[weibo startAuthorize];*/
}

#pragma mark - Weibo integration method list

- (void)weiboDidLogin
{
    weiboView.hidden=NO;

	//buttonLogout.hidden = FALSE;
	//buttonSend.hidden = FALSE;
	//buttonGetFeed.hidden = FALSE;
	
	UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"用户验证已成功！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
}

- (void)weiboLoginFailed:(BOOL)userCancelled withError:(NSError*)error
{
	UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"用户验证失败！"
													   message:userCancelled?@"用户取消操作":[error description]
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
}

- (void)weiboDidLogout
{
	//buttonLogout.hidden = TRUE;
	//buttonSend.hidden = TRUE;
	//buttonGetFeed.hidden = TRUE;
	
	UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"用户已成功退出！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
}

- (void)request:(WBRequest *)request didFailWithError:(NSError *)error
{
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"新浪微博" message:[NSString stringWithFormat:@"发送失败：%@",[error description] ] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
	[alert show];
}

- (void)request:(WBRequest *)request didLoad:(id)result
{
    
    
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"新浪微博" message:[NSString stringWithFormat:@"发送成功！" ] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
	NSString *urlString = request.url;
	if ([urlString rangeOfString:@"statuses/public_timeline"].location !=  NSNotFound)
	{
		alert.message = @"获取成功";
		NSLog(@"%@",result);
	}
	[alert show];
	[weibo dismissSendView];
}
#pragma mark WBSendView CALLBACK_API
- (void)sendViewWillAppear:(WBSendView*)sendView
{
	NSLog(@"sendview will appear.");
}

- (void)sendViewDidLoad:(WBSendView*)sendView
{
	NSLog(@"sendview did load.");
}

- (void)sendViewWillDisappear:(WBSendView*)sendView
{
	NSLog(@"sendview will disappear.");
}

- (void)sendViewDidDismiss:(WBSendView*)sendView
{
	NSLog(@"sendview did dismiss.");
}



@end
