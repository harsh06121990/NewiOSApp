//
//  SearchTableView.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/12/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "SearchTableView.h"

static NSString *cellIdentifier = @"SearchTableCell";

@implementation SearchTableView
@synthesize users;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"SearchTableView" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[SearchTableView class]]) {
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
    [self setDelegate:self];
    [self setDataSource:self];
}

- (void)setup {
    [self registerNib:[UINib nibWithNibName:@"SearchTableViewCell"
                                     bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchTableViewCell *cell = (SearchTableViewCell *)[self dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [self configureBasicCell:cell atIndexPath:indexPath];
    // Call this to update the views after layout all content
    [cell awakeFromNib];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // TO-DO: Add height calculation
    
    static SearchTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self dequeueReusableCellWithIdentifier:cellIdentifier];
    });
    [self configureBasicCell:sizingCell atIndexPath:indexPath];
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    // Calculate the size
    CGFloat expectedHeight = sizingCell.btnProfilePic.frame.size.height
    + 5.0f + 50.0f;      // Constant spaces
    return expectedHeight;

}


#pragma mark Custome-Methods
- (void)configureBasicCell:(SearchTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *userInfo = [users objectAtIndex:indexPath.row];
    // TO-DO: Add customize cell code
    [cell.lblUsername setText:[userInfo objectForKey:@"user_name"]];
    [cell.lblTitle setText:[userInfo objectForKey:@"type"]];
    [cell.lblEmail setText:[userInfo objectForKey:@"email"]];
    [cell.lblPhoneNumber setText:@"123456789"];
    [cell setColorForType:[userInfo objectForKey:@"type"]];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:[UserUtil getProfileImageUrl:[userInfo objectForKey:@"user_id"]]]
                          options:SDWebImageContinueInBackground
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                [cell.btnProfilePic setImage:image forState:UIControlStateNormal];
                            } else {
                                
                            }
                        }];
}

@end
