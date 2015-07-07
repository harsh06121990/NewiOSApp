//
//  EditExperience.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/23/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExperienceTableView.h"

@interface EditExperience : UIView
@property (weak, nonatomic) IBOutlet UIView *viewExpTableHolder;

@property (nonatomic, strong) ExperienceTableView *expTable;

@end
