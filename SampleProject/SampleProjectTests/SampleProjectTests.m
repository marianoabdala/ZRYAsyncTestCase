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

#pragma mark - SenTestCase
- (void)testPerformAfterDelay {
    
    [self performJobAfterDelay];
    
    ZRYAssertPerformsBeforeTimout(6.0f, @"Failed to get any results in time.");
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
    
    ZRYAssertPerformsBeforeTimout(20.0f, @"Failed to download image in time.");
    
    UIImage *downloadedImage =
    [UIImage imageWithData:self.data];
    
    STAssertNotNil(downloadedImage, @"Downloaded image was nil.");
}

- (void)testPerformBlockWithSleep {
    
    NSOperationQueue *backgroundQueue =
    [[NSOperationQueue alloc] init];
    
    [backgroundQueue addOperationWithBlock:^{
        
        sleep(3);
        
        ZRYAssertionPerformedBeforeTimeout();
    }];
    
    ZRYAssertPerformsBeforeTimout(5.0f, @"Failed to awake in time.");
}

#pragma mark - Self
#pragma mark SampleProjectTests
- (void)performJobAfterDelay {
    
    [self performSelector:@selector(finishPerformingJobAfterDelay)
               withObject:nil
               afterDelay:5.0f];
}

- (void)finishPerformingJobAfterDelay {
    
    ZRYAssertionPerformedBeforeTimeout();
}

#pragma mark - Protocols
#pragma mark NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

    STFail(error.description);
}

#pragma mark NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    [self.data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
 
    ZRYAssertionPerformedBeforeTimeout();
}

@end
