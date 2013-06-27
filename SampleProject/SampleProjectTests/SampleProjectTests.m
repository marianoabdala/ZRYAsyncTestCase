//
//  SampleProjectTests.m
//  SampleProjectTests
//
//  Created by Mariano Abdala on 6/26/13.
//  Copyright (c) 2013 Zerously.com. All rights reserved.
//

#import "SampleProjectTests.h"

@interface SampleProjectTests ()

- (void)performJobAfterDelay;
- (void)finishPerformingJobAfterDelay;

@end

@implementation SampleProjectTests

#pragma mark - SenTestCase
- (void)testPerformAfterDelay {
    
    [self performJobAfterDelay];
    
    ZRYAssertPerformsBeforeTimout(6.0f, @"Failed to get any results in time.");
}

#pragma mark - Self
#pragma mark sampleprojectTests
- (void)performJobAfterDelay {
    
    [self performSelector:@selector(finishPerformingJobAfterDelay)
               withObject:nil
               afterDelay:5.0f];
}

- (void)finishPerformingJobAfterDelay {
    
    ZRYAssertionPerformedBeforeTimeout();
}


@end
