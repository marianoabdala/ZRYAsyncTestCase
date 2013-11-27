//
//  SampleProjectTests.m
//  SampleProjectTests
//
//  Created by Mariano Abdala on 6/26/13.
//  Copyright (c) 2013 Zerously.com. All rights reserved.
//

#import "SampleProjectTests.h"

@interface SampleProjectTests () <
    NSURLConnectionDelegate,
    NSURLConnectionDataDelegate>

@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSMutableData *data;

- (void)performJobAfterDelay;
- (void)finishPerformingJobAfterDelay;

@end

@implementation SampleProjectTests

#pragma mark - XCTestCase
- (void)testPerformAfterDelay {
    
    [self performJobAfterDelay];
    
    ZRYWaitForSeconds(6.0f);
}

- (void)testPerformURLDownload {

    NSURL *url =
    [NSURL URLWithString:@"https://raw.github.com/marianoabdala/ZRYAsyncTestCase/master/Resources/Kato.jpg"];
    
    NSURLRequest *urlRequest =
    [[NSURLRequest alloc] initWithURL:url];
    
    self.connection =
    [[NSURLConnection alloc] initWithRequest:urlRequest
                                    delegate:self];
    
    self.data =
    [NSMutableData data];

    [self.connection start];
    
    ZRYWaitForSeconds(20.0f);
    
    UIImage *downloadedImage =
    [UIImage imageWithData:self.data];
    
    XCTAssertNotNil(downloadedImage, @"Downloaded image was nil.");
}

- (void)testPerformBlockWithSleep {
    
    NSOperationQueue *backgroundQueue =
    [[NSOperationQueue alloc] init];
    
    [backgroundQueue addOperationWithBlock:^{
        
        sleep(3);
        
        ZRYComplete();
    }];
    
    ZRYWaitForSeconds(5.0f);
}

#pragma mark - Self
#pragma mark SampleProjectTests
- (void)performJobAfterDelay {
    
    [self performSelector:@selector(finishPerformingJobAfterDelay)
               withObject:nil
               afterDelay:5.0f];
}

- (void)finishPerformingJobAfterDelay {
    
    ZRYComplete();
}

#pragma mark - Protocols
#pragma mark NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

    XCTFail(@"Failed with error: %@", error.description);
}

#pragma mark NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    [self.data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
 
    ZRYComplete();
}

@end
