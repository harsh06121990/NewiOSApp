//
//  Portfolio.h
//  ios-app
//
//  Created by Deepak on 10/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Portfolio : NSManagedObject

@property (nonatomic, retain) NSNumber * portfolioID;
@property (nonatomic, retain) NSString * portfolioDescription;
@property (nonatomic, retain) NSString * mediaID;
@property (nonatomic, retain) NSDate * created_on;
@property (nonatomic, retain) NSSet *portfolio_of;
@end

@interface Portfolio (CoreDataGeneratedAccessors)

- (void)addPortfolio_ofObject:(User *)value;
- (void)removePortfolio_ofObject:(User *)value;
- (void)addPortfolio_of:(NSSet *)values;
- (void)removePortfolio_of:(NSSet *)values;

@end
