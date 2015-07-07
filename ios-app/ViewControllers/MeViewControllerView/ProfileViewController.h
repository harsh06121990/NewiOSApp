//
//  MeViewControllerView.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/4/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileInfoView.h"
#import "ProfilePortFolioView.h"
#import "MeViewActionBar.h"

@interface ProfileViewController : UIView <MeViewActionBarDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewContentHolder;
@property (weak, nonatomic) IBOutlet UIView *viewActionBarHolder;

@property (nonatomic, strong) ProfileInfoView *profileInfo;
@property (nonatomic, strong) ProfilePortFolioView *profilePortfolio;
@property (nonatomic, strong) MeViewActionBar *actionBar;
@end
