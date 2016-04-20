//
//  HTTPTest.h
//  HS_WebsiteTests
//
//  Created by Rob Jonson on 11/05/2015.
//  Copyright (c) 2015 HobbyistSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCTest+HSHTTPTest.h"

@class XCTestExpectation;

@interface HSHTTPTest : NSObject

#pragma mark configuration

/** Stop download when download limit is reached (this allows you to run tests without waiting for large downloads). Default is 0 which allows download to complete fully **/
@property (assign) NSInteger downloadLimit;
/** Expectation which is fulfilled when the download completes **/
@property (retain) XCTestExpectation *expectation;
/** Should the test follow redirects **/
@property (assign) BOOL allowRedirect;


/** 
 @param address address to test
 @param numberOfBytes stop download after receiving this number of bytes (use 0 to indicate download should run to natural completion)
 @param testCase test case calling the test (which will generate the expectation)
 @return initialised HSHTTPTest
 **/
+(HSHTTPTest*)testAddress:(NSString*)address stopDownloadAfter:(NSInteger)numberOfBytes forTestCase:(XCTestCase*)testCase;

/**
 @param address address to test
 @param testCase test case calling the test (which will generate the expectation)
 @return initialised HSHTTPTest
 **/
+(HSHTTPTest*)testAddress:(NSString*)string forTestCase:(XCTestCase*)testCase;

/** start the test **/
-(void)start;

#pragma mark Info about the result of the test

/** response from the download **/
@property (retain) NSURLResponse *response;
/** Downloaded data **/
@property (retain) NSMutableData *data;
/** Any error encountered **/
@property (retain) NSError *error;
/** Final status code **/
@property (assign) NSInteger statusCode;
/** Connection used **/
@property (retain) NSURLConnection *connection;
/** Array of NSHTTPURLResponse objects. The first redirect is the first object **/
@property (retain) NSMutableArray *redirects;
/** Array of requests sent **/
@property (retain) NSMutableArray *requests;

/** Content type of final response **/
-(NSString*)contentType;
/** Content length from the response header **/
-(NSInteger)contentLength;
/** First redirect sent (or NULL) **/
-(NSHTTPURLResponse*)firstRedirect;
/* Data converted as NSUTF8StringEncoding to a string */
-(NSString*)dataAsString;

@end


