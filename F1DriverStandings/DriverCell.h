//
//  DriverCell.h
//  F1DriverStandings
//
//  Created by Angus Muller on 16/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Driver;

@interface DriverCell : UICollectionViewCell

-(void)updateUI:(nonnull Driver*)driver;

@end
