//
//  FilterMenuView.h
//  ios-app
//
//  Created by MinhThai on 2/6/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
@class FilterMenuView;
@protocol FilterMenuDelegate
- (void)filterMenu:(FilterMenuView *)menu filterSelected:(NSMutableArray *)selectedFileters;
@end

@interface FilterMenuView : UIView

typedef enum {
    NAME = 1,
    SKILL = 2,
    COUNTRY = 3,
    EDUCATION = 4,
    AGE = 5
} FILTER_NUMBER;

@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UIButton *btnName;
@property (weak, nonatomic) IBOutlet UIButton *btnSkill;
@property (weak, nonatomic) IBOutlet UIButton *btnEdu;
@property (weak, nonatomic) IBOutlet UIButton *btnCountry;
@property (weak, nonatomic) IBOutlet UIButton *btnAge;


@property (nonatomic, strong) id delegate;

// Methods
// --------
// 1:Name 2:Skill 3:Country 4:Language 5:Education 6:Age
- (void)selectFilter:(int)filter;
- (void)deSelectFilter:(int)filter;

- (void)appear;
- (void)disAppear:(void(^)())callback; // callback: will be called when animation completes
@end
