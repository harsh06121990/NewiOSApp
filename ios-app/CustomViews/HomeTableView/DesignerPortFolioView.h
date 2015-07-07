//
//  DesignerPortFolioView.h
//  ios-app
//
//  Created by MinhThai on 2/28/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface DesignerPortFolioView : UIView

@property (nonatomic) NSInteger itemCount;
@property (nonatomic) CGFloat preferredMaxLayoutWidth;
@property (nonatomic) CGFloat maxWidth;
@property (nonatomic) CGFloat maxHeight;

@property (nonatomic, strong) NSArray *data;

- (void)reloadData;
@end
