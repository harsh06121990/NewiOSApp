//
//  UserPersonalModel.h
//  ios-app
//
//  Created by Deepak on 10/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserPersonalModel : NSManagedObject

@property (nonatomic, retain) NSString * authToken;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSDate * dateOfBirth;
@property (nonatomic, retain) NSString * education;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * introduction;
@property (nonatomic, retain) NSString * proficiency;
@property (nonatomic, retain) NSString * skill;
@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * userType;

@end
