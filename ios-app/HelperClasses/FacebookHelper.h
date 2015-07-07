//
//  FacebookHelper.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/17/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Facebook-iOS-SDK/FacebookSDK/FacebookSDK.h>
#import "CADebugLog.h"

@interface FacebookHelper : NSObject
#define FacebookUtil        [FacebookHelper sharedInstance]

// Callback block for FacebookHelper callback
typedef void(^FacebookHelperLoginCallback) (FBSession *session, FBSessionState state, NSError *error);
typedef void(^FacebookHelperGraphCallback) (FBRequestConnection *connection,
                                            NSDictionary<FBGraphUser> *user,
                                            NSError *error);

+ (FacebookHelper*) sharedInstance;
@property (nonatomic) id<FBGraphUser> user;
@property (nonatomic,strong) NSString* accessToken;

- (BOOL)isLoginWithFB;
- (void)loginFB:(FacebookHelperLoginCallback)callback;
- (void)requestUserGraph:(FacebookHelperGraphCallback)callback;
- (void)logoutFB;

@end
