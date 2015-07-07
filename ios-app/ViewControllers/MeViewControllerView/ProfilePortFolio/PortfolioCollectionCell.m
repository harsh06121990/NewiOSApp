//
//  PortfolioCollectionCell.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/12/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "PortfolioCollectionCell.h"

@interface PortfolioCollectionCell() {
    CAGradientLayer *leftShadow;
}

@end

@implementation PortfolioCollectionCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"PortfolioCollectionCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[PortfolioCollectionCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
        [self setFrame:frame];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // additional setup
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setup];
}

- (void)setup {
    if (leftShadow == nil) {
        leftShadow = [CAGradientLayer layer];
        leftShadow.frame = CGRectMake(0, 0, self.frame.size.width*4, 50);
        leftShadow.startPoint = CGPointMake(0.0, 0.0);
        leftShadow.endPoint = CGPointMake(0.0, 1.0);
        leftShadow.colors = [NSArray arrayWithObjects:(id)[[THEME_COLOR colorWithAlphaComponent:0.6f] CGColor], (id)[[UIColor clearColor] CGColor], nil];
        [self.layer addSublayer:leftShadow];
        [self.lblTitle setBackgroundColor:[THEME_COLOR colorWithAlphaComponent:0.7]];
    }
    
}
@end
