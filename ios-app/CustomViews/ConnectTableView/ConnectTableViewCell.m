//
//  ConnectTableViewCell.m
//  ios-app
//
//  Created by MinhThai on 3/7/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ConnectTableViewCell.h"
#import "CADebugLog.h"

@interface ConnectTableViewCell()
@property BOOL isExtendedViewOpened;
@end

@implementation ConnectTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark Custom Methods
- (void)setup {
    [self measure];
    [self addGesture];
}

- (void)measure {
    self.leftMarginConstraint.constant = 0;
    self.bodyViewWidthConstraint.constant = self.cellWidth;
    self.cellWidthConstraint.constant = self.cellWidth + self.extendedView.frame.size.width;
}

- (void)addGesture {
    // Swipe gesture
    // ---------------
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.bodyView addGestureRecognizer: swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.bodyView addGestureRecognizer: swipeLeft];
    
    // Click gesture
    // ---------------
    UITapGestureRecognizer *profileTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(profileBtnClick:)];
    [self.profileBtnView addGestureRecognizer:profileTap];
    
    UITapGestureRecognizer *blockTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(blockBtnClick:)];
    [self.profileBtnView addGestureRecognizer:blockTap];
    
    UITapGestureRecognizer *deleteTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(deleteBtnClick:)];
    [self.profileBtnView addGestureRecognizer:deleteTap];
    
}

- (void)profileBtnClick:(UITapGestureRecognizer *)recognizer {
}

- (void)blockBtnClick:(UITapGestureRecognizer *)recognizer {
}

- (void)deleteBtnClick:(UITapGestureRecognizer *)recognizer {
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)gesture {
    if (gesture.direction == UISwipeGestureRecognizerDirectionRight)
        [self closeExtendedView];
    else if (gesture.direction == UISwipeGestureRecognizerDirectionLeft)
        [self openExtendedView];
}

- (void)openExtendedView {
    if(self.isExtendedViewOpened)
        return;
    
    self.leftMarginConstraint.constant -= self.extendedView.frame.size.width;
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
        [self.btnExpand setAlpha:0];
    }completion:^(BOOL finished) {
        self.isExtendedViewOpened = YES;
    }];
}

- (void)closeExtendedView {
    if(!self.isExtendedViewOpened)
        return;
    
    self.leftMarginConstraint.constant += self.extendedView.frame.size.width;
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
        [self.btnExpand setAlpha:1];
    }completion:^(BOOL finished) {
        self.isExtendedViewOpened = NO;
    }];
}

- (IBAction)btnExpandClick:(id)sender {
    if(self.isExtendedViewOpened) {
        [self closeExtendedView];
    }
    else {
        [self openExtendedView];
    }
}
@end
