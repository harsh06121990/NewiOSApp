//
//  EventTableViewCell.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/16/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgEventImage;
@property (weak, nonatomic) IBOutlet UIView *viewShareCountHolder;
@property (weak, nonatomic) IBOutlet UILabel *lblShareCount;
@property (weak, nonatomic) IBOutlet UILabel *lblEventTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblCompanyName;
@property (weak, nonatomic) IBOutlet UIImageView *imgCompanyLogo;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UIView *viewContentHolder;

@end
