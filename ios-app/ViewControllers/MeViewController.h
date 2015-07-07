//
//  MeViewController.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/2/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeViewSlidingMenu.h"
#import "ProfileViewController.h"
#import "UserHelper.h"
#import "MainTabBarViewController.h"
#import "EditProfileViewController.h"

@interface MeViewController : UIViewController <MeViewSlidingMenuDelegate>

@property (nonatomic, strong) MeViewSlidingMenu *leftSlidingMenu;
@property (nonatomic, strong) ProfileViewController *meView;
@property (nonatomic, strong) EditProfileViewController *editProfileVC;

@end
