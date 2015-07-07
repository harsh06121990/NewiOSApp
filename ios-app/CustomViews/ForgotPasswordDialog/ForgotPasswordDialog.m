//
//  ForgotPasswordDialog.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/17/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ForgotPasswordDialog.h"

@interface ForgotPasswordDialog() {
    int currentPage;
}

@end

@implementation ForgotPasswordDialog
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ForgotPasswordDialog" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[ForgotPasswordDialog class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
        [self setFrame:frame];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setup {
    [_scrollView setDelegate:self];
    [_scrollView setScrollEnabled:NO];
    [_txfEmail setReturnKeyType:UIReturnKeyDone];
    [_txfEmail setDelegate:self];
    [self.layer setCornerRadius:10.0f];
    [self setClipsToBounds:YES];
    [_btnRetype.layer setCornerRadius:_btnRetype.frame.size.height/2];
    [_btnForgot.layer setCornerRadius:_btnForgot.frame.size.height/2];
    [_btnRemind.layer setCornerRadius:_btnRemind.frame.size.height/2];
    [_btnConfirm.layer setCornerRadius:_btnConfirm.frame.size.height/2];
    [_btnBack.layer setCornerRadius:_btnBack.frame.size.height/2];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + (0.5f * width)) / width;
    
    if(page != currentPage) {
        currentPage = page;
    }
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark Event-Handlers
- (IBAction)retype:(id)sender {
    if (delegate) [delegate forgotDialog:self onReype:sender];
}

- (IBAction)forgot:(id)sender {
    if (delegate) [delegate forgotDialog:self onForgot:sender];
}

- (IBAction)back:(id)sender {
    if (delegate) [delegate forgotDialog:self onBack:sender];
}

- (IBAction)remind:(id)sender {
    if (delegate) [delegate forgotDialog:self onRemind:sender];
}

- (IBAction)confirm:(id)sender {
    if (delegate) [delegate forgotDialog:self onConfirm:sender];
}

- (void)setIndex:(NSUInteger)index {
    CGFloat width = self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(index * width, 0) animated:YES];
}
@end
