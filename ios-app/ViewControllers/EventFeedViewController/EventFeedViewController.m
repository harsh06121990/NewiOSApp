//
//  EventFeedViewController.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/21/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "EventFeedViewController.h"

@interface EventFeedViewController () {
    NSInteger currentPage;
}

@end

@implementation EventFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.eventTable == nil) {
        self.eventTable = [[EventTableView alloc] initWithFrame:CGRectMake(0, 0,
                                                                           self.viewAllHolder.frame.size.width,
                                                                           self.viewAllHolder.frame.size.height)];
        self.eventTable.events = [self createFakeData];
    }
    
    if (self.eventTab == nil) {
        self.eventTab = [[EventFilterTabBar alloc] initWithFrame:CGRectMake(0, 0,
                                                                            self.viewEventTabHolder.frame.size.width,
                                                                            self.viewEventTabHolder.frame.size.height)];
        [self.viewEventTabHolder addSubview:self.eventTab];
        [self.viewEventTabHolder setBackgroundColor:THEME_COLOR_DARK];
    }
    
    [self.eventTable removeFromSuperview];
    if ([self.eventTab getCurrentIndex] == 0) {
        [self.viewAllHolder addSubview:self.eventTable];
    } else if ([self.eventTab getCurrentIndex] == 1) {
        [self.viewTodayHolder addSubview:self.eventTable];
    } else {
        [self.viewComingHolder addSubview:self.eventTable];
    }
    
    self.parentView.backgroundColor = THEME_COLOR_DARKER;
    [self.eventTab setDelegate:self];
    currentPage = [self.eventTab getCurrentIndex];
    [self.scollMain setDelegate:self];
}

// Fake data for testing
- (NSMutableArray *)createFakeData {
    NSMutableArray *rs = [[NSMutableArray alloc]init];
    NSArray *imgs = @[@"sameple_google", @"sample_event", @"sample_cover"];
    NSArray *titles = @[@"INTERACTIVITY IN RESTAURANT", @"MEET THE STUDENT DEVELOPERS", @"GO TO THE PARK"];
    
    int n = [AppUtil randomRange:5 :50];
    for(int i = 0; i < n; ++i) {
        NSDictionary *event = @{@"image": [imgs objectAtIndex:[AppUtil randomRange:0 :imgs.count]],
                               @"title": [titles objectAtIndex:[AppUtil randomRange:0 :titles.count]]};
        [rs addObject:event];
    }
    return rs;

}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + (0.5f * width)) / width;
    
    if(page != currentPage) { // scroll to other page
        
        [self.eventTab resetIndicatorToIndex:page];
        currentPage = page;
        
        [self.eventTable removeFromSuperview];
        if (currentPage == 0) {
            [self.viewAllHolder addSubview:self.eventTable];
        } else if (currentPage == 1) {
            [self.viewTodayHolder addSubview:self.eventTable];
        } else if (currentPage == 2) {
            [self.viewComingHolder addSubview:self.eventTable];
        }
    }
}

#pragma mark EventFilterDelegate
- (void)eventFilter:(EventFilterTabBar *)tabBar indexSelected:(NSInteger)index {
    switch (index) {
        case 0: {
            CGFloat width = self.scollMain.frame.size.width;
            [self.scollMain setContentOffset:CGPointMake(width*0, 0) animated:YES];
            break;
        }
            
        case 1: {
            CGFloat width = self.scollMain.frame.size.width;
            [self.scollMain setContentOffset:CGPointMake(width*1, 0) animated:YES];
            break;
        }
            
        case 2: {
            CGFloat width = self.scollMain.frame.size.width;
            [self.scollMain setContentOffset:CGPointMake(width*2, 0) animated:YES];
            break;
        }
            
        default:
            break;
    }
}

@end
