//
//  EditSkill.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/23/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "EditSkill.h"

@implementation EditSkill

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"EditSkill" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[EditSkill class]]) {
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
    [_txfSkills setBackgroundColor:[UIColor clearColor]];
    [_txfSkills setTintColor:[UIColor whiteColor]];
    [_txfSkills setTextColor:[UIColor whiteColor]];
    [_txfSkills setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"What are your skills?"
                                                                            attributes:@{NSForegroundColorAttributeName: [AppUtil colorHex:@"#818D90"]}]];
    [_txfSkills setDelegate:self];
    [_txfSkills.layer setCornerRadius:8.0f];
    [_txfSkills.layer setBorderWidth:2.0f];
    [_txfSkills.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [_txfSkills setText:[UserUtil userPersonalInformation].skill];
}

- (void)onSave {
    NSString *skills = [_txfSkills.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [[EditProfileModel sharedInstance] setSkill:skills];
}

@end
