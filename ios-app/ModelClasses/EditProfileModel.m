//
//  EditProfileModel.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/26/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "EditProfileModel.h"

@implementation EditProfileModel
@synthesize education, skill, experience, intro, country, city, links;

+(EditProfileModel *)sharedInstance
{
    static EditProfileModel *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EditProfileModel alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

-(EditProfileModel *)init
{
    if ((self = [super init])) {
        // Init
    }
    return self;
}

@end
