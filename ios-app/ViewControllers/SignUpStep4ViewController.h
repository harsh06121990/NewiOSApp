//
//  SignUpStep4ViewController.h
//  ios-app
//
//  Created by MinhThai on 3/22/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignupModel.h"

@interface SignUpStep4ViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *parentView;

@property (weak, nonatomic) IBOutlet UIView *titleHolder;


@property (weak, nonatomic) IBOutlet UILabel *lblTitle_3;
@property (weak, nonatomic) IBOutlet UITextView *tvSkill;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

- (IBAction)btnNextClick:(id)sender;


@end
