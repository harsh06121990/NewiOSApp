//
//  MyWrappingView.h
//  WrapDemo
//
//  Created by Jonathon Mah on 2014-06-06.
//  This is free and unencumbered software released into the public domain.
//

#import <UIKit/UIKit.h>


@interface MyWrappingView : UIView

@property (nonatomic) NSInteger itemCount;
@property (nonatomic) CGFloat preferredMaxLayoutWidth;
@property (nonatomic) CGFloat maxWidth;
@property (nonatomic) CGFloat maxHeight;

@property (nonatomic, strong) UIColor *itemBackgroundColor;
@property (nonatomic, strong) UIColor *itemBorderColor;

@property (nonatomic, strong) NSArray *data;

- (NSArray *)parseDataFromString:(NSString *)input;
- (void)reloadData;
@end
