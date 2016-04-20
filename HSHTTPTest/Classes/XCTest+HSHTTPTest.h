//
//  XCTest+HTTPTest.h
//  HSWebsite
//
//  Created by Rob Jonson on 12/05/2015.
//  Copyright (c) 2015 HobbyistSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSHTTPTest.h"

@class HSHTTPTest;

@interface XCTestCase (HSHTTPTest)

/**
 @abstract test an address. Include a validation test for a 200 status code
 @param address address to test
 @param numberOfBytes stop download after receiving this number of bytes (use 0 to indicate download should run to natural completion)
 @param allowRedirect follow redirects
 @param validate validation block to run
 @return initialised HSHTTPTest
 **/
-(void)do200TestAddress:(NSString*)address stopDownloadAfter:(NSInteger)numberOfBytes allowRedirect:(BOOL)allowRedirect validate:(void(^)(HSHTTPTest* test))validate;

/**
 @abstract test an address. Include a validation test for a 200 status code. Redirects are not followed, download size is not limited.
 @param address address to test
 @param validate validation block to run
 @return initialised HSHTTPTest
 **/
-(void)do200TestAddress:(NSString*)address validate:(void(^)(HSHTTPTest* test))validate;


/**
 @abstract test an address.
 @param address address to test
 @param numberOfBytes stop download after receiving this number of bytes (use 0 to indicate download should run to natural completion)
 @param allowRedirect follow redirects
 @param validate validation block to run
 @return initialised HSHTTPTest
 **/
-(void)doTestAddress:(NSString*)address stopDownloadAfter:(NSInteger)numberOfBytes allowRedirect:(BOOL)allowRedirect validate:(void(^)(HSHTTPTest* test))validate;

@end

