//
//  SearchViewController.h
//  ios-app
//
//  Created by MinhThai on 2/5/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTableView.h"
#import "FilterMenuView.h"
#import "SearchHelper.h"
#import "UserHelper.h"
#import "CADebugLog.h"
#import "UserPersonalModel.h"
#import "FilterTabBar.h"

@interface SearchViewController : UIViewController <UIScrollViewDelegate, FilterMenuDelegate, FilterTabBarDelegate>
@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UIView *bodyView;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIButton *btnFilter;
@property (weak, nonatomic) IBOutlet UITextField *tfQuery;

@property (weak, nonatomic) IBOutlet UIView *searchTypeView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *allTableView;
@property (weak, nonatomic) IBOutlet UIView *designerTableView;
@property (weak, nonatomic) IBOutlet UIView *engineerTableView;
@property (weak, nonatomic) IBOutlet UIView *hustlerTableView;

@property (weak, nonatomic) IBOutlet UIView *scrollContentView;
@property (weak, nonatomic) IBOutlet UIButton *btnBeginSearch;

@property (nonatomic, strong) FilterTabBar *userFilterTabBar;
// Event Handlers
- (IBAction)btnFilter_Click:(id)sender;


@end
