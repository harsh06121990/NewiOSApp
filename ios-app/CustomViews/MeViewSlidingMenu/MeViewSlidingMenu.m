//
//  MeViewSlidingMenu.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/4/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "MeViewSlidingMenu.h"

@interface MeViewSlidingMenu() {
    int currentPage;
}

@end

@implementation MeViewSlidingMenu
@synthesize delegate;

- (IBAction)onAbout:(id)sender {
    if (delegate) [delegate meViewSliding:self onAboutTapped:sender];
}

- (IBAction)onSignout:(id)sender {
    if (delegate) [delegate meViewSliding:self onSignOut:sender];
}

- (IBAction)onEducation:(id)sender {
    if (delegate) [delegate meViewSliding:self onEditProfileAtIndex:0];
}

- (IBAction)onSkill:(id)sender {
    if (delegate) [delegate meViewSliding:self onEditProfileAtIndex:1];
}

- (IBAction)onIntro:(id)sender {
    if (delegate) [delegate meViewSliding:self onEditProfileAtIndex:2];
}

- (IBAction)onExp:(id)sender {
    if (delegate) [delegate meViewSliding:self onEditProfileAtIndex:4];
}

- (IBAction)onLocation:(id)sender {
    if (delegate) [delegate meViewSliding:self onEditProfileAtIndex:3];
}

- (IBAction)onExternalLink:(id)sender {
    if (delegate) [delegate meViewSliding:self onEditProfileAtIndex:5];
}

- (id)initWithFrame:(CGRect)frame andCenterView:(UIView *)view {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"MeViewSlidingMenu" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[MeViewSlidingMenu class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
        [self setFrame:frame];
        [self setCenterView:view];
        [self setUserInteractionEnabled:YES];
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
    [self.scrollLower setDelegate:self];
    [self.scrollLower setScrollEnabled:NO];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    
    singleTap.cancelsTouchesInView = NO;
    [self.scrollLower addGestureRecognizer:singleTap];
    
    UIColor *themeColorTrans = [SLIDING_THEME_LIGHT colorWithAlphaComponent:0.8];
    [self.viewTransLayer setBackgroundColor:themeColorTrans];
    [self.viewScrollMain setBackgroundColor:SLIDING_THEME_LIGHT];
    [self.viewUpper bringSubviewToFront:self.viewTransLayer];
    
    [self.viewImageFrame.layer setCornerRadius:self.viewImageFrame.frame.size.width/2];
    
    [self.imgProfilePicture.layer setMasksToBounds:YES];
    [self.imgProfilePicture.layer setCornerRadius:self.imgProfilePicture.frame.size.width/2];
    [self.imgProfilePicture.layer setBorderWidth:0.5f];
    [self.imgProfilePicture.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.imgProfilePicture setClipsToBounds:YES];
    
    [self.viewIndicator_1 setBackgroundColor:SLIDING_THEME_ORANGE];
    [self.viewIndicator_2 setBackgroundColor:SLIDING_THEME_GREEN];
    [self.viewIndicator_3 setBackgroundColor:SLIDING_THEME_BLUE];
    
    [self.btnEditProfile addTarget:self action:@selector(editProfile) forControlEvents:UIControlEventTouchUpInside];
    [self.btnBack addTarget:self action:@selector(backToProfile) forControlEvents:UIControlEventTouchUpInside];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return [super hitTest:point withEvent:event];
}

#pragma mark Handler
- (void)editProfile {
    CGFloat width = self.scrollLower.frame.size.width;
    [self.scrollLower setContentOffset:CGPointMake(width, 0) animated:YES];
}

- (void)backToProfile {
    [self.scrollLower setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)singleTapGestureCaptured:(id)sender {
    
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + (0.5f * width)) / width;
    
    if(page != currentPage) {
        currentPage = page;
    }
}

@end
