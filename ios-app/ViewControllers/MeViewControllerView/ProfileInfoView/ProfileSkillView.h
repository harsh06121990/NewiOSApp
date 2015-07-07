//
//  ProfileSkillView.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/7/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyWrappingView.h"
#import "Utility.h"

@class ProfileSkillView;

@protocol ProfileSkillViewDelegate <NSObject>

@end

@interface ProfileSkillView : UIView

#define TRANS_THEME_LIGHT         [UIColor colorWithRed:43/255.f green:65/255.f blue:78/255.f alpha:1.0]
#define TRANS_THEME_DARK          [UIColor colorWithRed:34/255.f green:49/255.f blue:58/255.f alpha:1.0]
#define TRANS_THEME_ORANGE        [UIColor colorWithRed:220/255.f green:102/255.f blue:77/255.f alpha:1.0]
#define TRANS_THEME_GREEN         [UIColor colorWithRed:56/255.f green:178/255.f blue:123/255.f alpha:1.0]
#define TRANS_THEME_BLUE          [UIColor colorWithRed:76/255.f green:163/255.f blue:161/255.f alpha:1.0]

@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIView *viewSkillHolder;

@property (nonatomic, strong) MyWrappingView *skillView;
@property (nonatomic, strong) NSArray *skills;

@end
