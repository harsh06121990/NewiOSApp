//
//  SlidingMenu.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/2/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CADebugLog.h"

@interface SlidingMenu : UIView <UIScrollViewDelegate>

@property (nonatomic, assign) CGFloat offSet;
@property (nonatomic, strong) UIView *centerView;

- (BOOL)isTogged;
- (void)toggle;
@end
