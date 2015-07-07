//
//  EventFeedViewController.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/21/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterTabBar.h"
#import "AdvertTableView.h"
#import "AdvertDetailViewController.h"
#import "CADebugLog.h"
#import "EventFilterTabBar.h"

@interface AdvertFeedViewController : UIViewController <FilterTabBarDelegate, UIScrollViewDelegate, AdvertTableViewDelegate, EventFilterTabBarDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewFilterTabHolder;
@property (weak, nonatomic) IBOutlet UIView *viewScrollContentHolder;
@property (weak, nonatomic) IBOutlet UIView *viewAllTableHolder;
@property (weak, nonatomic) IBOutlet UIView *viewDesignerTableHolder;
@property (weak, nonatomic) IBOutlet UIView *viewEngineerTableHolder;
@property (weak, nonatomic) IBOutlet UIView *viewPresenterTableHolder;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollMain;

@property (nonatomic, strong) EventFilterTabBar *filterTabBar;
@property (nonatomic, strong) AdvertTableView *advertTableView;

@end
