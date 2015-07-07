//
//  SignUpStep3ViewController.m
//  ios-app
//
//  Created by MinhThai on 3/22/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "SignUpStep3ViewController.h"
#import "SignUpStep4ViewController.h"
#import "ListPickerView.h"
#import "Constants.h"

@interface SignUpStep3ViewController () {
    UIPickerView *pickerView;
    NSArray *userTypes;
}

@end

@implementation SignUpStep3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    userTypes = [[NSArray alloc] initWithObjects:@"Designer", @"Engineer", @"Presenter", nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setup];
}

- (void)viewDidAppear:(BOOL)animated {
    //[self addListPicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup {
    self.titleView1.backgroundColor = [AppUtil colorRGBA:0 :0 :0 :0.5];
    self.titleView2.backgroundColor = [AppUtil colorRGBA:0 :0 :0 :0.5];
    
    self.tvIntro.textColor = [UIColor lightGrayColor];
    self.tvIntro.layer.cornerRadius = 10;
    self.tvIntro.layer.borderWidth = 2;
    self.tvIntro.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.tvIntro setTintColor:[UIColor whiteColor]];
    
    self.btnNext.backgroundColor = THEME_RED_COLOR;
    self.btnNext.layer.cornerRadius = self.btnNext.frame.size.height / 2;
    
    [self.btnSelecPos.layer setCornerRadius:self.btnSelecPos.frame.size.height/2];
    [self.btnSelecPos.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.btnSelecPos.layer setBorderWidth:2.0f];
    
    if (pickerView == nil) {
        pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        [pickerView setBackgroundColor:[UIColor whiteColor]];
        [pickerView setDelegate:self];
        [pickerView setDataSource:self];
        [pickerView setShowsSelectionIndicator:YES];
    }
    [pickerView setCenter:CGPointMake(self.view.center.x,
                                      self.view.center.y + self.view.frame.size.height / 2 + pickerView.frame.size.height / 2)];
    [self.view addSubview:pickerView];
    
    // change color of title
    NSMutableAttributedString *text =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: self.lblTitle_3.attributedText];
    [text addAttribute:NSForegroundColorAttributeName
                 value:THEME_RED_COLOR
                 range:NSMakeRange(8, 3)];
    [self.lblTitle_3 setAttributedText: text];
    
    text = [[NSMutableAttributedString alloc]
            initWithAttributedString: self.lblTitle_4.attributedText];
    [text addAttribute:NSForegroundColorAttributeName
                 value:THEME_RED_COLOR
                 range:NSMakeRange(0, text.length)];
    [self.lblTitle_4 setAttributedText:text];
    
    self.tvIntro.delegate = self;
}

- (void)addListPicker {
    CGFloat width = self.bodyView2.frame.size.width / 1.5;
    CGFloat height = width / 5.0;
    CGFloat mid = self.bodyView2.frame.size.width / 2;
    CGRect frame = CGRectMake(mid - width / 2, 20, width, height);
    ListPickerView * picker = [[ListPickerView alloc] initWithFrame:frame title:@"Select position"];
    picker.Data = @[@"Designer", @"Engineer", @"Presenter"];
    [self.bodyView2 addSubview:picker];
    
    picker.delegate = self;
}

- (void)showPickerView {
    [UIView animateWithDuration:0.2 animations:^{
        [pickerView setCenter:CGPointMake(self.view.center.x,
                                          self.view.frame.size.height - pickerView.frame.size.height/2)];
    }];
}

- (void)hidePickerView {
    [UIView animateWithDuration:0.2 animations:^{
        [pickerView setCenter:CGPointMake(self.view.center.x,
                                          self.view.center.y + self.view.frame.size.height / 2 + pickerView.frame.size.height / 2)];
    }];
}

- (IBAction)btnNextClick:(id)sender {
    
    NSString *type = [self.btnSelecPos.titleLabel.text uppercaseString];
    NSString *intro = self.tvIntro.text;
    
    // Save data
    [[SignupModel sharedInstance] setType:type];
    [[SignupModel sharedInstance] setIntroduction:intro];
    
    // Goto next step
    SignUpStep4ViewController *next = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUp4"];
    [self.navigationController pushViewController:next animated:YES];
}

- (IBAction)onPosSelect:(id)sender {
    [self showPickerView];
}

#pragma mark ListPickerDelegate
- (void)onItemSelected:(ListPickerView *)sender value:(NSString*)value index:(int)index {

}

#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return userTypes.count;
}

#pragma mark UIPickerViewDelegate
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [userTypes objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.btnSelecPos setTitle:[userTypes objectAtIndex:row] forState:UIControlStateNormal];
    [self hidePickerView];
}

#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Type here..."]) {
        textView.text = @"";
        textView.textColor = [UIColor whiteColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Type here...";
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}


@end
