//
//  SignupModel.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/24/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignupModel : NSObject

+ (SignupModel *)sharedInstance;

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSDate *dob;
@property (nonatomic, strong) NSString *introduction;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *skill;

@end
