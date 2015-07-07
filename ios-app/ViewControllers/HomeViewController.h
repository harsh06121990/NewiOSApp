//
//  HomeViewController.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/5/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTableView.h"
#import "Constants.h"
#import "ConnectTabBar.h"
#import "FilterMenuView.h"
#import "ExpandableSearchBar.h"
#import "SearchHelper.h"
#import "UserHelper.h"

@interface HomeViewController : UIViewController <HomeTableViewDelegate, ConnectTabBarDelegate, FilterMenuDelegate>

@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *bodyView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *userTypeView;

@property (weak, nonatomic) IBOutlet UIButton *btnFilter;

@property (nonatomic, strong) ConnectTabBar *homeTabBar;
@property (nonatomic, strong) HomeTableView *homeTableView;
@property (nonatomic, strong) ExpandableSearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *tableViewHolder;
@property (weak, nonatomic) IBOutlet UIView *topIndicatorView;
@property (weak, nonatomic) IBOutlet UIView *bottomIndicatorView;

@property (weak, nonatomic) IBOutlet UIView *indicatorLineTop;
@property (weak, nonatomic) IBOutlet UIImageView *indicatorIconTop;
@property (weak, nonatomic) IBOutlet UIView *indicatorLineBottom;
@property (weak, nonatomic) IBOutlet UIImageView *indicatorIconBottom;

@end
