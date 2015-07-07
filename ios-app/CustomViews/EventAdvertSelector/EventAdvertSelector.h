//
//  EventAdvertSelector.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/21/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EventAdvertSelector;
@protocol EventAdvertSelectorDelegate

- (void)eventAdvertSelector:(EventAdvertSelector *)selector eventSelected:(UIButton *)btnEvent;
- (void)eventAdvertSelector:(EventAdvertSelector *)selector advertSelected:(UIButton *)btnAdvert;
- (void)eventAdvertSelector:(EventAdvertSelector *)selector bookmarkSelected:(UIButton *)btnBookmark;

@end

@interface EventAdvertSelector : UIView

#define SELECTOR_BACKGROUND_LIGHT       [UIColor colorWithRed:138.0/255.0 green:201.0/255.0 blue:189.0/255.0 alpha:1.0]
#define SELECTOR_BACKGROUND_DARK        [UIColor colorWithRed:69.0/255.0 green:130.0/255.0 blue:118.0/255.0 alpha:1.0]
#define SELECTOR_TEXT_SELECTED          [UIColor colorWithRed:162.0/255.0 green:193.0/255.0 blue:187.0/255.0 alpha:1.0]
#define SELECTOR_TEXT_NORMAL            [UIColor whiteColor]
@property (weak, nonatomic) IBOutlet UIView *hiringHolderView;
@property (weak, nonatomic) IBOutlet UIView *eventHolderView;
@property (weak, nonatomic) IBOutlet UIView *bookmarkHolderView;

@property (weak, nonatomic) IBOutlet UIButton *btnEvents;
@property (weak, nonatomic) IBOutlet UIButton *btnHiring;
@property (weak, nonatomic) IBOutlet UIButton *btnBookmark;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, assign) id delegate;

- (NSInteger)getSelectedIndex;
@end
