//
//  WebSiteViewController.h
//  Cibo
//
//  Created by mithun ravi on 21/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomeClass.h"

@class AppDelegate;
@interface WebSiteViewController : UIViewController
{
    NSUserDefaults *webDefault;
    AppDelegate *appDelegate;
}
@property (nonatomic,strong)IBOutlet UIWebView *webViewResturant;
@property (nonatomic, strong) NSString *webString;
@property (nonatomic, strong) IBOutlet UILabel *webSiteName;
@property (nonatomic, strong) IBOutlet UIButton *backbutton;


@end
