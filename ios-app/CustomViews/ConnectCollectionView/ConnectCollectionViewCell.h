//
//  ConnectCollectionViewCell.h
//  ios-app
//
//  Created by MinhThai on 3/4/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface ConnectCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *parentView;

@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UIView *userImgHolder;
@property (weak, nonatomic) IBOutlet UIImageView *userImgView;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblUsertype;
@property (weak, nonatomic) IBOutlet UIView *menuView;

// Autolayout constraints
// ------------------------
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userImgWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnMenuWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMarginMenuViewConstraint;


- (IBAction)btnMenuClick:(id)sender;
- (IBAction)btncloseClick:(id)sender;
- (void)showMenu;
- (void)hideMenu;

@end
