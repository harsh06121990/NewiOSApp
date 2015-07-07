//
//  HomeTabBar.m
//  ios-app
//
//  Created by MinhThai on 2/24/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "HomeTabBar.h"
#import "Constants.h"

@interface HomeTabBar ()
    @property UIView* indicator;
@end

@implementation HomeTabBar
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"HomeTabBar" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[HomeTabBar class]]) {
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
}

- (void)setup {
    // Set background color
    // ---------------------
    [self resetColor];
    
    // Add events
    // ------------
    UITapGestureRecognizer *allClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allClick:)];
    [self.viewAllHolder addGestureRecognizer:allClick];
    [self.viewAllHolder setTag:ALL];
    
    UITapGestureRecognizer *designerClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(designerClick:)];
    [self.viewDesignerHolder addGestureRecognizer:designerClick];
    [self.viewDesignerHolder setTag:DESIGNER];
    
    UITapGestureRecognizer *engineerClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(engineerClick:)];
    [self.viewEngineerHolder addGestureRecognizer:engineerClick];
    [self.viewEngineerHolder setTag:ENGINEER];
    
    UITapGestureRecognizer *presenterClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presenterClick:)];
    [self.viewPresenterHolder addGestureRecognizer:presenterClick];
    [self.viewPresenterHolder setTag:PRESENTER];
}

- (void)allClick:(id)sender {
    [self resetIndicator:0];
}

- (void)designerClick:(id)sender {
    [self resetIndicator:1];
}

- (void)engineerClick:(id)sender {
    [self resetIndicator:2];
}

- (void)presenterClick:(id)sender {
    [self resetIndicator:3];
}

- (void)resetColor {
    [self.viewAllHolder setBackgroundColor:THEME_COLOR_DARK];
    [self.viewDesignerHolder setBackgroundColor:THEME_COLOR_DARK];
    [self.viewEngineerHolder setBackgroundColor:THEME_COLOR_DARK];
    [self.viewPresenterHolder setBackgroundColor:THEME_COLOR_DARK];
}

- (void)resetIndicator: (int)index {
    UIView *current = self.viewAllHolder;
    switch (index) {
        case 0:
            current = self.viewAllHolder;
            break;
        case 1:
            current = self.viewDesignerHolder;
            break;
        case 2:
            current = self.viewEngineerHolder;
            break;
        case 3:
            current = self.viewPresenterHolder;
            break;
    }

    if (self.indicator == nil) {
        [self createIndicator];
    }
    
    // Update the indicator with new size and move to position
    CGFloat indicator_height = 20, indicator_width = current.frame.size.width;
    CGFloat left = current.frame.origin.x;
    CGFloat bottom = current.frame.size.height - indicator_height;
    [UIView animateWithDuration:0.2 animations:^{
        [self.indicator setFrame:CGRectMake(left, bottom + 8, indicator_width, indicator_height)];
        [self.indicator setBackgroundColor:THEME_YELLOW_COLOR];
        [self resetColor];
        [current setBackgroundColor:THEME_COLOR];
    } completion:^(BOOL finished) {
        if (delegate) [delegate homeTabBar:self select:current];
    }];
}

- (void)createIndicator {
    // Create view and place it at bottom-midle
    self.indicator = [[UIView alloc]init];
    CGFloat indicator_height = 20, indicator_width = self.viewAllHolder.frame.size.width;
    CGFloat mid = self.viewAllHolder.frame.origin.x + self.viewAllHolder.frame.size.width / 2;
    CGFloat bottom = self.viewAllHolder.frame.size.height - indicator_height;
    [self.indicator setFrame:CGRectMake(0, bottom, indicator_width, indicator_height)];
    self.indicator.backgroundColor = THEME_YELLOW_COLOR;
    
    // Build a path
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:(CGPoint){0, 10}];
    [path addLineToPoint:(CGPoint){0, 8}]; // .
    [path addLineToPoint:(CGPoint){mid - 3, 8}]; // ---
    [path addLineToPoint:(CGPoint){mid, 3}]; // ---/
    [path addLineToPoint:(CGPoint){mid + 3, 8}]; // ----ˆ
    [path addLineToPoint:(CGPoint){indicator_width, 8}]; // ---ˆ---
    [path addLineToPoint:(CGPoint){indicator_width, indicator_height - 8}];
    [path addLineToPoint:(CGPoint){0, indicator_height - 8}];
    
    // Create a CAShapeLayer with this path
    CAShapeLayer *mask = [CAShapeLayer new];
    mask.frame = self.indicator.bounds;
    mask.path = path.CGPath;
    
    // Add to view
    self.indicator.layer.mask = mask;
    [self.parentView addSubview:self.indicator];
}


@end
