//
//  MeViewSlidingMenu.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/4/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "SlidingMenu.h"

@class MeViewSlidingMenu;
@protocol MeViewSlidingMenuDelegate <NSObject>

- (void)meViewSliding:(MeViewSlidingMenu *)menu onAboutTapped:(id)sender;
- (void)meViewSliding:(MeViewSlidingMenu *)menu onSignOut:(id)sender;
- (void)meViewSliding:(MeViewSlidingMenu *)menu onEditProfileAtIndex:(NSInteger)index;

@end

@interface MeViewSlidingMenu : SlidingMenu

#define SLIDING_THEME_LIGHT         [UIColor colorWithRed:43/255.f green:65/255.f blue:78/255.f alpha:1.0]
#define SLIDING_THEME_DARK          [UIColor colorWithRed:34/255.f green:49/255.f blue:58/255.f alpha:1.0]
#define SLIDING_THEME_ORANGE        [UIColor colorWithRed:220/255.f green:102/255.f blue:77/255.f alpha:1.0]
#define SLIDING_THEME_GREEN         [UIColor colorWithRed:56/255.f green:178/255.f blue:123/255.f alpha:1.0]
#define SLIDING_THEME_BLUE          [UIColor colorWithRed:76/255.f green:163/255.f blue:161/255.f alpha:1.0]

@property (weak, nonatomic) IBOutlet UIImageView *imgCover;
@property (weak, nonatomic) IBOutlet UIView *viewTransLayer;
@property (weak, nonatomic) IBOutlet UIView *viewImageFrame;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfilePicture;
@property (weak, nonatomic) IBOutlet UIView *viewUpper;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollLower;
@property (weak, nonatomic) IBOutlet UIView *viewScrollMain;

@property (weak, nonatomic) IBOutlet UIView *viewEditProfileHolder;
@property (weak, nonatomic) IBOutlet UIView *viewIndicator_1;
@property (weak, nonatomic) IBOutlet UIButton *btnEditProfile;

@property (weak, nonatomic) IBOutlet UIView *viewAboutHolder;
@property (weak, nonatomic) IBOutlet UIView *viewIndicator_2;
@property (weak, nonatomic) IBOutlet UIButton *btnAbout;

@property (weak, nonatomic) IBOutlet UIView *viewSignOutHolder;
@property (weak, nonatomic) IBOutlet UIView *viewIndicator_3;
@property (weak, nonatomic) IBOutlet UIButton *btnSignout;

@property (weak, nonatomic) IBOutlet UIView *viewEditProfile;

@property (weak, nonatomic) IBOutlet UIView *viewBackHolder;
@property (weak, nonatomic) IBOutlet UIButton *btnBackIcon;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property (weak, nonatomic) IBOutlet UIView *viewEduHolder;
@property (weak, nonatomic) IBOutlet UIButton *btnEducation;
@property (weak, nonatomic) IBOutlet UIView *viewSkillHolder;
@property (weak, nonatomic) IBOutlet UIButton *btnSkill;
@property (weak, nonatomic) IBOutlet UIView *viewIntroHolder;
@property (weak, nonatomic) IBOutlet UIButton *btnIntro;
@property (weak, nonatomic) IBOutlet UIView *viewExpHolder;
@property (weak, nonatomic) IBOutlet UIButton *btnExperience;
@property (weak, nonatomic) IBOutlet UIView *viewLocationHolder;
@property (weak, nonatomic) IBOutlet UIButton *btnLocation;
@property (weak, nonatomic) IBOutlet UIView *viewWebHolder;

@property (weak, nonatomic) IBOutlet UIButton *btnWeb;

@property (nonatomic, assign) id delegate;

- (IBAction)onAbout:(id)sender;
- (IBAction)onSignout:(id)sender;
- (IBAction)onEducation:(id)sender;
- (IBAction)onSkill:(id)sender;
- (IBAction)onIntro:(id)sender;
- (IBAction)onExp:(id)sender;
- (IBAction)onLocation:(id)sender;
- (IBAction)onExternalLink:(id)sender;
- (id)initWithFrame:(CGRect)frame andCenterView:(UIView *)view;

@end
