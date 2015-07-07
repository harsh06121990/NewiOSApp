//
//  DateUtility.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/3/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YLMoment/YLMoment.h>

@interface DateUtility : NSObject

#define DateUtil         [DateUtility sharedInstance]

#pragma mark Singleton
+ (DateUtility *)sharedInstance;

#pragma mark Custom-Methods
- (NSString *)getDateDuration:(NSDate *)date;   // "1 hour ago; 2 days ago..."
- (NSString *)getFormattedString:(NSDate *)date;
- (NSDate *)getDateFromString:(NSString *)dateString;
@end
