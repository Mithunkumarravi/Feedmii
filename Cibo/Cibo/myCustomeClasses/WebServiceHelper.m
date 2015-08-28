
#import "WebServiceHelper.h"
#import "AppDelegate.h"
#import "GSObject.h"


@implementation WebServiceHelper

@synthesize serviceName;
@synthesize dictionary;
@synthesize dynamicParams;
@synthesize dynamicURL;



#pragma mark Common Request method

-(void)jsonPaseringWithPHP :(NSString *)datastring :(NSString *)urlString
{
    NSURL *url=[NSURL URLWithString:urlString];
    NSData *postData = [datastring dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    //[request set];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *conn= [NSURLConnection connectionWithRequest:request  delegate:self];
    
    if(conn)
    {
        responseData=[[NSMutableData alloc] init];
    }
    [request release];
    
}
-(void)requestWithURLandParams:(NSString*)urlString param:(NSDictionary*)params
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    dynamicParams=[[NSMutableDictionary alloc] init];
    dynamicParams=[params copy];
    dynamicURL = [url copy];
    NSLog(@"%@",dynamicURL);
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:dynamicURL];
    
    if(params)
    {
        NSString *jsonRequest = [NSString stringWithFormat:@"%@",[params JSONRepresentation]];
        NSLog(@"Url string : %@",[url description]);
        NSLog(@"requestttt====%@",jsonRequest);
        NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
        [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody: requestData];
        // [request setHTTPBody:(NSData *)credential];
        
    }
    
    [request setHTTPMethod:@"POST"];
    // [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //  //[request setValue:@"123" forHTTPHeaderField:@"admin"];
    
    
    NSURLConnection *conn= [NSURLConnection connectionWithRequest:request  delegate:self];
    if(conn)
    {
        responseData=[[NSMutableData alloc] init];
    }
    [request release];
    
}

-(void)requestWithURL:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSURLConnection *conn= [NSURLConnection connectionWithRequest:request  delegate:self];
    if(conn)
    {
        responseData=[[NSMutableData alloc] init];
    }
    [request release];
    
}
////////////////////////////////////////////////////
///////////////////////////////////////////////////////
////////////////////////////////////////////////////

-(void)login:(NSDictionary *)param
{
    serviceName=@"Login";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/CheckLogin/loginCheck/"];//@"http://ciboapp.com/admin/posApi/doLogin/checkLogin"];
    [self requestWithURLandParams:urlString param:param];
    
}
-(void)login1:(NSString *)param
{
    serviceName=@"Login";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/checkLogin/clientLogin"];
    [self jsonPaseringWithPHP:param:urlString];
    
}
-(void)registrationApi:(NSString *)param
{
    serviceName=@"Registar";
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@",URI_HTTP,@"member/createMember/restId/",ciboRestaurantId];
    [self jsonPaseringWithPHP : param :urlString];
    
}
-(void)viewUserDetail:(NSString *)param
{
    serviceName=@"ViewUserInfo";
    NSString *urlString=[NSString stringWithFormat:@"%@%@",URI_HTTP,param];
    [self requestWithURL: urlString];
    
}
-(void)updateUserDetail :(NSString *)url :(NSString *)param
{
    serviceName=@"UpdateUserDetail";
    NSString *urlString=[NSString stringWithFormat:@"%@%@",URI_HTTP,url];
    [self jsonPaseringWithPHP: param: urlString];
}


-(void)restaurentAddress:(NSString *)param
{
    serviceName=@"RestaurentAddress";
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@",URI_HTTP,@"restDetails/viewDetails/restId/",param];
    [self requestWithURL: urlString];
    
}
-(void)gettingRoom:(NSString *)param
{
    serviceName=@"GettingRoom";
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@",URI_HTTP,@"tableRes/viewRoom/restId/",param];
    [self requestWithURL: urlString];
}
-(void)timeSlotResponse:(NSString *)param
{
    serviceName=@"TimeSlot";
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@",URI_HTTP,@"tableRes/viewTimeslots/restId/",param];
    [self requestWithURL: urlString];
    
}
-(void)gettingGallery:(NSString *) param
{
    serviceName=@"GettingGalleryInfo";
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@",URI_HTTP,@"gallery/viewGalleryCat/restId/",param];
    NSLog(@"%@",urlString);
    [self requestWithURL: urlString];
}
-(void)galleryCategoryFromServer :(NSString *) param
{
    serviceName=@"GettingGalleryCategoryInfo";
    NSString *urlString=[NSString stringWithFormat:@"%@%@",URI_HTTP,param];
    NSLog(@"%@",urlString);
    
    [self requestWithURL: urlString];
}
-(void)gettingEvents:(NSString *) param
{
    serviceName=@"GettingEventInfo";
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@",URI_HTTP,@"events/viewEvent/restId/",param];
    NSLog(@"%@",urlString);
    [self requestWithURL: urlString];
}
-(void)gettingCategoryList:(NSString *)param
{
    serviceName=@"GettingCategory";
    NSString *urlString=[NSString stringWithFormat:@"%@%@",URI_HTTP,param];
    NSLog(@"%@",urlString);
    [self requestWithURL: urlString];
}

-(void)gettingSumCategoryListFromMenu:(NSString *) param
{
    serviceName=@"GettingSubCategory";
    NSString *urlString=[NSString stringWithFormat:@"%@%@",URI_HTTP,param];
    NSLog(@"%@",urlString);
    [self requestWithURL: urlString];
}
-(void)gettingItemOfSubCategory:(NSString *) param
{
    serviceName=@"GettingItemFromSubCategory";
    NSString *urlString=[NSString stringWithFormat:@"%@%@",URI_HTTP,param];
    NSLog(@"%@",urlString);
    [self requestWithURL: urlString];
}
-(void)sendingOrder:(NSString *) urlString :(NSString *) param
{
    serviceName=@"SendingOrder";
    NSString *urlString1=[NSString stringWithFormat:@"%@%@",URI_HTTP,urlString];
    NSLog(@"%@",urlString1);
    [self jsonPaseringWithPHP:param:urlString1];
}
-(void)sentOrderListToTheServer:(NSString *) urlString :(NSString *) param
{
    serviceName=@"SendOrderList";
    NSString *urlString1=[NSString stringWithFormat:@"%@%@",URI_HTTP,urlString];
    NSLog(@"%@",urlString1);
    [self jsonPaseringWithPHP:param:urlString1];
    
}

-(void)tableBooking:(NSString *) url :(NSString *) param
{
    serviceName=@"TableBooking";
    NSString *urlString=[NSString stringWithFormat:@"%@",url];
    NSLog(@"%@",urlString);
    [self jsonPaseringWithPHP : param :urlString];
}
-(void)gettingLoyalityPunch:(NSString *) param
{
    serviceName=@"GettingLoyality";
    NSString *urlString=[NSString stringWithFormat:@"%@%@",URI_HTTP,param];
    [self requestWithURL :urlString];
    
}

-(void)gettingUserMounchPoints:(NSString *) param
{
    serviceName=@"UserMounchPoint";
    NSString *urlString=[NSString stringWithFormat:@"%@%@",URI_HTTP,param];
    NSLog(@"%@",urlString);
    [self requestWithURL :urlString];
}

-(void)redemmingMunchPoints:(NSString *) param :(NSString *) url
{
    serviceName=@"RedemingPoints";
    NSString *urlString=[NSString stringWithFormat:@"%@%@",URI_HTTP,url];
    NSLog(@"%@",urlString);
    [self jsonPaseringWithPHP : param :urlString];
}
-(void)addMemberPoints:(NSString *) param :(NSString *) url
{
    serviceName=@"AddPoints";
    NSString *urlString=[NSString stringWithFormat:@"%@%@",URI_HTTP,url];
    NSLog(@"%@",urlString);
    [self jsonPaseringWithPHP : param :urlString];
}
-(void)sendQRCode:(NSString *) param :(NSString *) url
{
    serviceName=@"QRCode";
    NSString *urlString=[NSString stringWithFormat:@"%@%@",URI_HTTP,url];
    NSLog(@"%@",urlString);
    [self jsonPaseringWithPHP : param :urlString];
}

-(void)restaurantInformation:(NSString *) param
{
    serviceName=@"Information";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/munchPoints/mobileAppPage/restId/%@",param];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}
-(void)userRedeemingPoint:(NSString *) param :(NSString *) urlString1
{
    serviceName=@"RedeemingPointOfUser";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/munchPoints/check_coupon/%@",urlString1];
    NSLog(@"%@",urlString);
    [self requestWithURL: urlString];
}
-(void)checkQRCodeScannerISExist : (NSString *) param
{
    serviceName=@"ChechQRCode";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/munchPoints/check_qr_code/%@",param];
    NSLog(@"%@",urlString);
    [self requestWithURL: urlString];
}
-(void)addingRedeemingPoints: (NSString *) param : (NSString *) url
{
    serviceName=@"AddRedeemingPoints";
    NSString *urlString=[NSString stringWithFormat:@"%@%@",URI_HTTP,url];
    NSLog(@"%@",urlString);
    [self jsonPaseringWithPHP : param :urlString];
}
-(void)paymentMethodList:(NSString *) url
{
    serviceName=@"PaymentMethodList";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/newdmenuapi/payment/payMethods/RestId/%@",url];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}
-(void)gateWayCradintialAccess:(NSString *)url
{
    serviceName=@"GatewayAccess";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/newdmenuapi/payment/paymentGateways/RestId/%@",url];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}

-(void)getForceModifier:(NSString *)url
{
    serviceName=@"ForceModifier";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/%@",url];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}
-(void)getOptionModifier:(NSString *)url
{
    serviceName=@"OptionModifier";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/%@",url];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}

-(void)basePizza:(NSString *)url
{
    serviceName=@"BasePizza";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/%@",url];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}
-(void)toppingPizza:(NSString *)url
{
    serviceName=@"ToppingPizza";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/%@",url];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}
-(void)sizePizz:(NSString *)url
{
    serviceName=@"SizePizza";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/%@",url];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}
-(void)pizzaPrice:(NSString *)url
{
    serviceName=@"PizzaPrice";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/%@",url];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}
-(void)redemDiscount:(NSString *) param : (NSString *) url
{
    serviceName=@"RedemDiscount";
    NSString *urlString=[NSString stringWithFormat:@"%@%@",URI_HTTP,url];
    NSLog(@"%@",urlString);
    [self jsonPaseringWithPHP: param: urlString];
}
-(void)viewTableInTheRoom:(NSString *)url
{
    serviceName=@"ViewTable";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/newdmenuapi/%@",url];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}
-(void)businessHourForRestaurant:(NSString *)url
{
    serviceName=@"BusinessHour";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/restDetails/viewBusinessHours/restId/%@",url];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}

-(void)mercuryPayment:(NSString *)url
{
    serviceName=@"BusinessHour";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/restDetails/viewBusinessHours/restId/%@",url];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}

-(void)updateDeviceToken:(NSString *)url
{
    serviceName=@"UpdateDevice";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/pushNotification/sendPushNotification/%@",url];
    NSLog(@"%@",urlString);
    //  [self requestWithURL : urlString];
}

-(void)sendNotification:(NSString *) url
{
    serviceName=@"BusinessHour";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/pushNotification/sendPushNotification/%@",url];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}

-(void)myOpenOrderList:(NSString *)url
{
    serviceName=@"MyOpenOrder";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/orders/viewOpenOrders/%@",url];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}
-(void)orderProductList:(NSString *)url
{
    serviceName=@"OrderProduct";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/orders/viewOrder_prod/%@",url];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}

-(void)deviceIDUpdate:(NSString *)url
{
    serviceName=@"DeviceUpdate";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/pushNotification/registerDevice/%@",url];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}
-(void)updateSendOrder:(NSString *) urlString :(NSString *) param
{
    serviceName=@"UpdateSendOrder";
    NSString *urlString1=[NSString stringWithFormat:@"%@%@",URI_HTTP,urlString];
    NSLog(@"%@",urlString1);
    [self jsonPaseringWithPHP:param:urlString1];
}
-(void)taxList:(NSString *)url
{
    serviceName=@"RestaurantTax";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/payment/getTax/restId/%@",url];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}

-(void)forgotPassword:(NSString *) url
{
    serviceName=@"ForgotPassword";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/member/resetpassword/username/%@",url];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}
-(void)checkUserName:(NSString *)url
{
    serviceName=@"CheckUserName";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/checkLogin/checkUsername"];
    [self jsonPaseringWithPHP:url:urlString];
}

-(void)redeemPoints2:(NSString *) url :(NSString *) postString
{
    serviceName=@"RedeemPointts";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/munchPoints/redeemPoints2%@",url];
    [self jsonPaseringWithPHP:postString:urlString];
}
-(void)closedMyOrder:(NSString *)url
{
    serviceName=@"ClosedMyOrder";
    NSString *urlString=[NSString stringWithFormat:@"%@%@",URI_HTTP,url];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}

-(void)happyHour:(NSString *)url
{
    serviceName=@"HappyHour";
    NSString *urlString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/beacons/happyhourAll/%@",url];
    NSLog(@"%@",urlString);
    [self requestWithURL : urlString];
}


-(void)registeredBeaconList:(NSString *)urlString
{
    serviceName=@"RegisteredBeacon";
    NSString *postString=[NSString stringWithFormat:@"%@beaconList/restId/%@",@"http://ciboapp.com/admin/mobileApi/beacons/",urlString];
    [self requestWithURL : postString];
}
-(void)beaconCompaining:(NSString *)urlString
{
    //urlString=@"64672688";
    serviceName=@"BeaconCompain";
    NSString *postString=[NSString stringWithFormat:@"%@campaignList/restId/%@",@"http://ciboapp.com/admin/mobileApi/beacons/",urlString];
    [self requestWithURL : postString];
    //http://ciboapp.com/admin/mobileApi/beacons/campaignAll/restId/30692730/campaignId/3
}
-(void)allBeaconDetailWithCompainingID:(NSString *)urlString
{
    serviceName=@"AllBeaconIfnoWithCompainID";
    NSString *postString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/beacons/campaignAll/%@",urlString];
    [self requestWithURL: postString];
}

-(void)coupenBeacon:(NSString*)urlString
{
    serviceName=@"CouponBeacon";
    NSString *postString=[NSString stringWithFormat:@"%@%@",@"http://ciboapp.com/admin/mobileApi/beacons/",urlString];
    [self requestWithURL : postString];
}
-(void)happyHourBeacon:(NSString *)urlString
{
    serviceName=@"HappyHourBeacon";
    NSString *postString=[NSString stringWithFormat:@"%@campaignList/restId/%@",@"http://ciboapp.com/admin/mobileApi/beacons/",urlString];
    [self requestWithURL : postString];
}
-(void)checkINCheckOUTBeacon:(NSString *)urlString postData:(NSString *)postData
{
    serviceName=@"CheckInCheckOutBeacon";
    NSString *postString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/clientsVisit/%@",urlString];
    [self jsonPaseringWithPHP :postData :postString];
}

-(void)allRestaurantList:(NSString *) urlString
{
    serviceName=@"AllRestaurantList";
    NSString *postString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/restInfo/getRestInfo/country/%@",urlString];
    //NSString *postString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/restaurantInfo/restList"];
    NSLog(@"postString: %@",postString);
    [self requestWithURL : postString];
}

-(void)checkINDetailToServer:(NSString *) urlString
{
    urlString=@"";
    serviceName=@"CheckInDetailToServer";
    NSString *postString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/clientsVisit/"];
    [self requestWithURL : postString];
}

-(void)checkOutDetailToServer:(NSString *) urlString
{
    urlString=@"";
    serviceName=@"CheckOutDetailToServer";
    NSString *postString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/clientsVisit/"];
    [self requestWithURL : postString];
}
-(void)saveSpiltBill:(NSString *)urlString
{
    serviceName=@"SaveSpliteBill";
    NSString *postString=[NSString stringWithFormat:@"http://ciboapp.com/admin/mobileApi/orders/sendOrders/restId/%@", ciboRestaurantId];
    NSLog(@"%@",postString);
    [self jsonPaseringWithPHP:urlString :postString];
}
#pragma mark nsurlconnection delegate

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.delegate gettingFail:[error localizedDescription]];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    responseString=[[NSMutableString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    if ([serviceName isEqualToString:@"Login"])
    {
        [self.delegate loginSuccess:responseString];
    }
    else if ([serviceName isEqualToString:@"Registar"])
    {
        [self.delegate registrationApi:responseString];
    }
    else if ([serviceName isEqualToString:@"ViewUserInfo"])
    {
        [self.delegate viewUserDetail:responseString];
    }
    else if ([serviceName isEqualToString:@"UpdateUserDetail"])
    {
        [self.delegate updateUserDetail:responseString];
    }
    else if ([serviceName isEqualToString:@"RestaurentAddress"])
    {
        [self.delegate restaurentAddress:responseString];
    }
    else if ([serviceName isEqualToString:@"GettingRoom"])
    {
        [self.delegate gettingRoom:responseString];
    }
    else if ([serviceName isEqualToString:@"TimeSlot"])
    {
        [self.delegate timeSlotResponse:responseString];
    }
    else if ([serviceName isEqualToString:@"GettingGalleryInfo"])
    {
        [self.delegate gettingGallery:responseString];
    }
    else if ([serviceName isEqualToString:@"GettingEventInfo"])
    {
        [self.delegate gettingEvents:responseString];
    }
    else if ([serviceName isEqualToString:@"GettingCategory"])
    {
        [self.delegate gettingCategoryList:responseString];
    }
    else if ([serviceName isEqualToString:@"GettingSubCategory"])
    {
        [self.delegate gettingSumCategoryListFromMenu:responseString];
    }
    else if ([serviceName isEqualToString:@"GettingItemFromSubCategory"])
    {
        [self.delegate gettingItemOfSubCategory:responseString];
    }
    else if ([serviceName isEqualToString:@"GettingGalleryCategoryInfo"])
    {
        [self.delegate galleryCategoryFromServer:responseString];
    }
    else if ([serviceName isEqualToString:@"SendingOrder"])
    {
        [self.delegate sendingOrder:responseString];
    }
    else if ([serviceName isEqualToString:@"TableBooking"])
    {
        [self.delegate tableBooking:responseString];
    }
    else if ([serviceName isEqualToString:@"GettingLoyality"])
    {
        [self.delegate gettingLoyalityPunch:responseString];
    }
    else if ([serviceName isEqualToString:@"UserMounchPoint"])
    {
        [self.delegate gettingUserMounchPoints:responseString];
    }
    else if ([serviceName isEqualToString:@"RedemingPoints"])
    {
        [self.delegate redemmingMunchPoints:responseString];
    }
    else if ([serviceName isEqualToString:@"AddPoints"])
    {
        [self.delegate addMemberPoints:responseString];
    }
    else if ([serviceName isEqualToString:@"QRCode"])
    {
        [self.delegate sendQRCode:responseString];
    }
    else if ([serviceName isEqualToString:@"Information"])
    {
        [self.delegate restaurantInformation:responseString];
    }
    else if ([serviceName isEqualToString:@"RedeemingPointOfUser"])
    {
        [self.delegate userRedeemingPoint:responseString];
    }
    else if ([serviceName isEqualToString:@"ChechQRCode"])
    {
        [self.delegate checkQRCodeScannerISExist:responseString];
    }
    else if ([serviceName isEqualToString:@"AddRedeemingPoints"])
    {
        [self.delegate addingRedeemingPoints:responseString];
    }
    else if ([serviceName isEqualToString:@"SendOrderList"])
    {
        [self.delegate sentOrderListToTheServer:responseString];
    }
    else if ([serviceName isEqualToString:@"PaymentMethodList"])
    {
        [self.delegate paymentMethodList:responseString];
    }
    else if ([serviceName isEqualToString:@"GatewayAccess"])
    {
        [self.delegate gateWayCradintialAccess:responseString];
    }
    else if ([serviceName isEqualToString:@"ForceModifier"])
    {
        [self.delegate getForceModifier:responseString];
    }
    else if ([serviceName isEqualToString:@"OptionModifier"])
    {
        [self.delegate getOptionModifier:responseString];
    }
    else if ([serviceName isEqualToString:@"BasePizza"])
    {
        [self.delegate basePizza:responseString];
    }
    else if ([serviceName isEqualToString:@"ToppingPizza"])
    {
        [self.delegate toppingPizza:responseString];
    }
    else if ([serviceName isEqualToString:@"SizePizza"])
    {
        [self.delegate sizePizz:responseString];
    }
    else if ([serviceName isEqualToString:@"RedemDiscount"])
    {
        [self.delegate redemDiscount:responseString];
    }
    else if ([serviceName isEqualToString:@"BasePizza"])
    {
        [self.delegate basePizza:responseString];
    }
    else if ([serviceName isEqualToString:@"ToppingPizza"])
    {
        [self.delegate toppingPizza:responseString];
    }
    else if ([serviceName isEqualToString:@"SizePizza"])
    {
        [self.delegate sizePizz:responseString];
    }
    else if ([serviceName isEqualToString:@"PizzaPrice"])
    {
        [self.delegate sizePizz:responseString];
    }
    else if ([serviceName isEqualToString:@"ViewTable"])
    {
        [self.delegate viewTableInTheRoom:responseString];
    }
    else if ([serviceName isEqualToString:@"BusinessHour"])
    {
        [self.delegate businessHourForRestaurant:responseString];
    }
    else if ([serviceName isEqualToString:@"UpdateDevice"])
    {
        [self.delegate updateDeviceToken:responseString];
    }
    else if ([serviceName isEqualToString:@"MyOpenOrder"])
    {
        [self.delegate myOpenOrderList:responseString];
    }
    else if ([serviceName isEqualToString:@"OrderProduct"])
    {
        [self.delegate orderProductList:responseString];
    }
    else if ([serviceName isEqualToString:@"DeviceUpdate"])
    {
        [self.delegate deviceIDUpdate:responseString];
    }
    else if ([serviceName isEqualToString:@"UpdateSendOrder"])
    {
        [self.delegate updateSendOrder:responseString];
    }
    else if ([serviceName isEqualToString:@"RestaurantTax"])
    {
        [self.delegate taxList:responseString];
    }
    else if ([serviceName isEqualToString:@"ForgotPassword"])
    {
        [self.delegate forgotPassword:responseString];
    }
    else if ([serviceName isEqualToString:@"CheckUserName"])
    {
        [self.delegate checkUserName:responseString];
    }
    else if ([serviceName isEqualToString:@"RedeemPointts"])
    {
        [self.delegate redeemPoints2:responseString];
    }
    else if ([serviceName isEqualToString:@"ClosedMyOrder"])
    {
        [self.delegate closedMyOrder:responseString];
    }
    else if ([serviceName isEqualToString:@"RegisteredBeacon"])
    {
        [self.delegate registeredBeaconList:responseString];
    }
    else if ([serviceName isEqualToString:@"HappyHour"])
    {
        [self.delegate happyHour:responseString];
    }
    else if ([serviceName isEqualToString:@"BeaconCompain"])
    {
        [self.delegate beaconCompaining:responseString];
    }
    else if ([serviceName isEqualToString:@"CouponBeacon"])
    {
        [self.delegate coupenBeacon:responseString];
    }
    else if ([serviceName isEqualToString:@"HappyHourBeacon"])
    {
        [self.delegate happyHourBeacon:responseString];
    }
    else if ([serviceName isEqualToString:@"CheckInCheckOutBeacon"])
    {
        [self.delegate checkINCheckOUTBeacon:responseString];
    }
    else if ([serviceName isEqualToString:@"AllBeaconIfnoWithCompainID"])
    {
        [self.delegate allBeaconDetailWithCompainingID:responseString];
    }
    else if ([serviceName isEqualToString:@"AllRestaurantList"])
    {
        [self.delegate allRestaurantList:responseString];
    }
    else if ([serviceName isEqualToString:@"CheckInDetailToServer"])
    {
        [self.delegate checkINDetailToServer:responseString];
    }
    else if ([serviceName isEqualToString:@"CheckOutDetailToServer"])
    {
        [self.delegate checkOutDetailToServer:responseString];
    }
    
    //CheckInDetailToServer
}



- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    if([protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        
        return YES;
    }
    else
    {
        if([protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodHTTPBasic])
        {
            return YES;
        }
    }
    return NO;
    
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge
{
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
    }
    else
    {
        if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodHTTPBasic])
        {
            
            NSURLCredential *creden = [[NSURLCredential alloc] initWithUser:@"admin" password:@"123" persistence:NSURLCredentialPersistenceForSession];
            
            
            [[challenge sender] useCredential:creden forAuthenticationChallenge:challenge];
            [creden release];
        }
        else
        {
            [[challenge sender]cancelAuthenticationChallenge:challenge];
            
        }
    }
}



////////////////////////////////////////////////
////////////                     ///////////////
//////////// DATABASE CONNECTION ///////////////
////////////                     ///////////////
////////////////////////////////////////////////

#pragma mark -  database value on view
+(NSMutableDictionary *) dataReadFromLocalDataBase: (NSString *) databaseName :(NSString *) databaseQuery :(NSString *) queryName
{
    // Setup the database object
    // Get the path to the documents directory and append the databaseName
    NSMutableDictionary *allGOTDATA =[[NSMutableDictionary alloc] init];
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    NSLog(@"%@",databasePath);
    NSFileManager   *fileManager = [NSFileManager defaultManager];
    BOOL   success = [fileManager fileExistsAtPath:databasePath];
    
    if(!success)
    {
        NSString  *databasepath1 = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
        [fileManager copyItemAtPath:databasepath1 toPath:databasePath error:nil];
    }
    
    sqlite3 *database;
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, [databaseQuery UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            if ([queryName isEqualToString:@"Follow"])
            {
                NSMutableArray *followNameArray = [[NSMutableArray alloc] init];
                NSMutableArray *staffNameArray =  [[NSMutableArray alloc] init];
                NSMutableArray *followTypeArray = [[NSMutableArray alloc] init];
                NSMutableArray *followInfoArray = [[NSMutableArray alloc] init];
                NSMutableArray *followDateArray = [[NSMutableArray alloc] init];
                while(sqlite3_step(compiledStatement) == SQLITE_ROW)
                {
                    // Read the data from the result row
                    NSString *followNane = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                    NSString *staffname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                    
                    NSString *followtype = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                    
                    NSString *followinfo = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,2)];
                    NSString *followdate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,1)];
                    
                    
                    if ([followNane length]==0)
                    {
                        [followNameArray addObject:@""];
                    }
                    else
                    {
                        [followNameArray addObject:followNane];
                        //  NSLog(@"%@",followNameArray);
                    }
                    if ([staffname length]==0)
                    {
                        [staffNameArray addObject:@""];
                    }
                    else
                    {
                        [staffNameArray addObject:staffname];
                    }
                    if ([followtype length]==0)
                    {
                        [followTypeArray addObject:@""];
                    }
                    else
                    {
                        [followTypeArray addObject:followtype];
                    }
                    if ([followinfo length]==0)
                    {
                        [followInfoArray addObject:@""];
                    }
                    else
                    {
                        [followInfoArray addObject:followinfo];
                    }
                    if ([followdate length]==0)
                    {
                        [followDateArray addObject:@""];
                    }
                    else
                    {
                        [followDateArray addObject:followdate];
                    }
                }
                [allGOTDATA setValue:followNameArray forKey:@"followNameArray"];
                [allGOTDATA setValue:staffNameArray forKey:@"staffNameArray"];
                [allGOTDATA setValue:followTypeArray forKey:@"followTypeArraay"];
                [allGOTDATA setValue:followInfoArray forKey:@"followinfoArray"];
                [allGOTDATA setValue:followDateArray forKey:@"followDateArray"];
                
                [followNameArray release];
                [staffNameArray release];
                [followTypeArray release];
                [followInfoArray release];
                [followDateArray release];
                
            }
            // Loop through the results and add them to the feeds array
        }
        // Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    return allGOTDATA;
}




@end
