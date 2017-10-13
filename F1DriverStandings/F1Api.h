//
//  F1Api.h
//  F1DriverStandings
//
//  Created by Angus Muller on 13/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^onComplete)(NSArray * __nullable dataArray, NSString * __nullable errorMessage);

@interface F1Api : NSObject

+ (id) instance;
- (void) getDrivers:(nullable onComplete)completionHandler;

@end
