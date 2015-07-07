//
//  ForgotPasswordDialog.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/17/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ForgotPasswordDialog;
@protocol ForgotPasswordDelegate <NSObject>

- (void)forgotDialog:(ForgotPasswordDialog *)dialog onReype:(id)sender;
- (void)forgotDialog:(ForgotPasswordDialog *)dialog onForgot:(id)sender;
- (void)forgotDialog:(ForgotPasswordDialog *)dialog onBack:(id)sender;
- (void)forgotDialog:(ForgotPasswordDialog *)dialog onRemind:(id)sender;
- (void)forgotDialog:(ForgotPasswordDialog *)dialog onConfirm:(id)sender;

@end

@interface ForgotPasswordDialog : UIView <UIScrollViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnRetype;
@property (weak, nonatomic) IBOutlet UIButton *btnForgot;
@property (weak, nonatomic) IBOutlet UIButton *btnRemind;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UITextField *txfEmail;

@property (nonatomic, assign) id delegate;

- (IBAction)retype:(id)sender;
- (IBAction)forgot:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)remind:(id)sender;
- (IBAction)confirm:(id)sender;

- (void)setIndex:(NSUInteger)index;

@end
