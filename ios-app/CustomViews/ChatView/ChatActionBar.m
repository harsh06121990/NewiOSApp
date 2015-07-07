//
//  UIView+ChatActionBar.m
//  ios-app
//
//  Created by Deepak on 19/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ChatActionBar.h"
#import "Constants.h"

@interface ChatActionBar() {
    NSUInteger currentIndex;
}
@end

@implementation ChatActionBar
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ChatActionBar" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[ChatActionBar class]]) {
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
    [_btnConversations addTarget:self action:@selector(conversationTapped) forControlEvents:UIControlEventTouchUpInside];
    [_btnContacts addTarget:self action:@selector(contactTapped) forControlEvents:UIControlEventTouchUpInside];
    [_btnSettings addTarget:self action:@selector(settingTapped) forControlEvents:UIControlEventTouchUpInside];
    [_viewSlider setBackgroundColor:THEME_COLOR];
    currentIndex = 0;
    [self deselectButtons];
    [_btnConversations setImage:[UIImage imageNamed:@"chat_tab1_active"] forState:UIControlStateNormal];
}

#pragma mark Custom-Methods
-(void) selectOption:(NSUInteger) optionSelected {
    if (optionSelected == 0) {
        [self conversationTapped];
    } else if (optionSelected == 1) {
        [self contactTapped];
    } else {
        [self settingTapped];
    }
}

- (void)conversationTapped {
    currentIndex = 0;
    [self deselectButtons];
    [self layoutIfNeeded];
    self.autoLayoutSliderLeadingSpace.constant = _viewConversationHolder.frame.size.width*0;
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [_btnConversations setImage:[UIImage imageNamed:@"chat_tab1_active"] forState:UIControlStateNormal];
        if (delegate) [delegate chatActionBar:self indexSelected:0];
    }];
}

- (void)contactTapped {
    currentIndex = 1;
    [self deselectButtons];
    [self layoutIfNeeded];
    self.autoLayoutSliderLeadingSpace.constant = _viewConversationHolder.frame.size.width*1;
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [_btnContacts setImage:[UIImage imageNamed:@"chat_tab2_active"] forState:UIControlStateNormal];
        if (delegate) [delegate chatActionBar:self indexSelected:1];
    }];
}

- (void)settingTapped {
    currentIndex = 2;
    [self deselectButtons];
    [self layoutIfNeeded];
    self.autoLayoutSliderLeadingSpace.constant = _viewConversationHolder.frame.size.width*2;
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [_btnSettings setImage:[UIImage imageNamed:@"chat_tab3_active"] forState:UIControlStateNormal];
        if (delegate) [delegate chatActionBar:self indexSelected:2];
    }];
}

- (NSUInteger)currentIndex {
    return currentIndex;
}

- (void)deselectButtons {
    [_btnConversations setImage:[UIImage imageNamed:@"chat_tab1_inactive"] forState:UIControlStateNormal];
    [_btnContacts setImage:[UIImage imageNamed:@"chat_tab2_inactive"] forState:UIControlStateNormal];
    [_btnSettings setImage:[UIImage imageNamed:@"chat_tab3_inactive"] forState:UIControlStateNormal];
}

@end
