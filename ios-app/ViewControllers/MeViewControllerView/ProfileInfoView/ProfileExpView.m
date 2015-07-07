//
//  ProfileExpView.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/9/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ProfileExpView.h"

@implementation ProfileExpView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ProfileExpView" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[ProfileExpView class]]) {
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
    
    dispatch_queue_t waitQueue = dispatch_queue_create("com.connekt.waiter", nil);
    dispatch_async(waitQueue, ^{
        [NSThread sleepForTimeInterval:0.1];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([NSThread isMainThread]) {
                [self setup];
            }
        });
    });
}

- (void)setup {
    if (_expView == nil) {
        _expView = [[PresenterPortFolioView alloc] initWithFrame:(CGRect){{0, 0}, _viewExpHolder.frame.size}];
        // The code below does not depend on portfolio type
        // -------------------------------------------------
        _expView.maxWidth = _viewExpHolder.frame.size.width;
        _expView.maxHeight = _viewExpHolder.frame.size.height - 10; // bottom margin
        _expView.itemCount = 40;

        [self.viewExpHolder addSubview:_expView];
    }
    
    UIColor *themeColorTrans = [TRANS_THEME_LIGHT colorWithAlphaComponent:0.8];
    [self.viewContainer setBackgroundColor:themeColorTrans];
    [self.viewContainer bringSubviewToFront:self.viewExpHolder];
    [self bringSubviewToFront:self.viewContainer];
}

@end
