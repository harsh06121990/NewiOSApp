//
//  EditProfileModel.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/26/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditProfileModel : NSObject

+ (EditProfileModel *)sharedInstance;

@property (nonatomic, strong) NSDictionary *education;
@property (nonatomic, strong) NSString *skill;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *experience;
@property (nonatomic, strong) NSString *links;

@end
