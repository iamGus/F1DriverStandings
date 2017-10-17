//
//  ParsingProtocol.h
//  F1DriverStandings
//
//  Created by Angus Muller on 17/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

#import <Foundation/Foundation.h>

// Model must have parsing init

@protocol ParsingProtocol <NSObject>

    @required
    + (instancetype) driversWithDictionary:(NSDictionary *) dictionary;

@end
