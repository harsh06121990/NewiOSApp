//
//  ConnectTableViewCell.h
//  ios-app
//
//  Created by MinhThai on 3/7/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConnectTableViewCell : UITableViewCell

@property CGFloat cellWidth;
@property CGFloat cellHeight;

@property (weak, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UIView *bodyView;
@property (weak, nonatomic) IBOutlet UIView *extendedView;

@property (weak, nonatomic) IBOutlet UIView *userImageHolder;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblUsertype;
@property (weak, nonatomic) IBOutlet UIButton *btnExpand;

@property (weak, nonatomic) IBOutlet UIView *profileBtnView;
@property (weak, nonatomic) IBOutlet UIView *blockBtnView;
@property (weak, nonatomic) IBOutlet UIView *deleteBtnView;


- (IBAction)btnExpandClick:(id)sender;


// Autolayout constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMarginConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bodyViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *extendedViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userImageWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelHolderHeightConstraint;


- (void)setup;

@end
