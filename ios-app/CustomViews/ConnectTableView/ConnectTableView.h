//
//  ConnectTableView.h
//  ios-app
//
//  Created by MinhThai on 3/7/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConnectTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property CGFloat cellHeight;
@property (nonatomic, strong) NSMutableArray *Data;

@end
