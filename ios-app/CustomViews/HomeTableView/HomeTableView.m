//
//  HomeTableView.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/4/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "HomeTableView.h"
#import "Utility.h"
#import "Constants.h"
#import "MyWrappingView.h"
#import "PresenterPortFolioView.h"
#import "DesignerPortFolioView.h"

static NSString *cellIdentifier = @"HomeTweetCell";

@interface HomeTableView ()
    @property HomeTableViewCell* currentCell;
    @property HomeTableViewCell* nextCell;
    @property UIImageView* dummyItem;
    @property UIImageView* dummyItem2;
    @property int currentPage;
@end

@implementation HomeTableView
@synthesize users;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"HomeTableView" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[HomeTableView class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
        [self setFrame:frame];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
    [self.layer setBackgroundColor:[[UIColor lightGrayColor] CGColor]];
    [self setDelegate:self];
    [self setDataSource:self];
}

- (void)setup {
    [self registerNib:[UINib nibWithNibName:@"HomeTableViewCell"
                                     bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
    
    self.pagingEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor clearColor];
    [self setSeparatorColor:[UIColor clearColor]];
}

#pragma mark UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = (HomeTableViewCell *)[self dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [self configureBasicCell:cell atIndexPath:indexPath];
    
    if(self.currentCell == nil)
        self.currentCell = cell;
    self.nextCell = cell;
    
    
    // Trigger event
    if(indexPath.row != 0) // not the first item
        [self.delegate2 nextItemAppear:cell :self];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.frame.size.height;
}


#pragma mark Custome-Methods
- (void)configureBasicCell:(HomeTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // Resize user image according to new size
    CGFloat avaW = self.frame.size.width / 4;
    cell.userImgWidthConstraint.constant = avaW;
    cell.userImgHeightConstraint.constant = avaW;
    cell.userImgHolder.layer.cornerRadius = avaW / 2;
    cell.userImgHolder.layer.borderWidth = 3;
    cell.userImgHolder.layer.borderColor = [AppUtil colorRGBA:220 :220 :220 :1].CGColor;
    
    // Resize option button
    CGFloat menuW = self.frame.size.width / 12;
    cell.menuBtnWidthConstraint.constant = menuW;
    cell.menuBtnHeightConstraint.constant = menuW * 1.7;
    cell.btnMenu.contentMode = UIViewContentModeScaleAspectFit;
    
    cell.usertypeHolder.layer.cornerRadius = 5;
    cell.usertypeHolder.backgroundColor = [AppUtil colorRGBA:255 :255 :255 :0.3];
    cell.lblUserType.textColor = THEME_COLOR;
    cell.separatorView.backgroundColor = [AppUtil colorRGBA:0 :0 :0 :0.3];
    cell.parentView.backgroundColor = THEME_COLOR;
    
    CGRect frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, self.frame.size.width, self.frame.size.height);
    [cell setFrame:frame];
    
    cell.layer.cornerRadius = 10;
    
    NSDictionary *userInfo = [users objectAtIndex:indexPath.row];
    // TO-DO: Add customize cell code
    
    [cell.lblUsername setText:[userInfo objectForKey:@"user_name"]];
    [cell.lblUserType setText:[userInfo objectForKey:@"type"]];
    
    if ([userInfo objectForKey:@"introduction"] != nil &&
        ![[userInfo objectForKey:@"introduction"] isEqual:[NSNull null]]) {
        [cell.lblIntro setText:[userInfo objectForKey:@"introduction"]];
    } else {
        [cell.lblIntro setText:@""];
    }
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:[UserUtil getProfileImageUrl:[userInfo objectForKey:@"user_id"]]]
                          options:SDWebImageContinueInBackground
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                [cell.imgProfilePic setImage:image];
                            } else {
                                
                            }
                        }];
    
    [self addPortFolioForUser:userInfo inCell:cell];
    // For testing purpose
    // ----------------------
    //[self addPortFolio:cell];
}

- (void)addPortFolioForUser:(NSDictionary *)user inCell:(HomeTableViewCell *)cell {
    
    UIView *portfolioView;
    
    if ([[user objectForKey:@"type"] isEqualToString:@"DESIGNER"]) {
        portfolioView = [[DesignerPortFolioView alloc] initWithFrame:(CGRect){{0, 0}, cell.portFolioHolder.frame.size}];
        DesignerPortFolioView *portfolio = (DesignerPortFolioView *)portfolioView;
        
        // The code below does not depend on portfolio type
        // -------------------------------------------------
        portfolio.maxWidth = self.frame.size.width;
        portfolio.maxHeight = cell.portFolioHolder.frame.size.height - 10; // bottom margin
        
        __block NSArray *imageData = [NSArray new];
        
        // Download her portfolio mediaID
        [PortfolioUtil getPortfolioForUser:[user objectForKey:@"user_id"] callback:^(bool success, id result) {
            if (success) {
                NSArray *res = (NSArray *)result;
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                
                // Download the portfolio image
                for (int i = 0; i < [AppUtil min:res.count :4]; i++) {
                [manager downloadImageWithURL:[NSURL URLWithString:[PortfolioUtil getPortfolioUrl:[user objectForKey:@"user_id"]
                                                                                            media:[res objectAtIndex:i]]]
                                      options:SDWebImageContinueInBackground
                                     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                         
                                     }
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                        if (image) {
                                            imageData = [imageData arrayByAddingObject:image];
                                        } else {
                                            imageData = [imageData arrayByAddingObject:[UIImage imageNamed:@"sample_google"]];
                                        }
                                        
                                        [portfolio setData:imageData];
                                        [portfolio reloadData];
                                    }];
                 }
            }
        }];
    } else if ([[user objectForKey:@"type"] isEqualToString:@"ENGINEER"]) {
        portfolioView = [[MyWrappingView alloc] initWithFrame:(CGRect){{0, 0}, cell.portFolioHolder.frame.size}];
        MyWrappingView *portfolio = (MyWrappingView *)portfolioView;
        
        // The code below does not depend on portfolio type
        // -------------------------------------------------
        portfolio.maxWidth = self.frame.size.width;
        portfolio.maxHeight = cell.portFolioHolder.frame.size.height - 10; // bottom margin
        
        NSArray *skillData = [portfolio parseDataFromString:[user objectForKey:@"skill"]];
        [portfolio setData:skillData];
        [portfolio reloadData];
    } else {
        portfolioView = [[PresenterPortFolioView alloc]initWithFrame:(CGRect){{0, 0}, cell.portFolioHolder.frame.size}];
        PresenterPortFolioView *portfolio = (PresenterPortFolioView *)portfolioView;
        
        // The code below does not depend on portfolio type
        // -------------------------------------------------
        portfolio.maxWidth = self.frame.size.width;
        portfolio.maxHeight = cell.portFolioHolder.frame.size.height - 10; // bottom margin
        portfolio.itemCount = [AppUtil randomRange:1 :5];
    }
    
    // remember to remove old portfolio
    while(cell.portFolioHolder.subviews.count > 0)
        [cell.portFolioHolder.subviews.lastObject removeFromSuperview];
    [cell.portFolioHolder addSubview:portfolioView];
    cell.portFolioView = portfolioView;
}

- (UIView*)getDummyImage {
    return self.dummyItem;
}

- (void)removeDummyImage {
    self.dummyItem = nil;
}

- (UIView*)getDummyImage2 {
    return self.dummyItem2;
}

- (void)removeDummyImage2 {
    self.dummyItem2 = nil;
}

- (UIImageView *)createSnapShot:(UIView*)view {
    UIImage *clone = [AppUtil takeSnapshot:view];
    
    // Get position of current cell
    CGRect pos = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:clone];
    [imgView setFrame:pos];
    
    return imgView;
}

// A true empty dummy view
- (UIImageView *)createDummyView {
    UIImageView *clone = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    clone.backgroundColor = [UIColor whiteColor];
    [clone setAlpha:0.5];
    clone.layer.cornerRadius = 10;
    
    return clone;
}

#pragma mark Methods for handling swiping up & down
// This will trigger event handler in Home Page
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.alpha = 1;
    
    if(self.dummyItem == nil)
        self.dummyItem = [self createSnapShot:self.currentCell];
    
    if(self.dummyItem2 == nil) {
        self.dummyItem2 = [self createDummyView];
    }
    
    // Trigger event
    [self.delegate2 scrollViewWillBeginScrolling:scrollView :self];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Trigger event
    [self.delegate2 scrollViewDidScrolled:scrollView :self];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.y / self.frame.size.height;
    if(page != self.currentPage) {
        self.currentCell = self.nextCell;
        self.currentPage = page;
    }
    
    // Trigger event
    [self.delegate2 scrollViewEndScroll:scrollView :self];
}

@end
