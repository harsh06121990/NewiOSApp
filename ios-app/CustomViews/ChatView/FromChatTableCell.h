//
//  UITableViewCell+FromChatTableCell.h
//  ios-app
//
//  Created by Deepak on 06/03/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FromChatTableCell:UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *messageText;

@property (weak, nonatomic) IBOutlet UIView *textBackground;

@end
