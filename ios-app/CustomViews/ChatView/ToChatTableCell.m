//
//  UITableViewCell+ToChatTableCell.m
//  ios-app
//
//  Created by Deepak on 21/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ToChatTableCell.h"

@implementation ToChatTableCell

- (void)awakeFromNib
{
    //Changes done directly here, we have an object
    [super awakeFromNib];
    self.textBackground.layer.cornerRadius = 8;
    self.textBackground.clipsToBounds = true;
    self.textBackground.layer.masksToBounds = true;
}

@end
