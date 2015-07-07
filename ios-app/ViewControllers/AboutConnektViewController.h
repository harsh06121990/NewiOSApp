//
//  AboutConnektViewController.h
//  ios-app
//
//  Created by MinhThai on 2/7/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutConnektViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *parentView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imgAppLogo;

@property (weak, nonatomic) IBOutlet UIView *versionView;
@property (weak, nonatomic) IBOutlet UIView *supportView;
@property (weak, nonatomic) IBOutlet UIView *termView;
@property (weak, nonatomic) IBOutlet UIView *policyView;
@property (weak, nonatomic) IBOutlet UIView *creditView;
@property (weak, nonatomic) IBOutlet UIView *contactView;

@property (weak, nonatomic) IBOutlet UIButton *btnMessage;
@end
