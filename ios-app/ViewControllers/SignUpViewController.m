//
//  SignUpViewController.m
//  ios-app
//
//  Created by MinhThai on 3/17/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "SignUpViewController.h"
#import "Constants.h"
#import "SignUpPopUpView.h"
#import "SignUpStep2ViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
    [self addEventToViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Custom-Methods
- (void)setup {
    // text field holders
    self.usernameHolder.layer.cornerRadius = 10;
    self.passwordHolder.layer.cornerRadius = 10;
    self.mailHolder.layer.cornerRadius = 10;
    self.usernameHolder.alpha = 0.7;
    self.passwordHolder.alpha = 0.7;
    self.mailHolder.alpha = 0.7;
    
    // color for title
    NSMutableAttributedString *text =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: self.lblTitle_1.attributedText];
    [text addAttribute:NSForegroundColorAttributeName
                 value:THEME_RED_COLOR
                 range:NSMakeRange(0, 7)];
    [self.lblTitle_1 setAttributedText: text];
    
    // button
    self.btnSignup.layer.cornerRadius = 15;
    self.btnSignup.backgroundColor = THEME_RED_COLOR;
    
    // add underline for text
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithAttributedString:self.lblOtherAcc.attributedText];
    [attributeString addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange){0,[attributeString length]}];
    self.lblOtherAcc.attributedText = [attributeString copy];
    
    // text field delegate
    [self.tfPassword setSecureTextEntry:YES];
    [self.tfUsername setReturnKeyType:UIReturnKeyNext];
    [self.tfPassword setReturnKeyType:UIReturnKeyNext];
    [self.tfMail setReturnKeyType:UIReturnKeyDone];
    [self.tfUsername setDelegate:self];
    [self.tfPassword setDelegate:self];
    [self.tfMail setDelegate:self];
}

- (void)addEventToViews {
    // For keyboards events
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)  name:UIKeyboardDidHideNotification object:nil];
}

- (void)showPopUpEmail {
    SignUpPopUpView *popup = [[SignUpPopUpView alloc] initWithFrame:self.parentView.frame];
    
    popup.lblTitle.text = @"Oops! Is this your email?";
    popup.tfBody1.text = @"wrongemail@mail.com";
    popup.lblBody2.text = @"we only accept email addresses that end with .edu or .ac. If yours is not listed above please send us a request email.";
    [popup setLeftButtonTitle:@"Retype"];
    [popup setRightButtonTitle:@"Request this email"];
    [popup chooseDelegate:self]; // remember to call this!
    
    [self.parentView addSubview:popup];
    [popup show]; // remember to call this!
}

- (void)showPopUpRequest {
    SignUpPopUpView *popup = [[SignUpPopUpView alloc] initWithFrame:self.parentView.frame];

    popup.lblTitle.text = @"Thanks for being patient!";
    popup.lblBody2.text = @"The request has been send. We will contact you shortly when your account is ready.";
    [popup hideUpperText];
    [popup hideLeftButton];
    [popup setRightButtonTitle:@"OK, got it!"];
    [popup chooseDelegate:self]; // remember to call this!
    
    [self.parentView addSubview:popup];
    [popup show]; // remember to call this!
}

- (void)showPopUpConfirmEmail {
    SignUpPopUpView *popup = [[SignUpPopUpView alloc] initWithFrame:self.parentView.frame];
    popup.tag = 99;
    
    popup.lblTitle.text = @"Confirm your email!";
    popup.tfBody1.text = self.tfMail.text;
    popup.lblBody2.text = @"Is the above email address correct?";
    [popup setLeftButtonTitle:@"No let me retype"];
    [popup setRightButtonTitle:@"Yes"];
    [popup chooseDelegate:self]; // remember to call this!
    
    [self.parentView addSubview:popup];
    [popup show]; // remember to call this!
}

- (void)showPopUpConfirmAppreciate {
    SignUpPopUpView *popup = [[SignUpPopUpView alloc] initWithFrame:self.parentView.frame];
    
    popup.lblTitle.text = @"We appreciate it!";
    popup.lblBody2.text = @"A confirmation email has been sent. Please don't forget to activate your account to enjoy the full service";
    popup.tag = 100;
    [popup hideUpperText];
    [popup hideLeftButton];
    [popup setRightButtonTitle:@"Yes"];
    [popup chooseDelegate:self]; // remember to call this!
    
    [self.parentView addSubview:popup];
    [popup show]; // remember to call this!
}

#pragma mark Event-Handlers
- (IBAction)btnSignUpClick:(id)sender {
    //[self showPopUpConfirmEmail];
    if (![self checkEmail]) {
        [self showPopUpEmail];
        return;
    }
    NSString *email = [self.tfMail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (![self checkPassword]) {
        [self showPopUpEmail];
        return;
    }
    NSString *password = [self.tfPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (![self checkUsername]) {
        [self showPopUpEmail];
        return;
    }
    NSString *username = [self.tfUsername.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // Save data
    [[SignupModel sharedInstance] setUsername:username];
    [[SignupModel sharedInstance] setPassword:password];
    [[SignupModel sharedInstance] setEmail:email];
    
    // Go to next step
    SignUpStep2ViewController *next = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUp2"];
    [self.navigationController pushViewController:next animated:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.parentView setFrame:CGRectMake(0,
                                       -keyboardFrameBeginRect.size.height/2,
                                       self.view.frame.size.width,
                                       self.view.frame.size.height)];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [UIView animateWithDuration:0.2 animations:^{
        [self.parentView setFrame:CGRectMake(0,
                                       0,
                                       self.view.frame.size.width,
                                       self.view.frame.size.height)];
    }];
}

- (void)keyboardDidHide:(NSNotification *)notification {
    
}

- (BOOL)checkUsername {
    // TODO
    NSString *username = [self.tfUsername.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!(username == nil) && ![username isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)checkPassword {
    // TODO
    NSString *password = [self.tfPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!(password == nil) && ![password isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)checkEmail {
    // TODO
    NSString *email = [self.tfMail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!(email == nil) && ![email isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.tfUsername) {
        [self.tfPassword becomeFirstResponder];
    }
    else if (textField == self.tfPassword) {
        [self.tfMail becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark Popup Delegate
- (void)onLeftButtonClick:(SignUpPopUpView *)sender {
    sender.tfBody1.text = @"";
    [sender.tfBody1 becomeFirstResponder];
}

- (void)onRightButtonClick:(SignUpPopUpView *)sender {
    // TODO
    if(sender.tag == 99) { // email confirm popup
        [sender removeFromSuperview];
        SignUpStep2ViewController *next = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUp2"];
        [self presentViewController:next animated:NO completion:nil];
        //[self showPopUpConfirmAppreciate];
    }
    if(sender.tag == 100) { // appreciate popup
    }

}


@end
