//
//  ConnectCollectionView.m
//  ios-app
//
//  Created by MinhThai on 3/4/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ConnectCollectionView.h"
#import "ConnectCollectionViewCell.h"
#import "Constants.h"

static NSString *cellIdentifier = @"ConnectGridCell";

@interface ConnectCollectionView() {
    CAImageCollectionLayout *viewLayout;
}
    @property CGFloat cellWidth;
    @property CGFloat cellHeight;
@end

@implementation ConnectCollectionView

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ConnectCollectionView" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[ConnectCollectionView class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
        [self setFrame:frame];
    }
    
    // Additional setup
    [self registerNib:[UINib nibWithNibName:@"ConnectCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellIdentifier];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setDelegate:self];
    [self setDataSource:self];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setup];
}

- (void)measure {
    CGFloat width = self.frame.size.width;
    self.cellWidth = (width - 10 - 10) / 3; // gap in between
    self.cellHeight = self.cellWidth * 1.3;
}

- (void)setup {
    if (viewLayout == nil) {
        viewLayout = [[CAImageCollectionLayout alloc] init];
        CGFloat width = (self.frame.size.width - 20 - 20) / 3;
        [viewLayout setItemSize:CGSizeMake(width, (width*3)/2)];
        [viewLayout setNumberOfColumns:3];
        [viewLayout setItemInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [viewLayout setInterItemSpacingY:10.0f];
    }

    [self setCollectionViewLayout:viewLayout];
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark UICollectionView Delegates
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.Data.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ConnectCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [self configureBasicCell:cell atIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return viewLayout.itemSize;
}

#pragma mark Custom Methods
- (void)configureBasicCell:(ConnectCollectionViewCell*)cell atIndexPath:(NSIndexPath *)indexPath {
    // Resize image & butto
    
    // Set data
    // -----------
    NSDictionary *user = [self.Data objectAtIndex:indexPath.row];
    cell.userImgView.image = [UIImage imageNamed: [user objectForKey:@"userImage" ]];
    cell.lblUsername.text = [user objectForKey:@"username" ];
    cell.lblUsertype.text = [user objectForKey:@"usertype" ];
    
    [cell hideMenu];
}


@end
