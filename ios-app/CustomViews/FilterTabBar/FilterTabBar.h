//
//  FilterTabBar.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/16/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@class FilterTabBar;
@protocol FilterTabBarDelegate <NSObject>

- (void)filterTabBar:(FilterTabBar *)tabBar filterSelect:(UIView *)filter;

@end

@interface FilterTabBar : UIView

typedef enum {
    ALL = 30,
    DESIGNER = 31,
    ENGINEER = 32,
    PRESENTER = 33
} FILTER_TAB_COMPONENT;

@property (weak, nonatomic) IBOutlet UIView *viewAllHolder;
@property (weak, nonatomic) IBOutlet UIImageView *imgAll;
@property (weak, nonatomic) IBOutlet UIView *viewDesignerHolder;
@property (weak, nonatomic) IBOutlet UIImageView *imgDesigner;
@property (weak, nonatomic) IBOutlet UIView *viewEngineerHolder;
@property (weak, nonatomic) IBOutlet UIImageView *imgEngineer;
@property (weak, nonatomic) IBOutlet UIView *viewPresenterHolder;
@property (weak, nonatomic) IBOutlet UIImageView *imgPresenter;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, assign) id delegate;

- (void)resetIndicatorToIndex:(NSInteger)index;

@end
