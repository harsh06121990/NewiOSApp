//
//  LoadingDialog.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/18/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "LoadingDialog.h"

@interface LoadingDialog() {
    BOOL isLoading;
    int cnt;
}

@end

@implementation LoadingDialog

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"LoadingDialog" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[LoadingDialog class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
        isLoading = NO;
        [self setFrame:frame];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.layer setCornerRadius:10.0f];
    [self setClipsToBounds:YES];
    
    dispatch_queue_t waitQueue = dispatch_queue_create("com.connekt.waiter", nil);
    dispatch_async(waitQueue, ^{
        [NSThread sleepForTimeInterval:0.1];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([NSThread isMainThread]) {
                [self.viewCircle_1.layer setCornerRadius:self.viewCircle_1.frame.size.height/2];
                [self.viewCircle_2.layer setCornerRadius:self.viewCircle_2.frame.size.height/2];
                [self.viewCircle_3.layer setCornerRadius:self.viewCircle_3.frame.size.height/2];
            }
        });
    });
}

- (void)startAnimation {
    isLoading = YES;
    cnt = 0;
    
    dispatch_queue_t waitQueue = dispatch_queue_create("com.connekt.waiter", nil);
    dispatch_async(waitQueue, ^{
        while (isLoading) {
            [NSThread sleepForTimeInterval:0.3];
            cnt++;
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([NSThread isMainThread]) {
                    if (cnt % 3 == 0) {
                        self.sizeCircle_1.constant = 15;
                        self.sizeCircle_2.constant = 10;
                        self.sizeCircle_3.constant = 5;
                        [self layoutIfNeeded];
                    } else if (cnt % 3 == 1) {
                        self.sizeCircle_1.constant = 10;
                        self.sizeCircle_2.constant = 15;
                        self.sizeCircle_3.constant = 10;
                        [self layoutIfNeeded];
                    } else if (cnt % 3 == 2) {
                        self.sizeCircle_1.constant = 5;
                        self.sizeCircle_2.constant = 10;
                        self.sizeCircle_3.constant = 15;
                        [self layoutIfNeeded];
                    }
                }
            });
        }
        
    });
}

- (void)stopAnimation {
    isLoading = NO;
}

- (void)setTitle:(NSString *)title {
    [self.lblTitle setText:title];
}

@end