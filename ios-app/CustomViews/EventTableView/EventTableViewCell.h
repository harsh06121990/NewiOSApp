//
//  EventTableViewCell.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/21/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface EventTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;


@property (weak, nonatomic) IBOutlet UIImageView *imgEventImage;
@property (weak, nonatomic) IBOutlet UIView *viewAddressLblHolder;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblEventTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblEventDes;
@property (weak, nonatomic) IBOutlet UILabel *lblEventTime;
@property (weak, nonatomic) IBOutlet UIView *viewInfoHolder;
@property (weak, nonatomic) IBOutlet UIImageView *imgPushPin;
@property (weak, nonatomic) IBOutlet UIView *viewUpperContentHolder;

@end
