//
//  SignUpStep2ViewController.h
//  ios-app
//
//  Created by MinhThai on 3/20/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignupModel.h"

@interface SignUpStep2ViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *parentView;

@property (weak, nonatomic) IBOutlet UIView *titleView1;
@property (weak, nonatomic) IBOutlet UIView *bodyView1;
@property (weak, nonatomic) IBOutlet UIView *titleView2;
@property (weak, nonatomic) IBOutlet UIView *bodyView2;


@property (weak, nonatomic) IBOutlet UILabel *lblTitle_4;
@property (weak, nonatomic) IBOutlet UIButton *btnMonth;
@property (weak, nonatomic) IBOutlet UIButton *btnYear;
@property (weak, nonatomic) IBOutlet UIButton *btnCountry;

@property (weak, nonatomic) IBOutlet UIButton *btnNext;

- (IBAction)btnNextClick:(id)sender;
- (IBAction)onMonth:(id)sender;
- (IBAction)onYear:(id)sender;
- (IBAction)onCountry:(id)sender;

@end
