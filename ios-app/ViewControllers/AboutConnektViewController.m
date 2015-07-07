//
//  AboutConnektViewController.m
//  ios-app
//
//  Created by MinhThai on 2/7/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "AboutConnektViewController.h"
#import "Constants.h"

@interface AboutConnektViewController ()

@end

@implementation AboutConnektViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpView];
    [self resizeViews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpView {
    // Show Navigation Bar
    // ----------------------
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBarTintColor:THEME_COLOR];
    [self.navigationController.navigationBar setTranslucent:NO];
    // Set Font and Color
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Light" size:18.0f],
                                                                    NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                    };
    
    // Set appearance of views and buttons
    // ------------------------------------
    self.versionView.layer.cornerRadius = 5;
    self.supportView.layer.cornerRadius = 5;
    self.termView.layer.cornerRadius = 5;
    self.policyView.layer.cornerRadius = 5;
    self.creditView.layer.cornerRadius = 5;
    self.contactView.layer.cornerRadius = 5;
    self.btnMessage.layer.cornerRadius = 5;
    self.btnMessage.backgroundColor = THEME_COLOR_DARK;
    
    [self addShadowToView:self.versionView];
    [self addShadowToView:self.supportView];
    [self addShadowToView:self.termView];
    [self addShadowToView:self.policyView];
    [self addShadowToView:self.creditView];
    [self addShadowToView:self.contactView];
}

- (void)resizeViews {
    CGFloat pageW = self.parentView.frame.size.width;
    CGFloat imgW = 150;
    CGRect imgRect = CGRectMake(pageW / 2 - imgW / 2, 20, imgW, imgW + self.navigationController.navigationBar.frame.size.height);
    [self.imgAppLogo setFrame:imgRect];
    
    [self.scrollView setContentSize:CGSizeMake(pageW, self.contactView.frame.origin.y + self.contactView.frame.size.height + 20)];
}

- (void)addShadowToView:(UIView *)view {
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.3f;
    view.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    view.layer.shadowRadius = 1.0f;
    view.layer.shouldRasterize = YES;
}

@end
