//
//  EditLink.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/23/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"

@interface EditLink : UIView <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnLinkFB;
@property (weak, nonatomic) IBOutlet UIButton *btnLinkCat;
@property (weak, nonatomic) IBOutlet UIButton *btnLinkTwitter;
@property (weak, nonatomic) IBOutlet UIButton *btnLinkGlobe;
@property (weak, nonatomic) IBOutlet UIButton *btnLinkBe;
@property (weak, nonatomic) IBOutlet UIButton *btnLinkIn;
@property (weak, nonatomic) IBOutlet UITextField *txfUrl;

@end
