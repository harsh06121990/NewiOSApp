//
//  NSObject+UserHelper.h
//  ios-app
//
//  Created by Deepak on 04/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "CoreDataCommonHelper.h"
#import <Foundation/Foundation.h>
#import "UserPersonalModel.h"
#import "User.h"
#import "Utility.h"

// Callback block for UserHelper callback
typedef void(^UserHelperCallback) (bool success, id result);

@interface UserHelper: CoreDataCommonHelper

#define UserUtil        [UserHelper getInstance]

// Variable which stores the information of the current user. It is readonly
@property (nonatomic, readonly)  UserPersonalModel *userPersonalInformation;

// Function for accessing the singleton instance of this helper class
+(UserHelper *) getInstance;

// Function for login in a user
-(void) login:(NSString *) userName password: (NSString *) password callback:(UserHelperCallback) callback;

// Function for logging as a facebook user
-(void) loginUsingFacebook:(NSString *)facebookID facebookAccessToken:(NSString *)access_token callback:(UserHelperCallback) callback;

// Function for signing up a user
-(void) signUp:(NSString *)userName passwordOfUser:(NSString *)password emailOfuser:(NSString*)email userDateOfBirth:(NSDate *) dateOfBirth introductionOfUser:(NSString *)introduction userType:(NSString *)type skillsOfuser:(NSString *)skill callback:(UserHelperCallback) callback;

// Function for signing up using Facebook
-(void) signUpUsingFacebook:(NSString *)userName passwordOfUser:(NSString *)password emailOfuser:(NSString*)email userDateOfBirth:(NSDate *) dateOfBirth introductionOfUser:(NSString *)introduction userType:(NSString *)type skillsOfuser:(NSString *)skill userFacebookID:(NSString *)facebookID userFacebookAccessToken:(NSString *)facebookToken callback:(UserHelperCallback) callback;

// Function for getting details of other users
-(void) getUsersDetail: (NSArray *) userID  callback:(UserHelperCallback) callback;

//Function for checking if a user is logged in or not and if he is logged in then it will initialize the rest client with correct paramater
-(BOOL) checkIfUserIsLoggedIn;

// Function for updating the user profile
-(void) updateUserProfile:(NSString *) education proficiencyOfUser:(NSString *)proficiency userDateOfBirth:(NSDate *) dateOfBirth introductionOfUser:(NSString *)introduction userType:(NSString *)type skillsOfuser:(NSString *)skill userCity:(NSString *)city userCountry:(NSString *) country callback:(UserHelperCallback) callback;

//Function for checking whether a user is logged in or not
-(BOOL)checkUserLoggedInStatus;

// Function for logging out the user
-(void)logout;

// Function for get user profile pic url
-(NSString *)getProfileImageUrl:(NSString *)userID;

// For upserting user information
-(BOOL) upsertuser:(NSNumber *)userID userName:(NSString *)userName;

// For getting user information
-(User*) getUserInfromation:(NSNumber *)userID;

- (void)retrievePersonalInfo:(UserHelperCallback)callback;

@end





