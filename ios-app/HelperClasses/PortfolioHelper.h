//
//  NSObject+PortfolioHelper.h
//  ios-app
//
//  Created by Deepak on 09/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataCommonHelper.h"

// Callback block for Portfolio callback
typedef void(^PortfolioHelperCallback) (bool success, id result);

@interface PortfolioHelper: CoreDataCommonHelper

#define PortfolioUtil       [PortfolioHelper getInstance]

//Function for accessing static instance of Portfolio class
+(PortfolioHelper *) getInstance;

// Function for syncing portfolio with the server
-(void) syncWithTheServer:(PortfolioHelperCallback) callback;

// Function for uploading a new portfolio
-(void) addPortfolio:(NSString *)description imageOfThePortfolio:(NSData *)imageData callback:(PortfolioHelperCallback) callback;

// Function to get user portfolios
- (void)getPortfolioForUser:(NSString *)userID callback:(PortfolioHelperCallback)callback;

// Function to get the image url
- (NSString *)getPortfolioUrl:(NSString *)userID media:(NSString *)mediaID;
@end
