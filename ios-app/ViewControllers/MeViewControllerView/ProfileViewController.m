//
//  MeViewControllerView.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/4/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ProfileViewController.h"

@implementation ProfileViewController

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ProfileViewController" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[ProfileViewController class]]) {
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
    // Wait for all autolayout constraints to finish, then re-position the indicator
    
    dispatch_queue_t waitQueue = dispatch_queue_create("com.connekt.waiter", nil);
    dispatch_async(waitQueue, ^{
        [NSThread sleepForTimeInterval:0.05];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([NSThread isMainThread]) {
                [self setView];
            }
        });
    });
}

- (void)setView {
    [self.viewContentHolder setBackgroundColor:THEME_COLOR_DARK];
    
    if (_profileInfo == nil) {
        _profileInfo = [[ProfileInfoView alloc] initWithFrame:(CGRect){{0,0}, self.viewContentHolder.frame.size}];
        [self.viewContentHolder addSubview:_profileInfo];
    }
    
    if (_profilePortfolio == nil) {
        _profilePortfolio = [[ProfilePortFolioView alloc] initWithFrame:(CGRect){{0,0}, self.viewContentHolder.frame.size}];
    }
    
    if (_actionBar == nil) {
        _actionBar = [[MeViewActionBar alloc] initWithFrame:(CGRect){{0,0}, self.viewActionBarHolder.frame.size}];
        [_actionBar setDelegate:self];
        [self.viewActionBarHolder addSubview:_actionBar];
    }
    
    [_actionBar selectIndex:0];
}

#pragma mark MeViewActionBarDelegate
- (void)meActionBar:(MeViewActionBar *)actionBar onAboutSelect:(id)sender {
    [_profileInfo removeFromSuperview];
    [_profilePortfolio removeFromSuperview];
    [self.viewContentHolder addSubview:_profileInfo];
}

- (void)meActionBar:(MeViewActionBar *)actionBar onWorkSelect:(id)sender {
    [_profileInfo removeFromSuperview];
    [_profilePortfolio removeFromSuperview];
    [self.viewContentHolder addSubview:_profilePortfolio];
}

- (void)meActionBar:(MeViewActionBar *)actionBar onAddWork:(id)sender {
    
}

- (void)meActionBar:(MeViewActionBar *)actionBar onChat:(id)sender {
    
}

@end
