//
//  ShareViewController.h
//  Cibo
//
//  Created by mithun ravi on 25/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomeClass.h"
#import <Social/Social.h>
#import <AddressBook/AddressBook.h>
#import <AdSupport/AdSupport.h>
///////////// weibo connection  /////
#import "WBConnect.h"

#define SinaWeiBoSDKDemo_APPKey @"3685260036"
#define SinaWeiBoSDKDemo_APPSecret @"dae86fe00e6929e5991bb467199ea2c4"

@interface ShareViewController : UIViewController<WBSessionDelegate,WBSendViewDelegate,WBRequestDelegate>
{
    WeiBo* weibo;

}

@property (nonatomic, strong) IBOutlet UIView *weiboView;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton,*postButton;
@property (nonatomic, strong) IBOutlet UIImageView *selectedImageView;
@property (nonatomic, strong) IBOutlet UITextView *messageTextView;

@property (nonatomic, strong) IBOutlet UIButton *backButton,*facebookButton,*weiboButton,*shareImage;
@property (nonatomic, strong) IBOutlet UILabel *titelLable,*subTitle;
@property (nonatomic,strong,readonly) WeiBo* weibo;



@end
