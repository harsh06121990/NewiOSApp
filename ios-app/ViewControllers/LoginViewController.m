//
//  LoginViewController.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/17/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController () {
    ForgotPasswordDialog *fdialog;
    LoadingDialog *ldialog;
    UIView *dimmedView;
    UINavigationController *currentNavigator;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setView];
    [self addEventToViews];
    currentNavigator = self.navigationController;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Custom-Methods
- (void)setView {
    [_viewUsernameHolder.layer setCornerRadius:10.0f];
    [_viewPasswordHolder.layer setCornerRadius:10.0f];
    [_txfPassword setSecureTextEntry:YES];
    [_txfUsername setReturnKeyType:UIReturnKeyNext];
    [_txfPassword setReturnKeyType:UIReturnKeyDone];
    [_txfPassword setDelegate:self];
    [_txfUsername setDelegate:self];
    [_btnSignIn.layer setCornerRadius:_btnSignIn.frame.size.height/2];
    
    if (fdialog == nil) {
        fdialog = [[ForgotPasswordDialog alloc] initWithFrame:CGRectMake(50, 50, 250, 200)];
        [fdialog setDelegate:self];
    }
    
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
    
    // Colour for first title
    NSMutableAttributedString *text =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: _lblTitle_1.attributedText];
    
    [text addAttribute:NSForegroundColorAttributeName
                 value:THEME_ORANGE_COLOR
                 range:NSMakeRange(0, 7)];
    [_lblTitle_1 setAttributedText: text];
    
    // Underline for forgot pass text
    text = [[NSMutableAttributedString alloc]
            initWithAttributedString: _btnForgotPass.titleLabel.attributedText];
    [text addAttributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)} range:NSMakeRange (0, text.length)];
    [self.btnForgotPass.titleLabel setAttributedText:text];
    
    // Underline for back text
    text = [[NSMutableAttributedString alloc]
            initWithAttributedString: _btnBack.titleLabel.attributedText];
    [text addAttributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)} range:NSMakeRange (0, text.length)];
    [self.btnBack.titleLabel setAttributedText:text];
}
// Function for setting up view for a already logged in user
- (void)setupLoggedInView {
    [self setupLoggedInView:TRUE];
}

// Function for setting up view for a already logged in user with animation parameter
- (void)setupLoggedInView:(BOOL) animated {
    [currentNavigator presentViewController:MainTabBar animated:YES completion:nil];
}

- (void)addEventToViews {
    // For keyboards events
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)  name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(0,
                                       -keyboardFrameBeginRect.size.height/2,
                                       self.view.frame.size.width,
                                       self.view.frame.size.height)];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setFrame:CGRectMake(0,
                                       0,
                                       self.view.frame.size.width,
                                       self.view.frame.size.height)];
    }];
}

- (void)keyboardDidHide:(NSNotification *)notification {
    
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

- (void)showForgot {
    [dimmedView addSubview:fdialog];
    [fdialog setCenter:dimmedView.center];
    [self.view addSubview:dimmedView];
    [self.view bringSubviewToFront:dimmedView];
    
    [dimmedView setAlpha:0.0f];
    [UIView animateWithDuration:0.3 animations:^{
        [dimmedView setAlpha:1.0f];
    } completion:^(BOOL finished) {

    }];
}

- (void)hideForgot {
    [UIView animateWithDuration:0.3 animations:^{
        [dimmedView setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [dimmedView removeFromSuperview];
        [fdialog removeFromSuperview];
    }];
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _txfUsername) {
        [_txfPassword becomeFirstResponder];
    } else if (textField == _txfPassword) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark ForgotPasswordDelegate
- (void)forgotDialog:(ForgotPasswordDialog *)dialog onReype:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        [dimmedView setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [dimmedView removeFromSuperview];
        [fdialog removeFromSuperview];
    }];
}

- (void)forgotDialog:(ForgotPasswordDialog *)dialog onForgot:(id)sender {
    [dialog setIndex:1];
}

- (void)forgotDialog:(ForgotPasswordDialog *)dialog onRemind:(id)sender {
    [dialog setIndex:2];
}

- (void)forgotDialog:(ForgotPasswordDialog *)dialog onBack:(id)sender {
    [dialog setIndex:0];
}

- (void)forgotDialog:(ForgotPasswordDialog *)dialog onConfirm:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        [dimmedView setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [dimmedView removeFromSuperview];
        [fdialog removeFromSuperview];
        //Setting index back to zero so that it re-start next time
        [dialog setIndex:0];
    }];
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)signin:(id)sender {
    if ([_txfUsername.text isEqualToString:@""] || [_txfPassword.text isEqualToString:@""]) {
        [self showForgot];
        return;
    }
    
    [self showLoading];
    
    [UserUtil login:_txfUsername.text password:_txfPassword.text callback:^(bool success, id result) {
        
        if (success) {
            //[self.navigationController popToRootViewControllerAnimated:NO];
            [UserUtil retrievePersonalInfo:^(bool success, id result) {
                [self hideLoading];
                if (success) {
                    [self setupLoggedInView];
                } else {
                    
                }
            }];
            
        } else {
            // TO-DO: ADD HANDLER FOR USER LOGIN FAILED
            [NSThread sleepForTimeInterval:1];
            [self showForgot];
        }
    }];
}
@end
