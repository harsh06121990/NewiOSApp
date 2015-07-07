//
//  CoreDataCommonHelper+EventHelper.h
//  ios-app
//
//  Created by Deepak on 24/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "CoreDataCommonHelper.h"

typedef void(^EventHelperCallback) (bool success, id result);
extern NSString * const EVENT_HELPER_MODEL;

@interface EventHelper:CoreDataCommonHelper

// Model Name for the helper

// Static function for accessing singleton instance of EventHelper class
+(EventHelper *) getInstance;

//For bookmarking an event
-(void) bookmarkAnEvent: (NSNumber *) eventID callbackHandler:(EventHelperCallback) callback;

//For getting all the bookmarked events
-(NSArray *) getBookmarkedEvents;

//For Deleting a bookmark
-(BOOL) deleteBookmarkedEvent:(NSNumber *) eventID callbackHandler:(EventHelperCallback) callback;

//For attending an event
-(void) attendAnEvent: (NSNumber *) eventID callbackHandler:(EventHelperCallback) callback;

//For getting all the attending events
-(NSArray *) getAttendingEvents;

//For Deleting a attending event
-(BOOL) deleteAttendingEvent:(NSNumber *) eventID callbackHandler:(EventHelperCallback) callback;

//For fetching event feeds from the server. Start with the page number zero
-(void) getEventsFromServer: (NSNumber *) pageNo callbackHandler:(EventHelperCallback) callback;

@end
