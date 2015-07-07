//
//  EventImageListView.m
//  ios-app
//
//  Created by MinhThai on 3/13/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "EventImageListView.h"
#import "Constants.h"

@implementation EventImageListView

- (id)initWithFrame:(CGRect)frame withData:(NSMutableArray *)data{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"EventImageListView" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[EventImageListView class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
        [self setFrame:frame];
        
        self.Data = data;
    }
    
    [self setup];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark Custom-Methods
- (void)setup {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat img_size = height, margin = img_size / 6;
    int n_img = width / img_size;
    BOOL overflow = self.Data.count > n_img;
    
    if(overflow) n_img -= 1; // save the last space for the counter
    else n_img = [AppUtil min:n_img :self.Data.count];
    
    // Add the images
    CGFloat cur_x = 0;
    for(int i = 0; i < n_img; ++i) {
        UIImageView *iv =[[UIImageView alloc] initWithFrame:CGRectMake(cur_x + margin, margin, img_size - 2 * margin, img_size - 2 * margin)];
        iv.image=[UIImage imageNamed: [self.Data objectAtIndex:i]];
        iv.layer.cornerRadius = (img_size - 2 * margin) / 2;
        iv.layer.borderColor = THEME_RED_COLOR.CGColor;
        iv.layer.borderWidth = 2;
        iv.clipsToBounds = YES;
        
        [self.parentView addSubview:iv];
        
        cur_x += img_size;
    }
    
    // Now add the counter
    if(overflow) {
        UIView *counter = [[UIView alloc] initWithFrame:CGRectMake(cur_x + margin, margin, img_size - 2 * margin, img_size - 2 * margin)];
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:(CGRect){{0, 0}, counter.frame.size}];
        lbl.text = [NSString stringWithFormat:@"%lu", self.Data.count];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = THEME_RED_COLOR;
        [lbl setFont:[UIFont systemFontOfSize:15]];
        
        counter.clipsToBounds = YES;
        counter.layer.borderColor = THEME_RED_COLOR.CGColor;
        counter.layer.borderWidth = 2;
        counter.layer.cornerRadius = (img_size - 2 * margin) / 2;
        
        [counter addSubview:lbl];
        [self.parentView addSubview:counter];
    }
}

@end
