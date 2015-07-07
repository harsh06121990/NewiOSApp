//
//  NSObject+CodeDataHelper.m
//  ios-app
//
//  Created by Deepak on 04/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "CoreDataCommonHelper.h"
#import "ConnektModel.h"
#import "ISO8601DateFormatter.h"

@interface CoreDataCommonHelper()
// Private managed object context
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) ISO8601DateFormatter *dateFormater;
@end

@implementation CoreDataCommonHelper
@synthesize managedObjectContext = _managedObjectContext;
@synthesize dateFormater = _dateFormater;

-(NSManagedObjectContext *) managedObjectContext{
    if (!_managedObjectContext) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        // Setting parent of private managed object context
        [_managedObjectContext setParentContext:[[ConnektModel getInstance] managedObjectContext]];
    }
    return _managedObjectContext;
}

-(ISO8601DateFormatter *) dateFormater{
    if(!_dateFormater){
        _dateFormater = [[ISO8601DateFormatter alloc] init];
    }
    return _dateFormater;
}

// Function used for saving the data using the private managed object context
-(BOOL) save{
    if([[self managedObjectContext] hasChanges]){
        NSError *error = nil;
        [[self managedObjectContext] save:&error];
        //TODO I don't know why I have to call the parent object context in order to write it to the core data
        [[[ConnektModel getInstance] managedObjectContext] save:&error];
        return true;
    }
    // We have no changes
    return FALSE;
}

-(void) deleteDatabase{
    // Deleting the database
    [[ConnektModel getInstance] deleteDatabase];
}

-(NSDate *) dateFromStandardISOString:(NSString *)dateString{
    return [[self dateFormater] dateFromString:dateString];
}
@end
