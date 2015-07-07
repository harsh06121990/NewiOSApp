//
//  EditProfileTabBar.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/19/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@class EditProfileTabBar;
@protocol EditProfileTabBarDelegate <NSObject>

- (void)profileTabBar:(EditProfileTabBar *)bar onIndexSelected:(NSUInteger)index;

@end

@interface EditProfileTabBar : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnEdu;
- (IBAction)edu:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSkill;
- (IBAction)skill:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnIntro;
- (IBAction)intro:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnLocation;
- (IBAction)location:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnExp;
- (IBAction)experience:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnLink;
- (IBAction)externalLink:(id)sender;

@property (nonatomic, assign) id delegate;

- (void)setSelectedIndex:(NSUInteger)index;
@end
