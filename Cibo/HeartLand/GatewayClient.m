//
//  GatewayClient.m
//  iOSSample
//
//  Created by  on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GatewayClient.h"
#import "GatewayResponse.h"                 //Import Gateway Response header file in order to handle response


@interface GatewayClient ()<HPResponseProtocalDeleage>
{
    
}
@end

@implementation GatewayClient

@synthesize delegate = _delegate;
@synthesize requestType = _requestType;
@synthesize wasCardSwiped = _wasCardSwiped;
@synthesize cardNumber = _cardNumber;
@synthesize expirationMonth = _expirationMonth;
@synthesize expirationYear = _expirationYear;
@synthesize isCardPresent = _isCardPresent;
@synthesize isReaderPresent = _isReaderPresent;
@synthesize txnAmount = _txnAmount;


-(void)sendRequest:(NSMutableDictionary *)paymentInfo
{
	responseData = [NSMutableData data];
    NSString *urlString = @"https://posgateway.secureexchange.net/Hps.Exchange.PosGateway/PosGatewayService.asmx";  //Production url
    
    urlString = @"https://posgateway.cert.secureexchange.net/Hps.Exchange.PosGateway/posgatewayservice.asmx";       //Development url
    
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];    //Currently app is using Development url
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/xml; charset=UTF-8" forHTTPHeaderField:@"content-type"];
    
    [request setHTTPBody:[self getRequestBody:paymentInfo]];                //Set the request body message.
    
	_connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    _responseTimer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(responseTimerDidFire:) userInfo:nil repeats:FALSE];  //response timeout set to 20 seconds, in case of no response from Gateway it will fire timeout.
}

//Delegate method, get invoked when receive response from Gateway
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response
{
    _response = response;
}

//Delegate method, get invoked when receive data from Gateway
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[responseData appendData:data];
}

//Delegate method, get invoked when app has completed the loading of response message from Gateway.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [_responseTimer invalidate];
    GatewayResponse *gatewayResponse = [[GatewayResponse alloc] init];
    gatewayResponse.delegateHeartLand=self;
    [gatewayResponse parse:self.requestType :responseData];
    gatewayResponse.httpResponseCode = _response.statusCode;

    if ([self.delegate respondsToSelector:@selector(didReceiveGatewayResponse::)])
        //  [self.delegate didReceiveGatewayResponse:self :gatewayResponse];
        NSLog(@"Response Received....");
}

//Delegate method, get invoked when there is connection issue while trying to communicate with Gateway
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", [error localizedDescription]);
    [_responseTimer invalidate];
    if ([self.delegate respondsToSelector:@selector(didReceiveGatewayCommunicationsError::)])
        //[self.delegate didReceiveGatewayCommunicationsError:self :error];
        NSLog(@"Gateway Error; %@", error);
}

//Time out method will fire after 20 seconds according to the current settings. If no response from Gateway
- (void)responseTimerDidFire:(NSTimer*)theTimer
{
    [_connection cancel];
    [_responseTimer invalidate];
    if ([self.delegate respondsToSelector:@selector(didAbortGatewayRequest:)])
        //[self.delegate didAbortGatewayRequest:self];
        NSLog(@"Gateway AbortMessage; %@", self);
}

//Preparing Message to send to the Gateway
-(NSData*)getRequestBody:(NSMutableDictionary *)paymentInfo
{
    _body = [NSMutableString string];
    //Develop Header section that will be used to send each message. Please use your appropriate credentials where-ever you find xxxxxx
    
    [_body appendString:@"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"];         //Begining of xml message
    [_body appendString:@"<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">"];
    [_body appendString:@"<soap:Body>"];
    [_body appendString:@"<PosRequest clientType=\"PosGatewayClient\" clientVer=\"1.4.0.1\" xmlns=\"http://Hps.Exchange.PosGateway\">"];
    [_body appendString:@"<Ver1.0>"];
    [_body appendString:@"<Header>"];
    
    //!!!!Important!!!!Please use your values instead of xxxxx
    /*[_body appendString:[NSString stringWithFormat:@"<LicenseId>%@</LicenseId>",[paymentInfo objectForKey:@"LicenseId"]]];
    [_body appendString:[NSString stringWithFormat:@"<SiteId>%@</SiteId>",[paymentInfo objectForKey:@"SiteId"]]];
    [_body appendString:[NSString stringWithFormat:@"<DeviceId>%@</DeviceId>",[paymentInfo objectForKey:@"DeviceId"]]];
    [_body appendString:[NSString stringWithFormat:@"<UserName>%@</UserName>",[paymentInfo objectForKey:@"UserName"]]];
    [_body appendString:[NSString stringWithFormat:@"<Password>%@</Password>",[paymentInfo objectForKey:@"Password"]]];*/
    
    [_body appendString:[NSString stringWithFormat:@"<LicenseId>20451</LicenseId>"]];
    [_body appendString:[NSString stringWithFormat:@"<SiteId>20442</SiteId>"]];
    [_body appendString:[NSString stringWithFormat:@"<DeviceId>90692318</DeviceId>"]];
    [_body appendString:[NSString stringWithFormat:@"<UserName>16070172</UserName>"]];
    [_body appendString:[NSString stringWithFormat:@"<Password>$Test1234</Password>"]];
    
    //[_body appendString:@"<DeveloperID>141302</DeveloperID>"]; optional
    //[_body appendString:@"<VersionNbr>xxxxx</VersionNbr>"];    optional
    
    [_body appendString:@"</Header>"];
    [_body appendString:@"<Transaction>"];
    
    switch (self.requestType)
    {
        case CreditSale:
            [self addCreditSaleParameters];
            break;
        default:
            break;
    }
    
    [_body appendString:@"</Transaction>"];
    [_body appendString:@"</Ver1.0>"];
    [_body appendString:@"</PosRequest>"];
    [_body appendString:@"</soap:Body>"];
    [_body appendString:@"</soap:Envelope>"];        //End of xml message.
    NSLog(@"%@",_body);
    return [_body dataUsingEncoding:NSUTF8StringEncoding];
}

-(void)addCreditSaleParameters
{
    [_body appendString:@"<CreditSale>"];
    [_body appendString:@"<Block1>"];
    [self addCardDataSection];
    [self appendXmlElement:@"Amt" withText:self.txnAmount];     //Appending transaction amount to the message body
    [_body appendString:@"</Block1>"];
    [_body appendString:@"</CreditSale>"];
}

//Appending Card related input, entered by the user.
-(void)addCardDataSection
{
    [_body appendString:@"<CardData>"];
    [_body appendString:@"<ManualEntry>"];
    [self appendXmlElement:@"CardNbr" withText:self.cardNumber];        //Appending Card Number to the message body
    [self appendXmlElement:@"ExpMonth" withText:self.expirationMonth];  //Appending expiration month to the message body
    [self appendXmlElement:@"ExpYear" withText:self.expirationYear];    //Appending expiration year to the message body
    [_body appendString:@"</ManualEntry>"];
    [_body appendString:@"</CardData>"];
}

//Helper function to create xml string
-(void)appendXmlElement:(NSString*)elementName withText:(NSString*)text
{
    text = [text stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    [_body appendString:[NSString stringWithFormat:@"<%@>%@</%@>", elementName, text, elementName]];
}

-(void)hPResponseMessage:(NSString *)resposne
{
    [self.delegateHeartLand heartLandPaymentResponseMessage:resposne];
}
-(void)hpResponseTransectionId:(NSString *)response
{
    [self.delegateHeartLand heartLandPaymentResponseTranID:response];
}
-(void)hpResponseCode:(NSString *)response
{
    [self.delegateHeartLand heartLandPaymentResponseCode:response];
}


@end
