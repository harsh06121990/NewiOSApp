//
//  ExperienceTableView.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/23/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExperienceTableViewCell.h"

@interface ExperienceTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *data;

@end
