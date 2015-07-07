//
//  EditEducation.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/20/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "EditEducation.h"

@implementation EditEducation

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"EditEducation" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[EditEducation class]]) {
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
    [self setView];
}

- (void)setView {
    [_txfStartYear setBackgroundColor:[UIColor clearColor]];
    [_txfStartYear setTintColor:[UIColor whiteColor]];
    [_txfStartYear setTextColor:[UIColor whiteColor]];
    [_txfStartYear setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Start year"
                                                                            attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}]];
    [_txfStartYear setDelegate:self];
    [_txfStartYear.layer setCornerRadius:8.0f];
    [_txfStartYear.layer setBorderWidth:2.0f];
    [_txfStartYear.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [_txfSchoolName setBackgroundColor:[UIColor clearColor]];
    [_txfSchoolName setTintColor:[UIColor whiteColor]];
    [_txfSchoolName setTextColor:[UIColor whiteColor]];
    [_txfSchoolName setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Enter school name"
                                                                            attributes:@{NSForegroundColorAttributeName: [AppUtil colorHex:@"#818D90"]}]];
    [_txfSchoolName setDelegate:self];
    [_txfSchoolName.layer setCornerRadius:8.0f];
    [_txfSchoolName.layer setBorderWidth:2.0f];
    [_txfSchoolName.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [_txfEndYear setBackgroundColor:[UIColor clearColor]];
    [_txfEndYear setTintColor:[UIColor whiteColor]];
    [_txfEndYear setTextColor:[UIColor whiteColor]];
    [_txfEndYear setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"End year"
                                                                             attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}]];
    [_txfEndYear setDelegate:self];
    [_txfEndYear.layer setCornerRadius:8.0f];
    [_txfEndYear.layer setBorderWidth:2.0f];
    [_txfEndYear.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [_txfCurrent setBackgroundColor:[UIColor clearColor]];
    [_txfCurrent setTintColor:[UIColor whiteColor]];
    [_txfCurrent setTextColor:[UIColor whiteColor]];
    [_txfCurrent setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"End year"
                                                                          attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}]];
    [_txfCurrent setDelegate:self];
    [_txfCurrent.layer setCornerRadius:8.0f];
    [_txfCurrent.layer setBorderWidth:2.0f];
    [_txfCurrent.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    NSDictionary *eduData = [NSDictionary dictionaryFromJSONString:[UserUtil userPersonalInformation].education];
    if ([eduData objectForKey:@"school"] != nil && ![[eduData objectForKey:@"school"] isEqual:[NSNull null]]) {
        [_txfSchoolName setText:[eduData objectForKey:@"school"]];
    }
    
    if ([eduData objectForKey:@"start_year"] != nil && ![[eduData objectForKey:@"start_year"] isEqual:[NSNull null]]) {
        [_txfStartYear setText:[eduData objectForKey:@"start_year"]];
    }
    
    if ([eduData objectForKey:@"end_year"] != nil && ![[eduData objectForKey:@"end_year"] isEqual:[NSNull null]]) {
        [_txfEndYear setText:[eduData objectForKey:@"end_year"]];
    }
    
    if ([eduData objectForKey:@"current_year"] != nil && ![[eduData objectForKey:@"current_year"] isEqual:[NSNull null]]) {
        [_txfCurrent setText:[eduData objectForKey:@"current_year"]];
    }
}

- (void)onSave {
    NSDictionary *education = [[NSDictionary alloc] initWithObjectsAndKeys:
                               _txfSchoolName.text, @"school",
                               _txfStartYear.text, @"start_year",
                               _txfEndYear.text, @"end_year",
                               _txfCurrent.text, @"current_year",
                               nil];
    [[EditProfileModel sharedInstance] setEducation:education];
}

@end
