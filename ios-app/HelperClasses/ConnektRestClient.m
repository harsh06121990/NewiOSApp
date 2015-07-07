//
//  NSObject+ConnektRestController.m
//  ios-app
//
//  Created by Deepak on 01/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ConnektRestClient.h"

@interface ConnektRestClient()

@end

@implementation ConnektRestClient

+(ConnektRestClient *) getInstance{
    static ConnektRestClient * singletonInstance;
    @synchronized(self){
        // If the instance if not initialized then initialize it
        if(singletonInstance == nil){
            // Setting base url based on the app identifier
            NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
            if([bundleIdentifier isEqualToString:@"com.connekt.ios-app"]){
                // Initializing session manager
                singletonInstance = [[ConnektRestClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://connekt-api-staging.herokuapp.com:443/v1"]];
            }
            
            // Starting monitoring of the internet connection
            [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        }
    }
    return singletonInstance;
}

-(void)setAuthorizationToken:(NSString *)token{
    // Setting Authorization Header
    [[self requestSerializer] setValue:token forHTTPHeaderField:@"Authorization"];
}

-(void) resetAuthorizationToken{
    // Resetting Authorization Header
    [[self requestSerializer] setValue:nil forHTTPHeaderField:@"Authorization"];
}

-(BOOL) sendRequest:(NSString *)path typeOfRequest:(RequestType)requestType payloadForRequest:(NSDictionary *) payload responseHandler:(ConnektRESTClientCallback) callback{
    // Switch case for network request
    switch (requestType) {
        case GET:{
            [self GET:path parameters:payload success:^(NSURLSessionDataTask *task, id responseObject) {
                callback(responseObject,true);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                callback(error,false);
            }];
            break;
        }
        case POST:{
            [self POST:path parameters:payload success:^(NSURLSessionDataTask *task, id responseObject) {
                callback(responseObject,true);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                callback(error,false);
            }];
            break;
        }
        case PUT:{
            [self PUT:path parameters:payload success:^(NSURLSessionDataTask *task, id responseObject) {
                callback(responseObject,true);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                callback(error,false);
            }];
            break;
        }
        case DELETE:{
            [self DELETE:path parameters:payload success:^(NSURLSessionDataTask *task, id responseObject) {
                callback(responseObject,true);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                callback(error,false);
            }];
            break;
        }
        default:
            break;
    }
    return TRUE;
}

-(BOOL) sendMultiPartRequest:(NSString *)path  payloadForRequest:(NSDictionary *) payload constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block  responseHandler:(ConnektRESTClientCallback) callback{
    [self POST:path parameters:payload constructingBodyWithBlock:block
       success:^(NSURLSessionDataTask *task, id responseObject) {
           callback(responseObject,true);
           
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           callback(nil,false);
       }];
    return TRUE;
}

-(BOOL) isNetworkReachable{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

@end
