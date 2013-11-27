//
//  ZRYAsyncTestCase.h
//  ZRYAsyncTestCase
//
//  Created by Mariano Abdala on 6/26/13.
//  Copyright (c) 2013 Zerously.com. All rights reserved.
//
//  https://github.com/marianoabdala/ZRYAsyncTestCase
//


#import <XCTest/XCTest.h>

#define ZRYWaitForSeconds(seconds) \
({ \
    BOOL timeRemains = \
    [self waitForCompletion:seconds]; \
    \
    self.operationFinishedPerforming = NO; \
    \
    if (timeRemains == NO) { \
        \
        NSString *description = [NSString stringWithFormat:@"Timeout after %.02f seconds.", seconds]; \
        \
        [self recordFailureWithDescription:description \
                                inFile:[NSString stringWithUTF8String: __FILE__] \
                                atLine:__LINE__ \
                              expected:NO]; \
    } \
})


#define ZRYComplete() \
({ \
    self.operationFinishedPerforming = YES; \
})

@interface ZRYAsyncTestCase : XCTestCase

@property (assign, nonatomic, getter = hasOperationFinishedPerforming) BOOL operationFinishedPerforming;

- (BOOL)waitForCompletion:(NSTimeInterval)timeInterval;

@end
