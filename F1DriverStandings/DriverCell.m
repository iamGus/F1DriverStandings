//
//  DriverCell.m
//  F1DriverStandings
//
//  Created by Angus Muller on 16/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

#import "DriverCell.h"
#import "Driver.h"

@interface DriverCell()

//Setup outlets
@property (weak, nonatomic) IBOutlet UILabel *driverNameLabel;
@property (weak, nonatomic) IBOutlet UIView *driverBackground;
@property (weak, nonatomic) IBOutlet UILabel *driverPositionLabel;
@property (weak, nonatomic) IBOutlet UILabel *driverCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;

@end

@implementation DriverCell

// Corner Radius for each cell
- (void)awakeFromNib {
    
    self.layer.cornerRadius = 5.0;
    self.layer.shadowColor = [UIColor colorWithRed:157.0 / 255.0 green:157.0 / 255.0 blue:157.0 / 255.0 alpha:0.8].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 5.0;
    self.layer.shadowOffset = CGSizeMake(0.0, 2.0);
    [super awakeFromNib];
}


// Update labels, called from CollectionView
-(void)updateUI:(nonnull Driver*)driver {
    self.driverNameLabel.text = [NSString stringWithFormat:@"%@ %@",driver.firstName, driver.lastName];
    self.driverPositionLabel.text = [NSString stringWithFormat:@"%d", driver.position];
    self.driverCodeLabel.text = [NSString stringWithFormat:@"%@", driver.driverCode];
    self.pointsLabel.text = [NSString stringWithFormat:@"%d", driver.points];
    
}


@end
