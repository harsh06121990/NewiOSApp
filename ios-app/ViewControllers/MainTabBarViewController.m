//
//  MainTabBarViewController.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/21/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "MainTabBarViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

+(MainTabBarViewController *)sharedInstance
{
    static MainTabBarViewController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MainTabBarViewController alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

-(MainTabBarViewController *)init
{
    if ((self = [super init])) {
        // Init
        UIStoryboard *storyBoard  = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        self = (MainTabBarViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"mainTabBarController"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UITabBar appearance] setBackgroundImage:[UIImage imageFromColor:THEME_COLOR_DARK
                                                              forSize:CGSizeMake(self.tabBar.frame.size.width, self.tabBar.frame.size.height)
                                                     withCornerRadius:0.0f]];
    
    [self.tabBar setSelectedImageTintColor:[UIColor whiteColor]];
    [self.tabBar setSelectionIndicatorImage:[UIImage imageFromColor:THEME_ORANGE_COLOR
                                                            forSize:CGSizeMake(self.tabBar.frame.size.width / 5, self.tabBar.frame.size.height)
                                                   withCornerRadius:0.0f]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setSelectedIndex:0];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

@end
