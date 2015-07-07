//
//  SignupModel.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/24/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "SignupModel.h"

@implementation SignupModel
@synthesize username, password, email, dob, introduction, type, skill;

+(SignupModel *)sharedInstance
{
    static SignupModel *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SignupModel alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

-(SignupModel *)init
{
    if ((self = [super init])) {
        // Init
    }
    return self;
}

@end
