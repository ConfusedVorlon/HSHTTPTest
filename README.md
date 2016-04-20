# HSHTTPTest

Test your website using Xcode and XCTest

## Usage

Create a new Xcode OSX project with a test target.
In your test class 

```#import "HSHTTPTest.h"```

Add tests such as...

Test an address returns 200 status code, and contains expected content:
```
[self do200TestAddress:@"http://blog.hobbyistsoftware.com"
	              validate:^(HSHTTPTest *test) {
	                  NSString *site=[test dataAsString];

	                  XCTAssertTrue([site containsString:@"Messages from Hobbyist Software"]);
	                  }];
```

Test your 404 page works

```
[self doTestAddress:@"http://hobbyistsoftware.com/notAPage"
                stopDownloadAfter:0
          allowRedirect:YES
               validate:^(HSHTTPTest *test) {
                   NSString *site=[test dataAsString]; 
                   XCTAssertTrue([site containsString:@"Doh! Page not found"]);
                   
                   XCTAssertEqual(404,test.statusCode,@" for address: %@",address);
               }];
```

Test that a redirect goes to the right place
```
[self doTestAddress:@"http://forum.hobbyistsoftware.com"
                stopDownloadAfter:0
          allowRedirect:YES
               validate:^(HSHTTPTest *test) {
                   
                   //redirect should be permanent
                   NSHTTPURLResponse *firstRedirect=test.firstRedirect;
                   XCTAssertEqual(firstRedirect.statusCode, 301);
                   
                   NSString *firstRedirectAddress=[[firstRedirect allHeaderFields] objectForKey:@"Location"];
                   XCTAssertEqualObjects(firstRedirectAddress, @"http://hobbyistsoftware.com/forum");
               }];
```

Test that redirect ends up at the right place, and that content type is correct
(without downloading the full file)
```
[self do200TestAddress:@"http://hobbyistsoftware.com//Downloads/Watchover/latest-mac.php"
                       stopDownloadAfter:5000
                 allowRedirect:YES
                      validate:^(HSHTTPTest *test) {
                          
                          XCTAssertTrue(test.redirects.count>=1);
                          XCTAssertEqualObjects(test.contentType, @"application/x-apple-diskimage");
      
                          NSURLRequest *lastRequest=[test.requests lastObject];
                          NSString *lastAddress=[[lastRequest URL] absoluteString];
                          
                          XCTAssertTrue([lastAddress containsString:@"Downloads/Watchover/Versions/Watchover_"]);
                          
                      }];
```


Run your tests in Xcode (Menu/Product/Test)

## Requirements

You should be familiar with running tests in Xcode

## Installation

HSHTTPTest is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "HSHTTPTest"
```

## Author

Rob, Rob@HobbyistSoftware.com

## License

HSHTTPTest is available under the MIT license. See the LICENSE file for more info.
