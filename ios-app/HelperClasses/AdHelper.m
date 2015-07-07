//
//  NSArray+AdHelper.m
//  ios-app
//
//  Created by Deepak on 20/03/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "AdHelper.h"
#import "ConnektRestClient.h"

typedef void(^AdHelperCallback) (bool success, id result);
@implementation AdHelper

#pragma mark - public functions
+(AdHelper *) getInstance{
    static AdHelper * singletonInstance;
    @synchronized(self){
        if(!singletonInstance){
            // Initializing singleton Instance
            singletonInstance = [[AdHelper alloc] init];
        }
        // Returning singletonInstance
        return singletonInstance;
    }
}


-(void) getAdsFromServer: (NSNumber *) pageNo callbackHandler:(AdHelperCallback) callback{
    NSString *url = [NSString stringWithFormat:@"page/feed/%@/", pageNo];
    [[ConnektRestClient getInstance] sendRequest:url typeOfRequest:GET payloadForRequest:nil responseHandler:^(id response, bool success) {
        //Event bookmarked on the server
        if(success){
            callback(true, response);
        }
        else{
            callback(false, nil);
        }
    }];
}
@end
