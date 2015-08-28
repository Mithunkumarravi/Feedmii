//
//  ScanViewController.h
//  Cibo
//
//  Created by mithun ravi on 03/05/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MyCustomeClass.h"
#import "WebServiceHelper.h"
#import <AVFoundation/AVFoundation.h>




@interface ScanViewController : UIViewController<UIImagePickerControllerDelegate,WebServiceHelperDelegate,AVCaptureMetadataOutputObjectsDelegate>
{
    AppDelegate *appDelegate;
    NSUserDefaults *loyaltyDefault;
    
}
@property(nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic,strong) AppDelegate *appDelegate;
@property (nonatomic, strong) UIImagePickerController *controllerPicker;
@property (nonatomic, strong) IBOutlet UITextField *enterCodeText;
@property (nonatomic, strong) NSString *scanCode;
@property (nonatomic, strong) IBOutlet UIButton *doneButton,*scanButton;
@property (nonatomic, strong) NSArray *scanDataArray;
@property (nonatomic, strong) IBOutlet UILabel  *partTimeLabel;

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UIView *viewPreview;



@end
