//
//  EventModel.h
//  ios-app
//
//  Created by Deepak on 25/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EventModel : NSManagedObject

@property (nonatomic, retain) NSNumber * eventID;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * attending;
@property (nonatomic, retain) NSNumber * bookmarked;

@end
