//
//  EventImageListView.h
//  ios-app
//
//  Created by MinhThai on 3/13/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventImageListView : UIView

@property (weak, nonatomic) IBOutlet UIView *parentView;


@property NSMutableArray *Data; // list of image names

// Custom method
- (id)initWithFrame:(CGRect)frame withData:(NSMutableArray *)data;

@end
