//
//  ConnectTabBar.h
//  ios-app
//
//  Created by MinhThai on 3/5/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ConnectTabBar;
@protocol ConnectTabBarDelegate <NSObject>

// get called when user select a tab
- (void)connectTabBar:(ConnectTabBar *)sender didSelect:(UIView *)item atIndex:(int)index;

@end

@interface ConnectTabBar : UIView

@property (nonatomic, strong) id delegate;

@property (weak, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UIView *allHolder;
@property (weak, nonatomic) IBOutlet UIView *designerHolder;
@property (weak, nonatomic) IBOutlet UIView *engineerHolder;
@property (weak, nonatomic) IBOutlet UIView *presenterHolder;

// Autolayout constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *itemWidthConstraint;

// Custom methods
- (void)selectTab:(int)index;

@end
