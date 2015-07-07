//
//  ImageViewerController.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/13/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ImageViewerController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgImage;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;
- (IBAction)doneTapped:(id)sender;


@property (nonatomic, strong) UIImage *imageToShow;
@end
