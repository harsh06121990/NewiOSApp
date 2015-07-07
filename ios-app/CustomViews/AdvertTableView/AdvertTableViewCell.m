//
//  EventTableViewCell.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/16/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "AdvertTableViewCell.h"

@implementation AdvertTableViewCell

- (void)awakeFromNib {
    //[self.viewShareCountHolder setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    [self.viewContentHolder setClipsToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
