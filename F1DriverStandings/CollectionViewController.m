//
//  CollectionViewController.m
//  F1DriverStandings
//
//  Created by Angus Muller on 13/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

#import "CollectionViewController.h"
#import "DriverCell.h"
#import "F1Api.h"
#import "Driver.h"
#import "WebViewController.h"

#define CELL_WIDTH 145
#define CELL_SPACING 10
#define COLLECTIONVIEW_WIDTH 320

@interface CollectionViewController ()

@property (strong, nonatomic) NSMutableArray *drivers; // Store downloaded drivers

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"DriverCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.drivers = [NSMutableArray array]; // setup drivers array
    
    [self refreshDrivers]; // Get drivers from API
   
}

// Get driver data as dictionary, put through model parser and then put in array.
- (void) refreshDrivers {
    [[F1Api instance] getDrivers:^(NSDictionary * _Nullable dictionary, NSString * _Nullable errorMessage) {
        if (dictionary) {
            
            NSArray *dictionaries = [dictionary valueForKeyPath:@"MRData.StandingsTable.StandingsLists.DriverStandings"];
            NSMutableArray *arr = [[NSMutableArray alloc]init]; // Temp array to store drivers
            
            for (NSDictionary *dict in dictionaries[0]) { // As there is a array in a array set loop to only look at first index
                Driver *driver = [Driver driversWithDictionary:dict];
                [arr addObject:driver]; // Add each driver to temporary array
            }
            
            self.drivers = arr; // Add temporary array of all drivers to main drivers array
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
            
            
        } else if (errorMessage) {
            // Display alert to user, this is a general alert, could be improved by finding out exact error code and display appropriate text.
            NSLog(@"Error: %@", errorMessage);
            NSString *title = @"Alert";
            NSString *message = @"Could not retrive data, please check your internet connection and try again";
            NSString *okText = @"OK";
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertController *okButton = [UIAlertAction actionWithTitle:okText style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:okButton];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.drivers count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DriverCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // If cell empty
    if (!cell) {
        cell = [[DriverCell alloc]init]; // If cell empty setup empty cell
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    // Setup DriverCell view
    
    Driver *driver = [self.drivers objectAtIndex:indexPath.row];
    DriverCell *driverCell = (DriverCell*)cell;
    [driverCell updateUI:driver];
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

// Centre the cells
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    NSInteger viewWidth = (NSInteger) [UIScreen mainScreen].bounds.size.width;
    NSInteger totalCellWidth = CELL_WIDTH * 2;
    NSInteger totalSpacingWidth = CELL_SPACING * 2;
    
    NSInteger leftInset = (viewWidth - (totalCellWidth + totalSpacingWidth)) / 2;
    NSInteger rightInset = leftInset;
    
    return UIEdgeInsetsMake(15, leftInset, 0, rightInset);
}

#pragma mark - Navigation

// Sending a drivers details to WebViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"WebView"]) {
        NSIndexPath *selectedIndexPath = [self.collectionView indexPathsForSelectedItems][0];
        
        Driver *driver = self.drivers[selectedIndexPath.row];
        WebViewController *webViewController = segue.destinationViewController;
        webViewController.driver = driver;
    }
}

@end
