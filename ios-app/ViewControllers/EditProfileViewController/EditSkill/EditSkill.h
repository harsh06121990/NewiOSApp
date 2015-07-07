//
//  EditSkill.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/23/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "EditProfileModel.h"
#import "UserHelper.h"

@interface EditSkill : UIView <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextField *txfSkills;

- (void)onSave;

@end
