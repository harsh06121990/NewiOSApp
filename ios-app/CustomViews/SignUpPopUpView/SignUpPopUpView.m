//
//  SignUpPopUpView.m
//  ios-app
//
//  Created by MinhThai on 3/18/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "SignUpPopUpView.h"
#import "Constants.h"

@interface SignUpPopUpView()
@property CGSize oldBodyText1Size;
@property CGFloat oldButtonsGap;
@end

@implementation SignUpPopUpView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"SignUpPopUpView" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[SignUpPopUpView class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
        [self setFrame:frame];
    }
    
    [self setup];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setup {
    // Colors
    self.titleView.backgroundColor = THEME_COLOR_DARK;
    self.btnLeft.backgroundColor = THEME_COLOR;
    self.btnRight.backgroundColor = THEME_RED_COLOR;
    self.parentView.backgroundColor = [AppUtil colorRGBA:0 :0 :0 :0.5];
    
    // Measure
    self.popupView.layer.cornerRadius = 10;
    self.btnLeft.layer.cornerRadius = 10;
    self.btnRight.layer.cornerRadius = 10;
    
    self.btnLeft.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    self.btnRight.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    
    // Other
    [self.tfBody1 setReturnKeyType:UIReturnKeyDone];
    
    // Initially hide everything
    self.parentView.alpha = 0;
    
    // Add touch event to the dim background
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(bgClick:)];
    [self.parentView addGestureRecognizer:singleFingerTap];
}

- (void)show {
    [UIView animateWithDuration:0.3 animations:^{
        [self.parentView setAlpha:1.0];
    }];
}

- (void)setLeftButtonTitle:(NSString *)title {
    [self.btnLeft setTitle:title forState:UIControlStateNormal];
    
    CGSize stringsize = [title sizeWithFont:self.btnLeft.titleLabel.font];
    self.leftBtnWidthConstraint.constant = stringsize.width + 20;
    
    if(self.oldButtonsGap > 0)
        self.btnGapConstraint.constant = self.oldButtonsGap;
}

- (void)setRightButtonTitle:(NSString *)title {
    [self.btnRight setTitle:title forState:UIControlStateNormal];
    
}

- (void)hideUpperText {
    self.tfBody1.text = @"";
    self.oldBodyText1Size = self.tfBody1.frame.size;
    NSLayoutConstraint *con2 = [NSLayoutConstraint constraintWithItem:self.body1HolderView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
    [self.body1HolderView addConstraint:con2];
}

- (void)hideLeftButton {
    self.oldButtonsGap = self.btnGapConstraint.constant;
    self.leftBtnWidthConstraint.constant = 0;
    self.btnGapConstraint.constant = 0;
}

- (void)chooseDelegate:(id)view {
    self.delegate = view;
    self.tfBody1.delegate = view;
}

#pragma mark Events
- (IBAction)leftBtnClick:(id)sender {
    if (self.delegate) [self.delegate onLeftButtonClick: self];
}

- (IBAction)rightBtnClick:(id)sender {
    if (self.delegate) [self.delegate onRightButtonClick: self];
}

- (void)bgClick:(UITapGestureRecognizer *)recognizer {
    [self removeFromSuperview];
}
@end
