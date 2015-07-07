//
//  HomeViewController.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/5/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "HomeViewController.h"
#import "Utility.h"
#import <tgmath.h>

@interface HomeViewController () {
    UILabel *lblTitle;
    CGFloat lastContentOffset;
    CGFloat middleOffset; // use this to detect scroll direction
    CGFloat anchorPoint; // the last fixed content offset (when animation ended)
    BOOL    isFilterMenuOpened;

    NSMutableDictionary *searchQuery;
    NSMutableArray *allResult;
}
    @property UIView *dummyItem;
    @property UIView *dummyItem2;
    @property BOOL isScrollUp;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setView];
    [self addTableView];
    
    [self calculateMiddleOffset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Custom-Methods
- (void)setView {
    // Hide Navigation bar
    self.tableViewHolder.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:THEME_COLOR_DARK];
    searchQuery = [NSMutableDictionary new];
    
    if (self.searchBar == nil) {
        self.searchBar = [[ExpandableSearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        [self.searchBar setBackgroundColor:THEME_COLOR_DARK];
        [self.searchBar.lblTitle setText:@"Talent Search"];
        [self.searchBar.lblTitle setTextColor:[UIColor whiteColor]];
    }
    [self.navigationItem setTitleView:self.searchBar];
    
    
    // Create filter button
    [self createSettingButton];
    
    // Set color
    // ----------
    [self.contentView setBackgroundColor:THEME_COLOR_DARKER];
    [self.indicatorIconTop setBackgroundColor:THEME_COLOR_DARKER];
    [self.indicatorIconBottom setBackgroundColor:THEME_COLOR_DARKER];
    [self.topView setBackgroundColor:THEME_COLOR_DARK];
    
    // Create gradient color for 2 indicator lines
    // ----------------------------------------------
    [self addGradient:self.indicatorLineTop centerColor:THEME_COLOR];
    [self addGradient:self.indicatorLineBottom centerColor:THEME_COLOR];
    // Create tab bar on the top
    // ---------------------------
    if (self.homeTabBar == nil) {
        self.homeTabBar = [[ConnectTabBar alloc] initWithFrame:CGRectMake(0, 0,
                                                                          self.userTypeView.frame.size.width - 20,
                                                                          self.userTypeView.frame.size.height - 20)];
        [self.userTypeView addSubview:self.homeTabBar];
        [self.homeTabBar setCenter:self.userTypeView.center];
        [self.userTypeView setBackgroundColor:THEME_COLOR_DARK];
        
        // Wait for all autolayout constraints to finish, then re-position the indicator
        dispatch_queue_t waitQueue = dispatch_queue_create("com.connekt.waiter", nil);
        dispatch_async(waitQueue, ^{
            [NSThread sleepForTimeInterval:0.1];
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([NSThread isMainThread]) {
                    [self.homeTabBar selectTab:0]; // update tabbar with new size
                }
            });
        });
    }
    
    // =========== Add event handlers ============
    [self.btnFilter addTarget:self action:@selector(filterTapped:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)createSettingButton
{
    //Create UIButton
    UIButton *filterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [filterButton setTitle:@"Filter" forState:UIControlStateNormal];
    [filterButton addTarget:self action:@selector(filterTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [searchButton setImage:[UIImage imageNamed:@"profile_go"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(startSearch) forControlEvents:UIControlEventTouchUpInside];
    
    //Create UIBarbuttonItem and add UIButton in it
    UIBarButtonItem *settingBarButton = [[UIBarButtonItem alloc] initWithCustomView:filterButton];
    UIBarButtonItem *searchBarButton = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    
    //Add UIBarButtonItem to NavigationBar
    [self.navigationItem setRightBarButtonItem:settingBarButton];
    [self.navigationItem setLeftBarButtonItem:searchBarButton];
}

- (void)addGradient:(UIView *)view centerColor:(UIColor *)center{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.startPoint = CGPointMake(0.0, 0.5); // make gradient horizontal
    gradient.endPoint = CGPointMake(1.0, 0.5);   // make gradient horizontal
    gradient.colors = @[(id)THEME_COLOR_DARKER.CGColor, (id)center.CGColor, (id)THEME_COLOR_DARKER.CGColor];
    gradient.locations = @[[NSNumber numberWithFloat:0], [NSNumber numberWithFloat:0.5], [NSNumber numberWithFloat:1]];
    
    //gradient.frame = self.indicatorLineTop.bounds;
    gradient.bounds = view.bounds;
    gradient.anchorPoint = CGPointZero;
    
    if(view.layer.sublayers.count > 0) {
        CALayer *existingLayer = [view.layer.sublayers objectAtIndex:0];
        [existingLayer removeFromSuperlayer];
    }
    [view.layer insertSublayer:gradient atIndex:0];
}

- (void)addTableView {
    self.homeTableView = [[HomeTableView alloc] initWithFrame:CGRectMake(0, 0, self.tableViewHolder.frame.size.width, self.tableViewHolder.frame.size.height)];
    
    [self.tableViewHolder addSubview:self.homeTableView];
    self.homeTableView.delegate2 = self;
    
    self.homeTableView.backgroundColor = [UIColor clearColor];
}

// This is neccessary for detecting scroll direction
- (void)calculateMiddleOffset {
    CGFloat height = self.homeTableView.frame.size.height;
    CGFloat offset = fmod(self.homeTableView.contentOffset.y, height); // remember to mod
    CGFloat bottom = self.bodyView.frame.size.height - self.tableViewHolder.frame.origin.y - self.tableViewHolder.frame.size.height;
    CGFloat top = self.bodyView.frame.size.height - height - offset - bottom;
    
    middleOffset = top;
}

// ------------------------------------------------------------
// The idea here is instead of moving the actual table cell
// I created the snap shot of that cell and move it instead
// -> better performance
// ------------------------------------------------------------

// Calculate alpha according to distance
- (CGFloat)alphaFromDistance:(CGFloat)d :(CGFloat)limit{
    // d = 0 -> alpha = 1
    // d = limit -> alpha = 0
    if(d < 0) d *= -1;
    CGFloat a = (limit - d) / limit;
    a = [AppUtil max:0 :a];
    a = [AppUtil min:1 :a];
    return a;
}

// Calculate size according to distance
- (CGSize)sizeFromDistance:(CGSize)size :(CGFloat)d :(CGFloat)limit{
    // d = 0 -> size = 50%
    // d = limit -> size = 100%
    if(d < 0) d *= -1;
    CGFloat ratio = (limit + d) / (2 * limit); 
    ratio = [AppUtil max:0.5 :ratio];
    ratio = [AppUtil min:1 :ratio];
    return CGSizeMake(size.width * ratio, size.height * ratio);
}

// Move the currentCell
- (void)moveDummyView:(UIScrollView *)sender :(HomeTableView*)tableView {
    CGFloat height = self.dummyItem.frame.size.height, width = self.dummyItem.frame.size.width;
    CGFloat offset = sender.contentOffset.y - anchorPoint;
    CGFloat left = self.tableViewHolder.frame.origin.x;
    
    // Detect direction
    // --------------------
    if(lastContentOffset < sender.contentOffset.y) // scroll up
        self.isScrollUp = YES;
    else  // scroll down
        self.isScrollUp = NO;
    
    // Y Position
    CGFloat top = self.tableViewHolder.frame.origin.y - offset;
    
    // Alpha according to distance
    [self.dummyItem setAlpha:[self alphaFromDistance:offset :height]];
    
    lastContentOffset = sender.contentOffset.y;
    
    // CADLog(@"%.2f %.2f %.2f", top, offset, sender.contentOffset.y);
    CGRect pos = CGRectMake(left, top, width, height);
    [self.dummyItem setFrame:pos];

}

// Move the nextCell
- (void)moveDummyView2:(UIScrollView *)sender :(HomeTableView*)tableView {
    CGFloat offset = sender.contentOffset.y - anchorPoint;
    
    CGSize newSize = [self sizeFromDistance:self.homeTableView.frame.size :offset :self.homeTableView.frame.size.height];
    
    CGFloat left = self.tableViewHolder.frame.origin.x + self.tableViewHolder.frame.size.width / 2 - newSize.width / 2;
    CGFloat top = self.tableViewHolder.frame.origin.y + self.tableViewHolder.frame.size.height / 2 - newSize.height / 2;
    
    CGRect pos = CGRectMake(left, top, newSize.width, newSize.height);
    [self.dummyItem2 setFrame:pos];
}

// Turn on the indicator, which means we are about to remove this item
- (void)turnOnTopIndicator {
    [self addGradient:self.indicatorLineTop centerColor:THEME_YELLOW_COLOR];
    [self turnOffBottomIndicator];
}

- (void)turnOffTopIndicator {
    [self addGradient:self.indicatorLineTop centerColor:THEME_COLOR];
}

// Turn on the bottom indicator, which means we are about to connect to this person
- (void)turnOnBottomIndicator {
    [self addGradient:self.indicatorLineBottom centerColor:THEME_YELLOW_COLOR];
    [self turnOffTopIndicator];
}

- (void)turnOffBottomIndicator {
    [self addGradient:self.indicatorLineBottom centerColor:THEME_COLOR];
}

- (void)showFilterMenu {
    // Create filter menu
    // ---------------------
    CGFloat pageW = self.parentView.frame.size.width, pageH = self.parentView.frame.size.height;
    CGRect filterFrame = CGRectMake(0, -pageW/5, pageW, pageW/5);
    FilterMenuView *filter_menu = [[FilterMenuView alloc] initWithFrame:filterFrame];
    [filter_menu setDelegate:self];
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

#pragma mark Event-Handlers
- (void)filterTapped:(id)sender {
    if(!isFilterMenuOpened) {
        [self showFilterMenu];
        [self.btnFilter setTitle:@"Done" forState:UIControlStateNormal];
        isFilterMenuOpened = YES;
    }
    else {
        [self hideFilterMenu];
        [self.btnFilter setTitle:@"Filter" forState:UIControlStateNormal];
        isFilterMenuOpened = NO;
    }
}

- (void)dummy_Click:(id)sender {
    [self hideFilterMenu];
    [self.btnFilter setTitle:@"Filter" forState:UIControlStateNormal];
    isFilterMenuOpened = NO;
}

- (void)startSearch {
    [[SearchHelper getInstance] searchUsers:@"all"
                                searchQuery:[self.searchBar getQuery]
                       searchInsideEduction:[[searchQuery valueForKey:@"education"] boolValue]
                       searchInsideUsername:[[searchQuery valueForKey:@"name"] boolValue]
                     searchInsideProficieny:NO
                          searchInsideSkill:[[searchQuery valueForKey:@"skill"] boolValue]
                      searchInsidePortfolio:NO
                               filterByCity:nil
                            filterByCountry:nil
                        filterByAgeLessThan:[NSNumber numberWithInt:100]
                     filterByAgeGreaterThan:[NSNumber numberWithInt:10]
                                   callback:^(bool success, id result) {
                                       NSArray *res = (NSArray *)result;
                                       if (success) {
                                           CADLog(@"%@", res.description);
                                           NSArray *userIds = [NSArray new];
                                           for (NSDictionary *data in res) {
                                               NSDictionary *userDic = [data objectForKey:@"doc"];
                                               userIds = [userIds arrayByAddingObject:
                                                          [NSNumber numberWithInteger:[[userDic objectForKey:@"user_id"] integerValue]]];
                                           }
                                           
                                           [UserUtil getUsersDetail:userIds callback:^(bool success, id result) {
                                               if (success) {
                                                   allResult = (NSMutableArray *)result;
                                                   [self.homeTableView setUsers:allResult];
                                                   [self.homeTableView reloadData];
                                                   [self hideFilterMenu];
                                                   //[searchResultTable setUsers:[self filterUserFromResult:allResult ForIndex:self.currentPage]];
                                                   //[searchResultTable reloadData];
                                               }
                                           }];
                                       } else {
                                           
                                       }
                                   }];
}

#pragma mark Table View events
- (void)scrollViewWillBeginScrolling:(UIScrollView *)sender :(HomeTableView*)tableView;{
    // Add the current item
    // ----------------------
    if(self.dummyItem == nil) {
        self.dummyItem = [tableView getDummyImage];
        self.dummyItem.layer.zPosition = 10;
        [self.bodyView addSubview:self.dummyItem];
    }
    // Add the next item
    // -------------------
    if(self.dummyItem2 == nil) {
        self.dummyItem2 = [tableView getDummyImage2];
        [self.bodyView addSubview:self.dummyItem2];
    }
}

- (void)scrollViewDidScrolled:(UIScrollView *)sender :(HomeTableView*)tableView{
    [self moveDummyView:sender :tableView];
    
    if(self.dummyItem2.frame.size.height > 0) { // sometimes the height is not correct so dont move
        [self moveDummyView2:sender :tableView];
    }
    
    if(self.homeTableView.contentOffset.y > anchorPoint) // swipe item up
        [self turnOnTopIndicator];
    else if(self.homeTableView.contentOffset.y < anchorPoint) // swipe item down
        [self turnOnBottomIndicator];
    
    // Hide the table view
    [self.homeTableView setAlpha:0];
}

- (void)scrollViewEndScroll:(UIScrollView *)sender :(HomeTableView*)tableView {
    // Animation complete
    // Remove dummy snapshots
    // -------------------------
    if(self.dummyItem != nil) {
        [self.dummyItem removeFromSuperview];
        self.dummyItem = nil;
        [tableView removeDummyImage];
    }
    if(self.dummyItem2 != nil) {
        [self.dummyItem2 removeFromSuperview];
        self.dummyItem2 = nil;
        [tableView removeDummyImage2];
    }
    
    lastContentOffset = self.homeTableView.contentOffset.y;
    anchorPoint = self.homeTableView.contentOffset.y;
    
    // Show the table view
    [self.homeTableView setAlpha:1];
    
    [self turnOffTopIndicator];
    [self turnOffBottomIndicator];
}

- (void)nextItemAppear:(UIView *)nextItem :(HomeTableView*)tableView {
}

#pragma mark FilterMenuDelegate
- (void)filterMenu:(FilterMenuView *)menu filterSelected:(NSMutableArray *)selectedFileters {
    [searchQuery removeAllObjects];
    
    [searchQuery setValue:[NSNumber numberWithBool:NO] forKey:@"name"];
    [searchQuery setValue:[NSNumber numberWithBool:NO] forKey:@"skill"];
    [searchQuery setValue:[NSNumber numberWithBool:NO] forKey:@"country"];
    [searchQuery setValue:[NSNumber numberWithBool:NO] forKey:@"education"];
    [searchQuery setValue:[NSNumber numberWithBool:NO] forKey:@"age"];
    
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

@end
