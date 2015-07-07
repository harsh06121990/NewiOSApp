//
//  EditLocation.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/23/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "EditLocation.h"

@implementation EditLocation

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"EditLocation" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[EditLocation class]]) {
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
    [_txfCountry setBackgroundColor:[UIColor clearColor]];
    [_txfCountry setTintColor:[UIColor whiteColor]];
    [_txfCountry setTextColor:[UIColor whiteColor]];
    [_txfCountry setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Country"
                                                                        attributes:@{NSForegroundColorAttributeName: [AppUtil colorHex:@"#818D90"]}]];
    [_txfCountry setDelegate:self];
    [_txfCountry.layer setCornerRadius:8.0f];
    [_txfCountry.layer setBorderWidth:2.0f];
    [_txfCountry.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [_txfCity setBackgroundColor:[UIColor clearColor]];
    [_txfCity setTintColor:[UIColor whiteColor]];
    [_txfCity setTextColor:[UIColor whiteColor]];
    [_txfCity setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"City"
                                                                          attributes:@{NSForegroundColorAttributeName: [AppUtil colorHex:@"#818D90"]}]];
    [_txfCity setDelegate:self];
    [_txfCity.layer setCornerRadius:8.0f];
    [_txfCity.layer setBorderWidth:2.0f];
    [_txfCity.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [_txfProvince setBackgroundColor:[UIColor clearColor]];
    [_txfProvince setTintColor:[UIColor whiteColor]];
    [_txfProvince setTextColor:[UIColor whiteColor]];
    [_txfProvince setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Province"
                                                                       attributes:@{NSForegroundColorAttributeName: [AppUtil colorHex:@"#818D90"]}]];
    [_txfProvince setDelegate:self];
    [_txfProvince.layer setCornerRadius:8.0f];
    [_txfProvince.layer setBorderWidth:2.0f];
    [_txfProvince.layer setBorderColor:[[UIColor whiteColor] CGColor]];
}

@end
