//
//  ProfileSkillView.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/7/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ProfileSkillView.h"

@implementation ProfileSkillView
@synthesize skills;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ProfileSkillView" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[ProfileSkillView class]]) {
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

#pragma mark Custom-Methods
- (void)setView {
    if (self.skillView == nil) {
        self.skillView = [[MyWrappingView alloc] initWithFrame:(CGRect){{0, 0}, self.viewSkillHolder.frame.size}];
        // The code below does not depend on portfolio type
        // -------------------------------------------------
        _skillView.maxWidth = self.frame.size.width;
        _skillView.maxHeight = self.frame.size.height - 10; // bottom margin
        [_skillView setItemBackgroundColor:[UIColor clearColor]];
        [_skillView setItemBorderColor:[AppUtil colorForUserType:@"DESIGNER"]];
        [self.viewSkillHolder addSubview:self.skillView];
    }
    [self.skillView setItemCount:4];
    
    UIColor *themeColorTrans = [TRANS_THEME_LIGHT colorWithAlphaComponent:0.8];
    [self.viewContainer setBackgroundColor:themeColorTrans];
    [self bringSubviewToFront:self.viewContainer];
}

@end
