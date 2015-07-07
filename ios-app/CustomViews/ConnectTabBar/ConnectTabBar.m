//
//  ConnectTabBar.m
//  ios-app
//
//  Created by MinhThai on 3/5/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ConnectTabBar.h"
#import "Constants.h"

@implementation ConnectTabBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ConnectTabBar" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[ConnectTabBar class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
        [self setFrame:frame];
    }
    
    [self setup];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setup {
    // Resize item
    // -------------
    CGFloat itemW = self.frame.size.width / 4;
    self.itemWidthConstraint.constant = itemW;
    
    // Set up appearance
    self.parentView.layer.cornerRadius = 10;
    
    self.allHolder.backgroundColor = THEME_COLOR;
    self.designerHolder.backgroundColor = THEME_COLOR;
    self.engineerHolder.backgroundColor = THEME_COLOR;
    self.presenterHolder.backgroundColor = THEME_COLOR;
    
    // Add events
    // ------------
    [self addClickEvents];
}

- (void)selectTab:(int)index {
    if(index < 0 || index > 3) return; // out of range
    
    UIView *target = nil;
    switch (index) {
        case 0:
            target = self.allHolder;
            break;
        case 1:
            target = self.designerHolder;
            break;
        case 2:
            target = self.engineerHolder;
            break;
        case 3:
            target = self.presenterHolder;
            break;
    }
    [self resetColor];
    [target setBackgroundColor:THEME_RED_COLOR];

    // trigger event
    if (self.delegate) [self.delegate connectTabBar:self didSelect:target atIndex:index];
}

- (void)addClickEvents {
    UITapGestureRecognizer *allClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allClick:)];
    [self.allHolder addGestureRecognizer:allClick];
    
    UITapGestureRecognizer *designerClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(designerClick:)];
    [self.designerHolder addGestureRecognizer:designerClick];
    
    UITapGestureRecognizer *engineerClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(engineerClick:)];
    [self.engineerHolder addGestureRecognizer:engineerClick];
    
    UITapGestureRecognizer *presenterClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presenterClick:)];
    [self.presenterHolder addGestureRecognizer:presenterClick];
}

- (void)allClick:(id)sender {
    [self selectTab:0];
}

- (void)designerClick:(id)sender {
    [self selectTab:1];
}

- (void)engineerClick:(id)sender {
    [self selectTab:2];
}

- (void)presenterClick:(id)sender {
    [self selectTab:3];
}

- (void)resetColor {
    [self.allHolder setBackgroundColor:THEME_COLOR];
    [self.designerHolder setBackgroundColor:THEME_COLOR];
    [self.engineerHolder setBackgroundColor:THEME_COLOR];
    [self.presenterHolder setBackgroundColor:THEME_COLOR];
}

@end
