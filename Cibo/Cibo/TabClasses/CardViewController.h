//
//  CardViewController.h
//  Restaurant Cibo
//
//  Created by mithun ravi on 28/06/14.
//  Copyright (c) 2014 mithun ravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomeClass.h"
#import <CoreLocation/CoreLocation.h>

////////// payment gate way class.
//#import "CreditCardPayment.h"
//#import "ueConnection.h"
//#import "uesoapTransactionResponse.h" //Needed to output the result response
//#import "Constants.h"
//// end payment gateway class

#import "AddCardViewController.h"
///// epay
#import "ePayLib.h"
#import "ePayParameter.h"
///// paypal
#import "PayPalMobile.h"
/// HeartLand payment gateway
#import "GatewayClient.h"
#import "GatewayResponse.h"

/// ipay 88
#import "IpayPayment.h"
#import "Ipay.h"
#import "OfferViewController.h"
#import "CardTableViewCell.h"


// first data
/*#import <PayeezyClient/PayeezyClient.h>
 #define kApiKey             @"y6pWAJNyJyjGv66IsVuWnklkKUPFbb0a"
 #define kApiSecret          @"y6pWAJNyJyjGv66IsVuWnklkKUPFbb0a"
 #define kMerchantToken      @"fdoa-a480ce8951daa73262734cf102641994c1e55e7cdf4c02b6"
 #define KURL    @"https://api-cert.payeezy.com/v1/transactions"
 #define kOsloMerchantId     @"mock-1"
 
 /// first data with apple pay
 #import <InAppSDK/FDPaymentAuthorizationViewControllerDelegate.h>
 #import <InAppSDK/FDPaymentDefs.h>
 #import <InAppSDK/InAppSDK.h>
 #import "MockAcadiaAPIs/PKPaymentAuthorizationViewController.h"
 */

///// end /////


#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_4_0
#define kCFCoreFoundationVersionNumber_iPhoneOS_4_0 550.32
#endif

#define kPayPalEnvironment PayPalEnvironmentProduction//PayPalEnvironmentSandbox//PayPalEnvironmentProduction //PayPalEnvironmentNoNetwork
#import <Stripe/Stripe.h>
#import "ShippingManager.h"
@protocol STPBackendCharging <NSObject>
- (void)createBackendChargeWithToken:(STPToken *)token completion:(STPTokenSubmissionHandler)completion;
@end


@class AppDelegate;
@interface CardViewController : UIViewController<WebServiceHelperDelegate,UIActionSheetDelegate,PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate, UIPopoverControllerDelegate,HeartLandPaymentProtocalDeleage,PaymentResultDelegate/*,FDPaymentAuthorizationViewControllerDelegate*/,STPCheckoutViewControllerDelegate,PKPaymentAuthorizationViewControllerDelegate,CLLocationManagerDelegate>
{
    AppDelegate *appDelegate;
    IBOutlet UIImageView *carImage;
    IBOutlet UIView *deliversView;
    IBOutlet UIView *pickupView;
    IBOutlet UILabel *userAddress,*addressTitle,*payOnDelievryTitle;
    IBOutlet UILabel *totalPrice,*checkOutPoints;
    IBOutlet UISegmentedControl *dePicSegmentController;
    IBOutlet UIButton *paypalChoosedButton,*payCraditCardButton,*payApplyPayButton,*payOnDelButton,*payByPointsButton;
    NSUserDefaults *cardDefault;
    float priceINFloat;
    NSMutableDictionary *restaurantDic;
    int totalOrderPoints;
    int selectedPaymentMethod;
    long int orderListCounter;
    NSString *subTotal,*grandTotal;
    NSString *pickupIS;
    int fromTime,toTime;
    ///// epay ///
    ePayLib* epaylib;
    NSString *restaurantCurrency;
    float tipAmount;
    int tipis;
    IBOutlet UIButton *offerButton;
    IBOutlet UILabel *discountLabel,*totalLabel,*finalLabel;
    IBOutlet UILabel *discountAmount,*totalAmount,*finalAmountLabel;
    IBOutlet UIView *amountView;
    float customerDiscountInFloat;
    float couponAmount;
    NSString *couponID;
    float savings;
    float totalLocalTax;
    float totalSevericeTax;
    float totalVatTax;
    float totalOtherTax;
    IBOutlet UIButton *showCoupon,*tipShowButton;
    IBOutlet UITableView *itemTable;
    IBOutlet UILabel *lblTitle;
    IBOutlet UILabel *lblTilB;
    CLLocationManager *locationManager;
    float latitude,longitude,latitude1,longitude1;
    int distance;

    /// stripe payment gateway
    STPCheckoutOptions *optionsStripe;

}

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, retain) NSString *ciboRestauantID;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *cardNumber;
@property (nonatomic, strong) NSString *exp_Date;
@property (nonatomic, strong) NSString *finalAmount;
@property (nonatomic, strong) NSString *cvvNumber;
@property (nonatomic, strong) NSMutableArray *selectedOrderArray;
@property (nonatomic, strong) NSMutableDictionary *paymentMethodDic;
@property (nonatomic, strong) NSMutableArray *businessHour,*gatewayData,*taxArray;

@property (nonatomic, strong) NSString *transectionId;
@property (nonatomic, strong) NSString *orderTypeCheckding,*selectedPaymentGateway;

////// paypal ////
@property(nonatomic, strong, readwrite) IBOutlet UIButton *payNowButton;
@property(nonatomic, strong, readwrite) IBOutlet UIButton *payFutureButton;
@property(nonatomic, strong, readwrite) IBOutlet UIView *successView;
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
////// End paypal ////

//// mercurypaymentgateway/////
@property (nonatomic, strong) NSString *mercuryUrl;
@property (nonatomic, strong) NSString *mercuryMerchantID;
@property (nonatomic, strong) NSString *mercuryMerchantPassword;
@property (nonatomic, strong) NSString *mercuryTranType;
@property (nonatomic, strong) NSString *mercuryTranCode;
//// end mercurypaymentway/////

/// HartLendPaymentGateway /////
@property (nonatomic, strong) NSMutableDictionary *heartLendInfoDic;
/////////// end  ///////////////

/////// first Data //////
//@property (nonatomic, strong) NSMutableDictionary *cardInfoForFirstData;
//@property (strong, nonatomic) FDInAppPaymentProcessor *fdPaymentProcessor;

@property (nonatomic, strong) NSMutableArray *tableArray;
@property (nonatomic, strong) NSMutableArray *welletArray;



///   Stripe Payment gateway / ////
@property (nonatomic) BOOL applePaySucceeded;
@property (nonatomic,retain) NSError *applePayError;
@property (nonatomic,retain) ShippingManager *shippingManager;
@property (weak, nonatomic) IBOutlet UIButton *applePayButton;

@end
