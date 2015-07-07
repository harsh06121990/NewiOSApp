//
//  SignUpStep4ViewController.m
//  ios-app
//
//  Created by MinhThai on 3/22/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "SignUpStep4ViewController.h"
#import "SignUpStep5ViewController.h"
#import "Constants.h"

@interface SignUpStep4ViewController ()

@end

@implementation SignUpStep4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setup];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup {
    self.titleHolder.backgroundColor = [AppUtil colorRGBA:0 :0 :0 :0.5];
    
    self.tvSkill.textColor = [UIColor lightGrayColor];
    self.tvSkill.layer.cornerRadius = 10;
    self.tvSkill.layer.borderWidth = 2;
    self.tvSkill.layer.borderColor = [UIColor whiteColor].CGColor;
    self.tvSkill.text = @"e.g. graphic design, UI/UX (designer) \ne.g. css, html (developer)";
    [self.tvSkill setTintColor:[UIColor whiteColor]];
    
    self.btnNext.backgroundColor = THEME_RED_COLOR;
    self.btnNext.layer.cornerRadius = self.btnNext.frame.size.height / 3;
    
    // change color of title
    NSMutableAttributedString *text =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: self.lblTitle_3.attributedText];
    [text addAttribute:NSForegroundColorAttributeName
                 value:THEME_RED_COLOR
                 range:NSMakeRange(0, 7)];
    [self.lblTitle_3 setAttributedText: text];
    
    self.tvSkill.delegate = self;
}

- (IBAction)btnNextClick:(id)sender {
    
    NSString *skills = [self.tvSkill.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // Save data
    [[SignupModel sharedInstance] setSkill:skills];
    
    // Goto next step
    SignUpStep5ViewController *next = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUp5"];
    [self.navigationController pushViewController:next animated:YES];
}

#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"e.g. graphic design, UI/UX (designer) \ne.g. css, html (developer)"]) {
        textView.text = @"";
        textView.textColor = [UIColor whiteColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"e.g. graphic design, UI/UX (designer) \ne.g. css, html (developer)";
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}

@end
