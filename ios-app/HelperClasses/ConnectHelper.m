//
//  NSObject+FollowUserHelper.m
//  ios-app
//
//  Created by Deepak on 15/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ConnectHelper.h"
#import "ConnektRestClient.h"
#import "FollowUserModel.h"
#import "UserHelper.h"
#import "NotInterestedModel.h"

@interface ConnectHelper ()
// Private function for upserting a follower user
-(void) upsertFollower:(NSNumber *) userID;
// Private function for upserting following user
-(void) upsertFollowing:(NSNumber *) userID;
// Private function for upserting not interested user
-(void) upsertNotInterested:(NSNumber *) userID;
//Function for deleting a following user
-(void) deleteFollowing:(NSNumber *) userID;

//Variable for storing not interested users
@property (nonatomic,weak) NSArray *notInterestedUsers;
//Variable for storing connected users
@property (nonatomic, weak) NSArray *connectedUsers;

@property (nonatomic, strong) NSArray *usersNotToBeDisplayInSearchResults;
@end

@implementation ConnectHelper
@synthesize notInterestedUsers = _notInterestedUsers;
@synthesize connectedUsers = _connectedUsers;
@synthesize usersNotToBeDisplayInSearchResults = _usersNotToBeDisplayInSearchResults;

#pragma mark - accessor functions
-(NSArray *) notInterestedUsers {
    if(!_notInterestedUsers){
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"NotInterestedModel"];
        fetchRequest.resultType = NSDictionaryResultType;
        [fetchRequest setPropertiesToFetch:[NSArray arrayWithObjects:@"userID", nil]];
        NSArray *results    = [self.managedObjectContext executeFetchRequest:fetchRequest
                                                                       error:nil];
        _notInterestedUsers = [results valueForKey:@"userID"];
    }
    return _notInterestedUsers;
}

-(NSArray *) connectedUsers {
    if(!_connectedUsers){
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"followedBy=%@",[[[UserHelper getInstance] userPersonalInformation] userID]];
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"FollowUserModel"];
        [fetchRequest setPropertiesToFetch:[NSArray arrayWithObjects:@"following", nil]];
        fetchRequest.predicate = predicate;
        NSArray * results = [[self managedObjectContext] executeFetchRequest:fetchRequest error:nil];
        _connectedUsers = [results valueForKey:@"following"];
    }
    return _connectedUsers;
}

-(NSArray *) usersNotToBeDisplayInSearchResults{
    // If these 2 arrays are not initialized then we have to re initialized it
    if(!(_connectedUsers) || !(_notInterestedUsers)){
        _usersNotToBeDisplayInSearchResults = [[self connectedUsers] arrayByAddingObjectsFromArray:[self notInterestedUsers]];
    }
    return _usersNotToBeDisplayInSearchResults;
}

#pragma mark - public functions
+(ConnectHelper *) getInstance{
    static ConnectHelper *_singletonInstance;
    @synchronized(self){
        if (!_singletonInstance) {
            _singletonInstance = [[ConnectHelper alloc] init];
        }
        return _singletonInstance;
    }
}

-(void) connectToUser: (NSNumber *)userID usernameOfTheUser:(NSString *)userName callback:(ConnectHelperCallback) callback{
    [[ConnektRestClient getInstance] sendRequest:@"follow/" typeOfRequest:POST
                               payloadForRequest:@{@"followingID" : userID}
                                 responseHandler:^(id response, bool success) {
        if(success){
            // Saving following data in the core data
            [self upsertFollowing:userID];
            //Saving user information in the core data
            [[UserHelper getInstance] upsertuser:userID userName:userName];
            //Resetting array
            [self setConnectedUsers:nil];
            callback(success, nil);
        }
        else{
            callback(success, nil);
        }
    }];
}

-(void) disconnectFromConnectedUser: (NSNumber *)userID usernameOfTheUser:(NSString *)userName callback:(ConnectHelperCallback) callback{
    [[ConnektRestClient getInstance] sendRequest:@"follow/" typeOfRequest:DELETE
                               payloadForRequest:@{@"followingID" : userID}
                                 responseHandler:^(id response, bool success) {
                                     if(success){
                                         [self deleteFollowing:userID];
                                         //Resetting array
                                         [self setConnectedUsers:nil];
                                         callback(success, nil);
                                     }
                                     else{
                                         callback(success, nil);
                                     }
                                 }];
}

-(void) disconnectFromUser: (NSNumber *)userID usernameOfTheUser:(NSString *)userName callback:(ConnectHelperCallback) callback{
    [[ConnektRestClient getInstance] sendRequest:@"follow/not_interested/" typeOfRequest:POST
                               payloadForRequest:@{@"notInterestedID" : userID}
                                 responseHandler:^(id response, bool success) {
                                     if(success){
                                         //Saving not interested entry in the core data
                                         [self upsertNotInterested:userID];
                                         //Saving user information in the core data
                                         [[UserHelper getInstance] upsertuser:userID userName:userName];
                                         // Setting not interested user array as nil
                                         [self setNotInterestedUsers:nil];
                                         callback(success, nil);
                                     }
                                     else{
                                         callback(success, nil);
                                     }
                                 }];
}

#pragma mark - private functions

-(void) upsertFollower:(NSNumber *) userID{
    //Checking if the core data record already exists or not
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"followedBy=%@",userID];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FollowUserModel"];
    request.predicate = predicate;
    NSArray * users = [[self managedObjectContext] executeFetchRequest:request error:nil];
    if([users count] > 0){
        // Record already exists do nothing
        return;
    }
    else{
        //Insert user record in the database
        FollowUserModel *temp = [NSEntityDescription insertNewObjectForEntityForName:@"FollowUserModel" inManagedObjectContext:[self managedObjectContext]];
        [temp setFollowedBy:userID];
        [temp setFollowing:[[[UserHelper getInstance] userPersonalInformation] userID]];
        [self save];
    }
}

-(void) upsertFollowing:(NSNumber *) userID{
    //Checking if the core data record already exists or not
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"following=%@",userID];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FollowUserModel"];
    request.predicate = predicate;
    NSArray * users = [[self managedObjectContext] executeFetchRequest:request error:nil];
    if([users count] > 0){
        // Record already exists do nothing
        return;
    }
    else{
        //Insert user record in the database
        FollowUserModel *temp = [NSEntityDescription insertNewObjectForEntityForName:@"FollowUserModel" inManagedObjectContext:[self managedObjectContext]];
        [temp setFollowing:userID];
        [temp setFollowedBy:[[[UserHelper getInstance] userPersonalInformation] userID]];
        [self save];
    }
}

-(void) deleteFollowing:(NSNumber *) userID{
    //Checking if the core data record already exists or not
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"following=%@",userID];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FollowUserModel"];
    request.predicate = predicate;
    NSArray * users = [[self managedObjectContext] executeFetchRequest:request error:nil];
    if([users count] > 0){
        // Record exists. Deleting it
        [[self managedObjectContext] deleteObject:[users lastObject]];
        [self save];
    }
}


-(void) upsertNotInterested:(NSNumber *) userID{
    //Checking if the core data record already exists or not
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"userID=%@",userID];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"NotInterestedModel"];
    request.predicate = predicate;
    NSArray * users = [[self managedObjectContext] executeFetchRequest:request error:nil];
    if([users count] > 0){
        // Record already exists do nothing
        return;
    }
    else{
        //Insert user record in the database
        NotInterestedModel *temp = [NSEntityDescription insertNewObjectForEntityForName:@"NotInterestedModel" inManagedObjectContext:[self managedObjectContext]];
        [temp setUserID:userID];
        [self save];
    }
}

@end
