//
//  EditExperience.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/23/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "EditExperience.h"

@implementation EditExperience

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"EditExperience" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[EditExperience class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
        [self setFrame:frame];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    dispatch_queue_t waitQueue = dispatch_queue_create("com.connekt.waiter", nil);
    dispatch_async(waitQueue, ^{
        [NSThread sleepForTimeInterval:0.1];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([NSThread isMainThread]) {
                [self setView];
            }
        });
    });
}

- (void)setView {
    if (_expTable == nil) {
        _expTable = [[ExperienceTableView alloc] initWithFrame:self.viewExpTableHolder.bounds];
    }
    [self.viewExpTableHolder.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.viewExpTableHolder addSubview:_expTable];
}

@end
