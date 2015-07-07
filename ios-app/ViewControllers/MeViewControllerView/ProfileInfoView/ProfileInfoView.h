//
//  ProfileInfoView.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/7/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileSkillView.h"
#import "ProfileIntroView.h"
#import "ProfileExpView.h"
#import "Constants.h"

@interface ProfileInfoView : UIView

@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewScrollMain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutViewMainHeight;

@property (weak, nonatomic) IBOutlet UIView *viewSkillHolder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutSkillHeight;
@property (weak, nonatomic) IBOutlet UIButton *btnExpandSkill;

@property (weak, nonatomic) IBOutlet UIView *viewIntroHolder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutIntroHeight;
@property (weak, nonatomic) IBOutlet UIButton *btnExpandIntro;

@property (weak, nonatomic) IBOutlet UIView *viewExpHolder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutExpHeight;
@property (weak, nonatomic) IBOutlet UIButton *btnExpandExp;

@property (weak, nonatomic) IBOutlet UIView *viewLocationTrans;
@property (weak, nonatomic) IBOutlet UIView *viewLocationHolder;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;

@property (weak, nonatomic) IBOutlet UIView *viewWebsiteHolder;
@property (weak, nonatomic) IBOutlet UIView *viewWebsiteTrans;
@property (weak, nonatomic) IBOutlet UIButton *btnGo;
@property (weak, nonatomic) IBOutlet UILabel *lblWebsite;

@property (weak, nonatomic) IBOutlet UIView *viewSocialHolder;
@property (weak, nonatomic) IBOutlet UIView *viewSocialTrans;


@property (nonatomic, strong) ProfileSkillView *skillView;
@property (nonatomic, strong) ProfileIntroView *introView;
@property (nonatomic, strong) ProfileExpView *expView;

@end
