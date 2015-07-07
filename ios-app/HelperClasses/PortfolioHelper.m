//
//  NSObject+PortfolioHelper.m
//  ios-app
//
//  Created by Deepak on 09/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "PortfolioHelper.h"
#import "ConnektRestClient.h"
#import "UserHelper.h"
#import "Portfolio.h"

@interface PortfolioHelper()

// Function for upserting portfolio information
-(BOOL) upsertPortfolio:(NSNumber *)portfolioID mediaIdOfPortfolio:(NSString *)mediaId descriptionOfPortfolio:(NSString *)description dateOfPortfolio:(NSDate *)date;
@end

@implementation PortfolioHelper

/*
    Static function for accessing the singleton pattern of this class
 */
+(PortfolioHelper *) getInstance{
    static PortfolioHelper *singletonInstance;
    @synchronized(self){
        if(!singletonInstance){
            singletonInstance = [[PortfolioHelper alloc] init];
        }
        return singletonInstance;
    }
}

-(BOOL) upsertPortfolio:(NSNumber *)portfolioID mediaIdOfPortfolio:(NSString *)mediaId descriptionOfPortfolio:(NSString *)description dateOfPortfolio:(NSDate *)date{
    //Checking if the core data already exists or not
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"portfolioID=%d",portfolioID];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Portfolio"];
    request.predicate = predicate;
    NSArray * portfolios = [[self managedObjectContext] executeFetchRequest:request error:nil];
    Portfolio *temp;
    if([portfolios count] > 0){
        // Portfolio is already present in the database just update it
        temp = [portfolios objectAtIndex:0];
    }
    else{
        //Insert portfolio record in the database
        temp = [NSEntityDescription insertNewObjectForEntityForName:@"Portfolio" inManagedObjectContext:[self managedObjectContext]];
    }
    //Updating values
    [temp setPortfolioID:portfolioID];
    [temp setMediaID:mediaId];
    [temp setPortfolioDescription:description];
    [temp setCreated_on:date];
    //Saving data inside core data
    [self save];
    return true;
}

/*
    Function for pulling portfolio data form the server and saving in the core data
 */
-(void) syncWithTheServer:(PortfolioHelperCallback) callback{
    NSString *url = [@"portfolio/" stringByAppendingFormat:@"%@/", [[[UserHelper getInstance] userPersonalInformation] userID]];
    // Getting users own portfolio
    [[ConnektRestClient getInstance] sendRequest:url typeOfRequest:GET payloadForRequest:nil responseHandler:^(id response, bool success) {
        // We are able to successfully pull all the data from the server
        if(success){
            //Marking it's type from id to NSArray
            response = (NSArray *) response;
            for(id object in response){
                //Saving objects in the database
                [ self upsertPortfolio:[NSNumber numberWithInteger:[[object objectForKey:@"portfolio_id"] integerValue] ]
                   mediaIdOfPortfolio: [object objectForKey:@"portfolio_media_id"]
                   descriptionOfPortfolio: [object objectForKey:@"portfolio_description"]
                   dateOfPortfolio: [self dateFromStandardISOString:[object objectForKey:@"created_on"]]
                 ];
            }
            callback(success, response);
        }
        else{
            callback(success, response);
        }
    }];
}


/*
 Function for adding a portfolio
 */
-(void) addPortfolio:(NSString *)description imageOfThePortfolio:(NSData *)imageData callback:(PortfolioHelperCallback) callback{
    //Sending multipart request to the server
    [[ConnektRestClient getInstance] sendMultiPartRequest:@"portfolio/" payloadForRequest:@{@"description": description} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // Appending image data in the request
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"image.png" mimeType:@"image/png"];
    } responseHandler:^(id response, bool success) {
        if(success){
            //Saving information in the core data
            [self upsertPortfolio:[NSNumber numberWithInteger:[[response objectForKey:@"portfolio_id"] integerValue] ] mediaIdOfPortfolio:[response objectForKey:@"portfolio_media_id"]
                descriptionOfPortfolio:description
                dateOfPortfolio:[self dateFromStandardISOString:[response objectForKey:@"created_on"]]
             ];
            callback(success, response);
        }
        else{
            callback(success, response);
        }

    }];
}

/*
 Function to get user portfolios
 */
- (void)getPortfolioForUser:(NSString *)userID callback:(PortfolioHelperCallback)callback {
    NSString *url = [NSString stringWithFormat:@"/portfolio/%@", userID];
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

- (NSString *)getPortfolioUrl:(NSString *)userID media:(NSString *)mediaID {
    NSString* imagePath = [NSString stringWithFormat:@"http://dev.connektapp.com/media/portfolio/%@_%@.png",userID, mediaID];
    return imagePath;
}
@end
