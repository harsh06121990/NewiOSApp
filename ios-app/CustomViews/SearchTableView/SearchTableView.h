//
//  SearchTableView.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/12/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTableViewCell.h"
#import "UserPersonalModel.h"
#import "UserHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SearchTableView : UITableView <UITableViewDataSource, UITableViewDelegate, SearchTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *users;

@end
