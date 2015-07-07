//
//  EditIntro.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/23/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "EditProfileModel.h"
#import "UserHelper.h"

@interface EditIntro : UIView <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txfIntro;

- (void)onSave;
@end
