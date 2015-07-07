//
//  AdEventViewController.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/21/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "AdEventViewController.h"
#import "Constants.h"

@interface AdEventViewController () {
    ExpandableSearchBar *searchBar;
}

@end

@implementation AdEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBarTintColor:THEME_COLOR_DARK];
    [self.navigationController.navigationBar setTranslucent:NO];
    if (searchBar == nil) {
        searchBar = [[ExpandableSearchBar alloc] initWithFrame:CGRectMake(0, 0,
                                                                          self.navigationController.navigationBar.frame.size.width,
                                                                          30)];
        [searchBar setBackgroundColor:THEME_COLOR_DARK];
        [searchBar.lblTitle setText:@"Career"];
        [searchBar.lblTitle setTextColor:[UIColor whiteColor]];
    }
    [self.navigationItem setTitleView:searchBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Custom-Methods
- (void)setView {
    if (self.advertViewController == nil) {
        self.advertViewController = [[AdvertFeedViewController alloc] init];
        [self.advertViewController.view setFrame:CGRectMake(0, 0,
                                                            self.view.frame.size.width,
                                                            self.view.frame.size.height)];
    }
    
    if (self.eventViewController == nil) {
        self.eventViewController = [[EventFeedViewController alloc] init];
        [self.eventViewController.view setFrame:CGRectMake(0, 0,
                                                           self.view.frame.size.width,
                                                           self.view.frame.size.height)];
    }
    
    if (self.eventAdSelector == nil) {
        self.eventAdSelector = [[EventAdvertSelector alloc] initWithFrame:CGRectMake(10, 10, self.tabBarHolder.frame.size.width - 20, self.tabBarHolder.frame.size.height - 20)];
        //[self.navigationItem setTitleView:self.eventAdSelector];
        [self.tabBarHolder addSubview:self.eventAdSelector];
    }
    
    if ([self.eventAdSelector getSelectedIndex] == 0) {
        [self.advertViewController removeFromParentViewController];
        [self.eventViewController removeFromParentViewController];
        [self.bodyView addSubview:self.advertViewController.view];
        [self addChildViewController:self.advertViewController];
    } else {
        [self.advertViewController removeFromParentViewController];
        [self.eventViewController removeFromParentViewController];
        [self.bodyView addSubview:self.eventViewController.view];
        [self addChildViewController:self.eventViewController];
    }
    
    [self.eventAdSelector setDelegate:self];
    
    self.tabBarHolder.backgroundColor = THEME_COLOR_DARK;
    self.bodyView.backgroundColor = THEME_COLOR_DARKER;
    
    
    //[self.navigationController.navigationBar setHidden:YES];
    [self.view layoutIfNeeded];
}

#pragma mark EventAdvertSelectorDelegate
- (void)eventAdvertSelector:(EventAdvertSelector *)selector advertSelected:(UIButton *)btnAdvert {
    [self.advertViewController removeFromParentViewController];
    [self.eventViewController removeFromParentViewController];
    [self.bodyView addSubview:self.advertViewController.view];
    [self addChildViewController:self.advertViewController];
}

- (void)eventAdvertSelector:(EventAdvertSelector *)selector eventSelected:(UIButton *)btnEvent {
    [self.advertViewController removeFromParentViewController];
    [self.eventViewController removeFromParentViewController];
    [self.bodyView addSubview:self.eventViewController.view];
    [self addChildViewController:self.eventViewController];
}

- (void)eventAdvertSelector:(EventAdvertSelector *)selector bookmarkSelected:(UIButton *)btnEvent {
    //TODO
}

@end
