//
//  EditIntro.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/23/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "EditIntro.h"

@implementation EditIntro

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"EditIntro" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[EditIntro class]]) {
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
    [_txfIntro setBackgroundColor:[UIColor clearColor]];
    [_txfIntro setTintColor:[UIColor whiteColor]];
    [_txfIntro setTextColor:[UIColor whiteColor]];
    [_txfIntro setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Tell others something about you."
                                                                         attributes:@{NSForegroundColorAttributeName: [AppUtil colorHex:@"#818D90"]}]];
    [_txfIntro setDelegate:self];
    [_txfIntro.layer setCornerRadius:8.0f];
    [_txfIntro.layer setBorderWidth:2.0f];
    [_txfIntro.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [_txfIntro setText:[UserUtil userPersonalInformation].introduction];
}

- (void)onSave {
    NSString *intro = [_txfIntro.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [[EditProfileModel sharedInstance] setIntro:intro];
}

@end
