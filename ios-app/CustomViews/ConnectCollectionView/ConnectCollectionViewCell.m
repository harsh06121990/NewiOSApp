//
//  ConnectCollectionViewCell.m
//  ios-app
//
//  Created by MinhThai on 3/4/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ConnectCollectionViewCell.h"

@implementation ConnectCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.userImgHolder.layer setCornerRadius:self.userImgHolder.frame.size.width/2];
    [self.userImgView.layer setCornerRadius:self.userImgView.frame.size.width/2];
    [self.userImgHolder setClipsToBounds:YES];
    
    self.userImgHolder.layer.borderWidth = 2;
    self.userImgHolder.layer.borderColor = THEME_YELLOW_COLOR.CGColor;
    
    self.menuView.layer.cornerRadius = 5;
    self.menuView.backgroundColor = THEME_COLOR;
    self.parentView.layer.cornerRadius = 5;
    self.parentView.backgroundColor = THEME_COLOR;
}

- (IBAction)btnMenuClick:(id)sender {
    [self showMenu];
}
- (IBAction)btncloseClick:(id)sender
{
    [self hideMenu];
}

- (void)showMenu {
    [self.menuView setHidden:NO];
}

- (void)hideMenu {
    [self.menuView setHidden:YES];
}
@end
