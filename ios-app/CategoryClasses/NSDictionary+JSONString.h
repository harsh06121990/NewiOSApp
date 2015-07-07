//
//  NSDictionary+JSONString.h
//  ComparisionAap
//
//  Created by Nguyen Minh Tu on 1/29/15.
//  Copyright (c) 2015 Tanveer Ashraf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(JSONString)

- (NSString*) jsonStringWithPrettyPrint:(BOOL) prettyPrint;
+ (NSDictionary *)dictionaryFromJSONString:(NSString *)string;

@end
