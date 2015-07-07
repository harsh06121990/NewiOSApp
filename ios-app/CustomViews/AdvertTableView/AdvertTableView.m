//
//  EventTableView.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/16/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "AdvertTableView.h"

static NSString *cellIdentifier = @"AdvertTableCell";

@implementation AdvertTableView
@synthesize adverts, customDelegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"AdvertTableView" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[AdvertTableView class]]) {
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
    [self registerNib:[UINib nibWithNibName:@"AdvertTableViewCell"
                                     bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AdvertTableViewCell *cell = (AdvertTableViewCell *)[self dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [self configureBasicCell:cell atIndexPath:indexPath];
    
    // Call this to update the views after layout all content
    [cell awakeFromNib];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // TO-DO: Add height calculation
    
    static AdvertTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self dequeueReusableCellWithIdentifier:cellIdentifier];
    });
    [self configureBasicCell:sizingCell atIndexPath:indexPath];
    // Call this to update the views after layout all content
    [sizingCell awakeFromNib];
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    // Calculate the size
    CGSize maximumLabelSize = CGSizeMake(300, 9999);
    CGFloat expectedLblHeight = [sizingCell.lblEventTitle sizeThatFits:maximumLabelSize].height;
    CGFloat expectedHeight =
    + expectedLblHeight
    + sizingCell.btnShare.frame.size.height       // Height of buttons
    + 70.0f + 5.0f;      // Constant spaces
    return expectedHeight;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (customDelegate) {
        [customDelegate advertTable:self advertSelected:(NSDictionary *)[adverts objectAtIndex:indexPath.row]];
    }
}


#pragma mark Custome-Methods
- (void)configureBasicCell:(AdvertTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // TO-DO: Add customize cell code
}

@end
