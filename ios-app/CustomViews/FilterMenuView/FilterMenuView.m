//
//  FilterMenuViewController.m
//  ios-app
//
//  Created by MinhThai on 2/6/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "FilterMenuView.h"

@interface FilterMenuView ()
    @property NSMutableArray *currentFilter;
@end

@implementation FilterMenuView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"FilterMenuView" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[FilterMenuView class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
        [self setFrame:frame];
        
        // Other initialization code
        [self addEventToViews];
        [self setUpView];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setUpView {
    self.currentFilter = [NSMutableArray new];
    [self.parentView setBackgroundColor:THEME_COLOR_DARK];
}

- (void)appear {
    CGFloat pageW = self.frame.size.width;
}

- (void)disAppear: (void(^)())callback {
    CGFloat pageW = self.frame.size.width;
}

- (void)addEventToViews {
    [self.btnName addTarget:self action:@selector(nameView_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    // For SKILLS filter
    [self.btnSkill addTarget:self action:@selector(skillView_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    // For COUNTRY filter
    [self.btnCountry addTarget:self action:@selector(countryView_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    // For EDUCATION filter
    [self.btnEdu addTarget:self action:@selector(educationView_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    // For AGE filter
    [self.btnAge addTarget:self action:@selector(ageView_Click:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectFilter:(int)filter {
    switch (filter) {
        case 1:
            [self.btnName setImage:[UIImage imageNamed:@"name_selected"] forState:UIControlStateNormal];
            break;
        case 2:
            [self.btnSkill setImage:[UIImage imageNamed:@"skill_selected"] forState:UIControlStateNormal];
            break;
        case 3:
            [self.btnCountry setImage:[UIImage imageNamed:@"country_selected"] forState:UIControlStateNormal];
            break;
        case 4:
            [self.btnEdu setImage:[UIImage imageNamed:@"education_selected"] forState:UIControlStateNormal];
            break;
        case 5:
            [self.btnAge setImage:[UIImage imageNamed:@"age_selected"] forState:UIControlStateNormal];
            break;
    }
    
}

- (void)deSelectFilter:(int)filter {
    switch (filter) {
        case 1:
            [self.btnName setImage:[UIImage imageNamed:@"name"] forState:UIControlStateNormal];
            break;
        case 2:
            [self.btnSkill setImage:[UIImage imageNamed:@"skill"] forState:UIControlStateNormal];
            break;
        case 3:
            [self.btnCountry setImage:[UIImage imageNamed:@"country"] forState:UIControlStateNormal];
            break;
        case 4:
            [self.btnEdu setImage:[UIImage imageNamed:@"education"] forState:UIControlStateNormal];
            break;
        case 5:
            [self.btnAge setImage:[UIImage imageNamed:@"age"] forState:UIControlStateNormal];
            break;
    }
}

- (void)nameView_Click:(UITapGestureRecognizer *)recognizer {
    if ([self.currentFilter containsObject:[NSNumber numberWithInt:NAME]]) {
        [self deSelectFilter:NAME];
        [self.currentFilter removeObject:[NSNumber numberWithInt:NAME]];
    } else {
        [self selectFilter:NAME];
        [self.currentFilter addObject:[NSNumber numberWithInt:NAME]];
    }
    if (delegate) [delegate filterMenu:self filterSelected:self.currentFilter];
}

- (void)skillView_Click:(UITapGestureRecognizer *)recognizer {
    if ([self.currentFilter containsObject:[NSNumber numberWithInt:SKILL]]) {
        [self deSelectFilter:SKILL];
        [self.currentFilter removeObject:[NSNumber numberWithInt:SKILL]];
    } else {
        [self selectFilter:SKILL];
        [self.currentFilter addObject:[NSNumber numberWithInt:SKILL]];
    }
    if (delegate) [delegate filterMenu:self filterSelected:self.currentFilter];
}

- (void)countryView_Click:(UITapGestureRecognizer *)recognizer {
    if ([self.currentFilter containsObject:[NSNumber numberWithInt:COUNTRY]]) {
        [self deSelectFilter:COUNTRY];
        [self.currentFilter removeObject:[NSNumber numberWithInt:COUNTRY]];
    } else {
        [self selectFilter:COUNTRY];
        [self.currentFilter addObject:[NSNumber numberWithInt:COUNTRY]];
    }
    if (delegate) [delegate filterMenu:self filterSelected:self.currentFilter];
}

- (void)educationView_Click:(UITapGestureRecognizer *)recognizer {
    if ([self.currentFilter containsObject:[NSNumber numberWithInt:EDUCATION]]) {
        [self deSelectFilter:EDUCATION];
        [self.currentFilter removeObject:[NSNumber numberWithInt:EDUCATION]];
    } else {
        [self selectFilter:EDUCATION];
        [self.currentFilter addObject:[NSNumber numberWithInt:EDUCATION]];
    }
    if (delegate) [delegate filterMenu:self filterSelected:self.currentFilter];
}

- (void)ageView_Click:(UITapGestureRecognizer *)recognizer {
    if ([self.currentFilter containsObject:[NSNumber numberWithInt:AGE]]) {
        [self deSelectFilter:AGE];
        [self.currentFilter removeObject:[NSNumber numberWithInt:AGE]];
    } else {
        [self selectFilter:AGE];
        [self.currentFilter addObject:[NSNumber numberWithInt:AGE]];
    }
    if (delegate) [delegate filterMenu:self filterSelected:self.currentFilter];
}

@end
