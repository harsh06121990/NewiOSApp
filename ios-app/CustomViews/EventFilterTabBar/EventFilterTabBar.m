//
//  EventFilterTabBar.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/21/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "EventFilterTabBar.h"

@interface EventFilterTabBar() {
    NSInteger currentIndex;
}

@end

@implementation EventFilterTabBar
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"EventFilterTabBar" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[EventFilterTabBar class]]) {
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

- (void)setTabTitles:(NSArray *)title {
    if(title.count < 3)
        [NSException raise:@"Must provide at least 3 titles" format:@"title count is %lu", (unsigned long)title.count];
    
    [self.btnAll setTitle:[title objectAtIndex:0] forState:UIControlStateNormal];
    [self.btnToday setTitle:[title objectAtIndex:1] forState:UIControlStateNormal];
    [self.btnComing setTitle:[title objectAtIndex:2] forState:UIControlStateNormal];
}

- (void)setup {
    [_btnAll addTarget:self action:@selector(allSelect) forControlEvents:UIControlEventTouchUpInside];
    [_btnToday addTarget:self action:@selector(todaySelect) forControlEvents:UIControlEventTouchUpInside];
    [_btnComing addTarget:self action:@selector(comingSelect) forControlEvents:UIControlEventTouchUpInside];
    
    // initially select TODAY
    [self.btnToday setTitleColor:THEME_RED_COLOR forState:UIControlStateNormal];

    self.parentView.backgroundColor = THEME_COLOR_DARK;
    currentIndex = 0;
}

- (void)allSelect {
    currentIndex = 0;
    [self resetColor];
    [self.btnAll setTitleColor:THEME_RED_COLOR forState:UIControlStateNormal];
    
    // trigger event
    if (self.delegate) [self.delegate eventFilter:self indexSelected:currentIndex];
}

- (void)todaySelect {
    currentIndex = 1;
    [self resetColor];
    [self.btnToday setTitleColor:THEME_RED_COLOR forState:UIControlStateNormal];
    
    // trigger event
    if (self.delegate) [self.delegate eventFilter:self indexSelected:currentIndex];
}

- (void)comingSelect {
    currentIndex = 2;
    [self resetColor];
    [self.btnComing setTitleColor:THEME_RED_COLOR forState:UIControlStateNormal];
    
    // trigger event
    if (self.delegate) [self.delegate eventFilter:self indexSelected:currentIndex];

//    [self layoutIfNeeded];
//    self.autoSliderLeadingSpace.constant = _btnAll.frame.size.width*2;
//    [UIView animateWithDuration:0.2 animations:^{
//        [self layoutIfNeeded];
//    } completion:^(BOOL finished) {
//        if (delegate) [delegate eventFilter:self indexSelected:2];
//    }];
}

- (void)resetColor {
    [self.btnAll setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnToday setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnComing setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}



- (NSInteger)getCurrentIndex {
    return currentIndex;
}

- (void)resetIndicatorToIndex:(NSInteger)index {
    if (index == 0) {
        [self allSelect];
    } else if (index == 1) {
        [self todaySelect];
    } else {
        [self comingSelect];
    }
}

@end
