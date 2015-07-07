//
//  ConnectViewController.m
//  ios-app
//
//  Created by MinhThai on 3/4/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ConnectViewController.h"
#import "ConnectCollectionView.h"
#import "Constants.h"

@interface ConnectViewController () {
    ExpandableSearchBar *searchBar;
}

@end

@implementation ConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBarTintColor:THEME_COLOR_DARK];
    [self.navigationController.navigationBar setTranslucent:NO];
    if (searchBar == nil) {
        searchBar = [[ExpandableSearchBar alloc] initWithFrame:CGRectMake(0, 0,
                                                                          self.navigationController.navigationBar.frame.size.width,
                                                                          30)];
        [searchBar setBackgroundColor:THEME_COLOR_DARK];
        [searchBar.lblTitle setText:@"Connect"];
        [searchBar.lblTitle setTextColor:[UIColor whiteColor]];
        
        [searchBar.dropdownbtn addTarget:self action:@selector(deopdownBtnpressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    [self.navigationItem setTitleView:searchBar];
    
    checkhidden = YES;
    
    dropdownview = [[UIView alloc] init];
    dropdownview.frame = CGRectMake(60, 0, 200, 200);
    dropdownview.hidden = YES;
    [self.view addSubview:dropdownview];
    
    
    UIButton *disconnected = [[UIButton alloc] init];
    disconnected.backgroundColor = [UIColor colorWithRed:35.0f/255 green:54.0f/255 blue:57.0f/255 alpha:1];
    disconnected.layer.cornerRadius = 5.0f;
    disconnected.layer.borderColor = [[UIColor colorWithRed:35.0f/255 green:54.0f/255 blue:57.0f/255 alpha:1] CGColor];
    [disconnected setTitle:@"Disconnected" forState:UIControlStateNormal];
    disconnected.frame = CGRectMake(25, 10, 150, 50);
    [dropdownview addSubview:disconnected];
    
    UIButton *intrested = [[UIButton alloc] init];
    [intrested setTitle:@"Interested" forState:UIControlStateNormal];
    intrested.backgroundColor = [UIColor colorWithRed:35.0f/255 green:54.0f/255 blue:57.0f/255 alpha:1];
    intrested.layer.cornerRadius = 5.0f;
    intrested.layer.borderColor = [[UIColor colorWithRed:35.0f/255 green:54.0f/255 blue:57.0f/255 alpha:1] CGColor];
    intrested.frame = CGRectMake(25, 80, 150, 50);
    [dropdownview addSubview:intrested];
}

-(IBAction)deopdownBtnpressed:(UIButton *)sender
{
    if (checkhidden) {
        checkhidden = NO;
        dropdownview.hidden = NO;
    }
    else
    {
        checkhidden = YES;
        dropdownview.hidden = YES;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setup];
}

#pragma mark Custom Methods

- (void)setup {
    // Hide Navigation bar
    // --------------------
    //[self.navigationController setNavigationBarHidden:YES];
    
    // Initially, display grid layout
    // -------------------------------
    [self selectGridLayout];

    // Add tab bar
    // ------------
    if(self.tabBar == nil) {
        self.tabBar = [[ConnectTabBar alloc]initWithFrame:(CGRect){{10, 10}, {self.tabBarHolder.frame.size.width - 20, self.tabBarHolder.frame.size.height - 20}}];
        [self.tabBar selectTab:0]; //initially at tab ALL
        [self.tabBarHolder addSubview:self.tabBar];
    }

    self.tabBarHolder.backgroundColor = THEME_COLOR_DARK;
    self.contentView.backgroundColor = THEME_COLOR_DARKER;
    
    [self.btnLayoutCards setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.btnLayoutGrid setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.btnLayoutList setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
}

- (void)addGridView {
    [self hideAllLayouts];
    
    if(self.collectionView == nil) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        
        CGFloat width = self.collectionViewHolder.frame.size.width;
        self.collectionView = [[ConnectCollectionView alloc] initWithFrame:(CGRect){{0, 0}, {width, self.collectionViewHolder.frame.size.height}} collectionViewLayout:layout];
        
        self.collectionView.Data = [self createFakeData];
        
        [self.collectionViewHolder addSubview:self.collectionView];
    }
    else {
        [self.collectionView setHidden:NO];
    }
}

- (void)addListView {
    [self hideAllLayouts];
    
    if(self.tableView == nil) {
        CGFloat width = self.collectionViewHolder.frame.size.width;
        self.tableView = [[ConnectTableView alloc] initWithFrame:(CGRect){{0, 0}, {width, self.collectionViewHolder.frame.size.height}}];
        
        self.tableView.Data = [self createFakeData];
        self.tableView.cellHeight = 80;
        
        [self.collectionViewHolder addSubview:self.tableView];
    }
    else{
        [self.tableView setHidden:NO];
    }
}

- (void)hideAllLayouts {
    if(self.tableView != nil)
        [self.tableView setHidden:YES];
    if(self.collectionView != nil)
        [self.collectionView setHidden:YES];
}

// Fake data for testing
- (NSMutableArray *)createFakeData {
    NSMutableArray *rs = [[NSMutableArray alloc]init];
    NSArray *imgs = @[@"sameple_google", @"sample_event"];
    NSArray *names = @[@"Morten H.", @"Amilia S.", @"Macy L."];
    NSArray *types = @[@"Designer", @"Engineer", @"Presenter"];
    
    int n = [AppUtil randomRange:5 :50];
    for(int i = 0; i < n; ++i) {
        NSDictionary *user = @{@"userImage": [imgs objectAtIndex:[AppUtil randomRange:0 :imgs.count]],
                               @"username": [names objectAtIndex:[AppUtil randomRange:0 :names.count]],
                               @"usertype": [types objectAtIndex:[AppUtil randomRange:0 :types.count]]};
        [rs addObject:user];
    }
    return rs;
}

- (void)selectGridLayout {
    [self.btnLayoutGrid setImage:[UIImage imageNamed:@"grid_white"] forState:UIControlStateNormal];
    
    [self.btnLayoutList setImage:[UIImage imageNamed:@"list_gray"] forState:UIControlStateNormal];
    [self.btnLayoutCards setImage:[UIImage imageNamed:@"square_gray"] forState:UIControlStateNormal];
    
    [self addGridView];
}

- (void)selectListLayout {
    [self.btnLayoutList setImage:[UIImage imageNamed:@"list_white"] forState:UIControlStateNormal];
    
    [self.btnLayoutGrid setImage:[UIImage imageNamed:@"grid_gray"] forState:UIControlStateNormal];
    [self.btnLayoutCards setImage:[UIImage imageNamed:@"square_gray"] forState:UIControlStateNormal];
    
    [self addListView];
}

- (IBAction)btnCardsLayoutClick:(id)sender {
}

- (IBAction)btnGridLayoutClick:(id)sender {
    [self selectGridLayout];
}

- (IBAction)btnListLayoutClick:(id)sender {
    [self selectListLayout];
}
@end
