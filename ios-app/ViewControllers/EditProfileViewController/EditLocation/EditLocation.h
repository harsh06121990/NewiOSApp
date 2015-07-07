//
//  EditLocation.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/23/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"

@interface EditLocation : UIView <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txfCountry;
@property (weak, nonatomic) IBOutlet UITextField *txfProvince;
@property (weak, nonatomic) IBOutlet UITextField *txfCity;

@end
