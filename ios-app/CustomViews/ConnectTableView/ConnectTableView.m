//
//  ConnectTableView.m
//  ios-app
//
//  Created by MinhThai on 3/7/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ConnectTableView.h"
#import "ConnectTableViewCell.h"
#import "Constants.h"

static NSString *cellIdentifier = @"ConnectTableCell";

@implementation ConnectTableView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ConnectTableView" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[ConnectTableView class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
        [self setFrame:frame];
    }
    
    // additional setup
    [self setup];
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setDelegate:self];
    [self setDataSource:self];
}

- (void)setup {
    [self registerNib:[UINib nibWithNibName:@"ConnectTableViewCell"
                                     bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.Data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ConnectTableViewCell *cell = (ConnectTableViewCell *)[self dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [self configureBasicCell:cell atIndexPath:indexPath];
    
    // Call this to update the views after layout all content
    [cell setup];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
}


#pragma mark Custom-Methods
- (void)configureBasicCell:(ConnectTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.cellWidth = self.frame.size.width;
    cell.cellHeight = self.cellHeight;
    
    CGFloat imgWidth = self.cellHeight * 0.8;
    cell.userImageWidthConstraint.constant = imgWidth;
    cell.labelHolderHeightConstraint.constant = imgWidth;
    
    cell.userImageHolder.layer.cornerRadius = imgWidth / 2;
    cell.userImage.layer.cornerRadius = imgWidth / 2;
    cell.userImageHolder.layer.borderWidth = 2;
    cell.userImageHolder.layer.borderColor = THEME_YELLOW_COLOR.CGColor;
    
    [cell.btnExpand setImageEdgeInsets:UIEdgeInsetsMake(20, 4, 20, 4)];
    
    cell.btnExpand.backgroundColor = THEME_COLOR;
    cell.bodyView.backgroundColor = THEME_COLOR_DARK;
    cell.extendedView.backgroundColor = THEME_COLOR;
    cell.backgroundColor = [UIColor clearColor];
    
    // Set data
    // -----------
    NSDictionary *user = [self.Data objectAtIndex:indexPath.row];
    cell.userImage.image = [UIImage imageNamed: [user objectForKey:@"userImage" ]];
    cell.lblUsername.text = [user objectForKey:@"username" ];
    cell.lblUsertype.text = [user objectForKey:@"usertype" ];
}


@end
