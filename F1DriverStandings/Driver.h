//
//  Driver.h
//  F1DriverStandings
//
//  Created by Angus Muller on 13/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParsingProtocol.h"


@interface Driver : NSObject <ParsingProtocol>

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (assign) int *position;
@property (assign) int *points;
@property (assign) int *wins;
@property (nonatomic, strong) NSString *driverCode;
@property (nonatomic, strong) NSURL *wikipediaUrl;
@property (nonatomic, strong) NSString *dateOfBirth;
@property (nonatomic, strong) NSString *nationality;

+ (instancetype) driversWithDictionary:(NSDictionary *) dictionary;

@end
