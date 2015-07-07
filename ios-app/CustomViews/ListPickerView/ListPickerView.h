//
//  ListPickerView.h
//  ios-app
//
//  Created by MinhThai on 3/22/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListPickerView;
@protocol ListPickerDelegate <NSObject>

- (void)onItemSelected:(ListPickerView *)sender value:(NSString*)value index:(int)index;

@end

@interface ListPickerView : UIView

@property (nonatomic, assign) id delegate;
@property NSArray *Data;

@property (weak, nonatomic) IBOutlet UIView *parentView;
@property UIView *expandView;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnExpand;

- (IBAction)btnExpandClick:(id)sender;


- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
@end
