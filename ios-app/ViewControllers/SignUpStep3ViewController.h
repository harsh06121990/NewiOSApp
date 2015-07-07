//
//  SignUpStep3ViewController.h
//  ios-app
//
//  Created by MinhThai on 3/22/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListPickerView.h"
#import "SignupModel.h"

@interface SignUpStep3ViewController : UIViewController <ListPickerDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *parentView;

@property (weak, nonatomic) IBOutlet UIView *titleView1;
@property (weak, nonatomic) IBOutlet UIView *bodyView1;
@property (weak, nonatomic) IBOutlet UIView *titleView2;
@property (weak, nonatomic) IBOutlet UIView *bodyView2;


@property (weak, nonatomic) IBOutlet UILabel *lblTitle_3;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle_4;
@property (weak, nonatomic) IBOutlet UITextView *tvIntro;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIButton *btnSelecPos;

- (IBAction)btnNextClick:(id)sender;
- (IBAction)onPosSelect:(id)sender;

@end
