 //
//  CardViewController.m
//  Restaurant Cibo
//
//  Created by mithun ravi on 28/06/14.
//  Copyright (c) 2014 mithun ravi. All rights reserved.
//

#import "CardViewController.h"

@interface CardViewController ()

@end

@implementation CardViewController

@synthesize address;
@synthesize userName;
@synthesize cardNumber;
@synthesize exp_Date;
@synthesize finalAmount;
@synthesize cvvNumber;
@synthesize selectedOrderArray;
@synthesize paymentMethodDic;

@synthesize gatewayData;
@synthesize businessHour;
@synthesize mercuryMerchantID;
@synthesize mercuryMerchantPassword;
@synthesize mercuryTranCode;
@synthesize mercuryTranType;
@synthesize mercuryUrl;
@synthesize orderTypeCheckding;
@synthesize selectedPaymentGateway;
@synthesize orderId;
@synthesize transectionId;
@synthesize taxArray;
@synthesize welletArray;
@synthesize ciboRestauantID;
@synthesize heartLendInfoDic;
@synthesize tableArray;


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
    [super viewDidLoad];//nandan@idctechnolies.com
    offerButton.layer.cornerRadius = 5;
    offerButton.layer.masksToBounds = YES;
    
    lblTitle.font=[UIFont fontWithName:FONT_Ragular size:20.0];
    [lblTitle setFont: [lblTitle.font fontWithSize: 20.0]];

    showCoupon.hidden=YES;
    tableArray=[[NSMutableArray alloc] init];
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    cardDefault=[NSUserDefaults standardUserDefaults];
    restaurantDic=[[NSMutableDictionary alloc] init];
    selectedOrderArray=[[NSMutableArray alloc] init];
    paymentMethodDic=[[NSMutableDictionary alloc] init];
    businessHour=[[NSMutableArray alloc] init];
    gatewayData=[[NSMutableArray alloc] init];
    taxArray=[[NSMutableArray alloc] init];//01129912198
    welletArray=[[NSMutableArray alloc] init];
    deliversView.hidden=NO;
    pickupView.hidden=YES;
    
    address=[NSString stringWithFormat:@"%@ %@ %@ %@",[cardDefault valueForKey:@"address"],[cardDefault valueForKey:@"city"],[cardDefault valueForKey:@"country"],[cardDefault valueForKey:@"zipcode"]];
    userAddress.text=address;
    pickupIS=@"delivery";
    userName=[[NSUserDefaults standardUserDefaults] valueForKey:@"CardHolderName"];
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:@"RestaurantDetail"];
    
    restaurantDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    customerDiscountInFloat=[[[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDiscount"] floatValue];
    discountAmount.text=[NSString stringWithFormat:@"%@ %.2f",@"%",customerDiscountInFloat];
    savings=savings+customerDiscountInFloat;
    restaurantCurrency=[restaurantDic objectForKey:@"currency"];
    
    selectedPaymentMethod=0;
   
    if ([orderTypeCheckding isEqualToString:@"OpenOrder"])
    {
        dePicSegmentController.hidden=YES;
        payOnDelievryTitle.hidden=YES;
        payOnDelButton.hidden=YES;
        carImage.hidden =YES;
    }
    else
    {
        orderId=nil;
    }
    
    /// e pay ///
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(event:) name:PaymentAcceptedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(event:) name:PaymentLoadingAcceptPageNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(event:) name:PaymentWindowCancelledNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(event:) name:PaymentWindowLoadedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(event:) name:PaymentWindowLoadingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(event:) name:ErrorOccurredNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(event:) name:NetworkActivityNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(event:) name:NetworkNoActivityNotification object:nil];
    
    /////////////
    [self orderID];
    
    // Do any additional setup after loading the view from its nib.
    
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"OfferDiscount"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"OfferAmounts"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"OfferPoints"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"selectedOfferID"];//selectedOfferID
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)viewWillAppear:(BOOL)animated
{
    cardNumber=[[NSUserDefaults standardUserDefaults] valueForKey:@"CraditCardNumber"];
    exp_Date=[[NSUserDefaults standardUserDefaults] valueForKey:@"ExpDate"];
    cvvNumber=[[NSUserDefaults standardUserDefaults] valueForKey:@"CCV2"];
    userName=[[NSUserDefaults standardUserDefaults] valueForKey:@"CardHolderName"];
    
    NSData* data2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"WalletOrderArray"];
    if (data2.length>0)
    {
        welletArray = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
    }
    
    if (welletArray.count<=0)
    {
        NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:@"OrderArray"];
        selectedOrderArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSData* data1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"TaxArray"];
        taxArray = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
        ciboRestauantID =[[selectedOrderArray objectAtIndex:0] objectForKey:@"restaurant_id"];

    }
    
    
    [self gateWayCradintialAccessRequest];
    [self paymentMethodListRequest];
    [self businessHourRequest];

    [self checkOutCalculation];
    [self priceCalulation];
    
    selectedPaymentMethod=1;
    selectedPaymentGateway=@"STRIPE";
    
    latitude1=[[NSString stringWithFormat:@"%@",[restaurantDic objectForKey:@"lat"]] floatValue];
    longitude1=[[NSString stringWithFormat:@"%@",[restaurantDic objectForKey:@"lon"]] floatValue];
}

-(void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *offer =[NSUserDefaults standardUserDefaults];
    float pointConversion =[[restaurantDic objectForKey:@"points_percent"] floatValue];
    couponID = [offer objectForKey:@"selectedOfferID"];
    pointConversion=pointConversion/100;
    pointConversion=pointConversion*priceINFloat;
    totalOrderPoints=pointConversion;
    
    if (welletArray.count>0)
    {
        priceINFloat = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"FinalPrice"]] floatValue];
        totalAmount.text= [NSString stringWithFormat:@"DKK %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"FinalPrice"]];
    }
    float calculatedPrice = priceINFloat;
    couponAmount=0.0;
    if ([offer objectForKey:@"OfferDiscount"]!=nil)
    {
        float discount =[[offer objectForKey:@"OfferDiscount"] floatValue];
        float veryFinalAmount = calculatedPrice - (calculatedPrice*discount/100);
        couponAmount = (calculatedPrice*discount/100);
        savings=savings +(calculatedPrice*discount/100);
        calculatedPrice = veryFinalAmount;
        [showCoupon setTitle:[NSString stringWithFormat:@" R: %.2f%@ -",discount,@"%"] forState:UIControlStateNormal];
    }
    else if ([offer objectForKey:@"OfferAmounts"]!=nil)
    {
        calculatedPrice=calculatedPrice-[[offer objectForKey:@"OfferAmounts"] floatValue];
        if (calculatedPrice<=0)
        {
            [[[UIAlertView alloc] initWithTitle:@"Coupon alert !" message:@"You can not take this coupon on this order." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            calculatedPrice = priceINFloat;
        }
        else
        {
            savings = savings + [[offer objectForKey:@"OfferAmounts"] floatValue];
            couponAmount = [[offer objectForKey:@"OfferAmounts"] floatValue];
            [showCoupon setTitle:[NSString stringWithFormat:@" R: %.2f -",couponAmount] forState:UIControlStateNormal];
        }
    }
    else if ([offer objectForKey:@"OfferPoints"]!=nil)
    {
        totalOrderPoints= totalOrderPoints - [[offer objectForKey:@"OfferPoints"] floatValue];
        [showCoupon setTitle:[NSString stringWithFormat:@" R: %d -",totalOrderPoints] forState:UIControlStateNormal];
    }
    
    showCoupon.hidden=YES;
    if (couponID>0)
    {
        showCoupon.hidden=NO;
    }
    
    totalPrice.text=[NSString stringWithFormat:@"DKK %.2f",calculatedPrice];
    checkOutPoints.text=[NSString stringWithFormat:@"%d",totalOrderPoints];
    checkOutPoints.hidden =YES;
    
    /// Tip calculation after adding some savings..
    if (tipAmount<1)
    {
        tipAmount=0.0;
        tipis=0;
        tipShowButton.hidden=YES;
    }
    else if(tipis==2)
    {
        float finalprice=0.0;
        if (couponAmount>0)
        {
            finalprice = calculatedPrice + tipAmount;
        }
        else
        {
            finalprice =(priceINFloat+tipAmount);
        }
        
        totalAmount.text =[NSString stringWithFormat:@"$ %.2f",priceINFloat];
        
        totalPrice.text=[NSString stringWithFormat:@"$ %.2f",finalprice];
        finalAmount= [NSString stringWithFormat:@"%f",finalprice];
        grandTotal = [NSString stringWithFormat:@"%.2f",finalprice];
        [tipShowButton setTitle:[NSString stringWithFormat:@" Tip: %.2f +",tipAmount] forState:UIControlStateNormal];
        tipShowButton.hidden=NO;
    }
    else
    {
        tipShowButton.hidden=YES;
        tipAmount=0.0;
    }

    
    [super viewDidAppear:animated];
    [itemTable reloadData];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"OfferDiscount"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"OfferAmounts"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"OfferPoints"];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"selectedOfferID"];
    //[[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"WalletOrderArray"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    //[welletArray removeAllObjects];
    
    [super viewDidDisappear:animated];
}
-(void)checkOutCalculation
{
    if (welletArray.count<=0)
    {
        priceINFloat=[[NSUserDefaults standardUserDefaults] floatForKey:@"FinalPrice"];
        totalAmount.text =[NSString stringWithFormat:@"DKK %.2f",priceINFloat];
        float C_discount = priceINFloat*customerDiscountInFloat/100;
        priceINFloat = priceINFloat - C_discount;
        totalPrice.text=[NSString stringWithFormat:@"DKK %.2f",priceINFloat];
        finalAmount=[NSString stringWithFormat:@"%f",priceINFloat];
        float pointConversion =[[restaurantDic objectForKey:@"points_percent"] floatValue];
        pointConversion=pointConversion/100;
        pointConversion=pointConversion*priceINFloat;
        totalOrderPoints=pointConversion;
        checkOutPoints.text=[NSString stringWithFormat:@"%d",totalOrderPoints];
        checkOutPoints.hidden =YES;
    }
    else
    {
        priceINFloat=[[NSUserDefaults standardUserDefaults] floatForKey:@"grand_total"];
        totalAmount.text =[NSString stringWithFormat:@"DKK %.2f",priceINFloat];
        float C_discount = priceINFloat*customerDiscountInFloat/100;
        priceINFloat = priceINFloat - C_discount;
        totalPrice.text=[NSString stringWithFormat:@"DKK %.2f",priceINFloat];
        finalAmount=[NSString stringWithFormat:@"%f",priceINFloat];
        float pointConversion =[[restaurantDic objectForKey:@"points_percent"] floatValue];
        pointConversion=pointConversion/100;
        pointConversion=pointConversion*priceINFloat;
        totalOrderPoints=pointConversion;
        checkOutPoints.text=[NSString stringWithFormat:@"%d",totalOrderPoints];
        checkOutPoints.hidden =YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)homeButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
    UIApplication *application=nil;
    NSDictionary *dic=nil;
    [cardDefault setValue:@"Home" forKey:@"RootView"];
    [cardDefault setValue:@"Home" forKey:@"Logout"];
    [appDelegate application:application didFinishLaunchingWithOptions:dic];
}

-(IBAction)clickOnSegment:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    if ([segmentedControl selectedSegmentIndex]==0)
    {
        pickupIS=@"delivery";
        deliversView.hidden=NO;
        pickupView.hidden=YES;
    }
    else
    {
        pickupIS=@"pickup";
    }
}

-(IBAction)clickOnCardPayment:(id)sender
{
    [self cardExist];
}

-(IBAction)clickOnPointsPayment:(id)sender
{
    [self checkUserPointAvailability];
}
-(void)checkUserPointAvailability
{
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Checking Points Availability..."]];
    
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    
    NSString *postData=[NSString stringWithFormat:@"grandTotal=%@",grandTotal];
    NSLog(@"%@",postData);
    NSString *urlString=[NSString stringWithFormat:@"/restId/%@/memberId/%@",ciboRestauantID,[cardDefault objectForKey:@"Member"]];
    [helper redeemPoints2:urlString :postData];
}
-(void)redeemPoints2:(NSString *)response
{
    NSLog(@"%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    if ([[dataDic valueForKey:@"RESULT"] isEqualToString:@"SUCCESS"])
    {
        NSString *message=[NSString stringWithFormat:@"Your Remaining points %@ after this checkout.",[dataDic valueForKey:@"pointsLeft"]];
        [[[UIAlertView alloc] initWithTitle:@"Alert !" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil] show];
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"" :1.0];
    }
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithError:@"" :1.0];
        selectedPaymentMethod=0;
        [payByPointsButton setBackgroundImage:[UIImage imageNamed:@"check_btn.png"] forState:UIControlStateNormal];
    }
}

#pragma mark - update Location
-(void)findInternetConnectionName
{
    NSString *ssid = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs)
    {
        NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info[@"SSID"]) {
            ssid = info[@"SSID"];
        }
    }
    //wifiName=ssid;
    //NSLog(@"wifiname=%@",wifiName);
}

-(void)currentLocation
{
    [self findInternetConnectionName];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    if (IS_IOS8)
    {
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
    locationManager.delegate=self;
    [self deviceLocation];
}

- (void)deviceLocation
{
    latitude= locationManager.location.coordinate.latitude;
    longitude=locationManager.location.coordinate.longitude;
    if (latitude<=0)
    {
         latitude=24.4607833;
    }
    if (longitude<=0)
    {
         longitude=54.3807539;
    }
    
    
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:latitude1 longitude:longitude1];
    
    CLLocationDistance distance1 = [locA distanceFromLocation:locB];
    
    distance=distance1;
    
    [locationManager stopUpdatingLocation];
    
}


-(IBAction)clickOnCheckOutButton:(id)sender
{
    if ([self checkCurrentDayandBussinessTimer])
    {
        if (selectedPaymentMethod==CARD)
        {
            if ([orderTypeCheckding isEqualToString:@"OpenOrder"])
            {
                [self currentLocation];
                if (distance<70)
                {
                    
                    if (tipAmount<=0 && tipis==0)
                    {
                        UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:@"$ TIP $" message:@"You can add some tip amount." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] ;
                        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
                        [alert show];
                        return;
                    }
                }
            }
            
            if ([selectedPaymentGateway isEqualToString:@"EPAY"] )
            {
                [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Loading..."];
                [self ePay];
            }
            else if([selectedPaymentGateway isEqualToString:@"PAYPAL"] )
            {
                [self payByPaypal];
            }
            else if([selectedPaymentGateway isEqualToString:@"AXIA"] )
            {
                
            }
            else if([selectedPaymentGateway isEqualToString:@"MERCURY"] )
            {
                //[self sendPaymentByHeartLand];
            }
            else if([selectedPaymentGateway isEqualToString:@"HEARTLAND"] )
            {
                //[self sendPaymentByHeartLand];
                
            }
            else if([selectedPaymentGateway isEqualToString:@"FIRSTDATA"] )
            {
                //[self payByPaypal];
                //[self sendFirstDataWithApplyPay];
                //[self initIPay88];
                //[self payByPaypal];
            }
            else if([selectedPaymentGateway isEqualToString:@"STRIPE"] )
            {
                [self initStripeSettings];
            }
            else
            {
                //[self sendPayment];
            }
        }
        else if (selectedPaymentMethod==PAY_BY_POINTS)
        {
            if ([orderTypeCheckding isEqualToString:@"OpenOrder"])
            {
                [self updateSendOrderRequst];
            }
            else
            {
                [self orderWithDefaultAddrss];
            }
        }
        else if (selectedPaymentMethod==CASH_ON_DELIVERY)
        {
            if ([orderTypeCheckding isEqualToString:@"OpenOrder"])
            {
                [self updateSendOrderRequst];
            }
            else
            {
                [self orderWithDefaultAddrss];
            }
        }
        else if (selectedPaymentMethod==PAY_BY_PAYPAL)
        {
            [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"We will coming soon with Paypal." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil,nil] show];
        }
        else if (selectedPaymentMethod==PAY_BY_APPLYPAY)
        {
            [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"We will coming soon with Apply Pay." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil,nil] show];
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"Please Choose payment method before checkout." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil,nil] show];
        }
    }
    else
    {
        if(businessHour.count>0)
        {
            if (fromTime>0)
            {
                [[[UIAlertView alloc] initWithTitle:@"Alert !" message:[NSString stringWithFormat:@"Please checkout in %d:00 to %d:00.",fromTime,toTime] delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil,nil] show];
            }
            else
            {
                [[[UIAlertView alloc] initWithTitle:@"Alert !" message:[NSString stringWithFormat:@"Now Restaurant closed."] delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil,nil] show];
            }
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"Alert !" message:[NSString stringWithFormat:@"Now Restaurant closed."] delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil,nil] show];
        }
    }
}

-(IBAction)clickOnPayOnDeleivery:(id)sender
{
    selectedPaymentMethod=2;
}

-(IBAction)clickOnCheckOutSelectionButton:(UIButton *)sender
{
    [payCraditCardButton setBackgroundImage:[UIImage imageNamed:@"check_btn.png"] forState:UIControlStateNormal];
    [paypalChoosedButton setBackgroundImage:[UIImage imageNamed:@"check_btn.png"] forState:UIControlStateNormal];
    [payOnDelButton setBackgroundImage:[UIImage imageNamed:@"check_btn.png"] forState:UIControlStateNormal];
    [payByPointsButton setBackgroundImage:[UIImage imageNamed:@"check_btn.png"] forState:UIControlStateNormal];
    [payApplyPayButton setBackgroundImage:[UIImage imageNamed:@"check_btn.png"] forState:UIControlStateNormal];
    if ([orderTypeCheckding isEqualToString:@"OpenOrder"])
    {
        if (tipAmount<=0 && tipis==0)
        {
            UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:@"DKK 'TIP' DKK" message:@"You can add some tip amount." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] ;
            [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
            [alert show];
        }
    }
    
    if(sender.tag==1001)
    {
        [payCraditCardButton setBackgroundImage:[UIImage imageNamed:@"optional modifier selected box.png"] forState:UIControlStateNormal];
        selectedPaymentMethod=1;
        selectedPaymentGateway=@"EPAY";
        return ;
    }
    else
    {
        [payCraditCardButton setBackgroundImage:[UIImage imageNamed:@"check_btn.png"] forState:UIControlStateNormal];
        selectedPaymentMethod=nil;
    }
    if (sender.tag==1002)
    {
        [payByPointsButton setBackgroundImage:[UIImage imageNamed:@"optional modifier selected box.png"] forState:UIControlStateNormal];
        int userPoints=[[cardDefault valueForKey:@"points"] intValue];
        int UserRemainingPoints=userPoints-totalOrderPoints;
        if (UserRemainingPoints>0)
        {
            [self checkUserPointAvailability];
            selectedPaymentMethod=4;
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"You don't have enough point for this checkout." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil] show];
            ///[self checkUserPointAvailability];
            //[self checkOutByStripe];
        }
        return ;
    }
    else
    {
        selectedPaymentMethod=nil;
        [payByPointsButton setBackgroundImage:[UIImage imageNamed:@"check_btn.png"] forState:UIControlStateNormal];
    }
    if (sender.tag==1003)
    {
        selectedPaymentMethod=2;
        [payOnDelButton setBackgroundImage:[UIImage imageNamed:@"optional modifier selected box.png"] forState:UIControlStateNormal];
        return ;
    }
    else
    {
        selectedPaymentMethod=nil;
        [payOnDelButton setBackgroundImage:[UIImage imageNamed:@"check_btn.png"] forState:UIControlStateNormal];
    }
    if (sender.tag==1004)
    {
        [paypalChoosedButton setBackgroundImage:[UIImage imageNamed:@"optional modifier selected box.png"] forState:UIControlStateNormal];
        BOOL paypal_isHave=YES;
        for (int i=0; i<gatewayData.count; i++)
        {
            if ([[NSString stringWithFormat:@"%@",[[gatewayData objectAtIndex:i] objectForKey:@"getway_name" ]] isEqualToString:@"paypal"])
            {
                if ([[[gatewayData objectAtIndex:i] objectForKey:@"status"] isEqualToString:@"1"])
                {
                    paypal_isHave=YES;
                }
                i=50000;
            }
        }
        if (paypal_isHave==YES)
        {
            selectedPaymentGateway=@"PAYPAL";
            selectedPaymentMethod=PAY_BY_PAYPAL;
            [self initPaypal];
            return ;
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"Currently paypal is not available. please try after some days." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
    }
    else
    {
        selectedPaymentMethod=nil;
        [paypalChoosedButton setBackgroundImage:[UIImage imageNamed:@"check_btn.png"] forState:UIControlStateNormal];
    }
    if (sender.tag==1005)
    {
        [payApplyPayButton setBackgroundImage:[UIImage imageNamed:@"optional modifier selected box.png"] forState:UIControlStateNormal];
        selectedPaymentMethod=1;
        selectedPaymentGateway=@"FIRSTDATA";//@"AXIA";
        //[self  initFirstDataWithApplyPay];
        return ;
    }
    else
    {
        selectedPaymentMethod=nil;
        [payApplyPayButton setBackgroundImage:[UIImage imageNamed:@"check_btn.png"] forState:UIControlStateNormal];
    }
}

-(void)cardExist
{
    selectedPaymentMethod=1;
    selectedPaymentGateway=@"STRIPE";
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:[MyCustomeClass languageSelectedStringForKey:@"Add Card"]])
    {
        if ([orderTypeCheckding isEqualToString:@"OpenOrder"])
        {
            AddCardViewController *addCard=[[AddCardViewController alloc] initWithNibName:@"AddCardViewController" bundle:nil];
            [self presentViewController:addCard animated:true completion:nil];
        }
        else
        {
            AddCardViewController *addCard=[[AddCardViewController alloc] initWithNibName:@"AddCardViewController" bundle:nil];
            [self.navigationController pushViewController:addCard animated:true];
        }
    }
    else if ([title isEqualToString:[MyCustomeClass languageSelectedStringForKey:@"Edit Card"]])
    {
        AddCardViewController *addCard=[[AddCardViewController alloc] initWithNibName:@"AddCardViewController" bundle:nil];
        [addCard setEditString:@"Edit"];
        [self.navigationController pushViewController:addCard animated:true];
    }
    else if ([title isEqualToString:[MyCustomeClass languageSelectedStringForKey:@"No"]])
    {
        tipis=1;
    }
    else if ([title isEqualToString:[MyCustomeClass languageSelectedStringForKey:@"Yes"]])
    {
        UITextField *username = [alertView textFieldAtIndex:0];
        tipAmount = [username.text floatValue];
        tipis=2;
        float finalprice=0.0;
        
        if (couponAmount>0)
        {
            finalprice = (priceINFloat-couponAmount) + tipAmount;
        }
        else
        {
            finalprice =(priceINFloat+tipAmount);
        }
        totalAmount.text =[NSString stringWithFormat:@"$ %.2f",priceINFloat];
        
        totalPrice.text=[NSString stringWithFormat:@"$ %.2f",finalprice];
        finalAmount= [NSString stringWithFormat:@"%f",finalprice];
        grandTotal = [NSString stringWithFormat:@"%.2f",finalprice];
        [tipShowButton setTitle:[NSString stringWithFormat:@" Tip: %.2f +",tipAmount] forState:UIControlStateNormal];
        tipShowButton.hidden=NO;
    }
}


#pragma mark - send order on back office
-(void)paymentMethodListRequest
{
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    helper.delegate=self;
    NSString *postData=[NSString stringWithFormat:@"%@",ciboRestauantID];

    [helper paymentMethodList:postData];
}

-(void)paymentMethodList:(NSString *)response
{
    NSLog(@"%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    paymentMethodDic=[dataDic objectForKey:@"pay_data"];
    NSLog(@"paymentMethodDic: %@",paymentMethodDic);
}

-(void)orderID
{
    NSTimeInterval timeInMiliseconds = [[NSDate date] timeIntervalSince1970];
    long int orderIDInInteger=(int )timeInMiliseconds;
    //grandTotal=[NSString stringWithFormat:@"%.2f",[grandTotal floatValue]+[self addTaxWithDish:10.0 price:[grandTotal floatValue]]];
    if (orderId.length<=0)
    {
        orderId=[NSString stringWithFormat:@"17%@",[NSString stringWithFormat:@"%ld",orderIDInInteger]];
    }
}
-(void)updateSendOrderRequst
{
    NSString *order_statue=@"";
    NSString *type=@"";
    if ([orderTypeCheckding isEqualToString:@"OpenOrder"])
    {
        order_statue=@"Completed";
        type=@"closed";
    }
    else
    {
        order_statue=@"New";
        type=@"open";
        
    }
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Order cleaning..."]];
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postString=[NSString stringWithFormat:@"orders/updateOrder/restId/%@/orderId/%@",ciboRestauantID,orderId];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"HH:mm:ss"];
    NSString *time = [formatter1 stringFromDate:[NSDate date]];
    
    NSString *PostData=[NSString stringWithFormat:@"order_id=%@&member_id=%@&firstname=%@&lastname=%@&email=%@&street=%@&delivery_city=%@&delivery_state=%@&delivery_time=%@&delivery_country=%@&delivery_zipcode=%@&phone=%@&mobile=%@&total=%@&general_discount=%@&promo_discount=%@&delivery_date=%@&comments=%@&time_for_delivery=%@&distance=%@&payment_method=%d&paid=%@&order_status=%@&order_date=%@&order_time=%@&type=%@&points=%@&service_tax=%.2f&vat=%.2f&local_tax=%.2f&other_tax=%.2f&grand_total=%.2f&delivery_option=%@&street=%@&tax=%.2f&is_online=%@&payment_status=%@&web=%@&restId=%@&order_location=mweb&transaction_id=%@&coupon_id=%@&savings=%.2f&tip=%.2f&coustomer_discount=%2.f",orderId,[cardDefault objectForKey:@"Member"],[cardDefault objectForKey:@"firstname"],[cardDefault objectForKey:@"lastname"],[cardDefault objectForKey:@"Email"],[cardDefault objectForKey:@"address"],[cardDefault objectForKey:@"city"],[cardDefault objectForKey:@"state"],time,[cardDefault objectForKey:@"country"],[cardDefault objectForKey:@"zipcode"],[cardDefault objectForKey:@"Phone"],[cardDefault objectForKey:@"mobile"],subTotal,[cardDefault objectForKey:@""], @"0", date,@"", time, @"0",selectedPaymentMethod,@"0",order_statue,date,time,type,checkOutPoints.text,totalSevericeTax,totalVatTax,totalLocalTax,totalOtherTax,[grandTotal floatValue]-savings,pickupIS,@"street",totalSevericeTax+totalVatTax+totalLocalTax+totalOtherTax,@"1",@"1",@"web",ciboRestauantID,transectionId,couponID,savings,tipAmount,customerDiscountInFloat];
    
    NSLog(@"%@",PostData);
    [helper updateSendOrder:postString :PostData];
}

-(void)updateSendOrder:(NSString *)response
{
    NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSLog(@"%@",dataDic);
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCESS"]|| [[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCCESS"])
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKeyPath:@"OrderArray"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Order successfully sent." :2.0];
        [self dismissViewControllerAnimated:true completion:nil];
        if ([orderTypeCheckding isEqualToString:@"OpenOrder"])
        {
            WebServiceHelper *helper = [[WebServiceHelper alloc] init];
            helper.delegate=self;
            [helper closedMyOrder:[NSString stringWithFormat:@"orders/notificationToPos/order_status/Completed/order_id/%@/restId/%@",orderId,ciboRestauantID]];
        }
    }
}

-(void)orderWithDefaultAddrss
{
    orderListCounter=0;
    
    // NSLog(@"%@", [NSString stringWithFormat:@"%@",orderId]);
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:[MyCustomeClass languageSelectedStringForKey:@"Order cleaning..."]];
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    
    NSString *postString=[NSString stringWithFormat:@"orders/sendOrder/restId/%@/",ciboRestauantID];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"HH:mm:ss"];
    NSString *time = [formatter1 stringFromDate:[NSDate date]];
    
    
    NSString *PostData=[NSString stringWithFormat:@"order_id=%@&member_id=%@&firstname=%@&lastname=%@&email=%@&street=%@&delivery_city=%@&delivery_state=%@&delivery_time=%@&delivery_country=%@&delivery_zipcode=%@&phone=%@&mobile=%@&total=%@&general_discount=%@&promo_discount=%@&delivery_date=%@&comments=%@&time_for_delivery=%@&distance=%@&payment_method=%d&paid=%@&order_status=%@&order_date=%@&order_time=%@&type=%@&points=%@&service_tax=%.2f&vat=%.2f&local_tax=%.2f&other_tax=%.2f&grand_total=%.2f&delivery_option=%@&street=%@&tax=%.2f&is_online=%@&payment_status=%@&web=%@&restId=%@&order_location=mweb&transaction_id=%@&coupon_id=%@&savings=%.2f&tip=%.2f&coustomer_discount=%2.f",orderId,[cardDefault objectForKey:@"Member"],[cardDefault objectForKey:@"firstname"],[cardDefault objectForKey:@"lastname"],[cardDefault objectForKey:@"Email"],[cardDefault objectForKey:@"address"],[cardDefault objectForKey:@"city"],[cardDefault objectForKey:@"state"],time,[cardDefault objectForKey:@"country"],[cardDefault objectForKey:@"zipcode"],[cardDefault objectForKey:@"Phone"],[cardDefault objectForKey:@"mobile"],subTotal,[cardDefault objectForKey:@""], @"0", date,@"", time, @"Distance",selectedPaymentMethod,@"0",@"New",date,time,@"open",checkOutPoints.text,totalSevericeTax,totalVatTax,totalLocalTax,totalOtherTax,[grandTotal floatValue]-savings,pickupIS,@"street",totalSevericeTax+totalVatTax+totalLocalTax+totalOtherTax,@"1",@"1",@"web",ciboRestauantID,transectionId,couponID,savings,tipAmount,customerDiscountInFloat];
    
    NSLog(@"%@",PostData);
    [helper sendingOrder:postString :PostData];
}

-(void)orderlistSentByForLoop:(NSMutableDictionary *)orderDictionary
{
    NSLog(@"%@",orderDictionary);
    // NSString *forceModifierID=@"";
    
    NSArray *fmLocalArray=[orderDictionary objectForKey:@"ForceModifier"];
    NSString *fmID=@"";
    NSString *omID=@"";
    
    for(int k=0; k<fmLocalArray.count;k++)
    {
        fmID=[fmID stringByAppendingString:[NSString stringWithFormat:@",%@",[[fmLocalArray objectAtIndex:k] objectForKey:@"fm_item_id"]]];
    }
    if ([fmID hasPrefix:@","])
    {
        fmID = [fmID substringFromIndex:1];
    }
    
    NSArray *omLocalArray=[orderDictionary objectForKey:@"OptionModifier"];
    for(int k=0; k<omLocalArray.count;k++)
    {
        omID=[omID stringByAppendingString:[NSString stringWithFormat:@",%@",[[omLocalArray objectAtIndex:k]objectForKey:@"om_item_id"]]];
        
    }
    if ([omID hasPrefix:@","])
    {
        omID = [omID substringFromIndex:1];
    }
    float vatTax=0.0;
    float otherTax=0.0;
    float serviceTax=0.0,
    singlePrice=0.0;
    float totaltax=0.0;
    
    float localTax=0.0;
    float forceModifierPrice=0.0;
    float optionModifierPrice=0.0;
    float subTtotalFloat=0.0;
    float grandTotalFloat = 0.0;
    
    int count =[[orderDictionary objectForKey:@"count" ] intValue];
    
    if(taxArray.count>0)
    {
        // modifier calculation
        singlePrice = [[orderDictionary objectForKey:@"price" ] floatValue];
        if ([orderTypeCheckding isEqualToString:@"OpenOrder"])
        {
        }
        else
        {
            NSArray *fmLocalArray=[orderDictionary objectForKey:@"ForceModifier"];
            for(int k=0; k<fmLocalArray.count;k++)
            {
                forceModifierPrice=forceModifierPrice+[[[fmLocalArray objectAtIndex:k] objectForKey:@"price"] floatValue];
            }
            NSArray *omLocalArray=[orderDictionary objectForKey:@"OptionModifier"];
            
            for(int k=0; k<omLocalArray.count;k++)
            {
                optionModifierPrice=optionModifierPrice+[[[omLocalArray objectAtIndex:k] objectForKey:@"price"] floatValue];
            }
        }
        
        singlePrice =singlePrice + forceModifierPrice+optionModifierPrice;
        subTtotalFloat = singlePrice;
        
        // service tax...
        if([NSString stringWithFormat:@"%@",[orderDictionary objectForKey:@"is_servicetax" ]].length>0)
        {
            serviceTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"service_tax" ] floatValue] price:singlePrice];
        }
        
        singlePrice=singlePrice+serviceTax;
        
        // happy hour calculation ....
        subTtotalFloat = subTtotalFloat - count*[[orderDictionary objectForKey:@"happyHourAmount" ] floatValue];
        subTtotalFloat = subTtotalFloat - (grandTotalFloat * [[orderDictionary objectForKey:@"happyHourDiscount" ] floatValue]/100);
        
        // all tax ....
        if([NSString stringWithFormat:@"%@",[orderDictionary objectForKey:@"is_vat" ]].length>0)
        {
            vatTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"vat" ] floatValue] price:singlePrice];
        }
        if([NSString stringWithFormat:@"%@",[orderDictionary objectForKey:@"is_othertax" ]].length>0)
        {
            otherTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"other_tax" ] floatValue] price:singlePrice];
        }
        if([NSString stringWithFormat:@"%@",[orderDictionary objectForKey:@"is_localtax" ]].length>0)
        {
            localTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"local_tax" ] floatValue] price:singlePrice];
        }
    }
    totaltax=totaltax+vatTax+otherTax+localTax;
    
    singlePrice=singlePrice + vatTax+otherTax+localTax;
    
    grandTotalFloat= singlePrice;
    
    //happy hour
    int displayCount =0;
    count =[[orderDictionary objectForKey:@"count"] intValue];
    displayCount= displayCount + count*[[orderDictionary objectForKey:@"happyHourGet"] intValue];//
    if ([[orderDictionary objectForKey:@"happyHourGet"] intValue]<=0)
    {
        displayCount = displayCount +count;
    }
    
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    NSString *postString=[NSString stringWithFormat:@"orders/insertOrderProduct/restId/%@/",ciboRestauantID];
    
    NSString *PostData=[NSString stringWithFormat:@"productId=%@&order_id=%@&qty=%d&sizeId=%@&price=%.2f&baseId=%@&toppingIdx1=%@&toppingIdx2=%d&fmId=%@&omId=%@&subTotal=%0.2f&type=%@&points=%@&service_tax=%.2f&local_tax=%.2f&other_tax=%.2f&vat=%.2f&tax_total=%0.2f&size_value=%@&happy_hour_id=%@&offer_amount=%@",[orderDictionary objectForKey:@"id"],orderId,displayCount,[orderDictionary objectForKey:@"pizza_size_id"],subTtotalFloat,[orderDictionary objectForKey:@"pizza_base_id"],[orderDictionary objectForKey:@"pizza_topping_id"],0,fmID,omID,grandTotalFloat,[orderDictionary objectForKey:@"type"],[orderDictionary objectForKey:@"points"],serviceTax,localTax,otherTax,vatTax,totaltax+serviceTax,[orderDictionary objectForKey:@"size"],[orderDictionary objectForKey:@"happy_hour_id"],[orderDictionary objectForKey:@"happyHourAmount" ]];
    
    NSLog(@"%@",PostData);
    [helper sentOrderListToTheServer:postString :PostData];
    //Orders /insertOrderProduct/
}

#pragma mark - Webservics Response classes
-(void)sendingOrder:(NSString *)response
{
    NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSLog(@"%@",dataDic);
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCCESS"] || [[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCESS"])
    {
        [self orderlistSentByForLoop:[selectedOrderArray objectAtIndex:orderListCounter]];
    }
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithError:@"Please try again" :2.0];
    }
}

-(void)sentOrderListToTheServer:(NSString *)response
{
    NSLog(@"responseresponse==%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    NSLog(@"%@",dataDic);
    if ([[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCESS"] || [[dataDic objectForKey:@"RESULT"] isEqualToString:@"SUCCESS"])
    {
        orderListCounter++;
        if (orderListCounter<selectedOrderArray.count)
        {
            [self orderlistSentByForLoop:[selectedOrderArray objectAtIndex:orderListCounter]];
        }
        else
        {
            //[selectedOrderArray removeAllObjects];
            [[NSUserDefaults standardUserDefaults] setValue:@"" forKeyPath:@"OrderArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [MyCustomeClass SVProgressMessageDismissWithSuccess:@"Order successfully sent." :2.0];//naveen
            [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"WalletOrderArray"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [welletArray removeAllObjects];
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    else
    {
        [MyCustomeClass SVProgressMessageDismissWithError:@"Please remove all order and select onece again." :2.0];
    }
}

-(void)gateWayCradintialAccessRequest
{
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    helper.delegate=self;
     NSString *postData=[NSString stringWithFormat:@"%@",ciboRestauantID];
    [helper gateWayCradintialAccess:postData];
}

-(void)gateWayCradintialAccess:(NSString *)response
{
    NSLog(@"%@",response);
    NSMutableDictionary *dataDic=[MyCustomeClass jsonDictionary:response];
    if ([[dataDic valueForKey:@"RESULT"] isEqualToString:@"FAIl"])
        return;
    else
    {
        gatewayData=[dataDic objectForKey:@"payment"];
        
        /// stripe
        [self cardExist];
        /// init AXIA
        //[self paymentGatewaySettings];
        /// paypal init ///
        //[self initPaypal];
        
        /// mercury init ///
        //[self initMercury];
        
        /// heartLand init ///
        // [self initHeartLand];
    }
}

-(void)gettingFail:(NSString *)error
{
    [MyCustomeClass SVProgressMessageDismissWithError:@"Fail Try again." :1.0];
}


-(float)addTaxWithDish:(float )tax price:(float) price
{
    float price1=(price*tax)/100;
    return price1;
}

-(void)priceCalulation
{
    //subTotal,*grandTotal;
    float subTtotalFloat=0.0;
    float grandTotalFloat=0.0;
    totalOtherTax=0.0;
    totalLocalTax=0.0;
    totalSevericeTax=0.0;
    totalVatTax=0.0;
    if (welletArray.count>0)
    {
        
    }
    else
    {
        for (int i=0; i<[selectedOrderArray count]; i++)
        {
            float singlePrice=0;
            float vatTax=0.0;
            float otherTax=0.0;
            float serviceTax=0.0;
            float localTax=0.0;
            float forceModifierPrice=0.0;
            float optionModifierPrice=0.0;
            savings = 0;
            
            singlePrice = [[[selectedOrderArray objectAtIndex:i] objectForKey:@"price" ] floatValue];
            
            if(taxArray.count>0)
            {
                // modifier calculation
                
                int count =[[[selectedOrderArray objectAtIndex:i] objectForKey:@"count"] intValue];
                
                if ([orderTypeCheckding isEqualToString:@"OpenOrder"])
                {
                    
                }
                else
                {
                    NSArray *fmLocalArray=[[selectedOrderArray objectAtIndex:i] objectForKey:@"ForceModifier"];
                    for(int k=0; k<fmLocalArray.count;k++)
                    {
                        forceModifierPrice=forceModifierPrice+[[[fmLocalArray objectAtIndex:k] objectForKey:@"price"] floatValue];
                    }
                    NSArray *omLocalArray=[[selectedOrderArray objectAtIndex:i] objectForKey:@"OptionModifier"];
                    
                    for(int k=0; k<omLocalArray.count;k++)
                    {
                        optionModifierPrice=optionModifierPrice+[[[omLocalArray objectAtIndex:k] objectForKey:@"price"] floatValue];
                    }
                }
                
                singlePrice = singlePrice + forceModifierPrice+optionModifierPrice;
                
                // service tax...
                if([NSString stringWithFormat:@"%@",[[selectedOrderArray objectAtIndex:i] objectForKey:@"is_servicetax" ]].length>0 && ![[NSString stringWithFormat:@"%@",[[selectedOrderArray objectAtIndex:i] objectForKey:@"is_servicetax" ]] isEqualToString:@"0"])
                {
                    serviceTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"service_tax" ] floatValue] price:singlePrice];
                    totalSevericeTax =totalSevericeTax+serviceTax;
                }
                
                singlePrice=singlePrice+serviceTax;
                
                
                // all tax ....
                if([NSString stringWithFormat:@"%@",[[selectedOrderArray objectAtIndex:i] objectForKey:@"is_vat" ]].length>0 && ![[NSString stringWithFormat:@"%@",[[selectedOrderArray objectAtIndex:i] objectForKey:@"is_vat" ]] isEqualToString:@"0"])
                {
                    vatTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"vat" ] floatValue] price:singlePrice];
                    totalVatTax=totalVatTax+vatTax;
                }
                if([NSString stringWithFormat:@"%@",[[selectedOrderArray objectAtIndex:i] objectForKey:@"is_othertax" ]].length>0 && ![[NSString stringWithFormat:@"%@",[[selectedOrderArray objectAtIndex:i] objectForKey:@"is_othertax" ]] isEqualToString:@"0"])
                {
                    otherTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"other_tax" ] floatValue] price:singlePrice];
                    totalOtherTax=totalOtherTax+otherTax;
                }
                if([NSString stringWithFormat:@"%@",[[selectedOrderArray objectAtIndex:i] objectForKey:@"is_localtax" ]].length>0 && ![[NSString stringWithFormat:@"%@",[[selectedOrderArray objectAtIndex:i] objectForKey:@"is_localtax" ]] isEqualToString:@"0"])
                {
                    localTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"local_tax" ] floatValue] price:singlePrice];
                    totalLocalTax=totalLocalTax+localTax;
                }
                
                singlePrice=singlePrice+vatTax+otherTax+localTax;
                
                
                // happy hour calculation ....
                singlePrice = singlePrice - count*[[[selectedOrderArray objectAtIndex:i] objectForKey:@"happyHourAmount" ] floatValue];
                savings = savings+count*[[[selectedOrderArray objectAtIndex:i] objectForKey:@"happyHourAmount" ] floatValue];
                
                singlePrice = singlePrice - (grandTotalFloat * [[[selectedOrderArray objectAtIndex:i] objectForKey:@"happyHourDiscount" ] floatValue]/100);
                
                savings = savings+(grandTotalFloat * [[[selectedOrderArray objectAtIndex:i] objectForKey:@"happyHourDiscount" ] floatValue]/100);
                
                subTtotalFloat =subTtotalFloat+ singlePrice;
            }
            grandTotalFloat= grandTotalFloat+singlePrice;
        }
        
        savings=savings+grandTotalFloat*customerDiscountInFloat/100;
        grandTotalFloat = grandTotalFloat - grandTotalFloat*customerDiscountInFloat/100;
        subTotal=[NSString stringWithFormat:@"%.2f",subTtotalFloat];
        grandTotal=[NSString stringWithFormat:@"%.2f",grandTotalFloat];
    }
}

-(void)businessHourRequest
{
    WebServiceHelper *helper=[[WebServiceHelper alloc] init];
    [helper setDelegate:self];
    
    NSString *postData=[NSString stringWithFormat:@"%@",ciboRestauantID];
    NSLog(@"%@",postData);
    [helper businessHourForRestaurant:postData];
    
}

-(void)businessHourForRestaurant:(NSString *)response
{
    NSLog(@"%@",response);
    NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
    dataDic=[MyCustomeClass jsonDictionary:response];
    businessHour=[dataDic objectForKey:@"businessInfo"];
}

-(BOOL)checkCurrentDayandBussinessTimer
{
    NSString *currentDay=[MyCustomeClass currentDay:[NSDate date]];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"HH:mm:ss"];
    NSString *time = [formatter1 stringFromDate:[NSDate date]];
    NSArray *currentArray=[MyCustomeClass seprateStringFromStringUsingArrray:time :@":"];
    int currentHour=[[NSString stringWithFormat:@"%@",[currentArray objectAtIndex:0]] intValue];
    
    for (int i=0; i < businessHour.count; i++)
    {
        if ([currentDay isEqualToString:[NSString stringWithFormat:@"%@",[[businessHour objectAtIndex:i ] objectForKey:@"day_name"]]])
        {
            fromTime = [[NSString stringWithFormat:@"%@",[[businessHour objectAtIndex:i] objectForKey:@"from"]] intValue];
            toTime = [[NSString stringWithFormat:@"%@",[[businessHour objectAtIndex:i] objectForKey:@"to"]] intValue];
            if (fromTime<=currentHour && toTime> currentHour)
            {
                return YES;
                break;
            }
            else
            {
                //return NO;
            }
        }
        else
        {
            //return NO;
        }
    }
    return NO;
}


#pragma mark - payment gateway AXIA
-(void)paymentGatewaySettings
{
    //Constants *shareManager = [Constants sharedManager];
    /*
     * This are the required information, which need to initialize
     * Before doing any transactions
     */
    /* shareManager.isProduction = false;
     if (gatewayData.count>0)
     {
     for (int i=0; i<gatewayData.count; i++)
     {
     if ([[NSString stringWithFormat:@"%@",[[gatewayData objectAtIndex:i] objectForKey:@"getway_name" ]] isEqualToString:@"axiaepay"])
     {
     NSString *soucreKey=[[gatewayData objectAtIndex:i] objectForKey:@"username" ];
     NSString *pinKey=[[gatewayData objectAtIndex:i] objectForKey:@"password" ];
     shareManager.sourceKey = soucreKey;
     shareManager.pinNum = pinKey;
     i=50000;
     }
     }
     }*/
    /*
     * Delegate all the textfield to use the textfield call back methods
     */
    /*
     * Initialize the credit card payment, and sets delegate to self so the call back methods will get call
     */
    /* _ccPayment = [[CreditCardPayment alloc] init];
     _ccPayment.delegate = self;
     
     
     [_ccPayment processCCPayment];*/
    
    
    /*
     * Sets the scroll view content size to allow user to scroll the fields up and down
     */
}

//-(void)sendPayment
//{
//    UIAlertView *paymentAlert;
//    /*
//     * Check to see if there is internet connection before processin any payments
//     */
//    //if([ueConnection isConnected])
//    {
//        /*
//         * Check to make sure all the required fields are filled in
//         * In addition, use our credit card verify method and expiration date verify method
//         * To make sure the credit card number and expiration date are valid
//         */
//        //[self checkCreditCard];
//
//       /* if(userName.length==0)
//        {
//            paymentAlert = [[UIAlertView alloc]initWithTitle:@"Alert !" message:@"Please enter credit card holder's name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Edit Card", nil];
//            [paymentAlert show];
//        }
//
//        else if(cardNumber.length==0 || ![_ccPayment verifyCreditCard:cardNumber])
//        {
//            paymentAlert = [[UIAlertView alloc]initWithTitle:@"Alert !" message:@"Invalid credit card number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Edit Card", nil];
//            [paymentAlert show];
//        }
//
//        else if(exp_Date.length==0 || [_ccPayment verifyExpDate:exp_Date])
//        {
//            paymentAlert = [[UIAlertView alloc]initWithTitle:@"Expiration date" message:@"Invalid credit card expiration date" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Edit Card", nil];
//            [paymentAlert show];
//        }
//
//        else if(cvvNumber.length==0 || cvvNumber.length < 3)
//        {
//            paymentAlert = [[UIAlertView alloc]initWithTitle:@"CCV" message:@"Invalid CVV number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Edit Card", nil];
//            [paymentAlert show];
//        }
//
//        else if(address.length==0)
//        {
//            paymentAlert = [[UIAlertView alloc]initWithTitle:@"Field empty" message:@"Please enter a street address" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [paymentAlert show];
//        }*/
//        /*else if(zipVerif.text.length==0 || zipVerif.text.length < 5 || zipVerif.text.length > 5)
//         {
//         paymentAlert = [[UIAlertView alloc]initWithTitle:@"Zip verificaiton field" message:@"Invalid zip code" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//         [paymentAlert show];
//         }*/
//       /* else if(finalAmount.length==0)
//        {
//            paymentAlert = [[UIAlertView alloc]initWithTitle:@"Charge amount field" message:@"Need to enter a charge amount" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [paymentAlert show];
//        }
//        else/*
//        {   /*
//             * Before we call the process payment method,
//             * We need to set the required values in credit card payment class
//             */
//            /*[MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Checking out..."];
//
//            _ccPayment.creditCardHolderName = userName;
//            _ccPayment.creditCardNumber = cardNumber;
//            _ccPayment.creditCardExpDate = exp_Date;
//            _ccPayment.creditCardCVV = cvvNumber;
//            _ccPayment.creditCardAvsStreet = address;
//            _ccPayment.creditCardAvsZip = [cardDefault valueForKey:@"zipcode"];
//            _ccPayment.creditCardChargeAmount = finalAmount;
//            */
//            /*
//             *The invoice number is an option field
//             */
//            /*_ccPayment.invoiceNumber = @"1";
//
//            [_ccPayment processCCPayment];*/
//        }
//    }
//
//    /*else
//    {
//
//
//        paymentAlert = [[UIAlertView alloc]initWithTitle:@"No connection" message:@"Please connect to the internet!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//
//        [paymentAlert show];
//    }*/
//}

//-(void)finishProcessingPayment :(uesoapTransactionResponse *)response
//{
//    [MyCustomeClass SVProgressMessageDismissWithSuccess:@"" :0.1];
//    /*
//     * Use an alert to display the payment result status
//     */
//    NSLog(@"%@",response.Result);
//    NSLog(@"%@",response);
//    if ([response.Result isEqualToString:@"Error"])
//    {
//        UIAlertView *paymentResult = [[UIAlertView alloc]initWithTitle:@"Payment status" message:@"Please reset your card." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Edit Card", nil];
//        [paymentResult show];
//        return;
//    }
//
//    UIAlertView *paymentResult = [[UIAlertView alloc]initWithTitle:@"Payment status" message:response.Result delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//    transectionId=[NSString stringWithFormat:@"%d",response.RefNum];
//    if ([orderTypeCheckding isEqualToString:@"OpenOrder"])
//    {
//        [self updateSendOrderRequst];
//    }
//    else
//    {
//        [self orderWithDefaultAddrss];
//    }
//    [paymentResult show];
//
//}
//- (BOOL)checkCreditCard:(NSString *)cardNumber1
//{
//    CreditCardPayment *ccPayment = [[CreditCardPayment alloc]init];
//
//    if([ccPayment verifyCreditCard:cardNumber1])
//    {
//        NSLog(@"credit card is valid");
//        return true;
//    }
//
//    else
//    {
//        NSLog(@"Credit card is invalid");
//        return false;
//    }
//}
//-(BOOL)checkExpDate:(NSString *)expDate1
//{
//    CreditCardPayment *ccPayment = [[CreditCardPayment alloc]init];
//    if([ccPayment verifyExpDate:expDate1])
//    {
//        NSLog(@"Expiration date is valid");
//        return true;
//    }
//    else
//    {
//        NSLog(@"Expiration date is invalid");
//        return false;
//    }
//}



#pragma mark - ePay Payment Getway

-(void)ePay
{
    [self initPayment];
}

- (void)initPayment
{
    
    if (gatewayData.count>0)
    {
        for (int i=0; i<gatewayData.count; i++)
        {
            if ([[NSString stringWithFormat:@"%@",[[gatewayData objectAtIndex:i] objectForKey:@"getway_name" ]] isEqualToString:@"epay"])
            {
                [epaylib.parameters addObject:[ePayParameter key:@"merchantnumber" value:[[gatewayData objectAtIndex:i] objectForKey:@"username" ]]];//8013990
                //http://tech.epay.dk/en/specification#258
                i=50000;
            }
        }
    }
    
    // Declare your unique OrderId
    //orderId = [NSString stringWithFormat:@"%f", [NSDate timeIntervalSinceReferenceDate]];
    
    // Init the ePay Lib with parameters and the view to add it to.
    epaylib = [[ePayLib alloc] initWithView:self.view];
    
    // Add parameters to the array//8013990
    [epaylib.parameters addObject:[ePayParameter key:@"currency" value:restaurantCurrency]];                    //http://tech.epay.dk/en/specification#259
    NSLog(@"%d",[[NSString stringWithFormat:@"%@",grandTotal] intValue]);
    [epaylib.parameters addObject:[ePayParameter key:@"amount" value:[NSString stringWithFormat:@"%d00",[[NSString stringWithFormat:@"%@",grandTotal] intValue]]]];                      //http://tech.epay.dk/en/specification#260
    [epaylib.parameters addObject:[ePayParameter key:@"orderid" value:orderId]];                    //http://tech.epay.dk/en/specification#261
    //[parameters addObject:[KeyValue initKey:@"windowid" value:@"1"]];                             //http://tech.epay.dk/en/specification#262
    [epaylib.parameters addObject:[ePayParameter key:@"paymentcollection" value:@"0"]];             //http://tech.epay.dk/en/specification#263
    [epaylib.parameters addObject:[ePayParameter key:@"lockpaymentcollection" value:@"0"]];         //http://tech.epay.dk/en/specification#264
    //[parameters addObject:[KeyValue initKey:@"paymenttype" value:@"1,2,3"]];                      //http://tech.epay.dk/en/specification#265
    [epaylib.parameters addObject:[ePayParameter key:@"language" value:@"0"]];                      //http://tech.epay.dk/en/specification#266
    [epaylib.parameters addObject:[ePayParameter key:@"encoding" value:@"UTF-8"]];                  //http://tech.epay.dk/en/specification#267
    //[parameters addObject:[KeyValue initKey:@"mobilecssurl" value:@""]];                          //http://tech.epay.dk/en/specification#269
    [epaylib.parameters addObject:[ePayParameter key:@"instantcapture" value:@"0"]];                //http://tech.epay.dk/en/specification#270
    //[parameters addObject:[KeyValue initKey:@"splitpayment" value:@"0"]];                         //http://tech.epay.dk/en/specification#272
    //[parameters addObject:[KeyValue initKey:@"callbackurl" value:@""]];                           //http://tech.epay.dk/en/specification#275
    [epaylib.parameters addObject:[ePayParameter key:@"instantcallback" value:@"1"]];               //http://tech.epay.dk/en/specification#276
    [epaylib.parameters addObject:[ePayParameter key:@"ordertext" value:ciboRestaurantName]];              //http://tech.epay.dk/en/specification#278
    //[parameters addObject:[KeyValue initKey:@"group" value:@"group"]];                            //http://tech.epay.dk/en/specification#279
    [epaylib.parameters addObject:[ePayParameter key:@"description" value:@""]];//http://tech.epay.dk/en/specification#280
    //[parameters addObject:[KeyValue initKey:@"hash" value:@""]];                                  //http://tech.epay.dk/en/specification#281
    //[parameters addObject:[KeyValue initKey:@"subscription" value:@"0"]];                         //http://tech.epay.dk/en/specification#282
    //[parameters addObject:[KeyValue initKey:@"subscriptionname" value:@"0"]];                     //http://tech.epay.dk/en/specification#283
    //[parameters addObject:[KeyValue initKey:@"mailreceipt" value:@""]];                           //http://tech.epay.dk/en/specification#284
    //[parameters addObject:[KeyValue initKey:@"googletracker" value:@"0"]];                        //http://tech.epay.dk/en/specification#286
    //[parameters addObject:[KeyValue initKey:@"backgroundcolor" value:@""]];                       //http://tech.epay.dk/en/specification#287
    //[parameters addObject:[KeyValue initKey:@"opacity" value:@""]];                               //http://tech.epay.dk/en/specification#288
    [epaylib.parameters addObject:[ePayParameter key:@"declinetext" value:@""]];        //http://tech.epay.dk/en/specification#289
    
    // Set the hash key
    [epaylib setHashKey:@"MartinBilgrau2013"];
    
    // Show/hide the Cancel button
    [epaylib setDisplayCancelButton:YES];
    
    // Load the payment window
    [epaylib loadPaymentWindow];
}

- (void)event:(NSNotification*)notification
{
    // Here we handle all events sent from the ePay Lib
    
    if ([[notification name] isEqualToString:PaymentAcceptedNotification])
    {
        NSLog(@"EVENT: PaymentAcceptedNotification");
        
        for (ePayParameter *item in [notification object])
        {
            NSLog(@"Data: %@ = %@", item.key, item.value);
        }
    }
    else if ([[notification name] isEqualToString:PaymentLoadingAcceptPageNotification])
    {
        NSLog(@"EVENT: PaymentLoadingAcceptPageNotification");
        if ([orderTypeCheckding isEqualToString:@"OpenOrder"])
        {
            [self updateSendOrderRequst];
        }
        else
        {
            [self orderWithDefaultAddrss];
        }
        
    }
    else if ([[notification name] isEqualToString:PaymentWindowCancelledNotification])
    {
        NSLog(@"EVENT: PaymentWindowCancelledNotification");
    }
    else if ([[notification name] isEqualToString:PaymentWindowLoadingNotification])
    {
        NSLog(@"EVENT: PaymentWindowLoadingNotification");
        
        // Display a loading indicator while loading the payment window
        // [activityIndicatorView startAnimating];
    }
    else if ([[notification name] isEqualToString:PaymentWindowLoadedNotification])
    {
        NSLog(@"EVENT: PaymentWindowLoadedNotification");
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"" :0.1];
        // Stop our loading indicator when the payment window is loaded
        // [activityIndicatorView stopAnimating];
    }
    else if ([[notification name] isEqualToString:ErrorOccurredNotification])
    {
        // Display error object if we get a error notification
        NSLog(@"EVENT: ErrorOccurredNotification - %@", [notification object]);
    }
    else if ([[notification name] isEqualToString:NetworkActivityNotification])
    {
        // Display network indicator in the statusbar
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
    }
    else if ([[notification name] isEqualToString:NetworkNoActivityNotification])
    {
        // Hide network indicator in the statusbar
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}

#pragma mark - Paypal Payment Gateway.

-(IBAction)clickOnPaypalChoosedButton:(id)sender
{
    
}

-(void)initPaypal
{
    if (gatewayData.count>0)
    {
        for (int i=0; i<gatewayData.count; i++)
        {
            if ([[NSString stringWithFormat:@"%@",[[gatewayData objectAtIndex:i] objectForKey:@"getway_name" ]] isEqualToString:@"paypal"])
            {
                if ([[NSString stringWithFormat:@"%@",[[gatewayData objectAtIndex:i] objectForKey:@"client_id" ]] length]>0)
                {
                    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction :[[gatewayData objectAtIndex:i] objectForKey:@"client_id" ],PayPalEnvironmentSandbox : @"AXosXRDroET9be7q_AYtn_wXpZdY08Uy5CB-RvwWMcaYispQOO6FjWvo5nbk"}];
                    i=50000;
                }
                else
                {
                    [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"Paypal is not setup in this time." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                }
                _payPalConfig = [[PayPalConfiguration alloc] init];
                _payPalConfig.acceptCreditCards = NO;
                _payPalConfig.languageOrLocale = @"en";
                _payPalConfig.merchantName = ciboRestaurantName;
                _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
                _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
                
                _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
                
                // Setting the payPalShippingAddressOption property is optional.
                //
                // See PayPalConfiguration.h for details.
                
                _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
                
                // Do any additional setup after loading the view, typically from a nib.
                
                // use default environment, should be Production in real life
                self.environment = kPayPalEnvironment;
                //self.environment=@"live";
                [PayPalMobile preconnectWithEnvironment:self.environment];
            }
            else
            {
                selectedPaymentGateway=@"PAYPAL";
                selectedPaymentMethod=0;
                [paypalChoosedButton setBackgroundImage:[UIImage imageNamed:@"check_btn.png"] forState:UIControlStateNormal];
                [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"Paypal is not setup in this time." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            }
        }
    }
}

- (void)payByPaypal
{
    PayPalItem *item1 = [PayPalItem itemWithName:@"Food Order"
                                    withQuantity:1
                                       withPrice:[NSDecimalNumber decimalNumberWithString:grandTotal]
                                    withCurrency:restaurantCurrency
                                         withSku:orderId];
    
    NSArray *items = @[item1];
    NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
    
    // Optional: include payment details
    NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"0.0"];
    NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:@"0.0"];
    PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal
                                                                               withShipping:shipping
                                                                                    withTax:tax];
    
    NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = restaurantCurrency;
    payment.shortDescription = ciboRestaurantName;
    payment.items = items;  // if not including multiple items, then leave payment.items as nil
    payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
    payment.intent=PayPalPaymentIntentSale;
    if (!payment.processable)
    {
        
    }
    // Update payPalConfig re accepting credit cards.
    self.payPalConfig.acceptCreditCards = self.acceptCreditCards;
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment configuration:self.payPalConfig delegate:self];
    
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment
{
    NSLog(@"PayPal Payment Success!");
    if ([orderTypeCheckding isEqualToString:@"OpenOrder"])
    {
        [self updateSendOrderRequst];
    }
    else
    {
        [self orderWithDefaultAddrss];
    }
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController
{
    NSLog(@"PayPal Payment Canceled");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment
{
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
}


#pragma mark - Authorize Future Payments

- (IBAction)getUserAuthorizationForFuturePayments:(id)sender
{
    
    PayPalFuturePaymentViewController *futurePaymentViewController = [[PayPalFuturePaymentViewController alloc] initWithConfiguration:self.payPalConfig delegate:self];
    [self presentViewController:futurePaymentViewController animated:YES completion:nil];
}


#pragma mark PayPalFuturePaymentDelegate methods

- (void)payPalFuturePaymentViewController:(PayPalFuturePaymentViewController *)futurePaymentViewController
                didAuthorizeFuturePayment:(NSDictionary *)futurePaymentAuthorization
{
    NSLog(@"PayPal Future Payment Authorization Success!");
    //self.resultText = [futurePaymentAuthorization description];
    //[self showSuccess];
    
    [self sendFuturePaymentAuthorizationToServer:futurePaymentAuthorization];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalFuturePaymentDidCancel:(PayPalFuturePaymentViewController *)futurePaymentViewController {
    NSLog(@"PayPal Future Payment Authorization Canceled");
    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendFuturePaymentAuthorizationToServer:(NSDictionary *)authorization {
    // TODO: Send authorization to server
    NSLog(@"Here is your authorization:\n\n%@\n\nSend this to your server to complete future payment setup.", authorization);
}


#pragma mark - Authorize Profile Sharing

- (IBAction)getUserAuthorizationForProfileSharing:(id)sender
{
    
    NSSet *scopeValues = [NSSet setWithArray:@[kPayPalOAuth2ScopeOpenId, kPayPalOAuth2ScopeEmail, kPayPalOAuth2ScopeAddress, kPayPalOAuth2ScopePhone]];
    
    PayPalProfileSharingViewController *profileSharingPaymentViewController = [[PayPalProfileSharingViewController alloc] initWithScopeValues:scopeValues configuration:self.payPalConfig delegate:self];
    [self presentViewController:profileSharingPaymentViewController animated:YES completion:nil];
}


#pragma mark PayPalProfileSharingDelegate methods
- (void)payPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController
             userDidLogInWithAuthorization:(NSDictionary *)profileSharingAuthorization
{
    NSLog(@"PayPal Profile Sharing Authorization Success!");
    //self.resultText = [profileSharingAuthorization description];
    //[self showSuccess];
    
    [self sendProfileSharingAuthorizationToServer:profileSharingAuthorization];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidCancelPayPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController
{
    NSLog(@"PayPal Profile Sharing Authorization Canceled");
    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendProfileSharingAuthorizationToServer:(NSDictionary *)authorization
{
    NSLog(@"Here is your authorization:\n\n%@\n\nSend this to your server to complete profile sharing setup.", authorization);
}

#pragma mark - Mercury Payment Gateway

-(void)initMercury
{
    int finalArrayNumber=0;
    
    if (gatewayData.count>0)
    {
        for (int i=0; i<gatewayData.count; i++)
        {
            if ([[NSString stringWithFormat:@"%@",[[gatewayData objectAtIndex:i] objectForKey:@"getway_name" ]] isEqualToString:@"mercury"])
            {
                finalArrayNumber=i;
                i=50000;
            }
        }
    }
    mercuryUrl = @"https://w1.mercurycert.net/PaymentsAPI";//@"https://hc.mercurydev.net/hcws/hcservice.mx";//@"https://w1.mercurycert.net/PaymentsAPI";
    mercuryMerchantID = @"018847445767734";[[gatewayData objectAtIndex:finalArrayNumber] objectForKey:@"username" ];//@"018847445767734";//@"395347308=E2ETKN";
    mercuryMerchantPassword = @"123E2ETKN";//[[gatewayData objectAtIndex:finalArrayNumber] objectForKey:@"password" ];//@"123E2ETKN";//@"123E2ETKN";
}

-(void)mercuryPaymentSetup
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    [dictionary setObject:orderId forKey:@"InvoiceNo"];
    [dictionary setObject:@"1001" forKey:@"RefNo"];
    [dictionary setObject:ciboRestaurantName forKey:@"Memo"];
    [dictionary setObject:@"1.00" forKey:@"Purchase"];
    [dictionary setObject:@"02" forKey:@"LaneID"];
    [dictionary setObject:@"OneTime" forKey:@"Frequency"];
    [dictionary setObject:@"RecordNumberRequested" forKey:@"RecordNo"];
    [dictionary setObject:@"MagneSafe" forKey:@"EncryptedFormat"];
    [dictionary setObject:@"Swiped" forKey:@"AccountSource"];
    [dictionary setObject:@"2F8248964608156B2B1745287B44CA90A349905F905514ABE3979D7957F13804705684B1C9D5641C" forKey:@"EncryptedBlock"];
    [dictionary setObject:@"9500030000040C200026" forKey:@"EncryptedKey"];
    [self processTransactionWithDictionary:dictionary andResource:@"/Credit/Sale"];
}

- (void) processTransactionWithDictionary:(NSDictionary *)dictionary andResource:(NSString *) resource
{
    // Create a JSON POST
    NSString *urlResource = [NSString stringWithFormat:@"%@%@", mercuryUrl, resource];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlResource]];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // Add Authorization header
    NSString *credentials = [NSString stringWithFormat:@"%@:%@", mercuryMerchantID, mercuryMerchantPassword];
    NSString *base64Credentials = [self base64String:credentials];
    [request addValue:[@"Basic " stringByAppendingString:base64Credentials] forHTTPHeaderField:@"Authorization"];
    
    // Serialize NSDictionary to JSON data
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
    
    // Add JSON data to request body
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: jsonData];
    
    // Process request async
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Error"
                                                   message: error.localizedDescription
                                                  delegate: self
                                         cancelButtonTitle: nil
                                         otherButtonTitles:@"OK",nil];
    
    [alert show];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Deserialize response from REST service
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    if ([dictionary objectForKey:@"CmdStatus"]
        && [[dictionary objectForKey:@"CmdStatus"] isEqualToString:@"Approved"])
    {
        
        if ([orderTypeCheckding isEqualToString:@"OpenOrder"])
        {
            [self updateSendOrderRequst];
        }
        else
        {
            [self orderWithDefaultAddrss];
        }
    }
    else
    {
        // Declined logic here
    }
    /*for (NSString *key in [dictionary allKeys])
     {
     //[message appendFormat:@"%@: %@;\n", key, [dictionary objectForKey:key]];
     }
     
     UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Response"
     message: message
     delegate: self
     cancelButtonTitle: nil
     otherButtonTitles:@"OK",nil];
     
     [alert show];*/
    
}

// Base64 function taken from http://calebmadrigal.com/string-to-base64-string-in-objective-c/
- (NSString *)base64String:(NSString *)str
{
    NSData *theData = [str dataUsingEncoding: NSASCIIStringEncoding];
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

#pragma mark - HeartLand Payment Gateway
-(void)initHeartLand
{
    //heartLendInfoDic
    if (gatewayData.count>0)
    {
        for (int i=0; i<gatewayData.count; i++)
        {
            if ([[NSString stringWithFormat:@"%@",[[gatewayData objectAtIndex:i] objectForKey:@"getway_name" ]] isEqualToString:@"heartland"] || [[NSString stringWithFormat:@"%@",[[gatewayData objectAtIndex:i] objectForKey:@"getway_name" ]] isEqualToString:@"HEARTLAND"])
            {
                NSString *deviceID=[[NSUserDefaults standardUserDefaults] valueForKey:@"DeviceToken"];
                deviceID=[deviceID substringToIndex:40];
                [heartLendInfoDic setValue:[[gatewayData objectAtIndex:i] objectForKey:@"licenseid"] forKey:@"LicenseId"];
                [heartLendInfoDic setValue:[[gatewayData objectAtIndex:i] objectForKey:@"siteid"] forKey:@"SiteId"];
                [heartLendInfoDic setValue:deviceID forKey:@"DeviceId"];
                [heartLendInfoDic setValue:[[gatewayData objectAtIndex:i] objectForKey:@"username"] forKey:@"UserName"];
                [heartLendInfoDic setValue:[[gatewayData objectAtIndex:i] objectForKey:@"password"] forKey:@"Password"];
                i=50000;
            }
        }
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Sorry !" message:@"Gateway info is not available please try after some time." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil]show];
    }
}
-(void)sendPaymentByHeartLand
{
    [self submitTransactionToGateway];
}

// Method to check if Amount field already contains decimal point
-(BOOL)isContainDecimalAlready:(NSString *)stringToCheck
{
    for (int i = 0; i < [stringToCheck length]; i++)
    {
        unichar c = [stringToCheck characterAtIndex:i];
        if(c == '.')
            return TRUE;
    }
    return FALSE;
}

//Method to send transaction to the POS Gateway
- (void)submitTransactionToGateway
{
    NSArray *exp_dateArray=[MyCustomeClass seprateStringFromStringUsingArrray:exp_Date :@"/"];
    NSString *exp_month=[exp_dateArray objectAtIndex:0];
    NSString *exp_year=[exp_dateArray objectAtIndex:1];
    NSMutableString *expYear = [[NSMutableString alloc]initWithString:@"20"];
    [expYear appendString:exp_year];                                       //Making the year field four digits long by appending with 20.
    GatewayClient *client = [[GatewayClient alloc] init];                                   //Creating Gateway Client Object.
    client.delegate = self;                                                                 //Set delegation.
    client.requestType = CreditSale;                                                        //Set request type.
    client.cardNumber = cardNumber;                                       //Set Card Number.
    client.expirationMonth = exp_month;                                    //Set Expiration date.
    client.expirationYear = expYear;                                                        //Must be four digit before submission.
    client.txnAmount = grandTotal;                                            //Set transaction amount.
    client.isCardPresent = TRUE;                                                            //Set card present parameter.
    client.isReaderPresent = FALSE;                                                         //Set reader present parameter.
    [client sendRequest:heartLendInfoDic];                                                                   //Send request to the Gateway.
    client.delegateHeartLand=self;
    
    
    [MyCustomeClass SVProgressMessageShowOnWhenNeed:@"Checkout..."];
}
-(void)heartLandPaymentResponseMessage:(NSString *)resposne
{
    if ([resposne isEqualToString:@"Transaction rejected because the manually entered card number is invalid."])
    {
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"" :1.0];
        UIAlertView *paymentAlert = [[UIAlertView alloc]initWithTitle:@"Alert !" message:@"Invalid credit card information please edit your card." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Edit Card", nil];
        [paymentAlert show];
    }
    else if ([resposne isEqualToString:@"Success"])
    {
        if ([orderTypeCheckding isEqualToString:@"OpenOrder"])
        {
            [self updateSendOrderRequst];
        }
        else
        {
            [self orderWithDefaultAddrss];
        }
        [MyCustomeClass SVProgressMessageDismissWithSuccess:@"checkout done." :1.0];
        
    }
}
-(void)heartLandPaymentResponseCode:(NSString *)resposne
{
    NSLog(@"%@",resposne);
}
-(void)heartLandPaymentResponseTranID:(NSString *)resposne
{
    NSLog(@"%@",resposne);
    transectionId=resposne;
}


#pragma mark - IPAY88 Payment Gageway
-(void)initIPay88
{
    Ipay *paymentsdk = [[Ipay alloc] init];
    paymentsdk.delegate = self;
    IpayPayment *payment = [[IpayPayment alloc] init];
    [payment setPaymentId:@"tsdsd1121"];
    [payment setMerchantKey:@"vmPLC6MGM4"];
    [payment setMerchantCode:@"M05976"];
    [payment setRefNo:@"121331212"];//orderId];
    [payment setAmount:@"1.00"];
    [payment setCurrency:@"USD"];//restaurantCurrency];
    [payment setProdDesc:ciboRestaurantName];
    [payment setUserName:[cardDefault objectForKey:@"firstname"]];
    [payment setUserEmail:[cardDefault objectForKey:@"Email"]];
    [payment setUserContact:[cardDefault objectForKey:@"mobile"]];
    [payment setRemark:@"test"];
    [payment setLang:@"ISO-8859-1"];//
    //[payment setBackendPostURL:@"https://www.mobile88.com/epayment/report/"];
    [payment setCountry:@"MY"];//[cardDefault objectForKey:@"country"]];
    NSLog(@"%@",payment);
    UIView *paymentView = [paymentsdk checkout:payment];
    [self.view addSubview:paymentView];
}

- (void)paymentSuccess:(NSString *)refNo withTransId:(NSString *)transId withAmount:(NSString *)amount withRemark:(NSString *)remark withAuthCode:(NSString *)authCode
{
    
}
- (void)paymentFailed:(NSString *)refNo withTransId:(NSString *)transId withAmount:(NSString *)amount withRemark:(NSString *)remark withErrDesc:(NSString *)errDesc
{
    
}
- (void)paymentCancelled:(NSString *)refNo withTransId:(NSString *)transId withAmount:(NSString *)amount withRemark:(NSString *)remark withErrDesc:(NSString *)errDesc
{
    
}
-(void)requeryFailed:(NSString *)refNo withMerchantCode:(NSString *)merchantCode withAmount:(NSString *)amount withErrDesc:(NSString *)errDesc
{
    
}
-(void)requerySuccess:(NSString *)refNo withMerchantCode:(NSString *)merchantCode withAmount:(NSString *)amount withResult:(NSString *)result
{
    
}



#pragma mark - First Data Payment with apply pay
/*
 -(void)initFirstDataWithApplyPay
 {
 fdPaymentProcessor = [[FDInAppPaymentProcessor alloc] initWithApiKey:kApiKey
 apiSecret:kApiSecret
 merchantToken:kMerchantToken
 merchantIdentifier:kOsloMerchantId];
 
 self.fdPaymentProcessor.paymentMode = FDPreAuthorization;
 
 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
 
 if([defaults valueForKey:@"environment"] == nil){
 NSDictionary *appDefaults = @{@"environment":@"TEST",
 @"cavv":@"ADV8726487nmbhdwedgvhvsvznc=",
 @"type":@"visa",
 @"cardholder_name":@"Unknown",
 @"card_number":@"4788250000028291",
 @"exp_date":@"1014",
 @"cvv":@"123",
 @"apikey":kApiKey,
 @"merchant_token":kMerchantToken
 };
 [defaults registerDefaults:appDefaults];
 [defaults setValuesForKeysWithDictionary:appDefaults];
 [defaults synchronize];
 }
 }
 -(void)sendFirstDataWithApplyPay
 {
 NSArray *supportedNetworks = @[
 FDPaymentNetworkVisa,
 FDPaymentNetworkMasterCard,
 FDPaymentNetworkAmericanExpress
 ];
 
 // Does this device support In-App payments?
 if ([FDInAppPaymentProcessor canMakePayments])
 {
 // Is a card registered on the device for one of the merchant's suported card networks?
 if ([FDInAppPaymentProcessor canMakePaymentsUsingNetworks:supportedNetworks])
 {
 // Populate the payment request
 FDPaymentRequest *pmtRqst = [[FDPaymentRequest alloc] init];
 pmtRqst.merchantIdentifier = kOsloMerchantId;
 pmtRqst.supportedNetworks = supportedNetworks;
 pmtRqst.countryCode = @"US";
 pmtRqst.currencyCode = @"USD";
 pmtRqst.merchantCapabilities = FDMerchantCapability3DS | FDMerchantCapability3EMV;
 pmtRqst.requiredShippingAddressFields = FDAddressFieldNone;
 
 // Set the payment type
 fdPaymentProcessor.paymentMode =FDPurchase;// FDPreAuthorization : FDPurchase);
 
 FDShippingMethod *shipping = [[FDShippingMethod alloc] init];
 shipping.identifier = @"Restaurant";
 shipping.detail = Restaurant_Name;
 pmtRqst.shippingMethods = @[shipping];
 
 // Create a sample order
 FDPaymentSummaryItem *item1 = [[FDPaymentSummaryItem alloc] init];
 item1.amount = [NSDecimalNumber decimalNumberWithString:grandTotal];
 
 NSArray *itemArray = [NSArray arrayWithObjects: item1, nil];
 pmtRqst.paymentSummaryItems = itemArray;
 
 // Send a sample application data payload
 NSString *appDataString = @"RefCode:12345; TxID:34234089240982304823094823432";
 pmtRqst.applicationData = [appDataString dataUsingEncoding:NSUTF8StringEncoding];
 
 // Present FD authorization view controller
 [fdPaymentProcessor presentPaymentAuthorizationViewControllerWithPaymentRequest:pmtRqst presentingController:self delegate:self];
 // PKPaymentAuthorizationViewController *pkPAVC=[[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:(PKPaymentRequest *)pmtRqst];
 // [pkPAVC authorizePayment:(id)@""];
 
 // Delegate methods are driving from here...
 }
 else
 {
 NSLog(@"Ability to make payments of merchant-supported network types was rejected by FD SDK");
 }
 }
 else
 {
 NSLog(@"Ability for device to make payments was rejected by FD SDK");
 }
 
 }
 
 #pragma mark - FDPaymentAuthorizationViewControllerDelegate
 
 - (void)paymentAuthorizationViewController:(UIViewController *)controller
 didAuthorizePayment:(FDPaymentResponse *)paymentResponse
 {
 
 NSString *authStatusMessage = nil;
 if (paymentResponse.validationStatus != FDPaymentValidationStatusSuccess)
 {
 authStatusMessage = @"Transaction Validation or communication failure. Please try again.";
 }
 else if (paymentResponse.authStatus == FDPaymentAuthorizationStatusFailure)
 {
 authStatusMessage = [NSString stringWithFormat:@"Transaction was validated but authorization failed with reason: %@", paymentResponse.transStatusMessage];
 
 }
 else if (paymentResponse.authStatus == FDPaymentAuthorizationStatusSuccess)
 {
 authStatusMessage = [NSString stringWithFormat:@"Transaction Successful\rType:%@\rTransaction ID:%@\rTransaction Tag:%@",
 paymentResponse.transactionType,
 paymentResponse.transactionID,
 paymentResponse.transactionTag];
 transectionId=paymentResponse.transactionID;
 if ([orderTypeCheckding isEqualToString:@"OpenOrder"])
 {
 [self updateSendOrderRequst];
 }
 else
 {
 [self orderWithDefaultAddrss];
 }
 }
 }
 
 - (void)paymentAuthorizationViewControllerDidFinish:(UIViewController *)controller
 {
 
 NSLog(@"ViewController:paymentAuthorizationViewControllerDidFinish invoked");
 }
 
 - (void)paymentAuthorizationViewController:(UIViewController *)controller
 didSelectShippingMethod:(FDShippingMethod *)shippingMethod
 {
 
 NSLog(@"ViewController:didSelectShippingMethod invoked");
 }
 
 - (void)paymentAuthorizationViewController:(UIViewController *)controller
 didSelectShippingAddress:(ABRecordRef)address
 {
 NSLog(@"ViewController:didSelectShippingAddress invoked");
 }
 */

-(IBAction)clickOnOffer:(id)sender
{
    OfferViewController *offer =[[OfferViewController alloc] initWithNibName:@"OfferViewController" bundle:nil];
    offer.restaurantID = ciboRestauantID;
    [self presentViewController:offer animated:true completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (welletArray.count>0)
    {
        return welletArray.count;
    }
    return selectedOrderArray.count;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1=@"CardTableViewCell";
    CardTableViewCell *cell = (CardTableViewCell *)[itemTable dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"CardTableViewCell" owner:self options:nil];
        
        cell = [cellArray objectAtIndex:0];
    }
    if (selectedOrderArray.count>0)
    {
        NSMutableDictionary *orderDictionary = [selectedOrderArray objectAtIndex:indexPath.row];
        
        NSArray *fmLocalArray=[orderDictionary objectForKey:@"ForceModifier"];
        NSString *fmID=@"";
        NSString *omID=@"";
        if([fmLocalArray isKindOfClass:[NSArray class]])
        {
            for(int k=0; k<fmLocalArray.count;k++)
            {
                fmID=[fmID stringByAppendingString:[NSString stringWithFormat:@",%@",[[fmLocalArray objectAtIndex:k] objectForKey:@"fm_item_name"]]];
            }
            if ([fmID hasPrefix:@","])
            {
                fmID = [fmID substringFromIndex:1];
            }
        }
        
        
        NSArray *omLocalArray=[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"OptionModifier"];
        if([fmLocalArray isKindOfClass:[NSArray class]])
        {
            for(int k=0; k<omLocalArray.count;k++)
            {
                omID=[omID stringByAppendingString:[NSString stringWithFormat:@",%@",[[omLocalArray objectAtIndex:k]objectForKey:@"om_item_name"]]];
                
            }
            if ([omID hasPrefix:@","])
            {
                omID = [omID substringFromIndex:1];
            }
        }
        
        
        NSString *modifireName =[NSString stringWithFormat:@"%@,%@",fmID,omID];
        cell.modifire.text = modifireName;
        int count = [[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"count" ] intValue]*[[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"happyHourGet" ] intValue];
        
        if (count<=0)
            count = [[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"count" ] intValue];
        
        NSString *totalTaxString=@"";
        float vatTax=0.0;
        float otherTax=0.0;
        float serviceTax=0.0;
        float local_Tax=0.0;
        float forceModiPrice = 0.0;
        float optionModiPrice = 0.0;
        float priceCalucaltion =0.0;
        float displayCount =0.0;
        
        if(taxArray.count>0)
        {
            priceCalucaltion = [[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"price"] floatValue];
            
            // modifier calculation
            NSArray *fmLocalArray=[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"ForceModifier"];
            
            for(int k=0; k<fmLocalArray.count;k++)
            {
                forceModiPrice=forceModiPrice+[[[fmLocalArray objectAtIndex:k] objectForKey:@"price"] floatValue];
            }
            NSArray *omLocalArray=[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"OptionModifier"];
            
            for(int k=0; k<omLocalArray.count;k++)
            {
                optionModiPrice=optionModiPrice+[[[omLocalArray objectAtIndex:k] objectForKey:@"price"] floatValue];
            }
            
            priceCalucaltion = priceCalucaltion + forceModiPrice+optionModiPrice;
            
            
            if([NSString stringWithFormat:@"%@",[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"is_servicetax" ]].length>0  && ![[NSString stringWithFormat:@"%@",[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"is_servicetax" ]] isEqualToString:@"0"])
            {
                vatTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"service_tax"] floatValue] price:[[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
            }
            if([NSString stringWithFormat:@"%@",[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"is_othertax" ]].length>0  && ![[NSString stringWithFormat:@"%@",[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"is_othertax" ]] isEqualToString:@"0"])
            {
                otherTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"other_tax"] floatValue] price:[[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
            }
            if([NSString stringWithFormat:@"%@",[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"is_vat" ]].length>0  && ![[NSString stringWithFormat:@"%@",[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"is_vat" ]] isEqualToString:@"0"])
            {
                serviceTax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"vat"] floatValue] price:[[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
            }
            if([NSString stringWithFormat:@"%@",[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"is_localtax" ]].length>0 && ![[NSString stringWithFormat:@"%@",[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"is_localtax" ]] isEqualToString:@"0"])
            {
                local_Tax = [self addTaxWithDish:[[[taxArray objectAtIndex:0] objectForKey:@"local_tax"] floatValue] price:[[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"price" ] floatValue]];
            }
        }
        priceCalucaltion = priceCalucaltion + vatTax + otherTax + serviceTax;
        
        displayCount = displayCount +count*[[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"happyHourGet" ] intValue];
        
        if ([[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"happyHourGet"] intValue]<=0)
        {
            displayCount = displayCount + count;
        }
        
        priceCalucaltion = priceCalucaltion - count*[[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"happyHourAmount" ] floatValue];
        priceCalucaltion = priceCalucaltion - (priceCalucaltion * [[[selectedOrderArray objectAtIndex:indexPath.row] objectForKey:@"happyHourDiscount" ] floatValue]/100);
        
        totalTaxString=[NSString stringWithFormat:@"%.2f",priceCalucaltion];
        cell.priceLabel.text=[NSString stringWithFormat:@"%@",totalTaxString];

        cell.nameLabel.text=[NSString stringWithFormat:@"%f X %@",displayCount, [orderDictionary objectForKey:@"name"]];
        
        //cell.priceLabel.font=[UIFont fontWithName:FONT_Ragular size:9.0];
        //cell.nameLabel.font=[UIFont fontWithName:FONT_Ragular size:9.0];

        cell.modifire.font=[UIFont fontWithName:FONT_Ragular size:8.0];
        [cell.modifire setFont: [cell.modifire.font fontWithSize: 8.0]];
    }
    if (welletArray.count>0)
    {
        cell.nameLabel.text=[NSString stringWithFormat:@"%@ X %@",[[welletArray objectAtIndex:indexPath.row] objectForKey:@"quantity"], [[welletArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
        cell.nameLabel.font=[UIFont fontWithName:FONT_Ragular size:12.0];
        [cell.nameLabel setFont: [cell.nameLabel.font fontWithSize: 12.0]];

    }
    cell.modifire.font=[UIFont fontWithName:FONT_Ragular size:9.0];
    [cell.modifire setFont: [cell.nameLabel.font fontWithSize: 9.0]];


    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

#pragma mark - Stripe Payment gateway

- (void)initStripeSettings
{
    NSString *sk_live=@"";
    NSString *pk_live=@"";
    BOOL gateInfoisExist = NO;
    
    if (gatewayData.count>0)
    {
        for (int i=0; i<gatewayData.count; i++)
        {
            if ([[NSString stringWithFormat:@"%@",[[gatewayData objectAtIndex:i] objectForKey:@"getway_name" ]] isEqualToString:@"stripe"])
            {
                sk_live=[[gatewayData objectAtIndex:i] objectForKey:@"username" ];
                pk_live=[[gatewayData objectAtIndex:i] objectForKey:@"password" ];
                i=50000;
                gateInfoisExist=YES;
            }
        }
    }
    if (gateInfoisExist)
    {
        optionsStripe = [[STPCheckoutOptions alloc] initWithPublishableKey:pk_live];//[Stripe defaultPublishableKey]];
        
        optionsStripe.purchaseDescription = [NSString stringWithFormat:@"Order Id:%@",orderId];
        optionsStripe.purchaseAmount = priceINFloat*100; // this is in cents
        optionsStripe.logoColor = [UIColor grayColor];
        optionsStripe.purchaseCurrency=restaurantCurrency;
        optionsStripe.companyName=ciboRestaurantName;
        optionsStripe.enableRememberMe=[NSNumber numberWithInt:1];
        optionsStripe.customerEmail=[[NSUserDefaults standardUserDefaults] valueForKey:@"Email"];
        optionsStripe.logoImage =[UIImage imageNamed:@"114.png"];
        [self checkOutByStripe];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Alert !" message:@"Card payment is not active on this restaurant." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
}

-(void)checkOutByStripe
{
    STPCheckoutViewController *checkoutViewController = [[STPCheckoutViewController alloc] initWithOptions:optionsStripe];
    checkoutViewController.checkoutDelegate = self;
    [self presentViewController:checkoutViewController animated:YES completion:nil];
    [self cardExist];
}

- (void)checkoutController:(STPCheckoutViewController *)controller didCreateToken:(STPToken *)token completion:(STPTokenSubmissionHandler)completion {
    [self createBackendChargeWithToken:token completion:completion];
}

- (void)checkoutController:(STPCheckoutViewController *)controller didFinishWithStatus:(STPPaymentStatus)status error:(NSError *)error
{
    switch (status)
    {
        case STPPaymentStatusSuccess:
            [self paymentSucceeded];
            break;
        case STPPaymentStatusError:
            [self presentError:error];
            break;
        case STPPaymentStatusUserCancelled:
            // do nothing
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)presentError:(NSError *)error
{
    /*UIAlertView *message = [[UIAlertView alloc] initWithTitle:nil
     message:[error localizedDescription]
     delegate:nil
     cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
     otherButtonTitles:nil];*/
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Gateway problem!"
                                                      message:@"Please try after some time."
                                                     delegate:nil
                                            cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                            otherButtonTitles:nil];
    [message show];
}

- (void)paymentSucceeded
{
    /*[[[UIAlertView alloc] initWithTitle:@"Success!"
     message:@"Payment successfully created!"
     delegate:nil
     cancelButtonTitle:nil
     otherButtonTitles:@"OK", nil] show];*/
    [self orderWithDefaultAddrss];
}

#pragma mark - STPBackendCharging

- (void)createBackendChargeWithToken:(STPToken *)token completion:(STPTokenSubmissionHandler)completion
{
    //NSDictionary *chargeParams = @{ @"stripeToken": token.tokenId, @"amount": @"1000" };
    transectionId = token.tokenId;
    if (!BackendChargeURLString)
    {
        NSError *error = [NSError
                          errorWithDomain:StripeDomain
                          code:STPInvalidRequestError
                          userInfo:@{
                                     NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Good news! Stripe turned your credit card into a token: %@ \nYou can follow the "
                                                                 @"instructions in the README to set up an example backend, or use this "
                                                                 @"token to manually create charges at dashboard.stripe.com .",
                                                                 token.tokenId]
                                     }];
        completion(STPBackendChargeResultFailure, error);
        return;
    }
    
    // This passes the token off to our payment backend, which will then actually complete charging the card using your Stripe account's secret key
    
    /*AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
     [manager POST:[BackendChargeURLString stringByAppendingString:@"/charge"]
     parameters:chargeParams
     success:^(AFHTTPRequestOperation *operation, id responseObject) { completion(STPBackendChargeResultSuccess, nil); }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) { completion(STPBackendChargeResultFailure, error); }];*/
}




@end
