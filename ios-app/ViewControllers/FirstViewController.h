//
//  FirstViewController.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/1/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "UserHelper.h"
#import "AppDelegate.h"
#import "DateUtility.h"
#import "FacebookHelper.h"
#import "MainTabBarViewController.h"

@interface FirstViewController : UIViewController

#define BUTTON_SIGNIN_THEME         [UIColor colorWithRed:149.0/255.0 green:165.0/255.0 blue:165.0/255.0 alpha:1.0]
#define BUTTON_CIRCLE1_THEME        [UIColor colorWithRed:108.0/255.0 green:122.0/255.0 blue:137.0/255.0 alpha:1.0]
#define BUTTON_CIRCLE2_THEME        [UIColor colorWithRed:58.0/255.0 green:147.0/255.0 blue:130.0/255.0 alpha:1.0]

@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UIView *viewConnektHolder;
@property (weak, nonatomic) IBOutlet UIView *viewFacebookHolder;
@property (weak, nonatomic) IBOutlet UIView *viewTwitterHolder;
@property (weak, nonatomic) IBOutlet UIView *viewLinkedInHolder;
@property (weak, nonatomic) IBOutlet UIButton *btnLoginConnekt;
@property (weak, nonatomic) IBOutlet UIButton *btnGoToSignup;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle_1;

// Event
- (IBAction)loginFB:(id)sender;
- (IBAction)linkedInbuttonPressed:(id)sender;
@end

