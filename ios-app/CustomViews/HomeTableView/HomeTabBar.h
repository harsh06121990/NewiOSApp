//
//  HomeTabBar.h
//  ios-app
//
//  Created by MinhThai on 2/24/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeTabBar;
@protocol HomeTabBarDelegate <NSObject>

- (void)homeTabBar:(HomeTabBar *)tabBar select:(UIView *)item;

@end

@interface HomeTabBar : UIView

typedef enum {
    ALL = 30,
    DESIGNER = 31,
    ENGINEER = 32,
    PRESENTER = 33
} HOME_TAB_COMPONENT;

@property (nonatomic, strong) id delegate;

@property (weak, nonatomic) IBOutlet UIView *parentView;

@property (weak, nonatomic) IBOutlet UIView *viewAllHolder;
@property (weak, nonatomic) IBOutlet UIView *viewDesignerHolder;
@property (weak, nonatomic) IBOutlet UIView *viewEngineerHolder;
@property (weak, nonatomic) IBOutlet UIView *viewPresenterHolder;
@property (weak, nonatomic) IBOutlet UILabel *lblAll;
@property (weak, nonatomic) IBOutlet UILabel *lblDesigner;
@property (weak, nonatomic) IBOutlet UILabel *lblEngineer;
@property (weak, nonatomic) IBOutlet UILabel *lblPresenter;


- (void)resetIndicator: (int)index;

@end