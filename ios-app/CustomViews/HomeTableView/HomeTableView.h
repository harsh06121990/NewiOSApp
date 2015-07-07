//
//  HomeTableView.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/4/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTableViewCell.h"
#import "CADebugLog.h"
#import <SDWebImage/SDImageCache.h>
#import "UserHelper.h"
#import "PortfolioHelper.h"

@class HomeTableView;
@protocol HomeTableViewDelegate <NSObject>

- (void)scrollViewWillBeginScrolling:(UIScrollView *)sender :(HomeTableView*)tableView;
- (void)scrollViewDidScrolled:(UIScrollView *)sender :(HomeTableView*)tableView;
- (void)scrollViewEndScroll:(UIScrollView *)sender :(HomeTableView*)tableView;
- (void)nextItemAppear:(UIView *)nextItem :(HomeTableView*)tableView;

@end

@interface HomeTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <HomeTableViewDelegate> delegate2;

@property (nonatomic, strong) NSMutableArray *users;

//- (HomeTableViewCell2 *)getCurrentCell;
- (UIView*)getDummyImage;
- (void)removeDummyImage;
- (UIView*)getDummyImage2;
- (void)removeDummyImage2;

@end
