//
//  EventFeedViewController.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/21/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "AdvertFeedViewController.h"
#import "EventFilterTabBar.h"

@interface AdvertFeedViewController () {
    int currentPage;
    AdvertDetailViewController *advertDetailVC;
}

@end

@implementation AdvertFeedViewController

- (id)init {
    self = [super initWithNibName:@"AdvertFeedViewController" bundle:nil];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setView];
}

- (void)setView {
    if (self.filterTabBar == nil) {
        self.filterTabBar = [[EventFilterTabBar alloc] initWithFrame:CGRectMake(0, 0,
                                                                           self.viewFilterTabHolder.frame.size.width,
                                                                           self.viewFilterTabHolder.frame.size.height)];

        [self.filterTabBar setTabTitles:@[@"Engineer", @"Designer", @"Presenter"]];
        self.filterTabBar.delegate = self;
        [self.filterTabBar setBackgroundColor:THEME_COLOR_DARK];
        [self.viewFilterTabHolder addSubview:self.filterTabBar];
    }
    
    if (self.advertTableView == nil) {
        self.advertTableView = [[AdvertTableView alloc] initWithFrame:CGRectMake(0, 0,
                                                                               self.viewAllTableHolder.frame.size.width,
                                                                               self.viewAllTableHolder.frame.size.height)];
        [self.viewAllTableHolder addSubview:self.advertTableView];
        [self.advertTableView setCustomDelegate:self];
    }
    
    if (advertDetailVC == nil) {
        advertDetailVC = [[AdvertDetailViewController alloc] init];
    }
    
    [self.scrollMain setDelegate:self];
    [self.filterTabBar setDelegate:self];
    [self.scrollMain setContentSize:CGSizeMake(self.viewScrollContentHolder.frame.size.width, self.scrollMain.frame.size.height)];
    
    // Wait for all autolayout constraints to finish, then re-position the indicator
    dispatch_queue_t waitQueue = dispatch_queue_create("com.connekt.waiter", nil);
    dispatch_async(waitQueue, ^{
        [NSThread sleepForTimeInterval:0.1];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([NSThread isMainThread]) {
                [self.filterTabBar resetIndicatorToIndex:0];
            }
        });
    });
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark FilterTabBarDelegate
- (void)filterTabBar:(FilterTabBar *)tabBar filterSelect:(UIView *)filter {
    switch (filter.tag) {
        case ALL: {
            CGFloat width = self.scrollMain.frame.size.width;
            [self.scrollMain setContentOffset:CGPointMake(width*0, 0) animated:YES];
            break;
        }
            
        case DESIGNER: {
            CGFloat width = self.scrollMain.frame.size.width;
            [self.scrollMain setContentOffset:CGPointMake(width*1, 0) animated:YES];
            break;
        }
            
        case ENGINEER: {
            CGFloat width = self.scrollMain.frame.size.width;
            [self.scrollMain setContentOffset:CGPointMake(width*2, 0) animated:YES];
            break;
        }
            
        case PRESENTER: {
            CGFloat width = self.scrollMain.frame.size.width;
            [self.scrollMain setContentOffset:CGPointMake(width*3, 0) animated:YES];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark TabBarDelegate
- (void)eventFilter:(EventFilterTabBar *)tabBar indexSelected:(NSInteger)index {
    
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + (0.5f * width)) / width;
    
    if(page != currentPage) { // scroll to other page
        
        [self.filterTabBar resetIndicatorToIndex:page];
        currentPage = page;
        
        [self.advertTableView removeFromSuperview];
        if (currentPage == 0) {
            [self.viewAllTableHolder addSubview:self.advertTableView];
        } else if (currentPage == 1) {
            [self.viewDesignerTableHolder addSubview:self.advertTableView];
        } else if (currentPage == 2) {
            [self.viewEngineerTableHolder addSubview:self.advertTableView];
        } else {
            [self.viewPresenterTableHolder addSubview:self.advertTableView];
        }
    }
}

#pragma mark AdvertTableViewDelegate
- (void)advertTable:(AdvertTableView *)tableView advertSelected:(NSDictionary *)advert {
    [self.parentViewController.navigationController pushViewController:advertDetailVC animated:YES];
}

@end
