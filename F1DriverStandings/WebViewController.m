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

@implementation WebViewController {;
    UIView* loadingView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // If driver contains data, setup WebView and title label
    if ( self.driver ) {
        self.webView.delegate = self;
        NSURLRequest *request = [NSURLRequest requestWithURL:self.driver.wikipediaUrl];
        [self.webView loadRequest:request];
        self.topBarTitleLabel.title = [NSString stringWithFormat:@"%@ %@",self.driver.firstName, self.driver.lastName];
    }
    
    // Setup Gestures and loading view
    [self setupGestures];
    
    [self setupLoading];
    

}

// Loading indicator and text setup
-(void)setupLoading {
    loadingView = [[UIView alloc]initWithFrame:CGRectMake(115, 300, 80, 80)];
    loadingView.backgroundColor = [UIColor colorWithWhite:0. alpha:0.6];
    loadingView.layer.cornerRadius = 5;
    
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.center = CGPointMake(loadingView.frame.size.width / 2.0, 35);
    [activityView startAnimating];
    activityView.tag = 100;
    [loadingView addSubview:activityView];
    
    UILabel* lblLoading = [[UILabel alloc]initWithFrame:CGRectMake(0, 48, 80, 30)];
    lblLoading.text = @"Loading...";
    lblLoading.textColor = [UIColor whiteColor];
    lblLoading.font = [UIFont fontWithName:lblLoading.font.fontName size:15];
    lblLoading.textAlignment = NSTextAlignmentCenter;
    [loadingView addSubview:lblLoading];
    
    [self.view addSubview:loadingView];
}

// Setup gesture control
- (void)setupGestures {
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeToDismiss)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeToDismiss)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
}

-(void) swipeToDismiss {
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(400, 0);
    } completion:^(BOOL finished) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}
// MARK: - Web View delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [loadingView setHidden:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [loadingView setHidden:NO];
    
}

@end


