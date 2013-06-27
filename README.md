ZRYAsyncTestCase
================

ZRYAsyncTestCase brings asynchronous unit testing to your Xcode apps, making it super easy and intuitive. Simply set a timeout and mark as finished when you are, that's it.

**Usage sample**  
  
    - (void)testPerformBlockWithSleep {
    
        NSOperationQueue *backgroundQueue =
        [[NSOperationQueue alloc] init];
        
        [backgroundQueue addOperationWithBlock:^{
        
            sleep(3);
        
            ZRYAssertionPerformedBeforeTimeout();
        }];
        
        ZRYAssertPerformsBeforeTimout(5.0f, @"Failed to awake in time.");
    }

Ideal for testing [asynchronous NSURLConnection requests](https://github.com/marianoabdala/ZRYAsyncTestCase/blob/12a84c7f1af1a861f76c7825aef6d9d6c53fd1ca/SampleProject/SampleProjectTests/SampleProjectTests.m#L33-L56)!


**Instructions**  
  
1. Drag the `ZRYAsyncTestCase` folder into your tests folder.
2. Make your test file inherit from `ZRTAsyncTestCase`, don't worry, you'll still be inheriting from `SetTestCase`.
3. Right after starting an asynchronous operation, call `ZRYAssertPerformsBeforeTimout(,)` with your desired timeout.
4. Once the operation is done, wherever that is, call `ZRYAssertionPerformedBeforeTimeout()`.


License
=======

Copyright (c) 2013 Mariano Abdala.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
