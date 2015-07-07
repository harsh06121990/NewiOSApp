//
//  User.h
//  ios-app
//
//  Created by Deepak on 10/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSSet *portfolios;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addPortfoliosObject:(NSManagedObject *)value;
- (void)removePortfoliosObject:(NSManagedObject *)value;
- (void)addPortfolios:(NSSet *)values;
- (void)removePortfolios:(NSSet *)values;

@end
