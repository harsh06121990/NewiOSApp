//
//  ProfileIntroView.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/9/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ProfileIntroView.h"

@implementation ProfileIntroView
@synthesize tvIntro;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ProfileIntroView" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[ProfileIntroView class]]) {
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
    [self setView];
}

- (void)setView {
    UIColor *themeColorTrans = [TRANS_THEME_LIGHT colorWithAlphaComponent:0.8];
    [self.viewContainer setBackgroundColor:themeColorTrans];
    [self bringSubviewToFront:self.viewContainer];
}

@end
