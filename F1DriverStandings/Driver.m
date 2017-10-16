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
        driver.firstName = [dictionary valueForKeyPath:@"Driver.givenName"];
        driver.lastName = [dictionary valueForKeyPath:@"Driver.familyName"];
        driver.position = [[dictionary objectForKey:@"position"] intValue];
        driver.points = [[dictionary objectForKey:@"points"] intValue];
        driver.wins = [[dictionary objectForKey:@"wins"] intValue];
        driver.driverCode = [dictionary valueForKeyPath:@"Driver.code"];
        driver.wikipediaUrl = [NSURL URLWithString:[dictionary valueForKeyPath:@"Driver.url"]];
        driver.dateOfBirth = [dictionary valueForKeyPath:@"Driver.dateOfBirth"];
        driver.nationality = [dictionary valueForKeyPath:@"Driver.nationality"];
        
    }
    
    return driver;
}

@end
