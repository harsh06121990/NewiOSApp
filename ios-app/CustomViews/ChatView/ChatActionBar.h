//
//  UIView+ChatActionBar.h
//  ios-app
//
//  Created by Deepak on 19/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChatActionBar;
@protocol ChatActionBarDelegate <NSObject>

- (void)chatActionBar:(ChatActionBar *)actionBar indexSelected:(NSUInteger)index;

@end

@interface ChatActionBar:UIView

-(void) selectOption:(NSUInteger) optionSelected;
@property (weak, nonatomic) IBOutlet UIButton *btnConversations;
@property (weak, nonatomic) IBOutlet UIButton *btnContacts;
@property (weak, nonatomic) IBOutlet UIButton *btnSettings;
@property (weak, nonatomic) IBOutlet UIView *viewSlider;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *autoLayoutSliderLeadingSpace;
@property (weak, nonatomic) IBOutlet UIView *viewConversationHolder;
@property (weak, nonatomic) IBOutlet UIView *viewContactHolder;
@property (weak, nonatomic) IBOutlet UIView *viewSettingHolder;


@property (nonatomic, assign) id delegate;
- (NSUInteger)currentIndex;

@end
