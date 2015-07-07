//
//  NSObject+SearchHelper.m
//  ios-app
//
//  Created by Deepak on 09/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "SearchHelper.h"
#import "ConnektRestClient.h"
#import "ConnectHelper.h"

@implementation SearchHelper

+(SearchHelper *) getInstance{
    static SearchHelper * singletonInstance;
    @synchronized(self){
        if(!singletonInstance){
            // Initializing singleton Instance
            singletonInstance = [[SearchHelper alloc] init];
        }
        // Returning singletonInstance
        return singletonInstance;
    }
}

-(BOOL) searchUsers:(NSString *)type searchQuery:(NSString *)query searchInsideEduction:(BOOL)education searchInsideUsername:(BOOL)username searchInsideProficieny:(BOOL)proficiency searchInsideSkill:(BOOL)skill searchInsidePortfolio:(BOOL)portfolio filterByCity:(NSString *)city filterByCountry:(NSString *)country filterByAgeLessThan:(NSNumber *)ageLT filterByAgeGreaterThan:(NSNumber *) ageGT callback:(SearchHelperCallback) callback{
    
    // Type is a mandatory parameters
    if (!type) {
        return false;
    }
    
    NSMutableDictionary *request_parameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                    type,@"type",
                                                    query, @"query" ,
                                                    education ? @"True" : @"False", @"education",
                                                    username ? @"True" : @"False", @"username",
                                                    proficiency ? @"True" : @"False", @"proficiency",
                                                    skill ? @"True" : @"False", @"skill",
                                                    portfolio ? @"True" : @"False", @"portfolio",
                                                    city, @"city",
                                                    country, @"country",
                                                    ageLT, @"ageLT",
                                                    ageGT, @"ageGT",
                                                    nil];
    [request_parameters setObject:ageLT forKey:@"ageLT"];
    [request_parameters setObject:ageGT forKey:@"ageGT"];
    [request_parameters setObject:@"False" forKey:@"introduction"];
    // Removing all the null or nil values from the dictionary
    [request_parameters removeObjectForKey:[request_parameters allKeysForObject:[NSNull null]]];
    
    //Sending request to the server
    [[ConnektRestClient getInstance] sendRequest:@"search/" typeOfRequest:GET payloadForRequest:request_parameters responseHandler:^(id response, bool success) {
        if (success) {
            
            // Got response from the server. Filtering results
            NSArray *filteredArray = [response objectsAtIndexes:[response indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                // Filtering array and removing all the objects which we don't have to display
                return ![[[ConnectHelper getInstance] usersNotToBeDisplayInSearchResults] containsObject:[[obj objectForKey:@"doc"] objectForKey:@"user_id"]];
            }]];
            callback(true, filteredArray);
        }
        else{
            // Server retuned an error
            callback(false, response);
        }
    }];
    return true;
}

@end

