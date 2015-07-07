//
//  FollowUserModel.h
//  ios-app
//
//  Created by Deepak on 15/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FollowUserModel : NSManagedObject

@property (nonatomic, retain) NSNumber * following;
@property (nonatomic, retain) NSNumber * followedBy;

@end
