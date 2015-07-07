//
//  EditProfileTabBar.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/19/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "EditProfileTabBar.h"

@implementation EditProfileTabBar
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"EditProfileTabBar" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[EditProfileTabBar class]]) {
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
    [self.layer setCornerRadius:15.0f];
    [self setClipsToBounds:YES];
}


- (IBAction)edu:(id)sender {
    [_btnEdu setTitleColor:THEME_ORANGE_COLOR forState:UIControlStateNormal];
    [_btnExp setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnIntro setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnSkill setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnLink setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnLocation setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    
    if (delegate) [delegate profileTabBar:self onIndexSelected:0];
}
- (IBAction)skill:(id)sender {
    [_btnEdu setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnExp setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnIntro setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnSkill setTitleColor:THEME_ORANGE_COLOR forState:UIControlStateNormal];
    [_btnLink setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnLocation setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    
    if (delegate) [delegate profileTabBar:self onIndexSelected:1];
}
- (IBAction)intro:(id)sender {
    [_btnEdu setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnExp setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnIntro setTitleColor:THEME_ORANGE_COLOR forState:UIControlStateNormal];
    [_btnSkill setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnLink setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnLocation setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    
    if (delegate) [delegate profileTabBar:self onIndexSelected:2];
}
- (IBAction)location:(id)sender {
    [_btnEdu setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnExp setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnIntro setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnSkill setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnLink setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnLocation setTitleColor:THEME_ORANGE_COLOR forState:UIControlStateNormal];
    
    if (delegate) [delegate profileTabBar:self onIndexSelected:3];
}
- (IBAction)experience:(id)sender {
    [_btnEdu setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnExp setTitleColor:THEME_ORANGE_COLOR forState:UIControlStateNormal];
    [_btnIntro setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnSkill setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnLink setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnLocation setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    
    if (delegate) [delegate profileTabBar:self onIndexSelected:4];
}
- (IBAction)externalLink:(id)sender {
    [_btnEdu setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnExp setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnIntro setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnSkill setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    [_btnLink setTitleColor:THEME_ORANGE_COLOR forState:UIControlStateNormal];
    [_btnLocation setTitleColor:[AppUtil colorHex:@"#818D90"] forState:UIControlStateNormal];
    
    if (delegate) [delegate profileTabBar:self onIndexSelected:5];
}

- (void)setSelectedIndex:(NSUInteger)index {
    switch (index) {
        case 0: {
            [self edu:_btnEdu];
            break;
        }
            
        case 1: {
            [self skill:_btnSkill];
            break;
        }
            
        case 2: {
            [self intro:_btnIntro];
            break;
        }
            
        case 3: {
            [self location:_btnLocation];
            break;
        }
            
        case 4: {
            [self experience:_btnExp];
            break;
        }
            
        case 5: {
            [self externalLink:_btnLink];
            break;
        }
            
        default:
            break;
    }
}
@end
