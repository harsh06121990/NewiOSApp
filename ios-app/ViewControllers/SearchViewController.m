//
//  SearchViewController.m
//  ios-app
//
//  Created by MinhThai on 2/5/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "SearchViewController.h"
#import "Constants.h"
#import "Utility.h"

@interface SearchViewController () {
    SearchTableView *searchResultTable;
    NSMutableDictionary *searchQuery;
    NSMutableArray *allResult;
}
    @property UIView* indicator;
    @property CGFloat lastOffset;
    @property int currentPage;
    @property BOOL isFilterMenuOpened;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollView.delegate = self;
    
    //[self setupView];
    [self reAlignElements];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self setupView];
}

- (void)viewDidAppear:(BOOL)animated {
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Custom-Methods
- (void)setupView {
    // Set appearance for elements
    // ------------------------------
    self.searchView.layer.cornerRadius = 5;
    self.headerView.backgroundColor = THEME_COLOR;
    
    // Hide Navigation bar
    [self.navigationController setNavigationBarHidden:YES];
    
    if (searchResultTable == nil) {
        searchResultTable = [[SearchTableView alloc] initWithFrame:CGRectMake(0, 0,
                                                                              self.allTableView.frame.size.width,
                                                                              self.allTableView.frame.size.height)];
        NSLog(@"%f", self.view.frame.size.width);
    }
    
    if (self.userFilterTabBar == nil) {
        self.userFilterTabBar = [[FilterTabBar alloc] initWithFrame:CGRectMake(0, 0,
                                                                               self.searchTypeView.frame.size.width,
                                                                               self.searchTypeView.frame.size.height)];
        [self.searchTypeView addSubview:self.userFilterTabBar];

    }
    
    [self.userFilterTabBar setDelegate:self];
    [self.allTableView addSubview:searchResultTable];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.btnBeginSearch addTarget:self action:@selector(startSearch) forControlEvents:UIControlEventTouchUpInside];
    
    // Wait for all autolayout constraints to finish, then re-position the indicator
    dispatch_queue_t waitQueue = dispatch_queue_create("com.connekt.waiter", nil);
    dispatch_async(waitQueue, ^{
        [NSThread sleepForTimeInterval:0.1];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([NSThread isMainThread]) {
                [self.userFilterTabBar resetIndicatorToIndex:0];
            }
        });
    });
}

- (void)startSearch {
    [[SearchHelper getInstance] searchUsers:@"all"
                                searchQuery:self.tfQuery.text
                       searchInsideEduction:[[searchQuery valueForKey:@"education"] boolValue]
                       searchInsideUsername:[[searchQuery valueForKey:@"name"] boolValue]
                     searchInsideProficieny:YES
                          searchInsideSkill:[[searchQuery valueForKey:@"skill"] boolValue]
                      searchInsidePortfolio:YES
                               filterByCity:nil
                            filterByCountry:nil
                        filterByAgeLessThan:[NSNumber numberWithInt:100]
                     filterByAgeGreaterThan:[NSNumber numberWithInt:10]
                                   callback:^(bool success, id result) {
                                       NSArray *res = (NSArray *)result;
                                       if (success) {
                                           CADLog(@"%@", res.description);
                                           NSArray *userIds = [NSArray new];
                                           for (NSDictionary *userDic in res) {
                                               userIds = [userIds arrayByAddingObject:
                                                          [NSNumber numberWithInteger:[[userDic objectForKey:@"user_id"] integerValue]]];
                                           }
                                           
                                           [UserUtil getUsersDetail:userIds callback:^(bool success, id result) {
                                               if (success) {
                                                   allResult = (NSMutableArray *)result;
                                                   [searchResultTable setUsers:[self filterUserFromResult:allResult ForIndex:self.currentPage]];
                                                   [searchResultTable reloadData];
                                               }
                                           }];
                                       } else {
                                           
                                       }
                                   }];
}

- (void)reAlignElements {
    [self.scrollView setContentSize:CGSizeMake(self.scrollContentView.frame.size.width, self.scrollView.frame.size.height)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + (0.5f * width)) / width;
    
    if(page != self.currentPage) {
        self.currentPage = page;
        [self.userFilterTabBar resetIndicatorToIndex:self.currentPage];
        
        [searchResultTable removeFromSuperview];
        [searchResultTable setUsers:[self filterUserFromResult:allResult ForIndex:self.currentPage]];
        [searchResultTable reloadData];
        
        if (self.currentPage == 0) {
            [self.allTableView addSubview:searchResultTable];
        } else if (self.currentPage == 1) {
            [self.designerTableView addSubview:searchResultTable];
        } else if (self.currentPage == 2) {
            [self.engineerTableView addSubview:searchResultTable];
        } else {
            [self.hustlerTableView addSubview:searchResultTable];
        }
    }
}

- (void)showFilterMenu {
    // Create filter menu
    // ---------------------
    CGFloat pageW = self.parentView.frame.size.width, pageH = self.parentView.frame.size.height;
    CGRect filterFrame = CGRectMake(0, -75, pageW, 75);
    FilterMenuView *filter_menu = [[FilterMenuView alloc] initWithFrame:filterFrame];
    filter_menu.tag = 98;
    
    // Create a dummy background
    // ----------------------------
    UIView *dummy = [[UIView alloc] init];
    [dummy setFrame:CGRectMake(0, 0, pageW, pageH)];
    dummy.backgroundColor = [AppUtil colorRGBA:0 :0 :0 :0.7];
    dummy.tag = 99;
    [dummy setAlpha:0];
    // Add click event
    UITapGestureRecognizer *singleClick1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dummy_Click:)];
    [dummy addGestureRecognizer:singleClick1];
    
    [self.bodyView addSubview:dummy];
    [self.bodyView addSubview:filter_menu];
    
    // Fade animation for dummy view
    [UIView animateWithDuration:0.3 animations:^{
        [dummy setAlpha:0.5];
        [filter_menu setFrame:CGRectMake(0, 0, pageW, 75)];
    }];
}

- (void)hideFilterMenu {
    // Play animation and remove subview
    [UIView animateWithDuration:0.3 animations:^{
        [[self.bodyView viewWithTag:98] setFrame:CGRectMake(0, -75, self.bodyView.frame.size.width, 75)];
        [[self.bodyView viewWithTag:99] setAlpha:0];
    } completion:^(BOOL finished) {
        [[self.bodyView viewWithTag:98] removeFromSuperview];
        [[self.bodyView viewWithTag:99] removeFromSuperview];
    }];
}

- (IBAction)btnFilter_Click:(id)sender {
    if(!self.isFilterMenuOpened) {
        [self showFilterMenu];
        
        [self.btnFilter setTitle:@"Done" forState:UIControlStateNormal];
        
        self.isFilterMenuOpened = YES;
    }
    else {
        [self hideFilterMenu];
        
        [self.btnFilter setTitle:@"Filter" forState:UIControlStateNormal];
        
        self.isFilterMenuOpened = NO;
    }
}

- (void)dummy_Click:(UITapGestureRecognizer *)recognizer {
    [self hideFilterMenu];
    [self.btnFilter setTitle:@"Filter" forState:UIControlStateNormal];
    self.isFilterMenuOpened = NO;
}


/*
 * Filter users by type for each page
 */
- (NSMutableArray *)filterUserFromResult:(NSMutableArray *)userList ForIndex:(NSInteger)index {
    NSMutableArray *result = [NSMutableArray new];
    NSString *typeByString;
    
    switch (index) {
        case 0: {
            typeByString = @"all";
            break;
        }
            
        case 1: {
            typeByString = @"DESIGNER";
            break;
        }
            
        case 2: {
            typeByString = @"ENGINEER";
            break;
        }
            
        case 3: {
            typeByString = @"HUSTLER";
        }
        default:
            break;
    }
    
    if ([typeByString isEqualToString:@"all"]) return userList;
    
    for (NSDictionary *userDic in userList) {
        if ([[userDic objectForKey:@"type"] isEqualToString:typeByString]) {
            [result addObject:userDic];
        }
    }
    
    return result;
}

#pragma mark FilterMenuDelegate
- (void)filterMenu:(FilterMenuView *)menu filterSelected:(NSMutableArray *)selectedFileters {
    [searchQuery removeAllObjects];
    for (NSNumber *value in selectedFileters) {
        switch ([value intValue]) {
            case NAME: {
                [searchQuery setValue:[NSNumber numberWithBool:YES] forKey:@"name"];
                break;
            }
                
            case SKILL: {
                [searchQuery setValue:[NSNumber numberWithBool:YES] forKey:@"skill"];
                break;
            }
                
            case COUNTRY: {
                [searchQuery setValue:[NSNumber numberWithBool:YES] forKey:@"country"];
                break;
            }
                
            case EDUCATION: {
                [searchQuery setValue:[NSNumber numberWithBool:YES] forKey:@"education"];
                break;
            }
                
            case AGE: {
                [searchQuery setValue:[NSNumber numberWithBool:YES] forKey:@"age"];
                break;
            }
                
            default:
                break;
        }
    }
}

#pragma mark FilterTabBarDelegate
- (void)filterTabBar:(FilterTabBar *)tabBar filterSelect:(UIView *)filter {
    switch (filter.tag) {
        case ALL: {
            CGFloat width = self.scrollView.frame.size.width;
            [self.scrollView setContentOffset:CGPointMake(width*0, 0) animated:YES];
            break;
        }
            
        case DESIGNER: {
            CGFloat width = self.scrollView.frame.size.width;
            [self.scrollView setContentOffset:CGPointMake(width*1, 0) animated:YES];
            break;
        }
            
        case ENGINEER: {
            CGFloat width = self.scrollView.frame.size.width;
            [self.scrollView setContentOffset:CGPointMake(width*2, 0) animated:YES];
            break;
        }
            
        case PRESENTER: {
            CGFloat width = self.scrollView.frame.size.width;
            [self.scrollView setContentOffset:CGPointMake(width*3, 0) animated:YES];
            break;
        }
            
        default:
            break;
    }
}

@end
