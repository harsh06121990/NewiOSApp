//
//  LoadingDialog.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/18/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingDialog : UIView

@property (weak, nonatomic) IBOutlet UIView *viewCircle_1;
@property (weak, nonatomic) IBOutlet UIView *viewCircle_2;
@property (weak, nonatomic) IBOutlet UIView *viewCircle_3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sizeCircle_3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sizeCircle_2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sizeCircle_1;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

- (void)startAnimation;
- (void)stopAnimation;
- (void)setTitle:(NSString *)title;
@end
