//
//  EditProfileViewController.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/19/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditProfileTabBar.h"
#import "Constants.h"
#import "EditEducation.h"
#import "EditSkill.h"
#import "EditIntro.h"
#import "EditLocation.h"
#import "EditExperience.h"
#import "EditLink.h"
#import "EditProfileModel.h"
#import "AppDelegate.h"
#import "NSDictionary+JSONString.h"
#import "UserHelper.h"

@interface EditProfileViewController : UIViewController <EditProfileTabBarDelegate>

@property (nonatomic, strong) EditProfileTabBar *tabBar;
@property (nonatomic, strong) EditEducation *editEducation;
@property (nonatomic, strong) EditSkill *editSkill;
@property (nonatomic, strong) EditIntro *editIntro;
@property (nonatomic, strong) EditLocation *editLocation;
@property (nonatomic, strong) EditExperience *editExp;
@property (nonatomic, strong) EditLink *editLink;

@property (nonatomic, assign) NSUInteger currentSelected;
@property (weak, nonatomic) IBOutlet UIView *viewTabBarHolder;
@property (weak, nonatomic) IBOutlet UIView *viewTransLayer;

@end
