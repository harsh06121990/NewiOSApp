//
//  FilterTabBar.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/16/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "FilterTabBar.h"

@interface FilterTabBar() {
    UIView *indicator;
}

@end

@implementation FilterTabBar
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"FilterTabBar" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[FilterTabBar class]]) {
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
    
    if (indicator == nil) {
        [self createIndicator];
    }
}

#pragma mark Custom-Methods
- (void)setup {
    [self.viewAllHolder setBackgroundColor:THEME_COLOR];
    UITapGestureRecognizer *allClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allClick:)];
    [self.viewAllHolder addGestureRecognizer:allClick];
    [self.viewAllHolder setTag:ALL];
    
    [self.viewDesignerHolder setBackgroundColor:THEME_RED_COLOR];
    UITapGestureRecognizer *designerClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(designerClick:)];
    [self.viewDesignerHolder addGestureRecognizer:designerClick];
    [self.viewDesignerHolder setTag:DESIGNER];
    
    [self.viewEngineerHolder setBackgroundColor:THEME_COLOR_DARK];
    UITapGestureRecognizer *engineerClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(engineerClick:)];
    [self.viewEngineerHolder addGestureRecognizer:engineerClick];
    [self.viewEngineerHolder setTag:ENGINEER];
    
    [self.viewPresenterHolder setBackgroundColor:THEME_YELLOW_COLOR];
    UITapGestureRecognizer *presenterClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presenterClick:)];
    [self.viewPresenterHolder addGestureRecognizer:presenterClick];
    [self.viewPresenterHolder setTag:PRESENTER];
}

- (void)allClick:(id)sender {
    CGFloat indicator_size = 20;
    CGFloat mid = self.viewAllHolder.frame.origin.x + self.viewAllHolder.frame.size.width / 2 - indicator_size / 2;
    CGFloat bottom = self.viewAllHolder.frame.size.height - indicator_size;
    [UIView animateWithDuration:0.2 animations:^{
        [indicator setFrame:CGRectMake(mid, bottom, indicator_size, indicator_size)];
        [indicator setBackgroundColor:THEME_COLOR];
        [self resetFilterImages];
        [self.imgAll setImage:[UIImage imageNamed:@"all_green"]];
    } completion:^(BOOL finished) {
        if (delegate) [delegate filterTabBar:self filterSelect:self.viewAllHolder];
    }];
}

- (void)designerClick:(id)sender {
    CGFloat indicator_size = 20;
    CGFloat mid = self.viewDesignerHolder.frame.origin.x + self.viewDesignerHolder.frame.size.width / 2 - indicator_size / 2;
    CGFloat bottom = self.viewDesignerHolder.frame.size.height - indicator_size;
    [UIView animateWithDuration:0.2 animations:^{
        [indicator setFrame:CGRectMake(mid, bottom, indicator_size, indicator_size)];
        [indicator setBackgroundColor:THEME_RED_COLOR];
        [self resetFilterImages];
        [self.imgDesigner setImage:[UIImage imageNamed:@"pencil_red"]];
    } completion:^(BOOL finished) {
        if (delegate) [delegate filterTabBar:self filterSelect:self.viewDesignerHolder];
    }];
}

- (void)engineerClick:(id)sender {
    CGFloat indicator_size = 20;
    CGFloat mid = self.viewEngineerHolder.frame.origin.x + self.viewEngineerHolder.frame.size.width / 2 - indicator_size / 2;
    CGFloat bottom = self.viewEngineerHolder.frame.size.height - indicator_size;
    [UIView animateWithDuration:0.2 animations:^{
        [indicator setFrame:CGRectMake(mid, bottom, indicator_size, indicator_size)];
        [indicator setBackgroundColor:THEME_COLOR_DARK];
        [self resetFilterImages];
        [self.imgEngineer setImage:[UIImage imageNamed:@"gear_green"]];
    } completion:^(BOOL finished) {
        if (delegate) [delegate filterTabBar:self filterSelect:self.viewEngineerHolder];
    }];
}

- (void)presenterClick:(id)sender {
    CGFloat indicator_size = 20;
    CGFloat mid = self.viewPresenterHolder.frame.origin.x + self.viewPresenterHolder.frame.size.width / 2 - indicator_size / 2;
    CGFloat bottom = self.viewPresenterHolder.frame.size.height - indicator_size;
    [UIView animateWithDuration:0.2 animations:^{
        [indicator setFrame:CGRectMake(mid, bottom, indicator_size, indicator_size)];
        [indicator setBackgroundColor:THEME_YELLOW_COLOR];
        [self resetFilterImages];
        [self.imgPresenter setImage:[UIImage imageNamed:@"hustler_yellow"]];
    } completion:^(BOOL finished) {
        if (delegate) [delegate filterTabBar:self filterSelect:self.viewPresenterHolder];
    }];
}

- (void)createIndicator {
    // Create view and place it at bottom-midle
    indicator = [[UIView alloc]init];
    CGFloat indicator_size = 20;
    CGFloat mid = self.viewAllHolder.frame.origin.x + self.viewAllHolder.frame.size.width / 2 - indicator_size / 2;
    CGFloat bottom = self.viewAllHolder.frame.size.height - indicator_size;
    [indicator setFrame:CGRectMake(mid, bottom, indicator_size, indicator_size)];
    indicator.backgroundColor = THEME_COLOR;
    
    // Build a triangular path
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:(CGPoint){10, 10}];
    [path addLineToPoint:(CGPoint){10, 10}];
    [path addLineToPoint:(CGPoint){20, 20}];
    [path addLineToPoint:(CGPoint){0, 20}];
    
    // Create a CAShapeLayer with this triangular path
    // Same size as the original imageView
    CAShapeLayer *mask = [CAShapeLayer new];
    mask.frame = indicator.bounds;
    mask.path = path.CGPath;
    
    // Mask the imageView's layer with this shape
    indicator.layer.mask = mask;
    [self.contentView addSubview:indicator];
}

- (void)resetIndicatorToIndex:(NSInteger)index {
    switch (index) {
        case 0:
            [self allClick:self.viewAllHolder];
            break;
            
        case 1:
            [self designerClick:self.viewAllHolder];
            break;
            
        case 2:
            [self engineerClick:self.viewAllHolder];
            break;
            
        case 3:
            [self presenterClick:self.viewAllHolder];
            break;
            
        default:
            break;
    }
    
}

- (void)resetFilterImages {
    [self.imgAll setImage:[UIImage imageNamed:@"all_gray"]];
    [self.imgDesigner setImage:[UIImage imageNamed:@"pencil_gray"]];
    [self.imgEngineer setImage:[UIImage imageNamed:@"gear_gray"]];
    [self.imgPresenter setImage:[UIImage imageNamed:@"hustler_gray"]];
}

@end
