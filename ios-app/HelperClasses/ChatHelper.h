//
//  CoreDataCommonHelper+ChatHelper.h
//  ios-app
//
//  Created by Deepak on 22/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "CoreDataCommonHelper.h"
#import "ChatModel.h"

extern NSString * const CHAT_HELPER_MODEL;
// Callback block for Chat callback
typedef void(^ChatHelperCallback) (bool success, id result);


@interface ChatHelper: CoreDataCommonHelper

//Function for accessing the singleton pattern of this class
+(ChatHelper *) getInstance;

//Function for syncing with the server
-(void) syncWithTheServer;

// Function for fetching all the chat users
-(NSSet *) chatUsers;

//Function for getting last chat message
-(ChatModel *) getLastChatMessage:(NSNumber *)userID;

// Function for getting all the chat messages between the users
-(NSArray *) getChatMessages:(NSNumber *)userID;

// Function for sending a message
-(void) sendChatMessage:(NSString *)message toTheUser:(NSNumber *)userID callback:(ChatHelperCallback) callback;
@end
