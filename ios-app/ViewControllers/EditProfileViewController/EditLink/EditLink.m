//
//  EditLink.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/23/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "EditLink.h"

@implementation EditLink

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"EditLink" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[EditLink class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
        [self setFrame:frame];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setView {
    [_btnLinkFB.layer setCornerRadius:8.0f];
    [_btnLinkCat.layer setCornerRadius:8.0f];
    [_btnLinkTwitter.layer setCornerRadius:8.0f];
    [_btnLinkGlobe.layer setCornerRadius:8.0f];
    [_btnLinkBe.layer setCornerRadius:8.0f];
    [_btnLinkIn.layer setCornerRadius:8.0f];
    
    [_txfUrl setBackgroundColor:[UIColor clearColor]];
    [_txfUrl setTintColor:[UIColor whiteColor]];
    [_txfUrl setTextColor:[UIColor whiteColor]];
    [_txfUrl setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Your website's url here"
                                                                          attributes:@{NSForegroundColorAttributeName: [AppUtil colorHex:@"#818D90"]}]];
    [_txfUrl setDelegate:self];
    [_txfUrl.layer setCornerRadius:8.0f];
    [_txfUrl.layer setBorderWidth:2.0f];
    [_txfUrl.layer setBorderColor:[[UIColor whiteColor] CGColor]];
}
@end
