//
//  AppDelegate.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/1/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "AppDelegate.h"
#import "FCUUID.h"
#import "ChatHelper.h"

@interface AppDelegate ()
@property (strong, nonatomic) NSString *deviceToken;
@property (strong, nonatomic) NSString *deviceUUID;
@end

@implementation AppDelegate
@synthesize deviceToken = _deviceToken, currentUser, currentViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Registering for remote notification
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [application registerForRemoteNotifications];
    }
    else
    {
        // iOS < 8 Notifications
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
    
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        
        [FacebookUtil loginFB:^(FBSession *session, FBSessionState state, NSError *error) {
            [FacebookUtil requestUserGraph:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                if (!error) {
                    [FacebookUtil setUser:user];
                }
            }];
        }];
        
    }
    
    // Generating UUID
    [self setDeviceUUID:[FCUUID uuidForDevice]];
    NSLog(@"The device UUID is: %@", self.deviceUUID);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    // Syncing chat messages
    [[ChatHelper getInstance] syncWithTheServer];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// Function for handling the notification token returned by the apple
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
    //Saving device token
    [self setDeviceToken:[[[NSString stringWithFormat:@"%@",deviceToken]
                           stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""]];
}

// Function handler when the user opt out for the push notification
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

// Function for receiving notifications
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    if([application applicationState] == UIApplicationStateActive){
        // Synchronizing with the server
        [[ChatHelper getInstance] syncWithTheServer];
    }else{
        // We will synchronize when the state of the application will become active.
        //self.needToSync = TRUE;
    }
    application.applicationIconBadgeNumber = 0;
}

@end
