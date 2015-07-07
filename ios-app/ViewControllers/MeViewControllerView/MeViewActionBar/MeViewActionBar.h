//
//  MeViewActionBar.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/11/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"

@class MeViewActionBar;
@protocol MeViewActionBarDelegate <NSObject>

- (void)meActionBar:(MeViewActionBar *)actionBar onAboutSelect:(id)sender;
- (void)meActionBar:(MeViewActionBar *)actionBar onWorkSelect:(id)sender;
- (void)meActionBar:(MeViewActionBar *)actionBar onChat:(id)sender;
- (void)meActionBar:(MeViewActionBar *)actionBar onAddWork:(id)sender;

@end

@interface MeViewActionBar : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnAbout;
@property (weak, nonatomic) IBOutlet UIButton *btnWork;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UIButton *btnChat;
@property (weak, nonatomic) IBOutlet UIView *viewTabHolder;
@property (weak, nonatomic) IBOutlet UIView *viewInfoHolder;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfilePic;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutBtnAddHeight;

@property (nonatomic, assign) id delegate;

- (void)selectIndex:(NSInteger)index;
@end
