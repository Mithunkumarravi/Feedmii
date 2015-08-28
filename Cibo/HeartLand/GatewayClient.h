//
//  GatewayClient.h
//  iOSSample
//
//  Created by  on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HeartLandPaymentProtocalDeleage <NSObject>
@optional
-(void)heartLandPaymentResponseMessage:(NSString *)resposne;
-(void)heartLandPaymentResponseCode:(NSString *)resposne;
-(void)heartLandPaymentResponseTranID:(NSString *)resposne;

@end


typedef enum
{
    CreditSale                  //All new "Gateway Request Types" will be added here
} GatewayRequestType;

@interface GatewayClient : NSObject
{
    NSURLConnection *_connection;
    NSHTTPURLResponse *_response;
    NSMutableData *responseData;
    NSTimer *_responseTimer;
    NSMutableString *_body;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic) GatewayRequestType requestType;
@property BOOL wasCardSwiped;
@property (nonatomic, copy) NSString *cardNumber;
@property (nonatomic, copy) NSString *expirationMonth;
@property (nonatomic, copy) NSString *expirationYear;
@property BOOL isCardPresent;
@property BOOL isReaderPresent;
@property (nonatomic, copy) NSString *txnAmount;
@property (nonatomic,strong)id <HeartLandPaymentProtocalDeleage>delegateHeartLand;

-(void)sendRequest:(NSMutableDictionary *)paymentInfo;                      //Method to send request to the Gateway
-(NSData*)getRequestBody:(NSMutableDictionary *)paymentInfo;               //Method will give complete request message

-(void)addCreditSaleParameters;         // Add Parameters for making Credit Sale Request. May others based on type of request


-(void)addCardDataSection;              //Method to add Card Data Section

@end
