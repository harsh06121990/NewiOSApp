//
//  ChatModel.h
//  ios-app
//
//  Created by Deepak on 11/03/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ChatModel : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSNumber * read;
@property (nonatomic, retain) NSNumber * userIdFrom;
@property (nonatomic, retain) NSNumber * userIdTo;
@property (nonatomic, retain) NSNumber * chatID;

@end
