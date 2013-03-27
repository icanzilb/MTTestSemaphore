MTTestSemaphore
===============

A class to help you create unit tests that test asynchronous methods. You will need this to unit test any class that fetch data from the network, use location, camera, etc.


How to include MTTestSemaphore in your project
------------

Clone this repo from [https://github.com/icanzilb/MTTestSemaphore](https://github.com/icanzilb/MTTestSemaphore) or download it as a zip file.

Include the contents of the "**MTTestSemaphore**" sub-folder in your project - make sure that the **MTTestSemaphore** class is included in your Test target.


How to use MTTestSemaphore in your unit tests
------------

Use `[[MTTestSemaphore semaphore] waitForKey: @"myAwesomeKey"]` to stop the code execution at a given place and wait (ie wait for your asynchronious code to finish executing)

Use `[[MTTestSemaphore semaphore] lift: @"myAwesomeKey"]` to un-block the program execution at the place where you stopped it for the same key. 

Here's a complete example, how to make an async call in a test case and wait for its execution:

```objective-c

-(void)testLocationAsyncNoComments
{
    NSString* sempahoreKey = @"testLocationAsync1";

    CLGeocoder* gc = [[CLGeocoder alloc] init];
    [gc geocodeAddressString:@"Triq Sant' Orsla, Valletta, Malta"
           completionHandler:^(NSArray *placemarks, NSError *error) {
               
               NSAssert(placemarks.count>0, @"the geocoder returned 0 results");
               [[MTTestSemaphor semaphore] lift: sempahoreKey];
               
           }];
    
    [[MTTestSemaphor semaphore] waitForKey: sempahoreKey];
}


```

Download and run Project/Test the project included in this repo, to see the usage of MTTestSemaphore