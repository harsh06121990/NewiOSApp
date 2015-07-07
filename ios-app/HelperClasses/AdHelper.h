//
//  NSArray+AdHelper.h
//  ios-app
//
//  Created by Deepak on 20/03/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataCommonHelper.h"

typedef void(^AdHelperCallback) (bool success, id result);

@interface AdHelper: CoreDataCommonHelper

// Static function for accessing singleton instance of AdHelper class
+(AdHelper *) getInstance;

//Function for fetching ads from the server
-(void) getAdsFromServer: (NSNumber *) pageNo callbackHandler:(AdHelperCallback) callback;

@end
