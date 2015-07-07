//
//  AdvertDetailViewController.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/24/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *viewExpandListHolder;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *autoLayoutExpandHolderHeight;
@property (weak, nonatomic) IBOutlet UIButton *btnTrigger;

@end
