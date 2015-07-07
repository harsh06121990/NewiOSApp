//
//  ExperienceTableViewCell.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/23/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ExperienceTableViewCell.h"

@implementation ExperienceTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self setView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setView {
    [_btnEdit.layer setCornerRadius:8.0f];
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    [self setBackgroundColor:[UIColor clearColor]];
    
    [_txfExperience setBackgroundColor:[UIColor clearColor]];
    [_txfExperience setTintColor:[UIColor whiteColor]];
    [_txfExperience setTextColor:[UIColor whiteColor]];
    [_txfExperience setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"e.g. Spokesperson at a conference."
                                                                        attributes:@{NSForegroundColorAttributeName: [AppUtil colorHex:@"#818D90"]}]];
    [_txfExperience setDelegate:self];
    [_txfExperience.layer setCornerRadius:8.0f];
    [_txfExperience.layer setBorderWidth:2.0f];
    [_txfExperience.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [_txfTime setBackgroundColor:[UIColor clearColor]];
    [_txfTime setTintColor:[UIColor whiteColor]];
    [_txfTime setTextColor:[UIColor whiteColor]];
    [_txfTime setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"When was it?"
                                                                             attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}]];
    [_txfTime setDelegate:self];
    [_txfTime.layer setCornerRadius:8.0f];
    [_txfTime.layer setBorderWidth:2.0f];
    [_txfTime.layer setBorderColor:[[UIColor whiteColor] CGColor]];
}

@end
