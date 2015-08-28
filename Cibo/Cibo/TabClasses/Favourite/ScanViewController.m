//
//  ScanViewController.m
//  Cibo
//
//  Created by mithun ravi on 03/05/13.
//  Copyright (c) 2013 mithun ravi. All rights reserved.
//

#import "ScanViewController.h"

@interface ScanViewController ()

@end
@implementation ScanViewController
@synthesize appDelegate;
@synthesize controllerPicker;
@synthesize enterCodeText;
@synthesize scanCode;
@synthesize imageView;
@synthesize doneButton,scanButton;
@synthesize scanDataArray;
@synthesize partTimeLabel;

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
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    loyaltyDefault=[NSUserDefaults standardUserDefaults];
    enterCodeText.text=scanCode;
    [appDelegate tabBarHide];
    [enterCodeText setEnabled:NO];
    _viewPreview.hidden=YES;
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
   // [doneButton setTitle:[MyCustomeClass languageSelectedStringForKey:@"DONE"] forState:UIControlStateNormal];
   // [scanButton setTitle:[MyCustomeClass languageSelectedStringForKey:@"SCAN QC CODE"] forState:UIControlStateNormal];
    [enterCodeText setPlaceholder:[MyCustomeClass languageSelectedStringForKey:@"ENTER CODE HERE"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)clickONEnterButton:(id)sender
{
    
}
-(IBAction)clickOnScanButton:(id)sender
{
    // This is the case where the app should read a QR code when the start button is tapped.
    [self startReading];

}
-(IBAction)clickOnCrossButton:(id)sender
{
    [appDelegate tabBarShow];

    [self dismissViewControllerAnimated:true completion:nil];
}
-(IBAction)clickOnDoneButton:(id)sender
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Send points..."];
    

    if ([enterCodeText.text length]<=0 || enterCodeText.text==nil)
    {
        [MyCustomeClass SVProgressMessageDismissWithError:@"Please scan QR code and get points" :2.0];
    }
    else
    {
        if ([MyCustomeClass checkInternetConnection])
        {
            //[self addUserPoints];
           // [self checkQRCodeScannerISExistRequest];
        }
        else
        {
            [MyCustomeClass SVProgressMessageDismissWithError:@"Device is not connected to internet" :2.0];
        }
    }
    
   }
-(IBAction)keyboardGone:(id)sender
{
    [enterCodeText resignFirstResponder];
}

#pragma mark - Webservics Request classes
-(void)checkQRCodeScannerISExistRequest
{
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postString=[NSString stringWithFormat:@"restaurant_id/%@/member_id/%@/order_id/%@",[loyaltyDefault objectForKey:@"Restaurantid"],[loyaltyDefault objectForKey:@"Member"],@"122323"];
    NSLog(@"%@",postString);
  
    [helper checkQRCodeScannerISExist:postString];
}
-(void)addUserPoints
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Add points..."];
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postString=[NSString stringWithFormat:@"munchPoints/qr_code_add/restaurant_id/%@/member_id/%@",[loyaltyDefault objectForKey:@"Restaurantid"],[loyaltyDefault objectForKey:@"Member"]];
    
    NSLog(@"%@",postString);
    if([[scanDataArray objectAtIndex:0] length]<=7)
    {
        [MyCustomeClass SVProgressMessageDismissWithError:@"Is not valid QR code." :1.0];
    }
    else
    {
        NSString *postData=[NSString stringWithFormat:@"points=%@&order_id=%@&date=%@&time=%@",[scanDataArray objectAtIndex:3],[scanDataArray objectAtIndex:1],[scanDataArray objectAtIndex:7],[scanDataArray objectAtIndex:9]];
     //   NSString *postData=[NSString stringWithFormat:@"points=123&order_id=122323&date=21-23-2013&time=21:23"];
        
        NSLog(@"%@",postData);
        [helper addMemberPoints:postData:postString];
    }
    
}
-(void)sendQRCode
{
    
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
     NSString *postString=[NSString stringWithFormat:@"munchPoints/addPoints/restId/%@/memberId/%@",[loyaltyDefault objectForKey:@"Restaurantid"],[loyaltyDefault objectForKey:@"Member"]];
     NSLog(@"%@",postString);
    
      NSString *postData=[NSString stringWithFormat:@"points=%@",[scanDataArray objectAtIndex:3]];
   // NSString *postData=[NSString stringWithFormat:@"points=123"];
    
      NSLog(@"%@",postData);
    [helper sendQRCode:postData:postString];
}
#pragma mark - Webservics Response classes
-(void)checkQRCodeScannerISExist:(NSString *)response
{
    NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCCESS"])
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"You already use this code for points." :2.0];
    }
    else
    {
        [self addUserPoints];
            
    }
}
-(void)sendQRCode:(NSString *)response
{
    NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCCESS"])
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"" :1.0];

        [self dismissViewControllerAnimated:true completion:nil];
         [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Successfully done." :1.0];
    }
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"" :1.0];
    }
    
}

#pragma mark - Private method implementation

- (BOOL)startReading
{
    NSError *error;
    _viewPreview.hidden=NO;

    
    // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
    // as the media type parameter.
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Get an instance of the AVCaptureDeviceInput class using the previous device object.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        // If any error occurs, simply log the description of it and don't continue any more.
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    // Initialize the captureSession object.
    _captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_captureSession addInput:input];
    
    
    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    // Create a new serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    
    [_captureSession startRunning];
    
    return YES;
}


-(void)stopReading
{
    _viewPreview.hidden=YES;

    // Stop video capture and make the capture session object nil.
    [_captureSession stopRunning];
    _captureSession = nil;
    
    // Remove the video preview layer from the viewPreview view's layer.
    [_videoPreviewLayer removeFromSuperlayer];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate method implementation

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if (metadataObjects != nil && [metadataObjects count] > 0)
    {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode])
        {
            // If the found metadata is equal to the QR code metadata then update the status label's text,
            // stop reading and change the bar button item's title and the flag's value.
            // Everything is done on the main thread.
            //[_lblStatus performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
            NSLog(@"%@",[metadataObj stringValue]);
            
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            
            scanDataArray =[MyCustomeClass seprateStringFromStringUsingArrray:[NSString stringWithFormat:@"%@",[metadataObj stringValue]] : @"="];
            
            NSLog(@"%@",scanDataArray);
            if ([scanDataArray count]>2)
            {
                //scanDataArray =[MyCustomeClass seprateStringFromStringUsingArrray:[NSString stringWithFormat:@"%@",symbol.data] : @":"];
                enterCodeText.text=[NSString stringWithFormat:@"%@=%@",[scanDataArray objectAtIndex:2],[scanDataArray objectAtIndex:3]];
            }
            else
            {
                [MyCustomeClass alertMessage:@"Is not a valid QR code" :@"Please try valid QR code" :@"OK"];
            }

            
        }
    }
    
    
}
-(void)addMemberPoints:(NSString *)response
{
    NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCCESS"])
    {
         [self dismissViewControllerAnimated:true completion:nil];
       
        //[self sendQRCode];
    }
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"You already use this code for points." :2.0];
    }
    
}

-(void)gettingFail:(NSString*)error
{
    NSLog(@"%@",error);
    [MyCustomeClass SVProgressMessageDismissWithError:error :2.00];
}

@end
