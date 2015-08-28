//
//  IndexPageViewController.h
//  Cibo
//
//  Created by mithun ravi on 16/04/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexPageCell.h"
#import "AppDelegate.h"
#import "SettingsViewController.h"
#import "InfoViewController.h"
#import "ShareViewController.h"
#import "ViewController.h"
#import "CardViewController.h"
#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <GPUImage/GPUImage.h>
#import "MuiltpleViewController.h"
#import "UIImageView+WebCache.h"

@class AppDelegate;
@interface IndexPageViewController : UIViewController<UINavigationControllerDelegate,WebServiceHelperDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    AppDelegate *appDelegate;
    BOOL infoValue;
    NSUserDefaults *indexDefault;
    MPMoviePlayerController *moviePlayer;
    GPUImageView *_backgroundImageView;
    GPUImageMovie *_recordedVideo;
    GPUImageBuffer *_videoBuffer;
    GPUImageiOSBlurFilter *_blurFilter;
    IBOutlet UILabel *eventLabel;
    IBOutlet UILabel *digitalMenuLabel;
    IBOutlet UILabel *ImageLabel;
    IBOutlet UILabel *onlineLabel;
    IBOutlet UILabel *offerLabel;
    IBOutlet UILabel *ourLabel;
    IBOutlet UILabel *bookTableLabel;
    IBOutlet UILabel *myOrderLabel;
    IBOutlet UILabel *restuantNameLabel;

    IBOutlet UIImageView *galleryImageView;
    IBOutlet UIButton *catButton;
    int allBeaconInfoCount;
    int nextImageInteger;
    NSString *categoryID;
    UIView *timeBackgroundView;
}

@property (nonatomic, strong) IBOutlet UITableView *indexTebleView;
@property (nonatomic, strong) NSMutableArray *textArray,*iconArray;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIButton *logoutButton;
@property (nonatomic, strong) IBOutlet UIButton *eventButton,*foodButton,*munchPointsButton,*MunchPointButton,*galleryButton,*ourVenuButton,*settingbutton,*sharebutton,*infoButton;
@property (nonatomic, strong) IBOutlet UIImageView *myMunchPoints,*middlemunchPoint,*leftLowerCorner,*lowerTab;
@property (nonatomic, strong) IBOutlet UIImageView *backgroundImage,*menuImage;
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSMutableArray *beaconCompainingArray;
@property (nonatomic, strong) NSMutableArray *gallaryArray;
@property (nonatomic, strong) NSMutableArray *categoryArray;

@property (nonatomic, assign) int isTableBooking;

@end
