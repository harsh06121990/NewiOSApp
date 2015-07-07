//
//  EventTableView.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/21/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventTableViewCell.h"

@interface EventTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *events;

@end
