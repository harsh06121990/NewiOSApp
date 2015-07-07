//
//  EditEducation.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/20/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "EditProfileModel.h"
#import "NSDictionary+JSONString.h"
#import "UserHelper.h"

@interface EditEducation : UIView <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txfSchoolName;
@property (weak, nonatomic) IBOutlet UITextField *txfStartYear;
@property (weak, nonatomic) IBOutlet UITextField *txfEndYear;
@property (weak, nonatomic) IBOutlet UITextField *txfCurrent;

- (void)onSave;

@end
