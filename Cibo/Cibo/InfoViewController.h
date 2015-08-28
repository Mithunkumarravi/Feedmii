//
//  InfoViewController.h
//  Cibo
//
//  Created by mithun ravi on 25/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "MyCustomeClass.h"
@interface InfoViewController : UIViewController<WebServiceHelperDelegate>
{
    NSUserDefaults *infoDefault;
}
@property (nonatomic, strong) IBOutlet UITextView *infoTextView;
@property (nonatomic, strong) IBOutlet UIButton *backButton;
@property (nonatomic, strong) IBOutlet UILabel *titelLable;

@end
