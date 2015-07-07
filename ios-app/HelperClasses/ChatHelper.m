//
//  CoreDataCommonHelper+ChatHelper.m
//  ios-app
//
//  Created by Deepak on 22/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ChatHelper.h"
#import "ConnektRestClient.h"
#import "UserHelper.h"

//Setting model for this helper class
NSString * const CHAT_HELPER_MODEL = @"ChatModel";

@interface ChatHelper()
// Function for upserting chat messages
-(BOOL) upsertChat:(NSNumber *)chatID fromTheUser:(NSNumber *)usedIdFrom toTheUser  :(NSNumber *)usedIdTo chatMessage:(NSString *)message dateOfChatMessage:(NSDate *)date;
@end

@implementation ChatHelper

#pragma mark - private methods
-(BOOL) upsertChat:(NSNumber *)chatID fromTheUser:(NSNumber *)userIdFrom toTheUser:(NSNumber *)userIdTo chatMessage:(NSString *)message dateOfChatMessage:(NSDate *)date{
    //Checking if the core data already exists or not
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"chatID=%@",chatID];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CHAT_HELPER_MODEL];
    request.predicate = predicate;
    NSArray * chats = [[self managedObjectContext] executeFetchRequest:request error:nil];
    ChatModel *temp;
    if([chats count] > 0){
        // Chat message is already present in the database just update it
        temp = [chats objectAtIndex:0];
    }
    else{
        //Insert portfolio record in the database
        temp = [NSEntityDescription insertNewObjectForEntityForName:CHAT_HELPER_MODEL inManagedObjectContext:[self managedObjectContext]];
    }
    //Updating values
    [temp setChatID:chatID];
    [temp setCreatedAt:date];
    [temp setUserIdFrom:userIdFrom];
    [temp setUserIdTo:userIdTo];
    [temp setMessage:message];
    //Saving data inside core data
    [self save];
    return true;

}


-(NSUInteger) getLastChatMessageID{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:CHAT_HELPER_MODEL];
    fetchRequest.fetchLimit = 1;
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"chatID" ascending:NO]];
    NSError *error = nil;
    ChatModel *person = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error].lastObject;
    if(!person){
        // If there is no record in the chat then simplt return 0
        return 0;
    }
    else{
        // Return the last chat id
        return [person.chatID integerValue];
    }
}

+(ChatHelper *) getInstance{
    static ChatHelper *_singletonInstance;
    @synchronized(self){
        if (!_singletonInstance) {
            _singletonInstance = [[ChatHelper alloc] init];
        }
        return _singletonInstance;
    }
}

// Function for syncing with the server
-(void) syncWithTheServer{
    NSString *url = [NSString stringWithFormat:@"chat/feed/%lu/", (unsigned long)[self getLastChatMessageID]];
    [[ConnektRestClient getInstance] sendRequest:url typeOfRequest:GET payloadForRequest:nil responseHandler:^(id response, bool success) {
        if(success){
            // Saving data in the core data
            NSArray * user_informations = [response objectForKey:@"user_information"];
            if([user_informations respondsToSelector:@selector(count)]){
                for(id temp in user_informations){
                    //Saving user information in the core data
                    [[UserHelper getInstance] upsertuser:[NSNumber numberWithInteger:[[temp objectForKey:@"user_id"] integerValue]] userName:[temp objectForKey:@"user_name"]];
                }
            }
            //Saving chats
            NSArray * chats = [response objectForKey:@"chats"];
            if([chats respondsToSelector:@selector(count)]){
                for(id temp in chats){
                    //Saving user information in the core data
                    [[UserHelper getInstance] upsertuser:[NSNumber numberWithInteger:[[temp objectForKey:@"user_id"] integerValue]] userName:[temp objectForKey:@"user_name"]];
                    //Saving chat messages in the core data
                    [[ChatHelper getInstance] upsertChat:[NSNumber numberWithInteger:[[temp objectForKey:@"chat_id"] integerValue]]
                                             fromTheUser:[NSNumber numberWithInteger:[[temp objectForKey:@"from_user"] integerValue]]
                                               toTheUser:[NSNumber numberWithInteger:[[temp objectForKey:@"to_user"] integerValue]]
                                             chatMessage:[temp objectForKey:@"message"]
                                       dateOfChatMessage:[self dateFromStandardISOString:[temp objectForKey:@"created_on"]]];
                    //Sending notification to the view controller for new
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"NEW_CHAT_MESSAGES" object:nil userInfo:nil];
                }
            }
        }
    }];
}

-(NSSet *) chatUsers{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:CHAT_HELPER_MODEL];
    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObjects:@"userIdFrom", @"userIdTo", nil]];
    [fetchRequest setPropertiesToGroupBy:[NSArray arrayWithObjects:@"userIdFrom", @"userIdTo", nil]];
    [fetchRequest setReturnsDistinctResults:YES];
    [fetchRequest setResultType:NSDictionaryResultType];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO];
    fetchRequest.sortDescriptors = @[descriptor];
    NSArray *temp_threads = [[self managedObjectContext] executeFetchRequest:fetchRequest error:nil];
    NSMutableArray *users = [[NSMutableArray alloc] init];
    //Finding out all the users
    for(id t in temp_threads){
        [users addObject:[t objectForKey:@"userIdTo"]];
        [users addObject:[t objectForKey:@"userIdFrom"]];
    }
    NSMutableSet *user_sets  = [[NSMutableSet alloc] initWithArray:users];
    // Removing the user personal id
    [user_sets removeObject:[[[UserHelper getInstance] userPersonalInformation] userID]];
    return user_sets;
}

-(ChatModel *) getLastChatMessage:(NSNumber *)userID{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:CHAT_HELPER_MODEL];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"userIdTo=%@ OR userIdFrom=%@",userID, userID];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"chatID" ascending:NO];
    fetchRequest.predicate = predicate;
    fetchRequest.sortDescriptors = @[descriptor];
    [fetchRequest setFetchLimit:1];
    return [[self managedObjectContext] executeFetchRequest:fetchRequest error:nil].lastObject;
}

-(NSArray *) getChatMessages:(NSNumber *)userID{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:CHAT_HELPER_MODEL];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"userIdTo=%@ OR userIdFrom=%@",userID, userID];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"chatID" ascending:YES];
    fetchRequest.predicate = predicate;
    fetchRequest.sortDescriptors = @[descriptor];
    return [[self managedObjectContext] executeFetchRequest:fetchRequest error:nil];
}

-(void) sendChatMessage:(NSString *)message toTheUser:(NSNumber *)userID callback:(ChatHelperCallback) callback{
    [[ConnektRestClient getInstance] sendRequest:@"chat/" typeOfRequest:POST
                               payloadForRequest:@{
                                                   @"toUser": userID,
                                                   @"message": message
                                                   }
                                 responseHandler:^(id response, bool success) {
                                     if(success){
                                         //Saving message in the core data
                                         [self upsertChat:[NSNumber numberWithInteger:[[response objectForKey:@"chat_id"] integerValue]]
                                                                fromTheUser:[[[UserHelper getInstance] userPersonalInformation] userID]
                                                                toTheUser:userID
                                                                chatMessage:message
                                                                dateOfChatMessage:[self dateFromStandardISOString:[response objectForKey:@"created_on"]]];
                                        callback(success, response);
                                     }
                                     else{
                                         callback(false, response);
                                     }
                                 }];
}

@end
