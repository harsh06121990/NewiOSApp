//
//  EventTableView.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/16/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvertTableViewCell.h"

@class AdvertTableView;
@protocol AdvertTableViewDelegate <NSObject>

- (void)advertTable:(AdvertTableView *)tableView advertSelected:(NSDictionary *)advert;

@end

@interface AdvertTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *adverts;
@property (nonatomic, assign) id customDelegate;

@end
