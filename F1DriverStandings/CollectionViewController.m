//
//  CollectionViewController.m
//  F1DriverStandings
//
//  Created by Angus Muller on 13/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "F1Api.h"
#import "Driver.h"

@interface CollectionViewController ()

@property (strong, nonatomic) NSMutableArray *drivers;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"DriverCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[F1Api instance] getDrivers:^(NSArray * _Nullable dataArray, NSString * _Nullable errorMessage) {
        if (dataArray) {
            
            NSArray *dictionary = [dataArray valueForKeyPath:@"MRData.StandingsTable.StandingsLists.DriverStandings"];
            NSLog(@"got here");
            
            for (NSDictionary *dict in dictionary) {
                Driver *driver = [Driver driversWithDictionary:dict];
                [self.drivers addObject:driver];
            }
            
            NSLog(@"%@",self.drivers);
            [self updateData];
            
            
        } else if (errorMessage) {
            //Display alert to user
            NSLog(@"Error: %@", errorMessage);
        }
    }];
    
   
}

- (void) updateData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 21;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
