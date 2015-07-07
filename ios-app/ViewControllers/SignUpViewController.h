//
//  SignUpViewController.h
//  ios-app
//
//  Created by MinhThai on 3/17/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpPopUpView.h"
#import "SignupModel.h"

@interface SignUpViewController : UIViewController <UITextFieldDelegate, SignUpPopUpDelegate>

@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle_1;

@property (weak, nonatomic) IBOutlet UIView *usernameHolder;
@property (weak, nonatomic) IBOutlet UIView *passwordHolder;
@property (weak, nonatomic) IBOutlet UIView *mailHolder;

@property (weak, nonatomic) IBOutlet UIImageView *imgUsername;
@property (weak, nonatomic) IBOutlet UIImageView *imgPassword;
@property (weak, nonatomic) IBOutlet UIImageView *imgMail;

@property (weak, nonatomic) IBOutlet UITextField *tfUsername;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfMail;

@property (weak, nonatomic) IBOutlet UIButton *btnSignup;
@property (weak, nonatomic) IBOutlet UILabel *lblOtherAcc;

@property (weak, nonatomic) IBOutlet UIImageView *imgUsernameCheck;
@property (weak, nonatomic) IBOutlet UIImageView *imgPasswordCheck;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmailCheck;


- (IBAction)btnSignUpClick:(id)sender;

@end
