//
//  UIView+ChatTableCell.h
//  ios-app
//
//  Created by Deepak on 19/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTableCell: UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userPicture;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *lastMessage;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIView *containerView;


// Function for initializing content in the cell
-(void) initializeInformation:(NSString *) username messageToBeDisplayed:(NSString *) message time:(NSString *) time;
//Function for setting opacity
-(void) setBackgroundOpacity:(CGFloat) alpha;
@end
