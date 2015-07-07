//
//  AdEventViewController.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/21/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvertFeedViewController.h"
#import "EventFeedViewController.h"
#import "EventAdvertSelector.h"
#import "ExpandableSearchBar.h"

@interface AdEventViewController : UIViewController <EventAdvertSelectorDelegate>

@property (nonatomic, strong) AdvertFeedViewController *advertViewController;
@property (nonatomic, strong) EventFeedViewController *eventViewController;
@property (nonatomic, strong) EventAdvertSelector *eventAdSelector;

@property (weak, nonatomic) IBOutlet UIView *tabBarHolder;
@property (weak, nonatomic) IBOutlet UIView *bodyView;


@end
