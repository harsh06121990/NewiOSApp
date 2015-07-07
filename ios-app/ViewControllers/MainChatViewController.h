//
//  PanelsViewController+MainChatViewController.h
//  ios-app
//
//  Created by Deepak on 18/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatActionBar.h"

@interface MainChatViewController : UIViewController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet ChatActionBar *actionBarView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *actionControlSegment;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollContentView;
@end
