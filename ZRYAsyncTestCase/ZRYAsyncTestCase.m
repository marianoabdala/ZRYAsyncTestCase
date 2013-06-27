//
//  ZRYAsyncTestCase.h
//  ZRYAsyncTestCase
//
//  Created by Mariano Abdala on 6/26/13.
//  Copyright (c) 2013 Zerously.com. All rights reserved.
//
//  https://github.com/marianoabdala/ZRYAsyncTestCase
//

#import "ZRYAsyncTestCase.h"

@implementation ZRYAsyncTestCase

#pragma mark - Self
#pragma mark SMPAsyncTestCase
- (BOOL)waitForCompletion:(NSTimeInterval)timeInterval {
    
    NSDate *timeoutDate =
    [NSDate dateWithTimeIntervalSinceNow:timeInterval];
    
    do {
        
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:timeoutDate];
        
        if([timeoutDate timeIntervalSinceNow] < 0.0) {
            
            break;
        }
        
    } while (self.hasOperationFinishedPerforming == NO);
    
    return self.hasOperationFinishedPerforming;
}

@end
