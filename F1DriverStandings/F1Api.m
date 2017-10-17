//
//  F1Api.m
//  F1DriverStandings
//
//  Created by Angus Muller on 13/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

#import "F1Api.h"

#define URL_BASE "http://ergast.com"
#define URL_DRIVERS "/api/f1/current/driverStandings.json"

@implementation F1Api

+ (id) instance {
    static F1Api *sharedInstance = nil;
    
    @synchronized (self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc]init];
    }
    
    return sharedInstance;
}


/// Downloads JSON and coverts it to a dictionary
- (void) getDrivers:(nullable onComplete)completionHandler {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%s", URL_BASE, URL_DRIVERS]];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data != nil) { // If data not nil
            NSError *error;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error]; // Json into dictionary
            
            if (error == nil) { // If no errors then send to completion handler
                //NSLog(@"%@", json.description);
                completionHandler(json, nil);
            } else {
                completionHandler(nil, @"Data parsing failed!");
            }
        } else {
            // Could not get data error
            NSLog(@"Network Error: %@", error.debugDescription);
            completionHandler(nil, @"Problem connecting to the server"); // General could not connect error, note future update, maybe use switch statement to switch on the more detailed response error codes to send back a more detailed description of connection error
        }
        
    }] resume];
    
    
    
}

@end
