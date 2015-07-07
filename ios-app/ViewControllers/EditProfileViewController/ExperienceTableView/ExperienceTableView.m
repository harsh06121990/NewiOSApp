//
//  ExperienceTableView.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/23/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ExperienceTableView.h"

static NSString *cellIdentifier = @"ExperienceTableCell";

@implementation ExperienceTableView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ExperienceTableView" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[ExperienceTableView class]]) {
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
    [self setBackgroundColor:[UIColor clearColor]];
    [self registerNib:[UINib nibWithNibName:@"ExperienceTableViewCell"
                                     bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
    [self setSeparatorColor:[UIColor clearColor]];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExperienceTableViewCell *cell = (ExperienceTableViewCell *)[self dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [self configureBasicCell:cell atIndexPath:indexPath];
    
    // Call this to update the views after layout all content
    [cell awakeFromNib];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200.0f;
}

#pragma mark Custom-Methods
- (void)configureBasicCell:(ExperienceTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // TO-DO: Add customize cell code
}

@end
