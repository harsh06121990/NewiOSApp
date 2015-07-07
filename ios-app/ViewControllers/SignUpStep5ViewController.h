//
//  SignUpStep5ViewController.h
//  ios-app
//
//  Created by MinhThai on 3/22/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignupModel.h"
#import "UserHelper.h"
#import "MainTabBarViewController.h"
#import "LoadingDialog.h"

@interface SignUpStep5ViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UIView *titleView;


@property (weak, nonatomic) IBOutlet UILabel *lblTitle_7;
@property (weak, nonatomic) IBOutlet UITextView *tvExperience;
@property (weak, nonatomic) IBOutlet UIButton *btnSignup;

- (IBAction)btnSignupClick:(id)sender;

@end
