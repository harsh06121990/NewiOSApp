//
//  MainTabBarViewController.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/21/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "UIImage+ColorImage.h"

@interface MainTabBarViewController : UITabBarController

#define MainTabBar      [MainTabBarViewController sharedInstance]

+ (MainTabBarViewController *)sharedInstance;

@end
