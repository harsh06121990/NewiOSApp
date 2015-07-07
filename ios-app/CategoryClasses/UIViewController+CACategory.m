//
//  UIViewController+CACategory.m
//  ComparisionAap
//
//  Created by Nguyen minh Tuan on 10/3/14.
//  Copyright (c) 2014 Tanveer Ashraf. All rights reserved.
//

#import "UIViewController+CACategory.h"

static NSArray* recordedClass;

@implementation UIViewController(CACategory)

+ (void)load {
    
    if (self == [UIViewController class]) {
        [RFSwizzlingUtils swizzleMethodWithClass: self currentSEL: @selector(viewDidAppear:) andReplacedSEL: @selector(caViewDidAppear:)];
        
        [RFSwizzlingUtils swizzleMethodWithClass: self currentSEL: @selector(viewWillAppear:) andReplacedSEL: @selector(caViewWillAppear:)];
        
        [RFSwizzlingUtils swizzleMethodWithClass: self currentSEL: @selector(viewDidLoad) andReplacedSEL: @selector(caViewDidLoad)];
        
        recordedClass = [[NSArray alloc] initWithObjects:
                                            [HomeViewController class],
                                            [ConnectViewController class],
                                            [AdEventViewController class],
                                            [MeViewController class],
                                            [ChatViewController class],
                                            nil];
    }
     
}

- (void)caViewDidAppear:(BOOL)animated {
    [self caViewDidAppear:animated];
    Class selfClass = [self class];
    
    /* Save the current view controller */
    if ([recordedClass containsObject:selfClass]) {
        
        CADLog(@"View did appear: %@",NSStringFromClass([self class]));
        
        AppDelegate* delegate = AppDelegateObj;
        [delegate setCurrentViewController:self];
    }
}

- (void)caViewWillAppear:(BOOL)animated {
    [self caViewWillAppear:animated];
}

- (void)caViewDidLoad {
    [self caViewDidLoad];
}
@end
