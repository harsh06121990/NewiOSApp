//
//  EventAdvertSelector.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/21/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "EventAdvertSelector.h"
#import "Constants.h"

@interface EventAdvertSelector() {
    NSInteger currentIndex;
}
@end

@implementation EventAdvertSelector
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"EventAdvertSelector" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[EventAdvertSelector class]]) {
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
    [self.btnHiring addTarget:self action:@selector(advertSelected) forControlEvents:UIControlEventTouchUpInside];
    [self.hiringHolderView setBackgroundColor:THEME_COLOR];
    
    [self.btnEvents addTarget:self action:@selector(eventSelected) forControlEvents:UIControlEventTouchUpInside];
    [self.eventHolderView setBackgroundColor:THEME_COLOR_DARK];
    
    [self.btnBookmark addTarget:self action:@selector(bookmarkSelected) forControlEvents:UIControlEventTouchUpInside];
    [self.bookmarkHolderView setBackgroundColor:THEME_COLOR_DARK];
    
    [self setClipsToBounds:YES];
    [self setBackgroundColor:[UIColor clearColor]];
    [self.layer setCornerRadius:8.0f];
    
    currentIndex = 0;
}

- (void)eventSelected {
    [self resetColor];
    self.eventHolderView.backgroundColor = THEME_COLOR;
    currentIndex = 1;
    if (delegate) [delegate eventAdvertSelector:self eventSelected:self.btnEvents];
}

- (void)advertSelected {
    [self resetColor];
    self.hiringHolderView.backgroundColor = THEME_COLOR;
    currentIndex = 0;
    if (delegate) [delegate eventAdvertSelector:self advertSelected:self.btnHiring];
}

- (void)bookmarkSelected {
    [self resetColor];
    self.bookmarkHolderView.backgroundColor = THEME_COLOR;
    currentIndex = 0;
    if (delegate) [delegate eventAdvertSelector:self bookmarkSelected:self.btnBookmark];
}

- (void)resetColor {
    self.eventHolderView.backgroundColor = THEME_COLOR_DARK;
    self.hiringHolderView.backgroundColor = THEME_COLOR_DARK;
    self.bookmarkHolderView.backgroundColor = THEME_COLOR_DARK;
}

- (NSInteger)getSelectedIndex {
    return currentIndex;
}

@end
