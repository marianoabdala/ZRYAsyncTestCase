//
//  ZRYAsyncTestCase.h
//  ZRYAsyncTestCase
//
//  Created by Mariano Abdala on 6/26/13.
//  Copyright (c) 2013 Zerously.com. All rights reserved.
//
//  https://github.com/marianoabdala/ZRYAsyncTestCase
//


#import <SenTestingKit/SenTestingKit.h>

#define ZRYAssertPerformsBeforeTimout(seconds, format...) \
({ \
    BOOL timeRemains = \
    [self waitForCompletion:seconds]; \
    \
    self.operationFinishedPerforming = NO; \
    \
    if (timeRemains == NO) { \
    \
    NSString *reason = \
    [NSString stringWithFormat:@"The operation failed to run in under %.02f seconds.", seconds]; \
    \
    NSException *exception = \
    [NSException exceptionWithName:@"ZRY_TIMED_OUT" \
                            reason:reason \
                          userInfo:nil]; \
    \
    [self failWithException:exception]; \
    } \
})

#define ZRYAssertionPerformedBeforeTimeout() \
({ \
    self.operationFinishedPerforming = YES; \
})

@interface ZRYAsyncTestCase : SenTestCase

@property (assign, nonatomic, getter = hasOperationFinishedPerforming) BOOL operationFinishedPerforming;

- (BOOL)waitForCompletion:(NSTimeInterval)timeInterval;

@end
