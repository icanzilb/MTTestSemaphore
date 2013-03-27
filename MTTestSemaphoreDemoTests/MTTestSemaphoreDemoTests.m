//
//  MTTestSemaphoreDemoTests.m
//  MTTestSemaphoreDemoTests
//
//  Created by Marin Todorov on 3/27/13.
//  Copyright (c) 2013 Marin Todorov. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "MTTestSemaphoreDemoTests.h"

#import "MTTestSemaphor.h"

@implementation MTTestSemaphoreDemoTests

//this test case gets automatically executed
//and invokes the Apple's geocoding server for a given address
-(void)testLocationAsync
{
    //just a string to use for key to the semaphore
    NSString* sempahoreKey = @"testLocationAsync";
    
    CLGeocoder* gc = [[CLGeocoder alloc] init];
    
    //invoke an asynchronious method
    //which means the code in the block won't be executed immediately
    //but the execution will continue on the next line
    [gc geocodeAddressString:@"Triq Sant' Orsla, Valletta, Malta"
           completionHandler:^(NSArray *placemarks, NSError *error) {
               
               NSAssert(placemarks.count>0, @"the geocoder returned 0 results");
               
               //when you want to release the lock for this method call lift:
               [[MTTestSemaphor semaphore] lift: sempahoreKey];
               
           }];
    
    // waitForKey: will stop the execution of the code
    // in this method, but will not block the execution
    // of other code, for example the async block above
    [[MTTestSemaphor semaphore] waitForKey: sempahoreKey];
    
}

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

@end
