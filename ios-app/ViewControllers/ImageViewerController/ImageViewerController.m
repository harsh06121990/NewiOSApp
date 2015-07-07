//
//  ImageViewerController.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/13/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ImageViewerController.h"

@interface ImageViewerController () {
    CAGradientLayer *leftShadow;
}
@end

@implementation ImageViewerController
@synthesize imageToShow;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self setNeedsStatusBarAppearanceUpdate];
    [self setup];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup {
    [self.imgImage setContentMode:UIViewContentModeScaleAspectFill];
    [self.imgImage setImage:self.imageToShow];
    
    [_btnDone setTintColor:[UIColor whiteColor]];
    [_btnDone setBackgroundColor:[UIColor lightGrayColor]];
    [_btnDone setTitle:@"   Done   " forState:UIControlStateNormal];
    [_btnDone.layer setCornerRadius:8.0f];
    
    if (leftShadow == nil) {
        leftShadow = [CAGradientLayer layer];
        leftShadow.frame = CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 100);
        leftShadow.startPoint = CGPointMake(0.0, 1.0);
        leftShadow.endPoint = CGPointMake(0.0, 0.0);
        leftShadow.colors = [NSArray arrayWithObjects:(id)[[[UIColor blackColor] colorWithAlphaComponent:1.0f] CGColor],
                             (id)[[UIColor clearColor] CGColor], nil];
        [self.view.layer addSublayer:leftShadow];
    }
    
    [self.view bringSubviewToFront:_lblTitle];
}

- (IBAction)doneTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.imgImage setImage:nil];
    }];
}
@end
