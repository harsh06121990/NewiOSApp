//
//  EventTableViewCell.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/21/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "EventTableViewCell.h"
#import "EventImageListView.h"
#import "Utility.h"

@implementation EventTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self setup];
    
    // bring this view to front
    [self.viewUpperContentHolder bringSubviewToFront:self.imgPushPin];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark Custom-Methods
- (void)setup {
    self.contentView.backgroundColor = THEME_COLOR_DARKER;
    [self.viewAddressLblHolder setBackgroundColor:THEME_COLOR];
    [self addGradient:self.viewInfoHolder];
    [self.lblAddress setTextColor:[UIColor whiteColor]];
    [self.lblEventTitle setTextColor:THEME_RED_COLOR];
    [self.lblEventDes setTextColor:[UIColor whiteColor]];
    [self.lblEventTime setTextColor:[UIColor whiteColor]];
    
    self.parentView.layer.cornerRadius = 10;
    
    // Remove old views
    NSArray *viewsToRemove = [self.bottomView subviews];
    for (UIView *v in viewsToRemove) {
        if(v.tag != 99)
            [v removeFromSuperview];
    }
    [self addImageList];
}

- (void)addImageList {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    EventImageListView *imgList = [[EventImageListView alloc] initWithFrame:CGRectMake(0, 0, self.bottomView.frame.size.width * 2/3, self.bottomView.frame.size.height) withData:[self createFakeData]];
    [self.bottomView addSubview:imgList];
}

- (void)addGradient:(UIView *)view {
    NSString *layerName = @"gradient";
    CAGradientLayer *gradient = [CAGradientLayer layer];
    [gradient setName:layerName];
    
    gradient.startPoint = CGPointMake(0.5, 0.0); // make gradient vertical
    gradient.endPoint = CGPointMake(0.5, 1.0);   // make gradient vertical
    gradient.colors = @[(id)[UIColor blackColor].CGColor, (id)[UIColor clearColor].CGColor];
    gradient.locations = @[[NSNumber numberWithFloat:0], [NSNumber numberWithFloat:1]];
    
    gradient.frame = view.bounds;
    
    if(view.layer.sublayers.count > 0) {
        for (CALayer *layer in view.layer.sublayers) {
            // if there already is a gradient
            if ([[layer name] isEqualToString:layerName])
                return;
        }
    }
    [view.layer insertSublayer:gradient atIndex:0];
}

- (NSMutableArray *)createFakeData {
    NSMutableArray *rs = [@[] mutableCopy];
    
    NSArray *imgs = @[@"sameple_google", @"sample_event", @"sample_JohnDoe"];
    int n = [AppUtil randomRange:1 :50];
    
    for(int i = 0; i < n; ++i) {
        [rs addObject:[imgs objectAtIndex:[AppUtil randomRange:0 :imgs.count]]];
    }
    
    return rs;
}

@end
