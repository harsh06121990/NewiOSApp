//
//  CADebugLog.h
//  ComparisionAap
//
//  Created by Nguyen minh Tuan on 10/4/14.
//  Copyright (c) 2014 Tanveer Ashraf. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#   define CADLog(fmt, ...) NSLog((@"[DEBUG] %s %s [Line %d] " fmt), __FILE__, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...) ;
#endif

// ALog always displays output regardless of the DEBUG setting
#define CAALog(fmt, ...) NSLog((@"%s %s [Line %d] " fmt), __FILE__, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

@interface CADebugLog : NSObject

+ (void)CADebugLog:(NSString*)content;

@end
