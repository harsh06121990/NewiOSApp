//
//  NSObject+SearchHelper.h
//  ios-app
//
//  Created by Deepak on 09/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <Foundation/Foundation.h>

// Callback block for SearchHelper callback
typedef void(^SearchHelperCallback) (bool success, id result);

@interface SearchHelper : NSObject

#define SearchUtil = [SearchHelper getInstance]

// Static function for accessing singleton instance of SearchHelper class
+(SearchHelper *) getInstance;

/*
    Function for sending search request to the server
    Parameters:
        1. type paramater is mandotary 
        2. For query and filters you can pass nil if you don't want to use them
        3. For other paramaters you can simply pass false if you don't want to use it
 
 */
-(BOOL) searchUsers:(NSString *)type searchQuery:(NSString *)query searchInsideEduction:(BOOL)education searchInsideUsername:(BOOL)username searchInsideProficieny:(BOOL)proficiency searchInsideSkill:(BOOL)skill searchInsidePortfolio:(BOOL)portfolio filterByCity:(NSString *)city filterByCountry:(NSString *)country filterByAgeLessThan:(NSNumber *)ageLT filterByAgeGreaterThan:(NSNumber *) ageGT callback:(SearchHelperCallback) callback;

@end
