//
//  SignUpStep2ViewController.m
//  ios-app
//
//  Created by MinhThai on 3/20/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "SignUpStep2ViewController.h"
#import "SignUpStep3ViewController.h"
#import "Utility.h"

@interface SignUpStep2ViewController () {
    UIPickerView *pickerView;
    NSArray *yearData;
    NSArray *monthData;
    NSArray *countryData;
    
    int currentPicking;
}


@property BOOL liftView; // true: view is lifted up when keyboard shows
@end

@implementation SignUpStep2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDate *currDate = [NSDate date];
    NSDateComponents *dComp = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )
                                          fromDate:currDate];
    
    // Initialize year
    yearData = [[NSArray alloc] init];
    for (NSInteger i = 1950; i < [dComp year] - 10; i++) {
        yearData = [yearData arrayByAddingObject:[NSNumber numberWithInteger:i]];
    }
    
    // Initialize month
    monthData = [[NSArray alloc] init];
    for (NSInteger i = 1; i <= 12; i++) {
        monthData = [monthData arrayByAddingObject:[NSNumber numberWithInteger:i]];
    }
    
    // Initalize country
    countryData = [[NSArray alloc] initWithObjects:@"Vietnam", @"Japan", @"US", @"Canada", @"China", nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setup];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addEventToViews];
    
    self.liftView = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setup {
    self.titleView1.backgroundColor = [AppUtil colorRGBA:0 :0 :0 :0.5];
    self.titleView2.backgroundColor = [AppUtil colorRGBA:0 :0 :0 :0.5];
    
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
    
    [self.btnMonth.layer setBorderWidth:2.0f];
    [self.btnMonth.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.btnMonth.layer setCornerRadius:self.btnMonth.frame.size.height/2];
    
    [self.btnYear.layer setBorderWidth:2.0f];
    [self.btnYear.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.btnYear.layer setCornerRadius:self.btnMonth.frame.size.height/2];
    
    [self.btnCountry.layer setBorderWidth:2.0f];
    [self.btnCountry.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.btnCountry.layer setCornerRadius:self.btnMonth.frame.size.height/2];
    
    self.btnNext.backgroundColor = THEME_RED_COLOR;
    self.btnNext.layer.cornerRadius = self.btnNext.frame.size.height / 2;
    
    // change color of title
    NSMutableAttributedString *text =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: self.lblTitle_4.attributedText];
    [text addAttribute:NSForegroundColorAttributeName
                 value:THEME_RED_COLOR
                 range:NSMakeRange(0, 6)];
    [self.lblTitle_4 setAttributedText: text];
}

- (void)addEventToViews {
    // For keyboards events
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)  name:UIKeyboardDidHideNotification object:nil];
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

- (BOOL)checkMonth {
    NSString *month = self.btnMonth.titleLabel.text;
    if ([month isEqualToString:@"Month"]) {
        return NO;
    }
    
    return YES;
}

- (BOOL)checkYear {
    NSString *year = self.btnYear.titleLabel.text;
    if ([year isEqualToString:@"Year"]) {
        return NO;
    }
    
    return YES;
}

- (BOOL)checkCountry {
    NSString *country = self.btnCountry.titleLabel.text;
    if ([country isEqualToString:@"Choose your country"]) {
        return NO;
    }
    
    return YES;
}

#pragma mark Keyboard-Events
- (void)keyboardWillShow:(NSNotification *)notification {
    if(!self.liftView)
        return;
    
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

#pragma mark UIPickerViewDataSource
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (currentPicking == 0) {
        return yearData.count;
    } else if (currentPicking == 1) {
        return monthData.count;
    } else {
        return countryData.count;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

#pragma mark UIPickerViewDelegate
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (currentPicking == 0) {
        NSNumber *year = [yearData objectAtIndex:row];
        return [NSString stringWithFormat:@"%d", [year integerValue]];
    } else if (currentPicking == 1) {
        NSNumber *month = [monthData objectAtIndex:row];
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM"];
        NSDate* myDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%d", [month integerValue]]];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMMM"];
        NSString *stringFromDate = [formatter stringFromDate:myDate];
        
        return stringFromDate;
    } else {
        return [countryData objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (currentPicking == 0) {
        NSNumber *year = [yearData objectAtIndex:row];
        [self.btnYear setTitle:[NSString stringWithFormat:@"%d", [year integerValue]]
                      forState:UIControlStateNormal];
    } else if (currentPicking == 1) {
        NSNumber *month = [monthData objectAtIndex:row];
        [self.btnMonth setTitle:[NSString stringWithFormat:@"%d", [month integerValue]]
                       forState:UIControlStateNormal];
    } else {
        [self.btnCountry setTitle:[countryData objectAtIndexedSubscript:row]
                         forState:UIControlStateNormal];
    }
    [self hidePickerView];
}

- (IBAction)btnNextClick:(id)sender {
    if (![self checkMonth]) {
        return;
    }
    NSString *month = self.btnMonth.titleLabel.text;
    if ([month length] == 1) {
        month = [NSString stringWithFormat:@"0%@", month];
    }
    
    if (![self checkYear]) {
        return;
    }
    NSString *year = self.btnYear.titleLabel.text;
    
    if (![self checkCountry]) {
        return;
    }
    
    NSString *dobString = [NSString stringWithFormat:@"%@-01-%@", month, year];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    
    // Save data
    [[SignupModel sharedInstance] setDob:[formatter dateFromString:dobString]];
    
    // Goto next step
    SignUpStep3ViewController *next = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUp3"];
    [self.navigationController pushViewController:next animated:YES];
}

- (IBAction)onMonth:(id)sender {
    currentPicking = 1;
    [pickerView reloadAllComponents];
    [self showPickerView];
}

- (IBAction)onYear:(id)sender {
    currentPicking = 0;
    [pickerView reloadAllComponents];
    [self showPickerView];
}

- (IBAction)onCountry:(id)sender {
    currentPicking = 2;
    [pickerView reloadAllComponents];
    [self showPickerView];
}
@end
