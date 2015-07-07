//
//  EventTableView.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/21/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "EventTableView.h"

static NSString *cellIdentifier = @"EventTableCell";

@implementation EventTableView
@synthesize events;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"EventTableView" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[EventTableView class]]) {
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
    [self registerNib:[UINib nibWithNibName:@"EventTableViewCell"
                                     bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventTableViewCell *cell = (EventTableViewCell *)[self dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [self configureBasicCell:cell atIndexPath:indexPath];
    
    // Call this to update the views after layout all content
    [cell awakeFromNib];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // TO-DO: Add height calculation
    
    static EventTableViewCell *sizingCell = nil;
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
    //CGFloat expectedLblTitleHeight = [sizingCell.lblEventTitle sizeThatFits:maximumLabelSize].height;
    //CGFloat expectedLblDesHeight = [sizingCell.lblEventDes sizeThatFits:maximumLabelSize].height;
    //CGFloat expectedLblTimeHeight = [sizingCell.lblEventTime sizeThatFits:maximumLabelSize].height;
    
    CGFloat expectedHeight =
    + sizingCell.viewInfoHolder.frame.size.height
    + 150.0f + 5.0f;      // Constant spaces
    return expectedHeight;
}


#pragma mark Custome-Methods
- (void)configureBasicCell:(EventTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // Set data
    // -----------
    NSDictionary *event = [self.events objectAtIndex:indexPath.row];
    cell.imgEventImage.image = [UIImage imageNamed: [event objectForKey:@"image" ]];
    cell.lblEventTitle.text = [event objectForKey:@"title" ];
}

@end
