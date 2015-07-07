//
//  DateUtility.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/3/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "DateUtility.h"

@implementation DateUtility

+(DateUtility *)sharedInstance
{
    static DateUtility *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DateUtility alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

-(DateUtility *)init
{
    if ((self = [super init])) {
        // Init
    }
    return self;
}

#pragma mark Custom-Methods
- (NSString *)getDateDuration:(NSDate *)date{
    NSString *formatedDate;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.locale = posix;
    
    // Convert to GMT time zone
    NSDate *postDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:date]];
    
    // Get current moment from GMT time zone
    NSDate *now = [NSDate date];
    now = [dateFormatter dateFromString:[dateFormatter stringFromDate:now]];
    
    // YLMoment from cocoapod: Please run pod install in case you don't have one!
    YLMoment *moment = [YLMoment momentWithDate:postDate];
    YLMoment *nowMoment = [YLMoment momentWithDate:now];
    
    formatedDate = [moment fromMoment:nowMoment];
    return formatedDate;
}

- (NSString *)getFormattedString:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // ...using a date format corresponding to your date
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    // Parse the representation of the date
    NSString *convertedDateString = [dateFormatter stringFromDate:date];
    
    // NSDate *convertedDate = [dateFormatter dateFromString:convertedDateString];
    // Write the date back out using the same format
    return convertedDateString;
}

- (NSDate *)getDateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // ...using a date format corresponding to your date
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    // Parse the string representation of the date
    NSDate *convertedDate = [dateFormatter dateFromString:dateString];
    
    // Write the date back out using the same format
    return convertedDate;
}

@end
