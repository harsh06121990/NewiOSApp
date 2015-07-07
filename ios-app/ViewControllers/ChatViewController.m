//
//  UITableViewController+ChatViewController.m
//  ios-app
//
//  Created by Deepak on 21/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ChatViewController.h"
#import "ToChatTableCell.h"
#import "FromChatTableCell.h"
#import "ChatModel.h"
#import "ChatHelper.h"
#import "UserHelper.h"

@interface ChatViewController()
@property (nonatomic, strong) NSArray *chatMessages;
-(void)scrollToTheBottom;
-(void) scrollToTheBottomWithNoAnimation;
@end

@implementation ChatViewController
@synthesize chatMessages = _chatMessages;

-(NSArray *) chatMessages{
    if(!_chatMessages){
        _chatMessages = [[ChatHelper getInstance] getChatMessages:[self userIdInChat]];
        NSLog(@"%@", _chatMessages);
    }
    return _chatMessages;
}

-(void) viewDidLoad{
    [[self tableView] setDataSource:self];
    [[self tableView] setDelegate:self];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Adding listener for keyboard hide and show event
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
    //Setting keyboard style
    [[self messageTextView] setKeyboardAppearance:UIKeyboardAppearanceDark];
    //Turning off auto correct so that we have move space on the screen
    [[self messageTextView] setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [[self messageTextView] setAutocorrectionType:UITextAutocorrectionTypeNo];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationHandler:)
                                                 name:@"NEW_CHAT_MESSAGES" object:nil];
}

-(void)notificationHandler:(NSNotification*)_notification
{
    //TODO we have to improve it. Right now it's quick and dirty
    [self setChatMessages:nil];
    [[self tableView] reloadData];
    //Scrolling at the bottom
    [self scrollToTheBottom];
}

-(void) keyboardWasShown:(NSNotification *) notification{
    NSDictionary *info = notification.userInfo;
    CGRect keyboardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // Updating constraints
    self.messageViewBottomConstraint.constant = keyboardFrame.size.height;
    // Forcing contraints to update
    [self.view setNeedsUpdateConstraints];
    //Animating
    [UIView animateWithDuration:[[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        [[self view] layoutIfNeeded];
    }];
    [self scrollToTheBottom];
}

-(void) keyboardWasHidden:(NSNotification *) notification{
    NSDictionary *info = notification.userInfo;
    // Updating constraints
    self.messageViewBottomConstraint.constant = 0;
    // Forcing contraints to update
    [self.view setNeedsUpdateConstraints];
    //Animating
    [UIView animateWithDuration:[[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        [[self view] layoutIfNeeded];
    }];
    [self scrollToTheBottom];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(void) viewWillAppear:(BOOL)animated{
    [self scrollToTheBottomWithNoAnimation];
}

#pragma mark - Table view data source delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self chatMessages] count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatModel *message = [[self chatMessages] objectAtIndex:indexPath.row];
    
    // The message is send by the user to the other user
    if([[message userIdFrom] isEqualToValue:[[[UserHelper getInstance] userPersonalInformation] userID]]){
        ToChatTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"toChatTableCell"];
        if(!cell){
            // If we are not able to dequeue cell
            [tableView registerNib:[UINib nibWithNibName:@"ToChatTableCell" bundle:nil] forCellReuseIdentifier:@"toChatTableCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"toChatTableCell"];
        }
        [[cell messageText] setText:[message message]];
        [cell setUserInteractionEnabled:false];
        return cell;
    }
    else{
        FromChatTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fromChatTableCell"];
        if(!cell){
            // If we are not able to dequeue cell
            [tableView registerNib:[UINib nibWithNibName:@"FromChatTableCell" bundle:nil] forCellReuseIdentifier:@"fromChatTableCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"fromChatTableCell"];
        }
        [[cell messageText] setText:[message message]];
        [cell setUserInteractionEnabled:false];
        return cell;
    }
}

-(void) scrollToTheBottom{
    [self.tableView scrollRectToVisible:CGRectMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height, self.tableView.bounds.size.width, self.tableView.bounds.size.height) animated:YES];
}

-(void) scrollToTheBottomWithNoAnimation{
    [self.tableView scrollRectToVisible:CGRectMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height, self.tableView.bounds.size.width, self.tableView.bounds.size.height) animated:NO];
}

- (IBAction)sendMessage:(UIButton *)sender {
    // Don't take any action if the user has not entered any message
    if([[[self messageTextView] text] length] == 0){
        return;
    }
    
    NSString *message = [[self messageTextView] text];
    ///Clearing text view
    [[self messageTextView] setText:@""];
    //Sending request to the server to send a message
    [[ChatHelper getInstance] sendChatMessage:message toTheUser:[self userIdInChat] callback:^(bool success, id result) {
        if(success){
            //TODO we have to improve it. Right now it's quick and dirty
            [self setChatMessages:nil];
            [[self tableView] reloadData];
            //Scrolling at the bottom
            [self scrollToTheBottom];
        }
    }];
}


#pragma mark - UITableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"chatDetailToChatView" sender:self];
}
@end
