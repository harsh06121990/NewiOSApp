//
//  UIView+ChatTableCell.m
//  ios-app
//
//  Created by Deepak on 19/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ChatTableCell.h"

@implementation ChatTableCell

- (void)awakeFromNib
{
    //Changes done directly here, we have an object
    [super awakeFromNib];
    self.userPicture.layer.borderWidth = 2.0f;
    self.userPicture.layer.masksToBounds = TRUE;
    self.userPicture.layer.borderColor = [UIColor colorWithRed:27.0/255.0 green:37.0/255.0 blue:47.0/255.0 alpha:1].CGColor;
    self.userPicture.layer.cornerRadius = self.userPicture.frame.size.width/2 + 2.5;
    self.userPicture.clipsToBounds = true;
    self.layer.masksToBounds = true;
}


-(void) initializeInformation:(NSString *) username messageToBeDisplayed:(NSString *) message time:(NSString *) time{
    [[self userName] setText:username];
    [[self lastMessage] setText:message];
    [[self time] setText:time];
}

-(void) setBackgroundOpacity:(CGFloat) alpha{
    [[self containerView] setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:alpha]];
}

@end
