//
//  MyCustomeClass.m
//  VidAdmin
//
//  Created by Subhash  dhondiyal on 11/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyCustomeClass.h"

@implementation MyCustomeClass

NSString *RESTAURANTID = nil;
NSString *ciboRestaurantId = nil;
NSString *ciboRestaurantName =nil;
int isTableBooking=0;

//////////////////////////////////////////////////////////////////
/////////////////////1.Email Validation///////////////////////////
//////////////////////////////////////////////////////////////////
+(BOOL)emailValidation:(UITextField *)emailTextfield
{
    BOOL emailTextedBool;
    {
        //validEmail = FALSE;
        
        NSString *strEmailValidation = emailTextfield.text;
        char *str_Email_Validation_chr = (char *)[strEmailValidation UTF8String];
        
        for (int i=0; i<strlen(str_Email_Validation_chr);i++)
        {
            if(str_Email_Validation_chr[i] == '@')
            {
                for(int j=i+1;j<strlen(str_Email_Validation_chr);j++)
                {
                    if(str_Email_Validation_chr[j] != '.')
                    {
                        if(str_Email_Validation_chr[j+1] == '.')
                        {    
                            for(int k=j+1;k<strlen(str_Email_Validation_chr);k++)
                            {  
                                emailTextedBool  =  TRUE;
                                
                            }
                        }
                    }
                }    
            }
        }
        
    }
    return emailTextedBool;
}

//////////////////////////////////////////////////////////////////
/////////////////////2.My Alert Message Popup/////////////////////
//////////////////////////////////////////////////////////////////
+(void)alertMessage:(NSString * )title :(NSString *) message :(NSString *)cencelButtontitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cencelButtontitle otherButtonTitles:nil];
    [alert show];
    
}

//////////////////////////////////////////////////////////////////
/////////////////////3.My Custome TextField  /////////////////////
//////////////////////////////////////////////////////////////////
+(UITextField *)addCustomeTextField :(UIView *)myCustomeView :(NSString *)customePlaceholder
{
    CGFloat width = 294.;
    CGFloat y = 0.0;
	CGFloat x = round((myCustomeView.frame.size.width - width) / 2.);
	UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, width, 30.)];
	textField.placeholder =customePlaceholder;
	textField.font = [UIFont systemFontOfSize:14.];
	textField.borderStyle = UITextBorderStyleRoundedRect;
	textField.delegate = nil;
	textField.keyboardType = UIKeyboardTypeDefault;
	textField.autocorrectionType = UITextAutocorrectionTypeNo;
	textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	[myCustomeView addSubview:textField];
	
	y += 30. +3;
	
	return textField;
}

//////////////////////////////////////////////////////////////////
///////4.Picker with Done and Cancel button with ActionSheet  ////
//////////////////use of this method to copy in your class   /////
//////////////////////////////////////////////////////////////////
+(UIActionSheet *)addDataPickerWithDoneAndCancelButton :(UIPickerView *)myPickerView :(UISegmentedControl *) cancelButton :(UISegmentedControl *)doneButton
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil 
                                              delegate:nil
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    
    
    myPickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    myPickerView.showsSelectionIndicator = YES;
    //myPickerView.dataSource = self;
    //myPickerView.delegate = self;
    
    [actionSheet addSubview:myPickerView];
    
    
    cancelButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Cancel"]];
    cancelButton.momentary = YES; 
    cancelButton.frame = CGRectMake(10, 7.0f, 50.0f, 30.0f);
    cancelButton.segmentedControlStyle = UISegmentedControlStyleBar;
    cancelButton.tintColor = [UIColor grayColor];
    [cancelButton addTarget:self action:@selector(clickOnCancelButtonOnActionSheet:) forControlEvents:UIControlEventValueChanged];
    //////////////////////////////////////////////
    doneButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
    doneButton.momentary = YES; 
    doneButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    doneButton.segmentedControlStyle = UISegmentedControlStyleBar;
    doneButton.tintColor = [UIColor grayColor];
    [doneButton addTarget:self action:@selector(clickOnDoneButtonOnActionSheet:) forControlEvents:UIControlEventValueChanged];
    
    [actionSheet addSubview:cancelButton];
    [actionSheet addSubview:doneButton];
    
    
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
    return actionSheet;
}

//////////////////////////////////////////////////////////////////
///////5.Save Data in Dictionary after getting JSON response /////
//////////////////////////////////////////////////////////////////
+(NSMutableDictionary*)jsonDictionary:(NSString*)response
{
    NSError *jsonError;
    NSMutableDictionary *parsedJSON = [[NSMutableDictionary alloc] init] ;
    SBJSON *json=[SBJSON new];
    [parsedJSON removeAllObjects];
    // NSLog(@"response-%@",response);
    
    parsedJSON=[json objectWithString:response error:&jsonError];
    
    if([parsedJSON isKindOfClass:[NSMutableDictionary class]])
    {
        //NSLog(@"parsedJSON-%@",parsedJSON);
        
        return parsedJSON;
    }
    else
    {
        //NSLog(@"data_array-%@",parsedJSON);
        
        //return parsedJSON;
        return [NSMutableDictionary dictionaryWithObject:parsedJSON forKey:@"responseData"];
    }
    
}

//////////////////////////////////////////////////////////////////
///////    6.   Post data by JSON Parsing                    /////
//////////////////////////////////////////////////////////////////
+(NSMutableURLRequest *)jsonPasering:(NSMutableDictionary *)passingDic :(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    if(passingDic)
    {
        NSString *jsonRequest = [passingDic JSONRepresentation];
        
        NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
        
        [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody: requestData];
        [request setHTTPMethod:@"POST"];
       // [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
       // [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
    }
    return request;
}

//////////////////////////////////////////////////////////////////
///////7.Set Any View Color By Passing hexadecimal String    /////
//////////////////////////////////////////////////////////////////
+(UIColor*)colorWithHexString:(NSString*)hex  
{  
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];  
    
    // String should be 6 or 8 characters  
    if ([cString length] < 6) return [UIColor grayColor];  
    
    // strip 0X if it appears  
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];  
    
    if ([cString length] != 6) return  [UIColor grayColor];  
    
    // Separate into r, g, b substrings  
    NSRange range;  
    range.location = 0;  
    range.length = 2;  
    NSString *rString = [cString substringWithRange:range];  
    
    range.location = 2;  
    NSString *gString = [cString substringWithRange:range];  
    
    range.location = 4;  
    NSString *bString = [cString substringWithRange:range];  
    
    // Scan values  
    unsigned int r, g, b;  
    [[NSScanner scannerWithString:rString] scanHexInt:&r];  
    [[NSScanner scannerWithString:gString] scanHexInt:&g];  
    [[NSScanner scannerWithString:bString] scanHexInt:&b];  
    
    return [UIColor colorWithRed:((float) r / 255.0f)  
                           green:((float) g / 255.0f)  
                            blue:((float) b / 255.0f)  
                           alpha:1.0f];  
} 

//////////////////////////////////////////////////////////////////
///////8.Set Progress Spring Message                         /////
//////////////////////////////////////////////////////////////////
+(void)SVProgressMessageShowOnWhenNeed:(NSString *)stringMessage
{
    [SVProgressHUD showWithStatus:stringMessage maskType:SVProgressHUDMaskTypeGradient];
}

//////////////////////////////////////////////////////////////////
///////9. Set Progress Spring dismiss with successfully      /////
//////////////////////////////////////////////////////////////////
+(void)SVProgressMessageDismissWithSuccess:(NSString *)stringMessage :(float ) timeDalay
{
    [SVProgressHUD dismissWithSuccess:stringMessage afterDelay:timeDalay];

}

//////////////////////////////////////////////////////////////////
///////10. Set Progress Spring Message dismiss with error    /////
//////////////////////////////////////////////////////////////////
+(void)SVProgressMessageDismissWithError:(NSString *)stringMessage :(float ) timeDalay
{
    [SVProgressHUD dismissWithError:stringMessage afterDelay:timeDalay];

}

//////////////////////////////////////////////////////////////////
//////11.Read Data From Plist File and Save Into NSMutableArray///
//////////////////////////////////////////////////////////////////
+(NSMutableArray *)dataReadFromPlist
{
    NSMutableArray *returnArrayList=[[NSMutableArray alloc] init];
    NSMutableArray *arrayInArray = [[NSMutableArray alloc] init];
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Name of the plist file" ofType:@"plist"];
    NSArray *dataFromPlist =[[NSArray alloc]initWithArray:[NSArray arrayWithContentsOfFile:plistPath]];
    
    
    for(NSDictionary *category in dataFromPlist)
    {
        [arrayInArray addObject:[category objectForKey:@"categories"]];
    }
    [returnArrayList addObjectsFromArray:[arrayInArray objectAtIndex:0]];
    return  returnArrayList; 
}

//////////////////////////////////////////////////////////////////
//////12.Change image into 64BitString and save in string     ////
//////////////////////////////////////////////////////////////////
+(NSString *)imageChangeIntoString:(UIImage *)avatarImage
{
    NSString *imageString = [[NSString alloc]init];
    //NSData *pictureData = UIImagePNGRepresentation(avatarImage);
    
    //imageString = [pictureData base64Encoding];
    
    
    return imageString;
}

//////////////////////////////////////////////////////////////////
//////13.Change image from uiview object to uiimage object type///
//////////////////////////////////////////////////////////////////
+(UIImage*)getUIImageFromThisUIView:(UIView*)aUIView
{
    UIGraphicsBeginImageContext(aUIView.bounds.size);
    /*this line show only when add CoreImage,OPenGL.framework+*/
   // [aUIView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

//////////////////////////////////////////////////////////////////
//////14.Chack internet connection with devicess              ////
//////////////////////////////////////////////////////////////////
+(BOOL)checkInternetConnection
{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    Reachability1 *netReachability=[delegate netReachability];
    
    NetworkStatus netStatus=[netReachability currentReachabilityStatus];
    BOOL connectionRequired = [netReachability connectionRequired];
    
    if ((netStatus == ReachableViaWiFi) ||
        ((netStatus == ReachableViaWWAN) && (!connectionRequired))) 
    {
        return YES;
    }
    return NO;
}

//////////////////////////////////////////////////////////////////
//////15.AlertView delegate method using in class where you want//
//////////////////////////////////////////////////////////////////
+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
	
	if([title isEqualToString:@"OK"])
	{
        ///what you want to do alertview delegate method when click on alert button.
        // this method you on this class where you want to add alert delegate method.
        
	}
    
}

//////////////////////////////////////////////////////////////////
//////16.Use timer to call method and any other work you want ////
//////////////////////////////////////////////////////////////////
+(void)myTimerMethodToCallAnyMethod:(SEL *)nameOfMethod :(BOOL)repeating
{
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nameofMethod) userInfo:nil repeats:repeating];

}

//////////////////////////////////////////////////////////////////
//////17.Move you according to keyboard appear or diappear    ////
//////////////////////////////////////////////////////////////////
+(void) moveViewAsPerTextField:(UIView *)yourView :(BOOL)move
{
    CGRect rect = yourView.frame;
    if (move)
    {	
        rect.origin.y -= 40;
        rect.size.height += 40 ;
        
    }
    else
    {
        //        rect.origin.y =0 ;
        //        rect.size.height =460 ;
        
        
    }
    yourView.frame = rect;
}

//////////////////////////////////////////////////////////////////
//////18.Add image on left side of textfield                  ////
//////////////////////////////////////////////////////////////////
+(void)addImageInLeftCornerOnTextField :(UITextField *)searchField :(UIImage *)imageToAdd
{
    searchField.leftView = [[UIImageView alloc] initWithImage:imageToAdd];
    searchField.leftViewMode = UITextFieldViewModeAlways;
}

//////////////////////////////////////////////////////////////////
//////19.Url white space replace by %20 in string             ////
//////////////////////////////////////////////////////////////////
+(NSString *)whiteSpaceReplaceFromString:(NSString*)insertString
{
    NSString  *urlString = [insertString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    return urlString;
}

//////////////////////////////////////////////////////////////////
//////20.Add url in webview using url string                  ////
//////////////////////////////////////////////////////////////////
+(UIWebView *)passAUrlInWebViewPage:(NSString *)urlString
{
    UIWebView *webView;
    webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    //webView.delegate = self;
    webView.multipleTouchEnabled = YES;

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    webView.backgroundColor = [UIColor clearColor];     
    [webView loadRequest:request];
    
    return webView;
}

//////////////////////////////////////////////////////////////////
//////21.Pass a number to Phone Call                          ////
//////////////////////////////////////////////////////////////////
+(void)methodForPhoneCall:(NSString *)phoneNumberString
{
    NSURL *dialingURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"tel:%@",phoneNumberString]];
    
    [[UIApplication sharedApplication] openURL:dialingURL];
}

//////////////////////////////////////////////////////////////////
//////22.Change Date formet according to you                  ////
//////////////////////////////////////////////////////////////////
+(NSString *)dateFormateByPassingDateString :(NSString *)yourDateString :(NSString *)typeOfDate
{
    NSString *formattedDate;
    NSDate *date = [NSDate date] ;
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:typeOfDate];
    formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}

//////////////////////////////////////////////////////////////////
//////23.Get Current Day from current Date                    ////
//////////////////////////////////////////////////////////////////
+(NSString *)currentDay:(NSDate *)date
{
    NSDateFormatter *theDateFormatter = [[NSDateFormatter alloc] init];
    [theDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [theDateFormatter setDateFormat:@"EEEE"];
    NSString *weekDay =  [theDateFormatter stringFromDate:date];
    return weekDay;
}

//////////////////////////////////////////////////////////////////
//////24.Get Current time from current Date in hour and minute////
//////////////////////////////////////////////////////////////////
+(NSString *)currentTime
{
    NSDate *currentDateForNotification = [NSDate date];
    NSDateFormatter *hourDateFormater=[[NSDateFormatter alloc] init];
    [hourDateFormater setDateFormat:@"hh:mm"];
    NSString *currentHour = [hourDateFormater stringFromDate:currentDateForNotification];
    return currentHour;
}

//////////////////////////////////////////////////////////////////
//////25.Image fromat in JPEGRepresentation                   ////
//////////////////////////////////////////////////////////////////
+(UIImage *)imageCovertINtoJPEGRepresentation:(UIImage *)inputImage
{
    UIImage *image = [[UIImage alloc] initWithData:UIImageJPEGRepresentation(inputImage, 0.5f)];
    return image;
}

//////////////////////////////////////////////////////////////////
//////26.Image fromat in PNGRepresentation                    ////
//////////////////////////////////////////////////////////////////
+(UIImage *)imageCovertINtoPNGRepresentation:(UIImage *)inputImage
{
    UIImage *image = [[UIImage alloc] initWithData:UIImagePNGRepresentation(inputImage)];
    return image;
}

//////////////////////////////////////////////////////////////////
//////27.Image Resize according to you                        ////
//////////////////////////////////////////////////////////////////
+(UIImage *)ScaleThePassingOfThisImage:(UIImage *)inputImage toThisSize:(CGSize)newSize
{
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [inputImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


//////////////////////////////////////////////////////////////////
//////28.Cut a fix word from the string                       ////
//////////////////////////////////////////////////////////////////
+(NSString  *)cutCharFromStringUsingNSRange:(NSString *)incomingsString
{
    NSString *yourReturnedString;
    NSRange range = NSMakeRange (0,10);
    
    if([incomingsString length]> 10)
    {
        yourReturnedString = [incomingsString substringWithRange:range];
    }
    return yourReturnedString;
}

//////////////////////////////////////////////////////////////////
//////29.My Custome textview with rounded shape               ////
//////////////////////////////////////////////////////////////////
+(UITextView *)myOwnTextView :(NSString *) textData :(float )xaxisMargin :(float )yaxisMargin :(float )width :(float )height;
{
   
     UITextView *yourTextView = [[UITextView alloc] initWithFrame:CGRectMake	(xaxisMargin, yaxisMargin, width, height)];
    [yourTextView setFont:[UIFont boldSystemFontOfSize:16.0]];
    [yourTextView setTextAlignment:NSTextAlignmentCenter];
	[yourTextView setEditable:NO];
    ///[yourTextView setTextColor:[UIColor whiteColor]];
   // [yourTextView setBackgroundColor:[UIColor clearColor]];
    [yourTextView setFont:[UIFont systemFontOfSize:12]];
    
    yourTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [yourTextView sizeToFit];

	//[[yourTextView layer] setBorderColor:[[UIColor whiteColor] CGColor]];
	//[[textViewStatus layer] setBorderWidth:2.3];//for this four line add quartzCore.frameworkand #import <QuartzCore/QuartzCore.h>

	//[[textViewStatus layer] setCornerRadius:15];
	//[textViewStatus setClipsToBounds: YES];
    [yourTextView setText:textData];
    
 	//[[self view] addSubview:textViewStatus];
    return yourTextView;
}

//////////////////////////////////////////////////////////////////
//////30.TextField with AlertViewController                   ////
//////////////////////////////////////////////////////////////////
+(NSString *)textFieldWithAlertView:(NSString *) textData
{
    NSString *textString;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:textData
                                                    message:@"\n\n"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Done", nil];
    CGRect rect = {12, 60, 260, 25};
    UITextField *dirField = [[UITextField alloc] initWithFrame:rect];
    dirField.backgroundColor = [UIColor whiteColor];
    [dirField becomeFirstResponder];
    [alert addSubview:dirField];
    
    [alert show];
    textString=dirField.text;
    return textString;
}
//////////////////////////////////////////////////////////////////
//////31.How to move cornor of the imageview  programmatically////
//////////////////////////////////////////////////////////////////
+(UIImageView *)roundedCornerOfImageView:(UIImageView *)imageView;
{
    UIImageView *profileImage;
    CALayer * l = [profileImage layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:10.0];    /// for this code need to add
    ///////////////quartz framework and import #import <QuartzCore/QuartzCore.h>
    return profileImage;
}

//////////////////////////////////////////////////////////////////
//////32.How to resize image from giving width and hight      ////
//////////////////////////////////////////////////////////////////
+(UIImage *)resizeImage:(UIImage *)image width:(int)width height:(int)height
{
    CGImageRef imageRef = [image CGImage];
	CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
	
	//if (alphaInfo == kCGImageAlphaNone)
    alphaInfo = kCGImageAlphaNoneSkipLast;
	
	CGContextRef bitmap = CGBitmapContextCreate(NULL, width, height, CGImageGetBitsPerComponent(imageRef), 4 * width, CGImageGetColorSpace(imageRef), alphaInfo);
	CGContextDrawImage(bitmap, CGRectMake(0, 0, width, height), imageRef);
	CGImageRef ref = CGBitmapContextCreateImage(bitmap);
	UIImage *result = [UIImage imageWithCGImage:ref];
	
	CGContextRelease(bitmap);
	CGImageRelease(ref);
	
	return result;	
}
//////////////////////////////////////////////////////////////////
//////33.My own activityIndicator                             ////
//////////////////////////////////////////////////////////////////
+(UIActivityIndicatorView *)myActivityIndicatorView :(float)xValue : (float)yValue
{
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake(xValue, yValue);
    spinner.hidesWhenStopped = YES;
    
    [spinner startAnimating];
    return spinner;
}
//////////////////////////////////////////////////////////////////
//////34.My BackgroundBigImage Customely                      ////
//////////////////////////////////////////////////////////////////
+(UIImageView *)myBackgroundBigImage :(float)xaxis :(float) yaxis :(float)width :(float)height :(NSString *)imageName
{
 UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(xaxis,yaxis, width,height)];
   backgroundImage.image = [UIImage imageNamed:imageName];
    return backgroundImage;
}
//////////////////////////////////////////////////////////////////
//////35.My Label add with view                               ////
//////////////////////////////////////////////////////////////////
+(UILabel *)myLabel :(float)xaxis :(float) yaxis :(float)width :(float)height :(NSString *)labelTitle :(NSString *)fontStyle :(UIColor *)fontColor :(float)fontSize
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xaxis,yaxis, width, height)];
    [label setText:labelTitle];
    label.font = [UIFont fontWithName:fontStyle size:fontSize];
    label.textColor = fontColor;
    label.textAlignment = NSTextAlignmentCenter;
    [label setBackgroundColor:[UIColor clearColor]];
    return label;
}

//////////////////////////////////////////////////////////////////
//////36.My Button add with view                              ////
//////////////////////////////////////////////////////////////////

+(UIButton *) myButton :(float)xaxis :(float) yaxis :(float)width :(float)height :(NSString *)buttonTitle :(NSString *)backgroundImage :(NSString*)selectedImage
{
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myButton.frame = CGRectMake(xaxis, yaxis, width, height);
     [myButton setBackgroundImage:[UIImage imageNamed:backgroundImage] forState:UIControlStateNormal];
    [myButton setBackgroundImage:[UIImage imageNamed:backgroundImage] forState:UIControlStateSelected];
    [myButton setTitle:buttonTitle forState:UIControlStateNormal];
    return myButton;
}

//////////////////////////////////////////////////////////////////
//////37.My Image Customely                                   ////
//////////////////////////////////////////////////////////////////
+(UIImageView *)myImage:(float)xaxis :(float) yaxis :(float)width :(float)height :(NSString *)imageName
{
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(xaxis,yaxis, width,height)];
    backgroundImage.image = [UIImage imageNamed:imageName];
    return backgroundImage;
}
//////////////////////////////////////////////////////////////////
//////38.Current month of the day                             ////
//////////////////////////////////////////////////////////////////
+(NSString *)currentMonthInString:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    NSString *currentMonth  = [formatter stringFromDate:date];
  
    return currentMonth;
}

//////////////////////////////////////////////////////////////////
//////39.Current month in integer of the day                             ////
//////////////////////////////////////////////////////////////////
+(NSString *)currentMonthInInteger:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM"];
    NSString *currentMonth  = [formatter stringFromDate:date];
    
    return currentMonth;
}

//////////////////////////////////////////////////////////////////
//////40.Current day in integer of the day                    ////
//////////////////////////////////////////////////////////////////
+(NSString *)currentDayInInteger:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    NSString *currentMonth  = [formatter stringFromDate:date];
    
    return currentMonth;
}

+(NSString *)currentYearInInteger:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *currentMonth  = [formatter stringFromDate:date];
    
    return currentMonth;
}

+(NSString *)currentHour:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh"];
    NSString *currentMonth  = [formatter stringFromDate:date];
    
    return currentMonth;
}
+(NSString *)currentMinute:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm"];
    NSString *currentMonth  = [formatter stringFromDate:date];
    
    return currentMonth;
}
+(NSString *)currentSecond:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"ss"];
    NSString *currentMonth  = [formatter stringFromDate:date];
    
    return currentMonth;
}


//////////////////////////////////////////////////////////////////
//////41.Table view horizontial by rotating 90 degree         ////
//////////////////////////////////////////////////////////////////
+(UITableView  *)mycustomeHorizontialTableView :(UITableView *) passTableView
{
    UITableView *horizontialTableView;
    horizontialTableView.showsVerticalScrollIndicator = NO;
    horizontialTableView.showsHorizontalScrollIndicator = NO;
    horizontialTableView.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
    // [self.horizontialTableView setFrame:CGRectMake(0 * 0.5,  0 * 0.5,  320 -  0, 192)];
    
    // self.horizontialTableView.rowHeight = 106;
    horizontialTableView.backgroundColor = [UIColor clearColor];
    
    //  self.horizontialTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    horizontialTableView.separatorColor = [UIColor clearColor];
    return horizontialTableView;
}

//////////////////////////////////////////////////////////////////
//////42.Get current location and update current location     ////
//////////////////////////////////////////////////////////////////
//+(void)locationManager:(CLLocationManager *)manager didUpdateToLocation: (CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//               
//        NSString *currentLatitude = [ NSString stringWithFormat:@"%3.6f" , (newLocation.coordinate.latitude) ];
//        NSString *currentLongitude= [ NSString stringWithFormat:@"%3.6f" , (newLocation.coordinate.longitude)];
//        NSLog(@"Latitude=%@--- Longitude = %@",currentLatitude,currentLongitude);
////////////////////////////////////////////////////////////////////////////////
//    for this method i need to #import <MapKit/MapKit.h>,#import  <CoreLocation/CoreLocation.h> then it will work so you can copy this method in class where you want/

//    
//}

//////////////////////////////////////////////////////////////////
//////43.How to hide  and               status bar            ////
//////////////////////////////////////////////////////////////////
+(void)hideStatusbar
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    [UIApplication sharedApplication].keyWindow.frame=CGRectMake(0, 0, 320, 480);
   ///////if you want to hide status bar permently from the app then go
    ////// in plist and find "Status bar is initially hidden": NO/YES set this

}

//////////////////////////////////////////////////////////////////
//////44.How to show and transparent    status bar            ////
//////////////////////////////////////////////////////////////////
+(void)showStatusbar
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    [UIApplication sharedApplication].keyWindow.frame=CGRectMake(0, 0, 320, 460);
    /////////////////////////this is for transparent status bar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
}

//////////////////////////////////////////////////////////////////
//////45.How to change view background color like any image color/
//////////////////////////////////////////////////////////////////
+(void)myViewBackgroundColorChangeLikeImageColor
{
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:set image object]
   // UIImage *img = [UIImage imageNamed:imageName];
        // NSArray *arr = [imageName componentsSeparatedByString:@"."];
       // NSLog(@"%@",[NSString stringWithFormat:@"%@-568h@2x.%@",[arr objectAtIndex:0],[arr objectAtIndex:1]]);
       // img = [UIImage imageNamed:[NSString stringWithFormat:@"%@-568h@2x.%@",[arr objectAtIndex:0],[arr objectAtIndex:1]]];
        UIImage *img=[UIImage imageNamed:@"name of image in string"];
        img = [UIImage imageWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
   

}

//////////////////////////////////////////////////////////////////
//////46.How to navigation bar transparent                   /////
//////////////////////////////////////////////////////////////////
+(void)myNavigationBarTransparent
{
    
    //self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    
}

//////////////////////////////////////////////////////////////////
//////47.How to select image according to the iphone5 screen size//
//////////////////////////////////////////////////////////////////
+(UIImage *)myViewBackgroundColorChangeLikeImageColor:(NSString *)imageName
{
    
    UIImage *img = [UIImage imageNamed:imageName];
    if (IS_IPHONE5)
    {
        NSArray *arr = [imageName componentsSeparatedByString:@"."];
        NSLog(@"%@",[NSString stringWithFormat:@"%@-568h@2x.%@",[arr objectAtIndex:0],[arr objectAtIndex:1]]);
        img = [UIImage imageNamed:[NSString stringWithFormat:@"%@-568h@2x.%@",[arr objectAtIndex:0],[arr objectAtIndex:1]]];
        img = [UIImage imageWithCGImage:img.CGImage scale:2.0 orientation:UIImageOrientationUp];
    }
    return img;
    
    
}
/////**********************Database Connection *************//////


//////////////////////////////////////////////////////////////////
//////48.Find the data base file from documents              /////
//////////////////////////////////////////////////////////////////
//////48b.Data fetch form local data base                     /////
//////////////////////////////////////////////////////////////////
+(NSMutableArray *) dataReadFromLocalDataBase: (NSString *) databaseName :(NSString *) databaseQuery
{
	// Setup the database object
	// Get the path to the documents directory and append the databaseName
    NSMutableArray *dataArray=[[NSMutableArray alloc] init];
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    NSLog(@"%@",databasePath);
	NSFileManager   *fileManager = [NSFileManager defaultManager];
    BOOL   success = [fileManager fileExistsAtPath:databasePath];
    
    if(!success)
    {
        NSString  *databasepath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
        [fileManager copyItemAtPath:databasepath toPath:databasePath error:nil];
        //  [fileManager release];
    }
	sqlite3 *database;
	// Init the animals Array
	//NSMutableArray *animals = [[NSMutableArray alloc] init];
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, [databaseQuery UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK)
        {
          	// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
				// Read the data from the result row
				//NSString *username = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                // NSString *firstname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                
                // NSString *type = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                
                NSString *aName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,0)];
                
                //  NSString *aName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                
                if ([aName length]==0)
                {
                    [dataArray addObject:@""];
                }
                else
                {
                    [dataArray addObject:aName];
                }
            }
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    return dataArray;
	
}

//////////////////////////////////////////////////////////////////
//////49.Data load delete and update                         /////
//////////////////////////////////////////////////////////////////
+(NSString *) dataUpdateInsertDeleteDataBase: (NSString *) databaseName :(NSString *) databaseQuery
{
    NSString *databaseResponse;
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    NSLog(@"%@",databasePath);
    NSFileManager   *fileManager = [NSFileManager defaultManager];
    BOOL   success = [fileManager fileExistsAtPath:databasePath];
    
    if(!success)
    {
        NSString  *databasepath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
        [fileManager copyItemAtPath:databasepath toPath:databasePath error:nil];
        //  [fileManager release];
    }
    sqlite3 *database;
    sqlite3_stmt *compiledStatement = nil;
    
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        
        sqlite3_reset(compiledStatement);
        if (sqlite3_prepare_v2(database, [databaseQuery UTF8String], -1, &compiledStatement, NULL) != SQLITE_OK)
        {
            databaseResponse=[NSString stringWithFormat:@"%s",sqlite3_errmsg(database)];
        }
        if (sqlite3_step(compiledStatement) != SQLITE_DONE)
        {
            databaseResponse=[NSString stringWithFormat:@"%s",sqlite3_errmsg(database)];
        }
        if(sqlite3_step(compiledStatement) == SQLITE_DONE)
        {
            databaseResponse=[NSString stringWithFormat:@"Successfully done."];
            sqlite3_finalize(compiledStatement);
        }
        sqlite3_close(database);
    }
    else
    {
        NSLog(@"Data Base has some problem to open");
    }
    NSLog(@"databaseResponse=%@",databaseResponse);
    
    return databaseResponse;
}

//////////////////////////////////////////////////////////////////
//////49a. Data load delete and update                         /////
//////////////////////////////////////////////////////////////////
+(void)deleteTablDataFromLocalDATABASE:(NSString *)tableName
{
    NSString *query =[NSString stringWithFormat:@"DELETE From %@",tableName];
    NSLog(@"%@",query);
    [MyCustomeClass dataUpdateInsertDeleteDataBase:@"CRMDatabase.sqlite" :query];
}

///// for all these you need to #improt<sqlite3.0>///////////////

/////******************End Database Connection *************//////

//////////////////////////////////////////////////////////////////
//////50.present model view controller open like a page      /////
//////////////////////////////////////////////////////////////////
+(void)myAnimatedOpenView :(UIView *) selectedView
{
   // BG_Text_ViewController *vewCtrl = [[BG_Text_ViewController alloc]initWithNibName:@"BG_Text_ViewController" bundle:nil];
    //vewCtrl.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    //[vewCtrl setImageName:[[self.imagenames objectAtIndex:randomIndex] valueForKey:@"Name"]];
  //  [self presentModalViewController:vewCtrl animated:YES];
   
}

//////////////////////////////////////////////////////////////////
//////51. Find iphone screen height                         /////
//////////////////////////////////////////////////////////////////
+(float )myIPhoneScreenSizeHeight
{
    
    float screenHeight=0.0;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            screenHeight =0.00;
        }
        if(result.height == 568)
        {
            screenHeight =88.00;
            
        }
    }
    return screenHeight;
}

//////////////////////////////////////////////////////////////////
//////52. Find iphone screen size                            /////
//////////////////////////////////////////////////////////////////
+(float)myIPhoneScreenIncreaseSize
{
    float screenHeight=0.0;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            screenHeight =0.00;
        }
        if(result.height == 568)
        {
            screenHeight =0.183;
            
        }
    }
    return screenHeight;
}

//////////////////////////////////////////////////////////////////
//////53. Find iphone screen Type                            /////
//////////////////////////////////////////////////////////////////
+(NSString * )myIPhoneScreenType
{
    NSString *screenHeight;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            screenHeight =@"480";
        }
        if(result.height == 568)
        {
            screenHeight =@"568";
            
        }
    }
    return screenHeight;

}

//////////////////////////plist handling dynamically//////////////
//////////////////////////////////////////////////////////////////
//////54. Create plist data programetically                  /////
//////////////////////////////////////////////////////////////////
+(void)myPlistInstertData
{
    NSString *plistFile;
    NSLog(@"createPlistFile");
    NSDictionary *plistDict=[NSDictionary dictionaryWithObjectsAndKeys: @"hi",@"1" ,@"hello",@"2",@"wel",@"3",@"com",@"4",nil];
    [plistDict writeToFile:plistFile atomically:NO];

}

//////////////////////////////////////////////////////////////////
//////55. Open plistFile programmetically                    /////
//////////////////////////////////////////////////////////////////
+(void)MyPlistFileOpened
{
    NSString *plistFile;

    NSLog(@"openPlistFile");
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([path count]>0)
    {
        NSLog(@"path count");
        plistFile=[[path objectAtIndex:0] stringByAppendingPathComponent:@"Data.plist"];
        NSDictionary *plistDict=[[NSDictionary alloc]initWithContentsOfFile:plistFile];
        
        if ([plistDict count]<=0)
        {
            
           // [self createPlistFile];
            NSLog(@"createPlistFile");
        }
        plistDict=nil;
    }
}

//////////////////////////////////////////////////////////////////
//////56. Read value from plistfile                          /////
//////////////////////////////////////////////////////////////////
+(NSString *)readValuesForKeyFromPlist:(NSString *)key
{
    NSString *plistFile;

    NSLog(@"readValuesForKey");
    NSDictionary *plistDict=[[NSDictionary alloc]initWithContentsOfFile:plistFile];
    NSString *value;
    value=[[NSString alloc]initWithString:[plistDict objectForKey:key]];
    plistDict=nil;
    return value;
}

//////////////////////////////////////////////////////////////////
//////56. Save data in plist by progarmmetically             /////
//////////////////////////////////////////////////////////////////
+(void)saveValueInPlist:(NSString *)value forKey:(NSString *)key
{
    NSString *plistFile;

    NSMutableDictionary *plistDict=[[NSMutableDictionary alloc]initWithContentsOfFile:plistFile];
    [plistDict removeObjectForKey:key];
    [plistDict setValue:value forKey:key];
    [plistDict writeToFile:plistFile atomically:NO];
    plistDict=nil;
    NSLog(@"saveValue");

}

//////////////////////////////////////////////////////////////////
//////57.My reading string from any charactar                 ////
//////////////////////////////////////////////////////////////////
+(NSArray *) seprateStringFromStringUsingArrray:(NSString *)insertString :(NSString *)seperatedfromsign
{
    NSArray *dataArray =[[NSArray alloc] init];
    dataArray=[insertString componentsSeparatedByString:seperatedfromsign];
    return dataArray;
}

//////////////////////////////////////////////////////////////////
//////58.My reading string from any charactar                 ////
//////////////////////////////////////////////////////////////////
+(NSString *) readStringFromChar:(NSString *)insertString :(NSString *) sepatatefromsign
{
    NSString *returnString=[[NSString alloc] init];
    NSRange charRange = [insertString rangeOfString:sepatatefromsign];
    NSUInteger index = charRange.location;
    NSRange MyOneRange = {1, index};
    returnString= [insertString substringWithRange:MyOneRange];
    return returnString;
    
}

//////////////////////////////////////////////////////////////////
//////59. My textfield add with view                          ////
//////////////////////////////////////////////////////////////////
+(UITextField *) myTextField :(float)xaxis :(float) yaxis :(float)width :(float)height :(NSString *)placeholder :(NSString *)backgroundImage
{
    UITextField *myText = [[UITextField alloc] initWithFrame:CGRectMake(xaxis, yaxis, width, height)];
    [myText setPlaceholder:placeholder];
    [myText setBorderStyle:UITextBorderStyleBezel];
    return myText;
    
}

//////////////////////////////////////////////////////////////////
//////60.Add image on left side of textfield                  ////
//////////////////////////////////////////////////////////////////
+(void)addImageInRightCornerOnTextField :(UITextField *)searchField :(UIImage *)imageToAdd
{
    searchField.rightView = [[UIImageView alloc] initWithImage:imageToAdd];
    searchField.rightViewMode = UITextFieldViewModeAlways;
}

//////////////////////////////////////////////////////////////////
/////////////////////61.Email Validation  by second way ///////////
//////////////////////////////////////////////////////////////////
+ (BOOL)validateEmail:(NSString*)email
{
	NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
	if ([emailTest evaluateWithObject:email] == YES)
		return TRUE;
	else
		return FALSE;
}

//////////////////////////////////////////////////////////////////
/////////////////////62.Mobile number Validation        ///////////
//////////////////////////////////////////////////////////////////
+ (BOOL)validateNumber:(NSString*)number
{
	NSString *numberRegEx = @"[0-9]{10}";
	NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
	if ([numberTest evaluateWithObject:number] == YES)
		return TRUE;
	else
		return FALSE;
}
//////////////////////////////////////////////////////////////////
/////////////////////63. age validation               ///////////
//////////////////////////////////////////////////////////////////
+ (BOOL)ageValidation:(NSString*)number
{
	NSString *numberRegEx = @"[0-9]{2}";
	NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
	if ([numberTest evaluateWithObject:number] == YES)
		return TRUE;
	else
		return FALSE;
}

//////////////////////////////////////////////////////////////////
/////////////////////64. iphone 4 & 5 display resolution /////////
//////////////////////////////////////////////////////////////////
+ (void)deviceResolution
{
    ///////////// resolution ////////////
   /* switch ([[UIDevice currentDevice] resolution])
    {
        case UIDeviceResolution_iPhoneRetina4:
            NSLog(@"ipghone retin 4 inch check");
            break;
        case UIDeviceResolution_iPhoneRetina35:
            NSLog(@"ipghone retin 3.5 inch check");
            self.view=iphoneStandard;
            break;
            
        case UIDeviceResolution_iPhoneStandard:
            NSLog(@"ipghone retin iphone inch check");
            self.view=iphoneStandard;
            break;
            
        default:
            break;
    }*/
}

//////////////////////////////////////////////////////////////////
////// 65.         sorting array                        ///    ///
///////////////////////////////////////////////////////////////
+(NSArray *) mySortingArray: (NSArray *)unSortedArray
{
    NSArray * sortedKeys =
    [unSortedArray sortedArrayUsingComparator:^(id string1, id string2)
    {
        return [((NSString *)string1) compare:((NSString *)string2)
                                      options:NSNumericSearch];
    }];
    return sortedKeys;
}


//////////////////////////////////////////////////////////////////
////// 66. This method returns an array of dictionaries where each
// key is a letter and each value is a group of words corresponding
// to the letter.                                        ///    ///
//////////////////////////////////////////////////////////////////
+ (NSMutableArray *) wordsFromLetters:(NSMutableArray *) unsortedArray
{
    static NSString *letters = @"abcdefghijklmnopqrstuvwxyz#";
    NSMutableArray *content=[[NSMutableArray alloc] init];
    for (int i = 0; i < 26; i++ )
    {
        NSMutableDictionary *row = [[NSMutableDictionary alloc] init];
        NSMutableArray *oneMoreArray=[[NSMutableArray alloc]init];
        oneMoreArray =[MyCustomeClass mySortingArray:unsortedArray];
        NSMutableArray *words = [[NSMutableArray alloc] init];
        
        for (int j = 0; j < [oneMoreArray count]; j++ )
        {
            
            char currentWord1[2]= {[[NSString stringWithFormat:@"%@",[oneMoreArray objectAtIndex:j]] characterAtIndex:0]};
            char currentWord2[2]= {[letters characterAtIndex:i]};
            char currentWord3[2]={ toupper([letters characterAtIndex:i]), '\0'};
            if ([[NSString stringWithFormat:@"%s",currentWord2] isEqualToString:[NSString stringWithFormat:@"%s",currentWord1]] || [[NSString stringWithFormat:@"%s",currentWord3] isEqualToString:[NSString stringWithFormat:@"%s",currentWord1]])
            {
                [words addObject:[oneMoreArray objectAtIndex:j]];
            }
            
            
        }
        char currentLetter[2] = { toupper([letters characterAtIndex:i]), '\0'};
        if ([words count]==0)
        {
            //NSLog(@"abcdefghijklmnopqrstuvwxyz");
        }
        else
        {
            [row setValue:[NSString stringWithCString:currentLetter encoding:NSASCIIStringEncoding]
                   forKey:@"headerTitle"];
            [row setValue:words forKey:@"rowValues"];
            [content addObject:row];
        }
        
    }
    
    
    return content;
}

//////////////////////////////////////////////////////////////////
//////67. calendar parmission has done            /////       /////
//////////////////////////////////////////////////////////////////
+(void)calendarParmissionAllo
{
    //first of all need to #import <EventKit/EventKit.h> after the this method is work//

  /*  EKEventStore *eventStore=[[EKEventStore alloc] init];
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
       //  iOS Settings > Privacy > Calendars > MY APP > ENABLE | DISABLE 
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
         {
             if ( granted )
             {
                 NSLog(@"User has granted permission!");
             }
             else
             {
                 NSLog(@"User has not granted permission!");
             }
         }];
    }
*/
}

//////////////////////////////////////////////////////////////////
//////68.add textfield with alertview controller /////       /////
//////////////////////////////////////////////////////////////////
+(UIAlertView *)myAlertViewWithTextField :(UIAlertView *) myAlertView :(NSString *)title :(NSString *)message :(NSString *)cancelButton :(NSString *)buttonTitle
{
    UIAlertView *textAlertView =[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButton otherButtonTitles:buttonTitle, nil];
    UITextField *txtName = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    txtName.text=@"";
    [txtName setBackgroundColor:[UIColor whiteColor]];
    [txtName setKeyboardAppearance:UIKeyboardAppearanceAlert];
    [txtName setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [txtName setTextAlignment:NSTextAlignmentCenter];
    [textAlertView addSubview:txtName];
    return textAlertView;
    
}

//////////////////////////////////////////////////////////////////
/////////////////////69.Move custom view with animation //////////
//////////////////////////////////////////////////////////////////
+ (void)myCustomAnimationLeftANDRight:(UIView *)view2 direction:(int)directionRL
{
    
    // set up an animation for the transition between the views
    CATransition *animation = [CATransition animation];
    [animation setDuration:1];
    [animation setType:kCATransitionMoveIn];
    if (directionRL == 0)
    {
        [animation setSubtype:kCATransitionFromRight];
    }
    else
    {
        [animation setSubtype:kCATransitionFromLeft];
    }
    
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    [[view2 layer] addAnimation:animation forKey:@"SwitchToView"];
}

//////////////////////////////////////////////////////////////////
/////////////////////70.Move any view with any direction with animation //////////
//////////////////////////////////////////////////////////////////
+ (void)myMovingAnimation :(UIView *)view2 direction :(int)upAndDwon :(float)height
{
    CGRect viewFrame = view2.frame;
    viewFrame.origin.y -= height * (upAndDwon? 1: -1);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:1.00];
    
    view2.frame = viewFrame;
    
    [UIView commitAnimations];
}

//////////////////////////////////////////////////////////////////
/////////////////////70.Move any view with any direction with animation //////////
//////////////////////////////////////////////////////////////////
+ (void)myMovingAnimationLeftRight :(UIView *)view2 direction :(int)upAndDwon :(float)height
{
    CGRect viewFrame = view2.frame;
    viewFrame.origin.x -= height * (upAndDwon? 1: -1);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:2.00];
    
    view2.frame = viewFrame;
    
    [UIView commitAnimations];
}
+(NSString*) languageSelectedStringForKey :(NSString*) key
{
    [NSUserDefaults standardUserDefaults];
    
	NSString *path;
    int selectedLanguage=[[[NSUserDefaults standardUserDefaults] objectForKey:@"Language" ] intValue];
	if(selectedLanguage==ENGLSIH_LANGUAGE)
		path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
	else if(selectedLanguage==CHINESE_LANGUAGE)
		path = [[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"];
	
	
	NSBundle* languageBundle = [NSBundle bundleWithPath:path];
	NSString* str=[languageBundle localizedStringForKey:key value:@"" table:nil];
	return str;
}
#pragma mark - Gesture Method List
//////////////////////////////////////////////////////////////////
//////110. LongPress gesture                                  ////
//////////////////////////////////////////////////////////////////
+(void)addLongPressGesture:(UIView *)view action:(SEL)action target:(id)target
{
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:action];
    [view addGestureRecognizer:recognizer];
}

//////////////////////////////////////////////////////////////////
//////111.SwipGestureFromLeftToRight gesture                  ////
//////////////////////////////////////////////////////////////////
+(void)addSwipGestureFromLeftToRight:(UIView *)view action:(SEL)action target:(id)target
{
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [view addGestureRecognizer:rightRecognizer];
}

//////////////////////////////////////////////////////////////////
//////112.SwipGestureFromRightToLeft gesture                  ////
//////////////////////////////////////////////////////////////////
+(void)addSwipGestureFromRightToLeft:(UIView *)view action:(SEL)action target:(id)target
{
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    [view addGestureRecognizer:leftRecognizer];
}

//////////////////////////////////////////////////////////////////
//////113.SingleTabGesture gesture                            ////
//////////////////////////////////////////////////////////////////
+(void)addSingleTabGesture:(UIView *)view action:(SEL)action target:(id)target
{
    UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [singleTapRecognizer setNumberOfTouchesRequired:1];
    [view addGestureRecognizer:singleTapRecognizer];
}

//////////////////////////////////////////////////////////////////
//////114. DoubleTabGesture gesture                           ////
//////////////////////////////////////////////////////////////////
+(void)addDoubleTabGesture:(UIView *)view action:(SEL)action target:(id)target
{
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [doubleTapRecognizer setNumberOfTouchesRequired:2];
    [view addGestureRecognizer:doubleTapRecognizer];
}

//////////////////////////////////////////////////////////////////
//////115. TripleTabGesture gesture                           ////
//////////////////////////////////////////////////////////////////
+(void)addTripleTabGesture:(UIView *)view action:(SEL)action target:(id)target
{
    UITapGestureRecognizer *tripleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [tripleTapRecognizer setNumberOfTouchesRequired:2];
    [view addGestureRecognizer:tripleTapRecognizer];
}

//////////////////////////////////////////////////////////////////
//////116. PinchGesture gesture                               ////
//////////////////////////////////////////////////////////////////
+(void)addPinchGesture:(UIView *)view action:(SEL)action target:(id)target
{
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:target action:action];
    [pinchRecognizer setDelegate:target];
    [view addGestureRecognizer:pinchRecognizer];
}

//////////////////////////////////////////////////////////////////
//////117. RotationGesture gesture                            ////
//////////////////////////////////////////////////////////////////
+(void)addRotationGesture:(UIView *)view action:(SEL)action target:(id)target
{
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:target action:action];
    [rotationRecognizer setDelegate:target];
    [view addGestureRecognizer:rotationRecognizer];
}

//////////////////////////////////////////////////////////////////
//////118. PanGesture gesture                                 ////
//////////////////////////////////////////////////////////////////
+(void)addPanGesture:(UIView *)view action:(SEL)action target:(id)target
{
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:target];
    [view addGestureRecognizer:panRecognizer];
}


+(void)drawBorder:(UIView*)view
{
    [view.layer setCornerRadius:05.0f];
    [view.layer setBorderColor:[UIColor blackColor].CGColor];
    [view.layer setBorderWidth:1.2f];
    
}
+(NSString *)internetConnectWithWhich
{
    CTTelephonyNetworkInfo *telephonyInfo = [CTTelephonyNetworkInfo new];
    return telephonyInfo.currentRadioAccessTechnology;
    
    [NSNotificationCenter.defaultCenter addObserverForName:CTRadioAccessTechnologyDidChangeNotification
                                                    object:nil
                                                     queue:nil
                                                usingBlock:^(NSNotification *note)
    {
        
        NSLog(@"New Radio Access Technology: %@", telephonyInfo.currentRadioAccessTechnology);
    }];
}

+(void)roundedImageView:(UIImageView *)imageView
{
    imageView.layer.cornerRadius = imageView.frame.size.height /2;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderWidth = 0;
}


+(int )getCurrentMonthInNumber
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM"];
    NSString *currentMonth  = [formatter stringFromDate:[NSDate date]];
    return [currentMonth intValue];
}



/////*******************************************************//////
+(NSString *)jsonStringFromNormalDictionary:(NSDictionary *)Dict
{
    NSDictionary *trackDictionary=[NSDictionary dictionaryWithDictionary:Dict];
    NSLog(@"%@",trackDictionary);
    //NSData *jsonData;//=[Dict JSONRepresentation] ;
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:trackDictionary
                        options:NSJSONWritingPrettyPrinted
                        error:&error];
    
    if ([jsonData length] > 0 &&
        error == nil){
        NSLog(@"Successfully serialized the dictionary into data = %@", jsonData);
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        NSLog(@"JSON String = %@", jsonString);
        
        return jsonString;
    }
    /* else if ([jsonData length] == 0 &&
     error == nil){
     NSLog(@"No data was returned after serialization.");
     }
     else if (error != nil){
     NSLog(@"An error happened = %@", error);
     }
     NSLog(@"%@", jsonData);  // To verify the jsonString.*/
    return @"";
}



@end
