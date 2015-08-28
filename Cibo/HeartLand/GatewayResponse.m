//
//  GatewayResponse.m
//  iOSSample
//
//  Created by  on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GatewayResponse.h"
#import <Foundation/NSString.h>

@implementation GatewayResponse

@synthesize httpResponseCode = _httpResponseCode;
@synthesize gatewayResponseCode = _gatewayResponseCode;     //Gateway response code. Usually "0" for success.
@synthesize gatewayResponseMsg = _gatewayResponseMsg;       //Gateway response message
@synthesize responseCode = _responseCode;
@synthesize responseMsg = _responseMsg;
@synthesize gatewayTxnId = _gatewayTxnId;                   //Transaction unique id from Gateway side
@synthesize delegateHeartLand;


NSMutableArray *elementStack;
NSMutableString *buffer;

-(void)parse:(GatewayRequestType)gatewayRequestType :(NSData*)input
{
    _gatewayRequestType = gatewayRequestType;
    elementStack = [NSMutableArray array];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:input];
    [parser setDelegate:self];
	[parser setShouldProcessNamespaces:FALSE];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[parser parse];
}

#pragma mark Parser

//Method to parse xml message
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	if (qName)
	{
		elementName = qName;
	}
	
    //	NSLog(@"elementName: %@", elementName);
    
    //push full path to element onto stack
    NSString *xmlPath = [elementStack lastObject];
    if (xmlPath == nil)
        xmlPath = @"";
    [elementStack addObject:[NSString stringWithFormat:@"%@/%@", xmlPath, elementName]];
    
        NSLog(@"%@",[elementStack lastObject]);
    
    buffer = [NSMutableString string];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (buffer)
	{
		[buffer appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSString *gatewayRequestTypeString = nil;
    switch (_gatewayRequestType)
    {
        case CreditSale:
            gatewayRequestTypeString = @"CreditSale";
            break;
        default:
            break;
    }
    
  /********************************************************* RESPONSE COMING FROM GATEWAY ARE BEING PARSED HERE ***********************************************************/
    NSString *xmlPath = [elementStack lastObject];
    
    if ([xmlPath isEqualToString:@"/soap:Envelope/soap:Body/PosResponse/Ver1.0/Header/GatewayRspCode"])
    {
        self.gatewayResponseCode = [self trim:buffer];
        [self.delegateHeartLand hpResponseCode:self.gatewayResponseCode];
    }
    else if ([xmlPath isEqualToString:@"/soap:Envelope/soap:Body/PosResponse/Ver1.0/Header/GatewayRspMsg"])
    {
         self.gatewayResponseMsg = [self trim:buffer];
        [self.delegateHeartLand hPResponseMessage:self.gatewayResponseMsg];
    }
    else if ([xmlPath isEqualToString:@"/soap:Envelope/soap:Body/PosResponse/Ver1.0/Header/GatewayTxnId"])
    {
        self.gatewayTxnId = [[self trim:buffer] intValue];
        [self.delegateHeartLand hpResponseTransectionId:[self trim:buffer]];
    }
    else if ([xmlPath isEqualToString:[NSString stringWithFormat:@"/soap:Envelope/soap:Body/PosResponse/Ver1.0/Transaction/%@/RspCode", gatewayRequestTypeString]])
        self.responseCode = [self trim:buffer];
    else if ([xmlPath isEqualToString:[NSString stringWithFormat:@"/soap:Envelope/soap:Body/PosResponse/Ver1.0/Transaction/%@/RspText", gatewayRequestTypeString]])
        self.responseMsg = [self trim:buffer];    
    
    [elementStack removeLastObject];
}

//Helper function to trim out some white space and new line characters from xml string
-(NSString*)trim:(NSMutableString *)string{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark -

@end
