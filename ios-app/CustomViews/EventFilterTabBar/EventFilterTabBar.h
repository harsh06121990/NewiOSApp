//
//  EventFilterTabBar.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/21/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@class EventFilterTabBar;
@protocol EventFilterTabBarDelegate

- (void)eventFilter:(EventFilterTabBar *)tabBar indexSelected:(NSInteger)index;

@end

@interface EventFilterTabBar : UIView


@property (weak, nonatomic) IBOutlet UIView *parentView;

@property (weak, nonatomic) IBOutlet UIView *viewIndicator;
@property (weak, nonatomic) IBOutlet UIButton *btnAll;
@property (weak, nonatomic) IBOutlet UIButton *btnToday;
@property (weak, nonatomic) IBOutlet UIButton *btnComing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *autoSliderLeadingSpace;

@property (nonatomic, strong) id delegate;

- (NSInteger)getCurrentIndex;
- (void)resetIndicatorToIndex:(NSInteger)index;
- (void)setTabTitles:(NSArray *)titles; // max 3 titles

@end
