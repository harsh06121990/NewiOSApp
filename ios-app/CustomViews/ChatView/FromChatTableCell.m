//
//  UITableViewCell+FromChatTableCell.m
//  ios-app
//
//  Created by Deepak on 06/03/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "FromChatTableCell.h"

@implementation FromChatTableCell:UITableViewCell

- (void)awakeFromNib
{
    //Changes done directly here, we have an object
    [super awakeFromNib];
    self.textBackground.layer.cornerRadius = 8;
    self.textBackground.clipsToBounds = true;
    self.textBackground.layer.masksToBounds = true;
}

@end
