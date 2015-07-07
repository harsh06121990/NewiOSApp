//
//  SlidingMenu.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/2/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "SlidingMenu.h"

@interface SlidingMenu() {
    BOOL isToggled;
    CGRect slidingMenuOriginalFrame;
    CGRect parentOriginalFrame;
}
@end


@implementation SlidingMenu
@synthesize offSet, centerView;

- (BOOL)isTogged {
    return isToggled;
}

- (void)toggle {
    [UIView animateWithDuration:0.3 animations:^{
        if (!isToggled) {
            slidingMenuOriginalFrame = self.frame;
            
            [self
             setFrame:CGRectMake(offSet,
                                 0,
                                 self.frame.size.width,
                                 self.frame.size.height)];
            
            parentOriginalFrame = self.centerView.frame;
            [self.centerView setFrame:
             CGRectMake(
                        -(self.centerView.frame.size.width - offSet),
                        self.centerView.frame.origin.y,
                        self.centerView.frame.size.width,
                        self.centerView.frame.size.height)];
        } else {
            [self setFrame:slidingMenuOriginalFrame];
            [self.centerView setFrame:parentOriginalFrame];
        }
        
        isToggled = !isToggled;
    } completion:^(BOOL finished) {
        [self layoutIfNeeded];
    }];
}

@end
