//
//  SignUpPopUpView.h
//  ios-app
//
//  Created by MinhThai on 3/18/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SignUpPopUpView;
@protocol SignUpPopUpDelegate <NSObject>

- (void)onLeftButtonClick:(SignUpPopUpView *)sender;
- (void)onRightButtonClick:(SignUpPopUpView *)sender;

@end

@interface SignUpPopUpView : UIView

@property (weak, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UIView *popupView;

@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIView *body1HolderView;
@property (weak, nonatomic) IBOutlet UIView *body2HolderView;
@property (weak, nonatomic) IBOutlet UIView *btnHolderView;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextField *tfBody1;
@property (weak, nonatomic) IBOutlet UILabel *lblBody2;

@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;

@property (nonatomic, assign) id delegate;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBtnWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnGapConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bodyText1HeightRatioConstraint;



- (IBAction)leftBtnClick:(id)sender;
- (IBAction)rightBtnClick:(id)sender;

// Other custom methods
- (void)show; // MUST BE CALLED TO SEE THE CONTROL
- (void)setLeftButtonTitle:(NSString *)title;
- (void)setRightButtonTitle:(NSString *)title;
- (void)hideUpperText;  // allow hiding the upper body text
- (void)hideLeftButton; // allow hiding the left button
- (void)chooseDelegate:(id)view;

@end
