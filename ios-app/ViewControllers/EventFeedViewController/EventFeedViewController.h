//
//  EventFeedViewController.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/21/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventTableView.h"
#import "EventFilterTabBar.h"

@interface EventFeedViewController : UIViewController <UIScrollViewDelegate, EventFilterTabBarDelegate>

@property (weak, nonatomic) IBOutlet UIView *parentView;

@property (weak, nonatomic) IBOutlet UIView *viewEventTabHolder;

@property (nonatomic, strong) EventTableView *eventTable;
@property (nonatomic, strong) EventFilterTabBar *eventTab;

@property (weak, nonatomic) IBOutlet UIScrollView *scollMain;
@property (weak, nonatomic) IBOutlet UIView *viewAllHolder;
@property (weak, nonatomic) IBOutlet UIView *viewTodayHolder;
@property (weak, nonatomic) IBOutlet UIView *viewComingHolder;

@end
