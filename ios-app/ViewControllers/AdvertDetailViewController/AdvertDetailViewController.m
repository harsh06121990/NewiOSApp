//
//  AdvertDetailViewController.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/24/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "AdvertDetailViewController.h"

@interface AdvertDetailViewController ()

@end

@implementation AdvertDetailViewController

- (id)init {
    self = [super initWithNibName:@"AdvertDetailViewController" bundle:nil];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.viewExpandListHolder setBackgroundColor:[UIColor redColor]];
    
    [_btnTrigger addTarget:self action:@selector(trigger) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)trigger {
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
