//
//  WebViewController.m
//  F1DriverStandings
//
//  Created by Angus Muller on 16/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

#import "WebViewController.h"
#import "Driver.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ( self.driver ) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.driver.wikipediaUrl];
        [self.webView loadRequest:request];
        self.topBarTitleLabel.title = [NSString stringWithFormat:@"%@ %@",self.driver.firstName, self.driver.lastName];
    }
    
    [self setupGestures];
}

- (void)setupGestures {
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeToDismiss)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];
}

-(void) swipeToDismiss {
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(400, 0);
    } completion:^(BOOL finished) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}



@end
