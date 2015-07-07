//
//  SignUpStep5ViewController.m
//  ios-app
//
//  Created by MinhThai on 3/22/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "SignUpStep5ViewController.h"
#import "Constants.h"

@interface SignUpStep5ViewController () {
    LoadingDialog *ldialog;
    UIView *dimmedView;
}

@end

@implementation SignUpStep5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setup];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)setup {
    self.titleView.backgroundColor = [AppUtil colorRGBA:0 :0 :0 :0.5];
    
    self.tvExperience.textColor = [UIColor lightGrayColor];
    self.tvExperience.layer.cornerRadius = 10;
    self.tvExperience.layer.borderWidth = 2;
    self.tvExperience.layer.borderColor = [UIColor whiteColor].CGColor;
    self.tvExperience.text = @"e.g. Spokesperson at a conference.";
    [self.tvExperience setTintColor:[UIColor whiteColor]];
    
    self.btnSignup.backgroundColor = THEME_RED_COLOR;
    self.btnSignup.layer.cornerRadius = self.btnSignup.frame.size.height / 2;
    
    // change color of title
    NSMutableAttributedString *text =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: self.lblTitle_7.attributedText];
    [text addAttribute:NSForegroundColorAttributeName
                 value:THEME_RED_COLOR
                 range:NSMakeRange(0, 7)];
    [self.lblTitle_7 setAttributedText: text];
    
    self.tvExperience.delegate = self;
    
    if (ldialog == nil) {
        ldialog = [[LoadingDialog alloc] initWithFrame:CGRectMake(50, 50, 250, 70)];
    }
    
    if (dimmedView == nil) {
        dimmedView = [[UIView alloc] init];
        [dimmedView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        dimmedView.backgroundColor = [AppUtil colorRGBA:0 :0 :0 :0.3];
        // Add click event
        /*
         UITapGestureRecognizer *singleClick1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dummy_Click:)];
         [dimmedView addGestureRecognizer:singleClick1];
         */
    }
}

- (void)showLoading {
    [dimmedView addSubview:ldialog];
    [ldialog setCenter:dimmedView.center];
    [ldialog startAnimation];
    [self.view addSubview:dimmedView];
    [self.view bringSubviewToFront:dimmedView];
    
    [dimmedView setAlpha:0.0f];
    [UIView animateWithDuration:0.3 animations:^{
        [dimmedView setAlpha:1.0f];
    } completion:^(BOOL finished) {
        return;
    }];
}

- (void)hideLoading {
    [UIView animateWithDuration:0.3 animations:^{
        [dimmedView setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [ldialog stopAnimation];
        [dimmedView removeFromSuperview];
        [ldialog removeFromSuperview];
    }];
}

#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"e.g. Spokesperson at a conference."]) {
        textView.text = @"";
        textView.textColor = [UIColor whiteColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"e.g. Spokesperson at a conference.";
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}

- (IBAction)btnSignupClick:(id)sender {
    [ldialog setTitle:@"Signing up..."];
    [self showLoading];
    
    [UserUtil signUp:[[SignupModel sharedInstance] username]
      passwordOfUser:[[SignupModel sharedInstance] password]
         emailOfuser:[[SignupModel sharedInstance] email]
     userDateOfBirth:[[SignupModel sharedInstance] dob]
  introductionOfUser:[[SignupModel sharedInstance] introduction]
            userType:[[SignupModel sharedInstance] type]
        skillsOfuser:[[SignupModel sharedInstance] skill]
            callback:^(bool success, id result) {
                if (success) {
                    [ldialog setTitle:@"loging in..."];
                    [UserUtil login:[[SignupModel sharedInstance] username]
                           password:[[SignupModel sharedInstance] password]
                           callback:^(bool success, id result) {
                               
                               [UserUtil retrievePersonalInfo:^(bool success, id result) {
                                   [self hideLoading];
                                   if (success) {
                                       [self.navigationController presentViewController:MainTabBar animated:YES completion:nil];
                                   } else {
                                       
                                   }
                               }];
                    }];
                } else {
                    
                }
            }];
}
@end
