//
//  NSObject+ConnektRestController.h
//  ios-app
//
//  Created by Deepak on 01/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

typedef void(^ConnektRESTClientCallback)(id response,bool success);

typedef enum {
    GET,
    POST,
    DELETE,
    PUT
} RequestType;

@interface ConnektRestClient: AFHTTPSessionManager
// Function for referencing singleton instance
+(ConnektRestClient *)getInstance;

//Function used for setting the Authorization token
-(void)setAuthorizationToken:(NSString *)token;

// Function for resetting Authorization token
-(void) resetAuthorizationToken;

// Function for sending request to the server
-(BOOL) sendRequest:(NSString *)path typeOfRequest:(RequestType)requestType payloadForRequest:(NSDictionary *) payload responseHandler:(ConnektRESTClientCallback) callback;

// Function to check if the Internet is available or not
-(BOOL) isNetworkReachable;

// Function for sending multipart request to the server
-(BOOL) sendMultiPartRequest:(NSString *)path  payloadForRequest:(NSDictionary *) payload constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block  responseHandler:(ConnektRESTClientCallback) callback;

@end