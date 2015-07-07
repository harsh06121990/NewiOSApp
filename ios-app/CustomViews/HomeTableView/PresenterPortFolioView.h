//
//  PresenterPortFolioView.h
//  ios-app
//
//  Created by MinhThai on 2/28/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresenterPortFolioView : UIView

@property (nonatomic) NSInteger itemCount;
@property (nonatomic) NSMutableArray *items;
@property (nonatomic) CGFloat maxWidth;
@property (nonatomic) CGFloat maxHeight;

@end
