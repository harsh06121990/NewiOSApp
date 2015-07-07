//
//  HomeTableViewCell.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/4/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyWrappingView.h"

@interface HomeTableViewCell : UITableViewCell

@property (weak, nonatomic) UIView *portFolioView;

@property (weak, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfilePic;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblUserType;

@property (weak, nonatomic) IBOutlet UILabel *lblInfo;
@property (weak, nonatomic) IBOutlet UILabel *lblIntro;

@property (weak, nonatomic) IBOutlet UIView *portFolioHolder;

@property (weak, nonatomic) IBOutlet UIView *userImgHolder;
@property (weak, nonatomic) IBOutlet UIView *usertypeHolder;
@property (weak, nonatomic) IBOutlet UIView *separatorView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userImgWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userImgHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuBtnHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuBtnWidthConstraint;

@end
