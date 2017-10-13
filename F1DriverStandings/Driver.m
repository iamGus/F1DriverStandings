//
//  Driver.m
//  F1DriverStandings
//
//  Created by Angus Muller on 13/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

#import "Driver.h"

@implementation Driver

+ (instancetype) driversWithDictionary:(NSDictionary *) dictionary {
    Driver *driver = [[Driver alloc] init];
    
    if ( driver ) {
        driver.firstName = [NSString stringWithString:[dictionary valueForKeyPath:@"Driver.givenName"]];
    }
    
    return driver;
}

@end
