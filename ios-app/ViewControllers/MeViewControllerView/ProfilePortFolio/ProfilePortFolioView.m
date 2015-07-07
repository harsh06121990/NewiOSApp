//
//  ProfilePortFolioView.m
//  ios-app
//
//  Created by MinhThai on 3/8/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ProfilePortFolioView.h"

@interface ProfilePortFolioView () <UICollectionViewDataSource, UICollectionViewDelegate> {
    BOOL isAnimating;
    ImageViewerController *imageViewer;
}

@property (nonatomic) NSMutableArray* numbers;
@property (nonatomic) NSMutableArray* numberWidths;
@property (nonatomic) NSMutableArray* numberHeights;
@end

int num = 0;

static NSString *cellIdentifier = @"portfolioCell";

@implementation ProfilePortFolioView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ProfilePortFolio" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[ProfilePortFolioView class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
        [self setFrame:frame];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // additional setup
    [self setup];
    [self.collectionView reloadData];
}

- (void)setup {
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self setBackgroundColor:THEME_COLOR_DARKER];
    
    [self datasInit];
    [self.collectionView registerClass:[PortfolioCollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    RFQuiltLayout* layout = (id)[self.collectionView collectionViewLayout];
    layout.direction = UICollectionViewScrollDirectionVertical;
    layout.blockPixels = CGSizeMake(self.collectionView.frame.size.width/3.0,self.collectionView.frame.size.width/3.0);
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    [layout setDelegate:self];
    
    [self.collectionView reloadData];
}

- (void)datasInit {
    num = 0;
    self.numbers = [@[] mutableCopy];
    self.numberWidths = @[].mutableCopy;
    self.numberHeights = @[].mutableCopy;
    for(; num<15; num++) {
        [self.numbers addObject:@(num)];
        [self.numberWidths addObject:@([self randomWidth])];
        [self.numberHeights addObject:@([self randomHeight])];
    }
}

- (IBAction)remove:(id)sender {
    if (!self.numbers.count) {
        return;
    }
    
    NSArray *visibleIndexPaths = [self.collectionView indexPathsForVisibleItems];
    NSIndexPath *toRemove = [visibleIndexPaths objectAtIndex:(arc4random() % visibleIndexPaths.count)];
    [self removeIndexPath:toRemove];
}

- (IBAction)refresh:(id)sender {
    [self datasInit];
    [self.collectionView reloadData];
}

- (IBAction)add:(id)sender {
    NSArray *visibleIndexPaths = [self.collectionView indexPathsForVisibleItems];
    if (visibleIndexPaths.count == 0) {
        [self addIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        return;
    }
    NSUInteger middle = (NSUInteger)floor(visibleIndexPaths.count / 2);
    NSIndexPath *toAdd = [visibleIndexPaths firstObject];[visibleIndexPaths objectAtIndex:middle];
    [self addIndexPath:toAdd];
}

- (UIColor*) colorForNumber:(NSNumber*)num {
    return [UIColor colorWithHue:((19 * num.intValue) % 255)/255.f saturation:1.f brightness:1.f alpha:1.f];
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (imageViewer == nil) {
        imageViewer = [[ImageViewerController alloc] init];
    }
    
    [imageViewer setImageToShow:[UIImage imageNamed:@"sample_google"]];
    [[AppDelegateObj currentViewController].navigationController presentViewController:imageViewer
                                                                              animated:YES completion:^{
                                                                                  
                                                                              }];
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.numbers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PortfolioCollectionCell *cell = (PortfolioCollectionCell *)[cv dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    return cell;
}


#pragma mark – RFQuiltLayoutDelegate


-(CGSize) collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row >= self.numbers.count) {
        NSLog(@"Asking for index paths of non-existant cells!! %ld from %lu cells", (long)indexPath.row, (unsigned long)self.numbers.count);
    }
    
    CGFloat width = [[self.numberWidths objectAtIndex:indexPath.row] floatValue];
    CGFloat height = [[self.numberHeights objectAtIndex:indexPath.row] floatValue];
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout insetsForItemAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsMake(8, 8, 8, 8);
}

#pragma mark - Helper methods

- (void)addIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > self.numbers.count) {
        return;
    }
    
    if(isAnimating) return;
    isAnimating = YES;
    
    [self.collectionView performBatchUpdates:^{
        NSInteger index = indexPath.row;
        [self.numbers insertObject:@(++num) atIndex:index];
        [self.numberWidths insertObject:@(1 + arc4random() % 3) atIndex:index];
        [self.numberHeights insertObject:@(1 + arc4random() % 3) atIndex:index];
        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]];
    } completion:^(BOOL done) {
        isAnimating = NO;
    }];
}

- (void)removeIndexPath:(NSIndexPath *)indexPath {
    if(!self.numbers.count || indexPath.row > self.numbers.count) return;
    
    if(isAnimating) return;
    isAnimating = YES;
    
    [self.collectionView performBatchUpdates:^{
        NSInteger index = indexPath.row;
        [self.numbers removeObjectAtIndex:index];
        [self.numberWidths removeObjectAtIndex:index];
        [self.numberHeights removeObjectAtIndex:index];
        [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]];
    } completion:^(BOOL done) {
        isAnimating = NO;
    }];
}

- (NSUInteger)randomWidth {
    // always returns a random length between 1 and 3, weighted towards lower numbers.
    NSUInteger result = arc4random() % 10;
    
    if (result <= 5)
    {
        result = 1;
    }
    else if (result <= 8) {
        result = 2;
    } else {
        result = 3;
    }
    
    return result;
}

- (NSUInteger)randomHeight {
    // always returns a random length between 1 and 3, weighted towards lower numbers.
    NSUInteger result = arc4random() % 10;
    
    if (result <= 4)
    {
        result = 1;
    }
    else
    {
        result = 2;
    }
    
    return result;
}

@end

