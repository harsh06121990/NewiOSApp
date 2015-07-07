//
//  UITableViewCell+ToChatTableCell.h
//  ios-app
//
//  Created by Deepak on 21/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToChatTableCell: UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *messageText;
@property (weak, nonatomic) IBOutlet UIView *textBackground;
@end
