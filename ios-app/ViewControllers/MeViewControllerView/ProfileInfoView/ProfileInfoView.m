//
//  ProfileInfoView.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/7/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ProfileInfoView.h"

@interface ProfileInfoView() {
    BOOL skillToggled;
    BOOL introToggled;
    BOOL expToggled;
}

@end

@implementation ProfileInfoView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ProfileInfoView" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[ProfileInfoView class]]) {
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
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    singleTap.cancelsTouchesInView = NO;
    [self.scrollView addGestureRecognizer:singleTap];
    [self.viewContainer setBackgroundColor:THEME_COLOR_DARK];
    
    if (_skillView == nil) {
        _skillView = [[ProfileSkillView alloc] initWithFrame:(CGRect){{0,0}, {_viewSkillHolder.frame.size.width, 200}}];
        [_viewSkillHolder addSubview:_skillView];
        [_viewSkillHolder setClipsToBounds:YES];
        skillToggled = NO;
    }
    
    if (_introView == nil) {
        _introView = [[ProfileIntroView alloc] initWithFrame:(CGRect){{0,0}, {_viewIntroHolder.frame.size.width, 300}}];
        [_viewIntroHolder addSubview:_introView];
        [_viewIntroHolder setClipsToBounds:YES];
        introToggled = NO;
    }
    
    if (_expView == nil) {
        _expView = [[ProfileExpView alloc] initWithFrame:(CGRect){{0,0}, {_viewExpHolder.frame.size.width, 300}}];
        [_viewExpHolder addSubview:_expView];
        [_viewExpHolder setClipsToBounds:YES];
        expToggled = NO;
    }
    
    UIColor *themeColorTrans = [TRANS_THEME_LIGHT colorWithAlphaComponent:0.8];
    [self.viewLocationTrans setBackgroundColor:themeColorTrans];
    [self.viewLocationHolder bringSubviewToFront:self.viewLocationTrans];
    [_lblLocation.layer setBorderWidth:2.0f];
    [_lblLocation.layer setBorderColor:[[AppUtil colorForUserType:@"DESIGNER"] CGColor]];
    [_lblLocation.layer setCornerRadius:_lblLocation.frame.size.height/2];
    
    [self.viewWebsiteTrans setBackgroundColor:themeColorTrans];
    [self.viewWebsiteHolder bringSubviewToFront:self.viewWebsiteTrans];
    [_lblWebsite.layer setBorderWidth:2.0f];
    [_lblWebsite.layer setBorderColor:[[AppUtil colorForUserType:@"DESIGNER"] CGColor]];
    [_lblWebsite.layer setCornerRadius:_lblWebsite.frame.size.height/2];
    [_btnGo setBackgroundColor:[AppUtil colorForUserType:@"DESIGNER"]];
    [_btnGo setTintColor:[UIColor whiteColor]];
    [_btnGo.layer setCornerRadius:_btnGo.frame.size.height/2];
    
    [self.viewSocialTrans setBackgroundColor:themeColorTrans];
    [self.viewSocialHolder bringSubviewToFront:self.viewSocialTrans];
    
    [_btnExpandSkill addTarget:self action:@selector(expandTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_btnExpandIntro addTarget:self action:@selector(expandTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_btnExpandExp addTarget:self action:@selector(expandTapped:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark Event-Handler

- (void)expandTapped:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    if (button == _btnExpandSkill) {
        if (!skillToggled) {
            [self layoutIfNeeded];
            _layoutSkillHeight.constant = _skillView.frame.size.height;
            _layoutViewMainHeight.constant += _skillView.frame.size.height - 80;
            [UIView animateWithDuration:0.5 animations:^{
                [self layoutIfNeeded];
                [_btnExpandSkill setTransform:CGAffineTransformMakeRotation(M_PI)];
            } completion:^(BOOL finished) {
                skillToggled = !skillToggled;
            }];
        } else {
            [self layoutIfNeeded];
            _layoutSkillHeight.constant = 80;
            _layoutViewMainHeight.constant -= _skillView.frame.size.height - 80;
            [UIView animateWithDuration:0.5 animations:^{
                [self layoutIfNeeded];
                [_btnExpandSkill setTransform:CGAffineTransformMakeRotation(0)];
            } completion:^(BOOL finished) {
                skillToggled = !skillToggled;
            }];
        }
    } else if (button == _btnExpandIntro) {
        if (!introToggled) {
            [self layoutIfNeeded];
            _layoutIntroHeight.constant = _introView.frame.size.height;
            _layoutViewMainHeight.constant += _introView.frame.size.height - 80;
            [UIView animateWithDuration:0.5 animations:^{
                [self layoutIfNeeded];
                [_btnExpandIntro setTransform:CGAffineTransformMakeRotation(M_PI)];
            } completion:^(BOOL finished) {
                introToggled = !introToggled;
            }];
        } else {
            [self layoutIfNeeded];
            _layoutIntroHeight.constant = 80;
            _layoutViewMainHeight.constant -= _introView.frame.size.height - 80;
            [UIView animateWithDuration:0.5 animations:^{
                [self layoutIfNeeded];
                [_btnExpandIntro setTransform:CGAffineTransformMakeRotation(0)];
            } completion:^(BOOL finished) {
                introToggled = !introToggled;
            }];
        }
    } else if (button == _btnExpandExp) {
        if (!expToggled) {
            [self layoutIfNeeded];
            _layoutExpHeight.constant = _expView.frame.size.height;
            _layoutViewMainHeight.constant += _expView.frame.size.height - 80;
            [UIView animateWithDuration:0.5 animations:^{
                [self layoutIfNeeded];
                [_btnExpandExp setTransform:CGAffineTransformMakeRotation(M_PI)];
            } completion:^(BOOL finished) {
                expToggled = !expToggled;
            }];
        } else {
            [self layoutIfNeeded];
            _layoutExpHeight.constant = 80;
            _layoutViewMainHeight.constant -= _expView.frame.size.height - 80;
            [UIView animateWithDuration:0.5 animations:^{
                [self layoutIfNeeded];
                [_btnExpandExp setTransform:CGAffineTransformMakeRotation(0)];
            } completion:^(BOOL finished) {
                expToggled = !expToggled;
            }];
        }
    }
}

- (void)singleTapGestureCaptured:(id)sender {
    
}

@end
