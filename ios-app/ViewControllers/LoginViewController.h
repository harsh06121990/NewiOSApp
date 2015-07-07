//
//  LoginViewController.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/17/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "UserHelper.h"
#import "ForgotPasswordDialog.h"
#import "LoadingDialog.h"
#import "MainTabBarViewController.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate, ForgotPasswordDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewUsernameHolder;
@property (weak, nonatomic) IBOutlet UIView *viewPasswordHolder;
@property (weak, nonatomic) IBOutlet UITextField *txfUsername;
@property (weak, nonatomic) IBOutlet UITextField *txfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSignIn;
@property (weak, nonatomic) IBOutlet UIButton *btnForgotPass;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle_1;

- (IBAction)back:(id)sender;
- (IBAction)signin:(id)sender;

@end
