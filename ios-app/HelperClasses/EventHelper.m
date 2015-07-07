//
//  CoreDataCommonHelper+EventHelper.m
//  ios-app
//
//  Created by Deepak on 24/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "EventHelper.h"
#import "EventModel.h"
#import "ConnektRestClient.h"

//Setting model for this helper class
NSString * const EVENT_HELPER_MODEL = @"EventModel";

@interface EventHelper()

/*
    Function of upserting an event entry in the core data
    1. Event ID is mandotary 
    2. Other parameters are optional and if you don't want to change or store their value then simply pass nil for it
    3. Use @YES and @NO for the boolean values
 */
-(BOOL) upsertEvent:(NSNumber *)eventID creationDate:(NSDate *)date isEventBookmarked:(NSNumber *)bookmarked isAttendingEvent:(NSNumber *) attending;

// For fetching event from the core data
-(EventModel *) getEventFromCoreData: (NSNumber *)eventID;

@end

@implementation EventHelper

#pragma mark - public functions
+(EventHelper *) getInstance{
    static EventHelper * singletonInstance;
    @synchronized(self){
        if(!singletonInstance){
            // Initializing singleton Instance
            singletonInstance = [[EventHelper alloc] init];
        }
        // Returning singletonInstance
        return singletonInstance;
    }
}


#pragma mark - Bookmark Event Functions
-(void) bookmarkAnEvent: (NSNumber *) eventID callbackHandler:(EventHelperCallback) callback{
    NSString *url = [NSString stringWithFormat:@"event/bookmark/%@/", eventID];
    [[ConnektRestClient getInstance] sendRequest:url typeOfRequest:POST payloadForRequest:nil responseHandler:^(id response, bool success) {
        //Event bookmarked on the server
        if(success){
            // Saving entry in the core data
            [self upsertEvent:eventID creationDate:[self dateFromStandardISOString:[response objectForKey:@"created_at"]] isEventBookmarked:@YES isAttendingEvent:nil];
            callback(true, response);
        }
        else{
            callback(false, nil);
        }
    }];
}

-(NSArray *) getBookmarkedEvents{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"bookmarked=1"];
    fetchRequest.predicate = predicate;
    NSEntityDescription * entity = [NSEntityDescription entityForName:EVENT_HELPER_MODEL inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    NSError *error;
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

-(BOOL) deleteBookmarkedEvent:(NSNumber *) eventID callbackHandler:(EventHelperCallback) callback{
    NSString *url = [NSString stringWithFormat:@"event/bookmark/%@/", eventID];
    [[ConnektRestClient getInstance] sendRequest:url typeOfRequest:DELETE payloadForRequest:nil responseHandler:^(id response, bool success) {
        //Event bookmarked on the server
        if(success){
            //Deleting it from the core data
            [[self managedObjectContext] deleteObject:[self getEventFromCoreData:eventID]];
            [self save];
            callback(true, nil);
        }
        else{
            callback(false, nil);
        }
    }];
    return TRUE;
}

#pragma mark - Attend Event Functions
-(void) attendAnEvent: (NSNumber *) eventID callbackHandler:(EventHelperCallback) callback{
    NSString *url = [NSString stringWithFormat:@"event/attend/%@/", eventID];
    [[ConnektRestClient getInstance] sendRequest:url typeOfRequest:POST payloadForRequest:nil responseHandler:^(id response, bool success) {
        //Event bookmarked on the server
        if(success){
            // Saving entry in the core data
            [self upsertEvent:eventID creationDate:[self dateFromStandardISOString:[response objectForKey:@"created_at"]] isEventBookmarked:nil isAttendingEvent:@YES];
            callback(true, response);
        }
        else{
            callback(false, nil);
        }
    }];
}

-(NSArray *) getAttendingEvents{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"attending=1"];
    fetchRequest.predicate = predicate;
    NSEntityDescription * entity = [NSEntityDescription entityForName:EVENT_HELPER_MODEL inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    NSError *error;
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

-(BOOL) deleteAttendingEvent:(NSNumber *) eventID callbackHandler:(EventHelperCallback) callback{
    NSString *url = [NSString stringWithFormat:@"event/attend/%@/", eventID];
    [[ConnektRestClient getInstance] sendRequest:url typeOfRequest:DELETE payloadForRequest:nil responseHandler:^(id response, bool success) {
        //Event bookmarked on the server
        if(success){
            //Deleting it from the core data
            [[self managedObjectContext] deleteObject:[self getEventFromCoreData:eventID]];
            [self save];
            callback(true, nil);
        }
        else{
            callback(false, nil);
        }
    }];
    return TRUE;
}


-(void) getEventsFromServer: (NSNumber *) pageNo callbackHandler:(EventHelperCallback) callback{
    NSString *url = [NSString stringWithFormat:@"ad/feed/%@/", pageNo];
    [[ConnektRestClient getInstance] sendRequest:url typeOfRequest:GET payloadForRequest:nil responseHandler:^(id response, bool success) {
        //Event bookmarked on the server
        if(success){
            callback(true, response);
        }
        else{
            callback(false, nil);
        }
    }];
}

-(void) syncWithServer{
    //Sending request to the server
    [[ConnektRestClient getInstance] sendRequest:@"event/" typeOfRequest:GET payloadForRequest:nil responseHandler:^(id response, bool success) {
        if(success){
        }
        else{
        }
    }];
}

#pragma mark - private function 
-(EventModel *) getEventFromCoreData: (NSNumber *)eventID {
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"eventID = %d",[eventID integerValue]];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:EVENT_HELPER_MODEL];
    request.predicate = predicate;
    NSArray * portfolios = [[self managedObjectContext] executeFetchRequest:request error:nil];
    if([portfolios count] > 0){
        // Event is already present in the database just update it
        return [portfolios objectAtIndex:0];
    }
    else{
        return nil;
    }
}

// Function for upserting an event
-(BOOL) upsertEvent:(NSNumber *)eventID creationDate:(NSDate *)date isEventBookmarked:(NSNumber *)bookmarked isAttendingEvent:(NSNumber *) attending{
    //Checking if it exists in core data or not
    EventModel *temp = [self getEventFromCoreData:eventID];
    if(!temp){
        //It does not exists. Inserting Event record in the database
        temp = [NSEntityDescription insertNewObjectForEntityForName:EVENT_HELPER_MODEL inManagedObjectContext:[self managedObjectContext]];
    }
    //Updating values
    [temp setEventID:eventID];
    if(bookmarked)
    {
        [temp setBookmarked:bookmarked];
    }
    if(attending){
        [temp setAttending:attending];
    }
    if(date){
        [temp setCreatedAt:date];
    }
    //Saving data inside core data
    [self save];
    return true;
}

@end
