//
//  GatewayResponse.h
//  iOSSample
//
//  Created by Davis, Darrell on 5/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GatewayClient.h"

@protocol HPResponseProtocalDeleage <NSObject>
@optional
-(void)hPResponseMessage:(NSString *)resposne;
-(void)hpResponseTransectionId:(NSString *)response;
-(void)hpResponseCode:(NSString *)response;
@end

@interface GatewayResponse : NSObject <NSXMLParserDelegate>
{
    GatewayRequestType _gatewayRequestType;
}

@property int httpResponseCode;
@property (nonatomic, copy) NSString *gatewayResponseCode;
@property (nonatomic, copy) NSString *gatewayResponseMsg;
@property (nonatomic, copy) NSString *responseCode;
@property (nonatomic, copy) NSString *responseMsg;

@property int gatewayTxnId;

@property (nonatomic, strong)id <HPResponseProtocalDeleage>delegateHeartLand;
-(void)parse:(GatewayRequestType)gatewayRequestType :(NSData*)input;                //Method use to parse xml message coming from Gateway.

@end