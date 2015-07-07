//
//  SearchTableViewCell.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/12/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell
@synthesize delegate, indexPath;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *infoClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(infoClicked:)];
    [self.viewInfoHolder addGestureRecognizer:infoClick];
    
    UITapGestureRecognizer *typeClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(typeClicked:)];
    [self.viewTitleHolder addGestureRecognizer:typeClick];
    
    [self.btnProfilePic addTarget:self action:@selector(btnProfileTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.viewAllHolder.layer setMasksToBounds:YES];
    [self.viewAllHolder.layer setCornerRadius:3.0f];
    
    //[self.viewBtnProfileHolder.layer setMasksToBounds:YES];
    [self.viewBtnProfileHolder.layer setCornerRadius:self.viewBtnProfileHolder.frame.size.width/2];
    [self.viewBtnProfileHolder.layer setShadowColor:[[UIColor lightGrayColor] CGColor]];
    [self.viewBtnProfileHolder.layer setShadowOffset:CGSizeMake(1.5f, 1.5f)];
    [self.viewBtnProfileHolder.layer setShadowOpacity:1.0f];
    [self.viewBtnProfileHolder.layer setShadowRadius:1.0f];
    
    [self.btnProfilePic.layer setMasksToBounds:YES];
    [self.btnProfilePic.layer setCornerRadius:self.btnProfilePic.frame.size.width/2];
    [self.btnProfilePic.layer setBorderWidth:0.5f];
    [self.btnProfilePic.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.btnProfilePic setClipsToBounds:YES];
    
    [self.btnProfilePic layoutIfNeeded];
    
    [self.contentView layoutIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)infoClicked:(id)sender {
    if (delegate) [delegate searchTableViewCell:self componentTapped:(UIView *)self.viewInfoHolder atIndexPath:indexPath];
}

- (void)typeClicked:(id)sender {
    if (delegate) [delegate searchTableViewCell:self componentTapped:(UIView *)self.viewTitleHolder atIndexPath:indexPath];
}

- (void)btnProfileTapped:(id)sender {
    if (delegate) [delegate searchTableViewCell:self componentTapped:(UIView *)sender atIndexPath:indexPath];
}

- (void)setColorForType:(NSString *)userType {
    if ([userType isEqualToString:@"ENGINEER"]) {
        [self.viewBtnProfileHolder setBackgroundColor:THEME_COLOR_DARK];
    } else if ([userType isEqualToString:@"DESIGNER"]) {
        [self.viewBtnProfileHolder setBackgroundColor:THEME_RED_COLOR];
    } else if ([userType isEqualToString:@"HUSTLER"]) {
        [self.viewBtnProfileHolder setBackgroundColor:THEME_YELLOW_COLOR];
    }
}

@end
