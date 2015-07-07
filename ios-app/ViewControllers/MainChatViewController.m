//
//  PanelsViewController+MainChatViewController.m
//  ios-app
//
//  Created by Deepak on 18/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "MainChatViewController.h"
#import "ChatTableCell.h"
#import "ChatHelper.h"
#import "NSDate+Helper.h"
#import "UserHelper.h"
#import "ChatViewController.h"

@interface MainChatViewController()
@property(nonatomic, strong) NSMutableArray *tableViews;
@property(nonatomic, weak) NSArray *chatUsers;

@property(nonatomic) NSUInteger previousPage;
// Temporary hold the user id of the user with whom user is about to have a chat
@property(nonatomic) NSNumber *_toChatUserId;
@end

@implementation MainChatViewController
@synthesize tableViews = _tableViews;
@synthesize chatUsers = _chatUsers;

-(NSMutableArray *) tableViews{
    if(!_tableViews){
        _tableViews = [[NSMutableArray alloc] init];
    }
    return _tableViews;
}

-(NSArray *) chatUsers{
    if(!_chatUsers){
        _chatUsers = [[[ChatHelper getInstance] chatUsers] allObjects];
    }
    return _chatUsers;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void) viewDidLoad{
    [super viewDidLoad];
    [[self mainScrollContentView] setScrollsToTop:NO];
    [[self mainScrollContentView] setShowsHorizontalScrollIndicator:NO];
    [[self mainScrollContentView] setPagingEnabled:YES];
    [[self mainScrollContentView] setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [[self mainScrollContentView] setDelegate:self];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    UIColor *backgroundColor = [UIColor colorWithRed:27.0/255.0 green:37.0/255.0 blue:47.0/255.0 alpha:1];
    for(int i=0, length = [self noOfPages]; i < length; i++){
        UITableView *tableView = [[UITableView alloc] init];
        // Setting data source as self
        [tableView setDataSource:self];
        // Setting delegate to self
        [tableView setDelegate:self];
        //Removing seprator from empty rows
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        //Setting background view
        [tableView setBackgroundColor:backgroundColor];
        [tableView setSeparatorColor:backgroundColor];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
        [[self mainScrollContentView] setBackgroundColor:backgroundColor];
        //Adding it to the scrollView
        [[self mainScrollContentView] addSubview:tableView];
        //Adding it in the array
        [[self tableViews] addObject:tableView];
    }
    
    [[self mainScrollContentView] setDelegate:self];
    
    self.previousPage = 0;
    // Do any additional setup after loading the view, typically from a nib.
    [[[self actionControlSegment] layer] setBorderWidth:0];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                              NSForegroundColorAttributeName : [UIColor colorWithRed:147.0/255.0 green:160.0/255 blue:162.0/255.0 alpha:1]
                                                              } forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                              NSForegroundColorAttributeName : [UIColor whiteColor]
                                                              } forState:UIControlStateSelected];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationHandler:)
                                                 name:@"NEW_CHAT_MESSAGES" object:nil];
}

-(void)notificationHandler:(NSNotification*)_notification
{
    for(int i=0, length = (int)[[self tableViews]count]; i < length; i++){
        //Reloading tables
        [[[self tableViews] objectAtIndex:i] reloadData];
    }
}

-(void) viewDidLayoutSubviews{
    CGRect temp = [[self mainScrollContentView] frame];
    temp.origin.x = 0;
    temp.origin.y = -[[self actionBarView] frame].origin.y;
    //Setting content width
    [[self mainScrollContentView] setContentSize:CGSizeMake(temp.size.width * [[self tableViews] count], 0)];
    
    //Setting frame of every tableview
    for(int i=0, length = (int)[[self tableViews]count]; i < length; i++){
        temp.origin.x = temp.size.width * i;
        //Setting new frame
        [[[self tableViews] objectAtIndex:i] setFrame:temp];
    }
}

-(int) noOfPages{
    return 3;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self setTitle:@"Chat"];
}

#pragma mark - Table view data source delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self chatUsers] count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chatTableCell"];
    if(!cell){
        // If we are not able to dequeue cell
        [tableView registerNib:[UINib nibWithNibName:@"ChatTableCell" bundle:nil] forCellReuseIdentifier:@"chatTableCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"chatTableCell"];
    }

    ChatModel *message = [[ChatHelper getInstance] getLastChatMessage:[[self chatUsers] objectAtIndex:indexPath.row]];\
    User *user = [[UserHelper getInstance] getUserInfromation:[[self chatUsers] objectAtIndex:indexPath.row]];
    //If the message is not read
    if(![message read]){
        [cell setBackgroundOpacity:0.075];
    }
    else{
        [cell setBackgroundOpacity:0.025];
    }
    
    [cell initializeInformation:[user userName] messageToBeDisplayed:[message message] time:[NSDate stringForDisplayFromDate:[message createdAt]]];
    [cell setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]];
    return cell;
}


#pragma mark - UITableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // Saving user id of the other user
    self._toChatUserId = [[self chatUsers] objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"chatDetailToChatView" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //Fetching the destination view controller
    ChatViewController *temp = [segue destinationViewController];
    [temp setUserIdInChat:self._toChatUserId];
}

#pragma mark - Scroll View delegate
//scrolling ends
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
}

//dragging ends, please switch off paging to listen for this event
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView{
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    if (self.previousPage != page) {
        self.previousPage = page;
        NSLog(@"Page Scrolled: %d", page);
        [[self actionBarView] selectOption:page];
    }
}

@end
