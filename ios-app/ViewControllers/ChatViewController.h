//
//  UITableViewController+ChatViewController.h
//  ios-app
//
//  Created by Deepak on 21/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController: UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageViewBottomConstraint;
@property (weak, nonatomic) IBOutlet UITextField *messageTextView;
// Store the user id of person who is chating
@property (weak, nonatomic) NSNumber* userIdInChat;

- (IBAction)sendMessage:(UIButton *)sender;

@end
