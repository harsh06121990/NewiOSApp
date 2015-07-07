//
//  MeViewController.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/2/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController () {
    UIView *dimmedView;
}

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self createSettingButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)setView {
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:THEME_COLOR_DARK];
    
    // this will appear as the title in the navigation bar
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textAlignment = NSTextAlignmentCenter;
    // ^-Use UITextAlignmentCenter for older SDKs.
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Me", @"");
    [label sizeToFit];
    
    if (self.meView == nil) {
        self.meView = [[ProfileViewController alloc] initWithFrame:CGRectMake(0, 0,
                                                                              self.view.frame.size.width,
                                                                              self.view.frame.size.height)];
        [self.view addSubview:self.meView];
    }
    
    if (self.leftSlidingMenu == nil) {
        self.leftSlidingMenu = [[MeViewSlidingMenu alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0,
                                                                                   self.view.frame.size.width,
                                                                                   self.view.frame.size.height)
                                                          andCenterView:self.meView];
        
        UIGestureRecognizer *gesture = [[UIGestureRecognizer alloc] initWithTarget:self.leftSlidingMenu action:@selector(slidingTapped)];
        [self.leftSlidingMenu addGestureRecognizer:gesture];
        [self.view addSubview:self.leftSlidingMenu];
        [self.leftSlidingMenu setOffSet:100.0f];
        
        [self.leftSlidingMenu setFrame:CGRectMake(self.view.frame.size.width,
                                                  0,
                                                  self.view.frame.size.width - self.leftSlidingMenu.offSet,
                                                  self.view.frame.size.height)];
        [self.leftSlidingMenu setDelegate:self];
        
        [self.leftSlidingMenu layoutIfNeeded];
    }
}

#pragma mark MeViewSlidingDelegate
- (void)meViewSliding:(MeViewSlidingMenu *)menu onAboutTapped:(id)sender {
    [dimmedView removeFromSuperview];
    [self.leftSlidingMenu toggle];
}

- (void)meViewSliding:(MeViewSlidingMenu *)menu onSignOut:(id)sender {
    [UserUtil logout];
    [dimmedView removeFromSuperview];
    [self.leftSlidingMenu toggle];
    [MainTabBar dismissViewControllerAnimated:YES completion:nil];
}

- (void)meViewSliding:(MeViewSlidingMenu *)menu onEditProfileAtIndex:(NSInteger)index {
    if (self.editProfileVC == nil) {
        self.editProfileVC = [[EditProfileViewController alloc] init];
    }
    [dimmedView removeFromSuperview];
    [self.leftSlidingMenu toggle];
    [self.editProfileVC setCurrentSelected:index];
    [self.navigationController pushViewController:self.editProfileVC animated:YES];
}

#pragma mark Custom-Method
-(void)createSettingButton
{
    //Create UIButton
    UIButton *settingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [settingButton setImage:[UIImage imageNamed:@"me_setting"] forState:UIControlStateNormal];
    
    [settingButton addTarget:self action:@selector(settingButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    //Create UIBarbuttonItem and add UIButton in it
    UIBarButtonItem *settingBarButton = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
    
    //Add UIBarButtonItem to NavigationBar
    [self.navigationItem setRightBarButtonItem:settingBarButton];
}

- (void)settingButtonPressed {
    if (![self.leftSlidingMenu isTogged]) {
        // Create a dummy background
        // ----------------------------
        if (dimmedView == nil) {
            dimmedView = [[UIView alloc] init];
            [dimmedView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            dimmedView.backgroundColor = [AppUtil colorRGBA:0 :0 :0 :0.3];
            // Add click event
            UITapGestureRecognizer *singleClick1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dummy_Click:)];
            [dimmedView addGestureRecognizer:singleClick1];
        }
        [self.meView addSubview:dimmedView];
        [self.meView bringSubviewToFront:dimmedView];
    } else {
        [dimmedView removeFromSuperview];
    }
    
    // show/hide SlideMenu
    [self.leftSlidingMenu toggle];
}

- (void)slidingTapped {
    NSLog(@"Tapped");
}

- (void)dummy_Click:(id)sender {
    [dimmedView removeFromSuperview];
    [self.leftSlidingMenu toggle];
}

@end
