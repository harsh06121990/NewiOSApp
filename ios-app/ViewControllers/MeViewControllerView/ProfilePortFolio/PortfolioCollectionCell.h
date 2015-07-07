//
//  PortfolioCollectionCell.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/12/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"
@interface PortfolioCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgPortfolio;
@property (weak, nonatomic) IBOutlet UIView *viewShadow;
@property (weak, nonatomic) IBOutlet UIButton *btnSetting;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end
