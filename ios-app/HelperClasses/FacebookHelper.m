//
//  FacebookHelper.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/17/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "FacebookHelper.h"

@implementation FacebookHelper

+(FacebookHelper *)sharedInstance
{
    static FacebookHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FacebookHelper alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

-(FacebookHelper *)init
{
    if ((self = [super init])) {
        // Init
    }
    return self;
}

- (BOOL)isLoginWithFB {
    return (([FacebookHelper sharedInstance].user != nil) && (FBSession.activeSession.state == FBSessionStateOpen
                                   || FBSession.activeSession.state == FBSessionStateOpenTokenExtended
                                   || FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded));
}

- (void)loginFB:(FacebookHelperLoginCallback)callback {
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended
        || FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]
                                           allowLoginUI:NO
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             if (!error && state == FBSessionStateOpen){
                 CADLog(@"Session opened");
                 
                 NSString* accessToken = [session accessTokenData].accessToken;
                 [FacebookHelper sharedInstance].accessToken = accessToken;
             }
             callback(session, state, error);
         }];
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for public_profile permissions when opening a session
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             if (!error && state == FBSessionStateOpen){
                 CADLog(@"Session opened");
                 
                 NSString* accessToken = [session accessTokenData].accessToken;
                 [FacebookHelper sharedInstance].accessToken = accessToken;
             }
             callback(session, state, error);
         }];
    }
}

- (void)logoutFB {
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
    }
}

- (void)requestUserGraph:(FacebookHelperGraphCallback)callback {
    [[FBRequest requestForMe] startWithCompletionHandler:
     ^(FBRequestConnection *connection,
       NSDictionary<FBGraphUser> *user,
       NSError *error) {
         callback(connection, user, error);
     }];
}

@end
