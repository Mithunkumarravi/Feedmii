
#import <Foundation/Foundation.h>
#import "GSObject.h"
#import <sqlite3.h>
#import "SBJSON.h"

#define URI_HTTP    @"http://ciboapp.com/admin/mobileApi/"
#define URLFORALLDATA @"http://www.educationbizz.co.uk/education/alldata.php?tablename="

@protocol WebServiceHelperDelegate<NSObject>
@required
-(void)gettingFail:(NSString*)error;
@optional
-(void)loginSuccess:(NSString*)response;
-(void)registrationApi:(NSString *)response;
-(void)viewUserDetail:(NSString *)response;
-(void)updateUserDetail:(NSString *)response;


-(void)restaurentAddress:(NSString *)response;
-(void)gettingRoom:(NSString *)response;
-(void)timeSlotResponse:(NSString *)response;
-(void)gettingGallery:(NSString *) response;
-(void)galleryCategoryFromServer :(NSString *) response;
-(void)gettingEvents:(NSString *) response;
-(void)gettingCategoryList:(NSString *) response;
-(void)gettingSumCategoryListFromMenu:(NSString *) response;
-(void)gettingItemOfSubCategory:(NSString *) response;
-(void)sendingOrder:(NSString *) response;
-(void)sentOrderListToTheServer:(NSString *)response;

-(void)tableBooking:(NSString *) response;
-(void)gettingLoyalityPunch:(NSString *) response;
-(void)gettingUserMounchPoints:(NSString *) response;
-(void)redemmingMunchPoints:(NSString *) response;
-(void)addMemberPoints:(NSString *) response ;
-(void)sendQRCode:(NSString *) response ;
-(void)restaurantInformation:(NSString *) response ;
-(void)userRedeemingPoint:(NSString *) response;
-(void)checkQRCodeScannerISExist : (NSString *) response;
-(void)addingRedeemingPoints: (NSString *) response;
-(void)paymentMethodList:(NSString *) response;
-(void)gateWayCradintialAccess:(NSString *)response;

-(void)getForceModifier:(NSString *)response;
-(void)getOptionModifier:(NSString *)response;
-(void)basePizza:(NSString *)response;
-(void)toppingPizza:(NSString *)response;
-(void)sizePizz:(NSString *)response;

-(void)redemDiscount:(NSString *) response;
-(void)pizzaPrice:(NSString *) response;
-(void)viewTableInTheRoom:(NSString *)response;
-(void)businessHourForRestaurant:(NSString *)response;
-(void)mercuryPayment:(NSString *)response;

-(void)updateDeviceToken:(NSString *)response;
-(void)sendNotification:(NSString *) response;
-(void)myOpenOrderList:(NSString *)response;
-(void)orderProductList:(NSString *)response;
-(void)deviceIDUpdate:(NSString *) response;
-(void)updateSendOrder:(NSString *) response;

-(void)taxList:(NSString *)response;
-(void)forgotPassword:(NSString *) response;
-(void)checkUserName:(NSString *) response;
-(void)redeemPoints2:(NSString *) response;
-(void)closedMyOrder:(NSString *) response;

-(void)registeredBeaconList:(NSString *)response;
-(void)beaconCompaining:(NSString *)response;
-(void)coupenBeacon:(NSString*)response;
-(void)happyHourBeacon:(NSString *)response;
-(void)checkINCheckOUTBeacon:(NSString *)response;
-(void)allBeaconDetailWithCompainingID:(NSString *)response;

-(void)allRestaurantList:(NSString *) response;

-(void)checkINDetailToServer:(NSString *) response;
-(void)checkOutDetailToServer:(NSString *) response;
-(void)happyHour:(NSString *)response;
-(void)saveSpiltBill:(NSString *)response;


@end


@interface WebServiceHelper : NSObject
{
    NSMutableData   *responseData;
    NSString   *serviceName;
    NSDictionary    *parsedJSON;
    NSMutableString *responseString;
}
@property(nonatomic,strong)id <WebServiceHelperDelegate>delegate;
@property(nonatomic,strong)NSString *serviceName;
@property (nonatomic, strong) NSMutableDictionary *dynamicParams;
@property (nonatomic , strong) NSURL *dynamicURL;

@property (nonatomic, strong)NSDictionary *dictionary;

-(void)login:(NSDictionary *)param;
-(void)login1:(NSString *)param;
-(void)registrationApi:(NSString *)param;
-(void)viewUserDetail:(NSString *)param;
-(void)updateUserDetail :(NSString *)url :(NSString *)param;

///////////////// Location Tab ////////////////////
-(void)restaurentAddress:(NSString *)param;
-(void)gettingRoom:(NSString *)param;
-(void)timeSlotResponse:(NSString *)param;
-(void)tableBooking:(NSString *) url :(NSString *) param;
///////////////////////////////////////////////////////
//////////////////// Gallery Tab //////////////////////
-(void)gettingGallery:(NSString *) param;
-(void)galleryCategoryFromServer :(NSString *) param;

///////////////////////////////////////////////////////
//////////////////// Item Tab //////////////////////
-(void)gettingEvents:(NSString *) param;

////////    Menu tab    /////////////////////////////////
-(void)gettingCategoryList:(NSString *) param;
-(void)gettingSumCategoryListFromMenu:(NSString *) param;
-(void)gettingItemOfSubCategory:(NSString *) param;
-(void)sendingOrder:(NSString *) urlString :(NSString *) param;
-(void)sentOrderListToTheServer :(NSString *) urlString :(NSString *) param;

//-(void)userRedeemingPoint:(NSString *) param :(NSString *) urlString1;

///////////////////////////////////////////////////////
//////////////////// Loyality module //////////////////
-(void)gettingLoyalityPunch:(NSString *) param;
-(void)gettingUserMounchPoints:(NSString *) param;
-(void)redemmingMunchPoints:(NSString *) param :(NSString *) url;
-(void)addMemberPoints:(NSString *) param :(NSString *) url;
-(void)sendQRCode:(NSString *) param :(NSString *) url;

-(void)restaurantInformation:(NSString *) param ;
//-(void)userRedeemingPoint:(NSString *) param;
-(void)userRedeemingPoint :(NSString *) param : (NSString *) urlString1;
-(void)checkQRCodeScannerISExist : (NSString *) param;
-(void)addingRedeemingPoints: (NSString *) param : (NSString *) url;
-(void)paymentMethodList:(NSString *) url;
-(void)gateWayCradintialAccess:(NSString *)url;

//////
-(void)getForceModifier:(NSString *)url;
-(void)getOptionModifier:(NSString *)url;
-(void)basePizza:(NSString *)url;
-(void)toppingPizza:(NSString *)url;
-(void)sizePizz:(NSString *)url;
-(void)pizzaPrice:(NSString *)url;
-(void)redemDiscount:(NSString *) param : (NSString *) url;
-(void)viewTableInTheRoom:(NSString *)url;
-(void)businessHourForRestaurant:(NSString *)url;
-(void)mercuryPayment:(NSString *)url;

///// push notification api list ////
-(void)updateDeviceToken:(NSString *)url;
-(void)sendNotification:(NSString *) url;
-(void)myOpenOrderList:(NSString *)url;
-(void)orderProductList:(NSString *)url;
-(void)deviceIDUpdate:(NSString *)url;
-(void)updateSendOrder:(NSString *) urlString :(NSString *) param;
-(void)taxList:(NSString *)url;
-(void)forgotPassword:(NSString *) url;
-(void)checkUserName:(NSString *) url;
-(void)redeemPoints2:(NSString *) url :(NSString *) postString;
-(void)closedMyOrder:(NSString *) url;

-(void)happyHour:(NSString *)url;
-(void)saveSpiltBill:(NSString *)urlString;


///// Beacon Info Api ////

-(void)registeredBeaconList:(NSString *)urlString;
-(void)beaconCompaining:(NSString *)urlString;
-(void)coupenBeacon:(NSString*)urlString;
-(void)happyHourBeacon:(NSString *)urlString;
-(void)checkINCheckOUTBeacon:(NSString *)urlString postData:(NSString *)postData;
-(void)allBeaconDetailWithCompainingID:(NSString *)urlString;

-(void)checkINDetailToServer:(NSString *) urlString;
-(void)checkOutDetailToServer:(NSString *) urlString;


/////// multiple Restaurant api
-(void)allRestaurantList:(NSString *) urlString;

////////////////////////////////////////////////
////////////                     ///////////////
//////////// DATABASE CONNECTION ///////////////
////////////                     ///////////////
////////////////////////////////////////////////

+(NSMutableDictionary *) dataReadFromLocalDataBase: (NSString *) databaseName :(NSString *) databaseQuery :(NSString *) queryName;


@end
