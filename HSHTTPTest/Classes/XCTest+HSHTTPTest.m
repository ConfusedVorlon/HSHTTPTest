//
//  XCTest+HTTPTest.m
//  HSWebsite
//
//  Created by Rob Jonson on 12/05/2015.
//  Copyright (c) 2015 HobbyistSoftware. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XCTest+HSHTTPTest.h"

@implementation XCTestCase (HSHTTPTest)

-(void)do200TestAddress:(NSString*)address stopDownloadAfter:(NSInteger)numberOfBytes allowRedirect:(BOOL)allowRedirect validate:(void(^)(HSHTTPTest* test))validate
{
    
    [self doTestAddress:address
                stopDownloadAfter:numberOfBytes
          allowRedirect:allowRedirect
               validate:^(HSHTTPTest *test) {
                  
                   XCTAssertEqual(200,test.statusCode,@" for address: %@",address);
                   
                   validate(test);
                   
               }];
}

-(void)doTestAddress:(NSString*)address stopDownloadAfter:(NSInteger)numberOfBytes allowRedirect:(BOOL)allowRedirect validate:(void(^)(HSHTTPTest* test))validate
{
    NSLog(@"testing: %@",address);
    
    HSHTTPTest *test=[HSHTTPTest testAddress:address stopDownloadAfter:numberOfBytes forTestCase:self];
    
    [test setAllowRedirect:allowRedirect];
    [test start];
    
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError *error) {
   
                                     validate(test);
                                 }];
}

-(void)do200TestAddress:(NSString*)address validate:(void(^)(HSHTTPTest* test))validate
{
    [self do200TestAddress:address
                   stopDownloadAfter:0
             allowRedirect:NO
                  validate:validate];
}

@end