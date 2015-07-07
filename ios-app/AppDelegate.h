//
//  AppDelegate.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/1/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserPersonalModel.h"
#import "FacebookHelper.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

#define AppDelegateObj      (AppDelegate *)[[UIApplication sharedApplication] delegate]

#pragma mark Properties
@property (strong, nonatomic) UIWindow *window;
// Used for storing device token
@property (strong, nonatomic, readonly) NSString *deviceToken;
// Used for storing the uuid of the device
@property (strong, nonatomic, readonly) NSString *deviceUUID;

@property (nonatomic, strong) UIViewController *currentViewController; // Store the current view controller
@property (nonatomic, strong) UserPersonalModel *currentUser;

@end

