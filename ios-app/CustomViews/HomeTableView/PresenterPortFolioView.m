//
//  PresenterPortFolioView.m
//  ios-app
//
//  Created by MinhThai on 2/28/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "PresenterPortFolioView.h"
#import "Constants.h"

@interface PresenterPortFolioView () {
    CGFloat itemWidth;
    CGFloat yearWidth;
    CGFloat textWidth;
    CGFloat currentY;
    CGFloat indicatorWidth;
    CGFloat margin;
}
    @property UIScrollView *scrollView;
@end

@implementation PresenterPortFolioView

- (void)measure {
    yearWidth = self.maxWidth / 7.0;
    textWidth = self.maxWidth - yearWidth - margin - 10;
    indicatorWidth = yearWidth / 5;
    
    margin = 10;
}

- (void)setItemCount:(NSInteger)itemCount {
    _itemCount = itemCount;
    
    // Important!!! The system may reuse previous view so we have to make sure
    // the view is always empty
    while (self.subviews.count > 0) {
        [self.subviews.lastObject removeFromSuperview];
    }
    
    [self measure];
    
    // For testing purpose
    NSArray *years = @[@"1994", @"2000", @"2009", @"2010", @"2012", @"2014", @"2015"];
    NSArray *contents = @[@"TedTalk about Marine Health",
                          @"Talk: The important of dolphin",
                          @"Talk: The impact of over fishing",
                          @"Presenting at a global conference",
                          @"Education speaker at a local aquarium"];
    
    if(self.scrollView == nil) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:(CGRect){{0, 0}, {self.maxWidth, self.maxHeight}}];
        [self.scrollView setShowsVerticalScrollIndicator:NO];
        self.scrollView.contentSize = (CGSize){self.maxWidth, 1};
        
        CGFloat width = self.maxWidth;
        int remain = itemCount;
        while(remain > 0) {
            int n_item = [AppUtil min:3 :[AppUtil randomRange:1 :remain]]; // how many item in this year
            NSString *year = [years objectAtIndex:[AppUtil randomRange:0 :years.count]]; // choose a year
            
            NSString *text = @"";
            for(int i = 0; i < n_item; ++i) {
                NSString *tmp = [contents objectAtIndex:[AppUtil randomRange:0 :contents.count]];
                tmp = [@"\n" stringByAppendingString:tmp]; // add line break
                text = [text stringByAppendingString:tmp];
            }
            
            UIView *item = [self createItemWithYear:year content:text];
            [self.scrollView addSubview:item];
            
            remain -= n_item;
        }

        // update height and add bottom margin
        self.scrollView.contentSize = (CGSize){self.maxWidth, self.scrollView.contentSize.height + currentY + margin};
        [self addSubview:self.scrollView];
    }
}

- (UIView *)createItemWithYear:(NSString *)year content:(NSString *)text {
    // Label for year
    // ----------------
    UILabel *lblY = [[UILabel alloc]init];
    lblY.text = year;
    [lblY setFont:[UIFont systemFontOfSize:12]];
    lblY.textColor = [UIColor blackColor];
    [lblY sizeToFit];
    
    CGFloat yearW = yearWidth;
    CGFloat yearH = lblY.frame.size.height;
    lblY.frame = (CGRect){{margin + indicatorWidth + 5, 15}, {yearW, yearH}};
    
    // Label for content
    // ---------------------
    CGSize sizeOfText=[text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(textWidth, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap]; // calculate needed size
    UILabel *lblText=[[UILabel alloc] initWithFrame:(CGRect){{margin + indicatorWidth + 5 + yearW + 5, 0}, {textWidth, sizeOfText.height}}];
    lblText.text = text;
    lblText.font = [UIFont systemFontOfSize:12];
    lblText.numberOfLines = 0;// JUST TO SUPPORT MULTILINING.
    lblText.textColor = [UIColor blackColor];
    
    [lblText sizeToFit];
    CGFloat textW = textWidth;
    CGFloat textH = lblText.frame.size.height;
    
    // Create container
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, currentY, self.maxWidth, yearH + textH)];
    
    // Create indicator
    UIView * indicator = [self createIndicator:15 + 2];
    
    // Update current position
    currentY += lblText.frame.size.height;
    
    [view addSubview:indicator];
    [view addSubview:lblY];
    [view addSubview:lblText];
    
    return view;
}

- (UIView *)createIndicator:(CGFloat)offsetY {
    UIView *circle = [[UIView alloc] initWithFrame:(CGRect){{0, 0},{indicatorWidth,indicatorWidth}}];
    circle.layer.cornerRadius = indicatorWidth / 2;
    circle.backgroundColor = [AppUtil colorHex:@"#949494"];
    circle.layer.zPosition = 99;

    UIView *line = [[UIView alloc] initWithFrame:(CGRect){{0, indicatorWidth / 2},{indicatorWidth,self.maxHeight}}];
    line.backgroundColor = [AppUtil colorHex:@"#E0E0E0"];
    

    UIView *container = [[UIView alloc] initWithFrame:(CGRect){{margin, offsetY},{indicatorWidth,self.maxHeight}}];
    [container addSubview:circle];
    [container addSubview:line];
    
    return container;
}

@end
