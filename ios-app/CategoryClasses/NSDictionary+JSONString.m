//
//  NSDictionary+JSONString.m
//  ComparisionAap
//
//  Created by Nguyen Minh Tu on 1/29/15.
//  Copyright (c) 2015 Tanveer Ashraf. All rights reserved.
//

#import "NSDictionary+JSONString.h"

@implementation NSDictionary(JSONString)

-(NSString*)jsonStringWithPrettyPrint:(BOOL) prettyPrint {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

+ (NSDictionary *)dictionaryFromJSONString:(NSString *)string {
    if (string != nil) {
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:data //1
                              options:NSJSONReadingAllowFragments
                              error:&error];
        return json;
    } else {
        return nil;
    }
}

@end
