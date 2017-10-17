//
//  WebViewController.h
//  F1DriverStandings
//
//  Created by Angus Muller on 16/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Driver;

@interface WebViewController : UIViewController <UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UINavigationItem *topBarTitleLabel;
@property (strong, nonatomic) Driver *driver;

@end
