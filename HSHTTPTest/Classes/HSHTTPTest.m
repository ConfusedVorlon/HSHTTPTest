//
//  HTTPTest.m
//  HS_WebsiteTests
//
//  Created by Rob Jonson on 11/05/2015.
//  Copyright (c) 2015 HobbyistSoftware. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "HSHTTPTest.h"

@interface HSHTTPTest() <NSURLConnectionDelegate,NSURLConnectionDataDelegate>



@end

@implementation HSHTTPTest


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.data=[NSMutableData data];
        self.redirects=[NSMutableArray array];
        self.requests=[NSMutableArray array];
    }
    return self;
}


#pragma mark convenience initialisers

+(HSHTTPTest*)testAddress:(NSString*)address stopDownloadAfter:(NSInteger)numberOfBytes forTestCase:(XCTestCase*)testCase
{
    
    HSHTTPTest *test=[HSHTTPTest new];
    XCTestExpectation *expectation = [testCase expectationWithDescription:address];
    
    test.downloadLimit=numberOfBytes;
    test.expectation=expectation;
    
    [test testAddress:address];
    
    return test;
}

+(HSHTTPTest*)testAddress:(NSString*)string forTestCase:(XCTestCase*)testCase
{
    return [self testAddress:string
           stopDownloadAfter:0
                 forTestCase:testCase];
}

#pragma mark test methods

-(void)testAddress:(NSString*)address
{
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:address]
                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                       timeoutInterval:60];
    
    self.connection=[[NSURLConnection alloc] initWithRequest:request
                                                    delegate:self
                                            startImmediately:NO];
    
    [self.connection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                               forMode:NSDefaultRunLoopMode];
    
    
}

-(void)start
{
    [self.connection start];
}

#pragma mark info methods

-(NSDictionary*)headers
{
    return [(NSHTTPURLResponse*)self.response allHeaderFields];
}

-(NSString*)contentType
{
    return [[self headers] objectForKey:@"Content-Type"];
}

-(NSInteger)contentLength
{
    return [[[self headers] objectForKey:@"Content-Length"] integerValue];
}

-(NSHTTPURLResponse*)firstRedirect
{
    return [self.redirects firstObject];
}

-(NSString*)dataAsString
{
    NSString *string=[[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    
    return string;
}

#pragma mark connection delegate methods

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    //NSLog(@"connectionDidFailWithError: %@",error);
    
    self.error=error;
    
    [self.expectation fulfill];
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    //NSLog(@"connectionDidReceiveData");
    
    [self.data appendData:data];
    if (self.downloadLimit && [self.data length]>self.downloadLimit)
    {
        [self.connection cancel];
        [self.expectation fulfill];
    }
}

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
    //NSLog(@"connectionDidReceiveResponse");
    
    NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse*)response;
    
    self.statusCode=httpResponse.statusCode;
    self.response=response;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //NSLog(@"connectionDidFinishLoading");
    
    [self.expectation fulfill];
}

- (NSURLRequest *)connection:(NSURLConnection *)connection
             willSendRequest:(NSURLRequest *)request
            redirectResponse:(NSURLResponse *)redirectResponse
{
    if (redirectResponse)
    {
        [self.redirects addObject:redirectResponse];
        
        if (!self.allowRedirect)
        {
            NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse*)redirectResponse;
            
            self.statusCode=httpResponse.statusCode;
            self.response=redirectResponse;
            
            [connection cancel];
            
            [self.expectation fulfill];
            
            return nil;
        }
        
    }
    
    [self.requests addObject:request];
    
    return request;
}





@end
