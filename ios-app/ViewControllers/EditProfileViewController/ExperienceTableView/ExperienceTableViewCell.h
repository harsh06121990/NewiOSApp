//
//  ExperienceTableViewCell.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/23/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"

@interface ExperienceTableViewCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txfExperience;
@property (weak, nonatomic) IBOutlet UITextField *txfTime;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;

@end
