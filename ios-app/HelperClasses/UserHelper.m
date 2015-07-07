//
//  NSObject+UserHelper.m
//  ios-app
//
//  Created by Deepak on 04/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "UserHelper.h"
#import "ConnektRestClient.h"
#import "AppDelegate.h"

@interface UserHelper()
// Varibale which store the information of the user
@property (nonatomic)  UserPersonalModel *userPersonalInformation;
// Function for registering device
-(void) registerDevice;
@end

@implementation UserHelper
@synthesize userPersonalInformation =_userPersonalInformation;

// Accessor Function for userPersonalInformation variable with createIfNotExists variable so that we can create a new variable if it does not exists. Parameter: createIfNotExists - Whether to create a new entry if it does not exists
-(UserPersonalModel *) userPersonalInformation: (BOOL) createIfNotExists{
    // If the variable is nil
    if (!_userPersonalInformation) {
        // Getting user personal data from the core data
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription * entity = [NSEntityDescription entityForName:@"UserPersonalModel" inManagedObjectContext:[self managedObjectContext]];
        [fetchRequest setEntity:entity];
        NSError *error;
        NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        if([result count] > 0){
            // If the count is greater than zero then user information is present
            _userPersonalInformation = [result objectAtIndex:0];
        }
        else{
            // If user has requested to create a new object
            if(createIfNotExists == YES){
                UserPersonalModel *temp = [NSEntityDescription insertNewObjectForEntityForName:@"UserPersonalModel" inManagedObjectContext:[self managedObjectContext]];
                _userPersonalInformation = temp;
            }
        }
    }
    return _userPersonalInformation;
}
// Accessor Function for userPersonalInformation variable
-(UserPersonalModel *) userPersonalInformation{
    return [self userPersonalInformation:NO];
}

// Function for accessing the singleton instance
+(UserHelper *) getInstance{
    static UserHelper *singletonInstance;
    @synchronized(self){
        if (!singletonInstance) {
            singletonInstance = [[UserHelper alloc] init];
        }
        return singletonInstance;
    }
}

-(void) login:(NSString *) userName password: (NSString *) password callback:(UserHelperCallback) callback{
    // Sending request to the server in order to login the username
    [[ConnektRestClient getInstance] sendRequest:@"user/login/" typeOfRequest:POST payloadForRequest:@{@"userName" : userName, @"password" : password} responseHandler:^(id response, bool success) {
        if (success) {
            // Creating a new entry in core data for the user
            UserPersonalModel *temp = [self userPersonalInformation:YES];
            [temp setAuthToken:[response objectForKey:@"auth_token"]];
            [temp setUserID:[NSNumber numberWithInteger:[[response objectForKey:@"user_id"] integerValue] ]];
            // Saving data in core data
            [self save];
            // Cross checking if everything is ok or not
            [self checkIfUserIsLoggedIn];
            //Registering Device
            //[self registerDevice];
            // Correct username and password
            callback(true, response);
        }
        else{
            // Wrong username or password
            callback(false, response);
        }
    }];
}

-(void) loginUsingFacebook:(NSString *)facebookID facebookAccessToken:(NSString *)access_token callback:(UserHelperCallback) callback{
    // Sending request to the server in order to login the username
    [[ConnektRestClient getInstance] sendRequest:@"user/login/" typeOfRequest:POST payloadForRequest:@{@"accessToken" : access_token, @"fbId" : facebookID} responseHandler:^(NSDictionary *response, bool success) {
        if (success) {
            // Creating a new entry in core data for the user
            UserPersonalModel *temp = [self userPersonalInformation:YES];
            [temp setAuthToken:[response objectForKey:@"auth_token"]];
            [temp setUserID:[NSNumber numberWithInteger:[[response objectForKey:@"user_id"] integerValue] ]];
            // Saving data inside core data
            [self save];
            // Cross checking if everything is ok or not
            [self checkIfUserIsLoggedIn];
            //Registering Device
            [self registerDevice:callback];
            // Correct username and password
            //callback(true, response);
        }
        else{
            // Wrong username or password
            callback(false, response);
        }
    }];
}

-(void) signUp:(NSString *)userName passwordOfUser:(NSString *)password emailOfuser:(NSString*)email userDateOfBirth:(NSDate *) dateOfBirth introductionOfUser:(NSString *)introduction userType:(NSString *)type skillsOfuser:(NSString *)skill callback:(UserHelperCallback) callback {
    // Formating date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDictionary *request_data = @{@"userName":userName, @"password":password, @"email":email, @"dateOfBirth":[formatter stringFromDate:dateOfBirth], @"introduction":introduction, @"type":type, @"skill":skill};
    
    [[ConnektRestClient getInstance] sendRequest:@"user/signup/" typeOfRequest:POST payloadForRequest:request_data responseHandler:^(id response, bool success) {
        if (success) {
            // User is able to signup
            callback(true, response);
        }
        else{
            // User is unable to signup
            callback(false, response);
        }
    }];
}

-(void) signUpUsingFacebook:(NSString *)userName passwordOfUser:(NSString *)password emailOfuser:(NSString*)email userDateOfBirth:(NSDate *) dateOfBirth introductionOfUser:(NSString *)introduction userType:(NSString *)type skillsOfuser:(NSString *)skill userFacebookID:(NSString *)facebookID userFacebookAccessToken:(NSString *)facebookToken callback:(UserHelperCallback) callback {
    
    NSDictionary *request_data = @{@"UserName":userName, @"password":password, @"email":email, @"dateOfBirth":dateOfBirth, @"introduction":introduction, @"type":type, @"skill":skill, @"fbId":facebookID, @"accessToken": facebookToken};
    
    [[ConnektRestClient getInstance] sendRequest:@"user/signup/facebook/" typeOfRequest:POST payloadForRequest:request_data responseHandler:^(id response, bool success) {
        if (success) {
            // User is able to signup
            callback(true, response);
        }
        else{
            // User is unable to signup
            callback(false, response);
        }
    }];
}


-(UserPersonalModel *) getUserOwnDetail{
    return [self userPersonalInformation];
}

-(void) getUsersDetail: (NSArray *) userID  callback:(UserHelperCallback) callback{
    NSString *url = [@"user/info/?users=" stringByAppendingString:[userID componentsJoinedByString:@","]];
    [[ConnektRestClient getInstance] sendRequest:url typeOfRequest:GET payloadForRequest:nil responseHandler:^(id response, bool success) {
        if (success) {
            //
            callback(true, response);
        }
        else{
            // Unable to get details fo the users
            callback(false, response);
        }
    }];
}

-(BOOL) checkIfUserIsLoggedIn{
    if (![self userPersonalInformation]) {
        return NO;
    }
    else{
        // Setting authorization token
        [[ConnektRestClient getInstance] setAuthorizationToken:[[self userPersonalInformation] authToken]];
        return TRUE;
    }
}

-(void) updateUserProfile:(NSString *) education proficiencyOfUser:(NSString *)proficiency userDateOfBirth:(NSDate *) dateOfBirth introductionOfUser:(NSString *)introduction userType:(NSString *)type skillsOfuser:(NSString *)skill userCity:(NSString *)city userCountry:(NSString *) country callback:(UserHelperCallback) callback{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyy"];
    
    NSString *dob = [formatter stringFromDate:dateOfBirth];
    NSDictionary *request_data = @{@"education":education, @"proficiency":proficiency, @"dateOfBirth":dob, @"introduction":introduction, @"type":type, @"skill":skill, @"city":city, @"country":country};
    
    [[ConnektRestClient getInstance] sendRequest:@"user/" typeOfRequest:PUT payloadForRequest:request_data responseHandler:^(id response, bool success) {
        if (success) {
            // We are able to update the user profile
            callback(true, response);
            
            //Updating user profile in core data
            [[self userPersonalInformation]  setEducation:education];
            [[self userPersonalInformation] setProficiency:proficiency];
            [[self userPersonalInformation] setDateOfBirth:dateOfBirth];
            [[self userPersonalInformation] setIntroduction:introduction];
            [[self userPersonalInformation] setSkill:skill];
            [[self userPersonalInformation] setCity:city];
            [[self userPersonalInformation] setCountry:country];
            [[self userPersonalInformation] setUserType:type];
            // Saving data
            [self save];
        }
        else{
            // We are not able to update the user profile
            callback(false, response);
        }
    }];
}

-(void)logout{
    // Setting reference of personal information as null
    [self setUserPersonalInformation:nil];
    // Deleting the entire database from the memory
    [self deleteDatabase];
}

-(BOOL)checkUserLoggedInStatus{
    // If we already have a user stored in the database
    if(![self userPersonalInformation]){
        // Setting rest authorization token for the user
        [[ConnektRestClient getInstance] setAuthorizationToken:[[self userPersonalInformation] authToken]];
        return TRUE;
    }
    else{
        // No user is logged in
        return FALSE;
    }
}

-(NSString *)getProfileImageUrl:(NSString *)userID {
    NSString* imagePath = [NSString stringWithFormat:@"%@%@%@",@"http://dev.connektapp.com/media/user/user_",userID,@".jpg"];
    return imagePath;
}

-(BOOL) upsertuser:(NSNumber *)userID userName:(NSString *)userName{
    //Checking if the core data already exists or not
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"userID=%@",userID];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = predicate;
    NSArray * users = [[self managedObjectContext] executeFetchRequest:request error:nil];
    User *temp;
    if([users count] > 0){
        // User already present in the database just update it
        temp = [users objectAtIndex:0];
    }
    else{
        //Insert user record in the database
        temp = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:[self managedObjectContext]];
    }
    //Updating values
    [temp setUserID:userID];
    [temp setUserName:userName];
    //Saving data inside core data
    [self save];
    return true;
    
}

-(User*) getUserInfromation:(NSNumber *)userID{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"userID=%@",userID];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = predicate;
    NSArray * users = [[self managedObjectContext] executeFetchRequest:request error:nil];
    if([users count] > 0){
        // Found user
        return [users objectAtIndex:0];
    }
    else{
        return nil;
    }
}

#pragma mark - private functions

/*
    Private function for registering the device
 */
-(void) registerDevice: (UserHelperCallback) callback{
    AppDelegate *app_delegate_instance = [[UIApplication sharedApplication] delegate];
    [[ConnektRestClient getInstance] sendRequest:@"device/"
                                   typeOfRequest:POST
                               payloadForRequest:@{
                                                   @"deviceType" : @"ios",
                                                   @"deviceUDID": [app_delegate_instance deviceUUID],
                                                   @"token" : [app_delegate_instance deviceToken]
                                                   }
                                 responseHandler:^(id response, bool success) {
                                     if (success) {
                                         callback(YES, response);
                                     } else {
                                         NSLog(@"Fail register device");
                                         callback(NO, response);
                                     }
    }];
}

- (void)retrievePersonalInfo:(UserHelperCallback)callback {
    [UserUtil getUsersDetail:[NSArray arrayWithObject:[UserUtil userPersonalInformation].userID] callback:^(bool success, id result) {
        if (success) {
            NSArray *response = (NSArray *)result;
            NSDictionary *userData = [response objectAtIndex:0];
            
            if ([userData objectForKey:@"skill"] != nil && ![[userData objectForKey:@"skill"] isEqual:[NSNull null]]) {
                [[UserUtil userPersonalInformation] setSkill:[userData objectForKey:@"skill"]];
            } else {
                [[UserUtil userPersonalInformation] setSkill:[userData objectForKey:@""]];
            }
            
            if ([userData objectForKey:@"date_of_birth"] != nil && ![[userData objectForKey:@"date_of_birth"] isEqual:[NSNull null]]) {
                [[UserUtil userPersonalInformation] setDateOfBirth:[AppUtil dateFromUTCFormat:[userData objectForKey:@"date_of_birth"]]];
            } else {
                [[UserUtil userPersonalInformation] setDateOfBirth:nil];
            }
            
            if ([userData objectForKey:@"introduction"] != nil && ![[userData objectForKey:@"introduction"] isEqual:[NSNull null]]) {
                [[UserUtil userPersonalInformation] setIntroduction:[userData objectForKey:@"introduction"]];
            } else {
                [[UserUtil userPersonalInformation] setIntroduction:[userData objectForKey:@""]];
            }
            
            if ([userData objectForKey:@"education"] != nil && ![[userData objectForKey:@"education"] isEqual:[NSNull null]]) {
                [[UserUtil userPersonalInformation] setEducation:[userData objectForKey:@"education"]];
            } else {
                [[UserUtil userPersonalInformation] setEducation:[userData objectForKey:@""]];
            }
            
            if ([userData objectForKey:@"email"] != nil && ![[userData objectForKey:@"email"] isEqual:[NSNull null]]) {
                [[UserUtil userPersonalInformation] setEmail:[userData objectForKey:@"email"]];
            } else {
                [[UserUtil userPersonalInformation] setEmail:[userData objectForKey:@""]];
            }
            
            if ([userData objectForKey:@"type"] != nil && ![[userData objectForKey:@"type"] isEqual:[NSNull null]]) {
                [[UserUtil userPersonalInformation] setUserType:[userData objectForKey:@"type"]];
            } else {
                [[UserUtil userPersonalInformation] setUserType:[userData objectForKey:@""]];
            }
            
            if ([userData objectForKey:@"proficiency"] != nil && ![[userData objectForKey:@"proficiency"] isEqual:[NSNull null]]) {
                [[UserUtil userPersonalInformation] setProficiency:[userData objectForKey:@"proficiency"]];
            } else {
                [[UserUtil userPersonalInformation] setProficiency:[userData objectForKey:@""]];
            }
            
            if ([userData objectForKey:@"user_name"] != nil && ![[userData objectForKey:@"user_name"] isEqual:[NSNull null]]) {
                [[UserUtil userPersonalInformation] setUserName:[userData objectForKey:@"user_name"]];
            } else {
                [[UserUtil userPersonalInformation] setUserName:[userData objectForKey:@""]];
            }
            
            if ([userData objectForKey:@"user_name"] != nil && ![[userData objectForKey:@"user_name"] isEqual:[NSNull null]]) {
                NSString *userID = [userData objectForKey:@"user_id"];
                [[UserUtil userPersonalInformation] setUserID:[NSNumber numberWithInt: [userID intValue]]];
            } else {
                [[UserUtil userPersonalInformation] setUserID:0];
            }
            
        }
        
        callback(success, result);
    }];
}

@end
