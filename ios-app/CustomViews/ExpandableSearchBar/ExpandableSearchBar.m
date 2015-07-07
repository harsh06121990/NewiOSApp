//
//  ExpandableSearchBar.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/13/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ExpandableSearchBar.h"

@interface ExpandableSearchBar() {
    BOOL isToggled;
}

@end
@implementation ExpandableSearchBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ExpandableSearchBar" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[ExpandableSearchBar class]]) {
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
    [_txfQuery setDelegate:self];
    [_txfQuery setTintColor:[UIColor whiteColor]];
    [_txfQuery setTextColor:[UIColor whiteColor]];
    [_txfQuery.layer setBorderWidth:1.0f];
    [_txfQuery.layer setBorderColor:[[AppUtil colorHex:@"#3D494F"] CGColor]];
    [_txfQuery.layer setCornerRadius:5.0f];
    [_txfQuery setReturnKeyType:UIReturnKeyDone];
    [_txfQuery setHidden:YES];
    [_txfQuery setBackgroundColor:[AppUtil colorHex:@"#3D494F"]];
    isToggled = NO;
}

- (NSString *)getQuery {
    return _txfQuery.text;
}


#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_lblTitle setText:_txfQuery.text];
    [self searchTapped:_btnSearch];
    return YES;
}
- (IBAction)searchTapped:(id)sender {
    
    if (!isToggled) {
        [self.lblTitle setHidden:YES];
        [self layoutIfNeeded];
        self.layoutBtnTrailing.constant = self.frame.size.width - _btnSearch.frame.size.width;
        self.layoutTxfLeading.constant = self.frame.size.height;
        [UIView animateWithDuration:0.3 animations:^{
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self.viewQueryHolder bringSubviewToFront:_txfQuery];
            [self.txfQuery setHidden:NO];
            [_txfQuery becomeFirstResponder];
            isToggled = YES;
        }];
    } else {
        [self.txfQuery setHidden:YES];
        [self layoutIfNeeded];
        self.layoutTxfLeading.constant = 0;
        self.layoutBtnTrailing.constant = 0;
        [UIView animateWithDuration:0.3 animations:^{
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            [_txfQuery resignFirstResponder];
            [self.viewQueryHolder bringSubviewToFront:_lblTitle];
            [self.lblTitle setHidden:NO];
            isToggled = NO;
        }];
    }
}
@end
