//
//  NSObject+FollowUserHelper.h
//  ios-app
//
//  Created by Deepak on 15/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataCommonHelper.h"

// Callback block for ConnektHelper callback
typedef void(^ConnectHelperCallback) (bool success, id result);

@interface ConnectHelper:CoreDataCommonHelper

// Function for accssing singleton instance of this class
+(ConnectHelper *) getInstance;

// Function for connecting to a user
-(void) connectToUser: (NSNumber *)userID usernameOfTheUser:(NSString *)userName callback:(ConnectHelperCallback) callback;

// Function for disconnecting from a connected user
-(void) disconnectFromConnectedUser: (NSNumber *)userID usernameOfTheUser:(NSString *)userName callback:(ConnectHelperCallback) callback;

// Function for disconnecting from a user
-(void) disconnectFromUser: (NSNumber *)userID usernameOfTheUser:(NSString *)userName callback:(ConnectHelperCallback) callback;


//Not interested users
@property (nonatomic,weak, readonly) NSArray *notInterestedUsers;
//Connected users
@property (nonatomic, weak, readonly) NSArray *connectedUsers;

@property (nonatomic, strong, readonly) NSArray *usersNotToBeDisplayInSearchResults;
@end
