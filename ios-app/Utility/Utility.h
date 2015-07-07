//
//  Utility.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/5/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Constants.h"
@interface Utility : NSObject

#define AppUtil         [Utility sharedInstance]

#pragma mark Singleton
+ (Utility *)sharedInstance;

#pragma mark Custom-Methods
- (CGFloat)max:(CGFloat)a :(CGFloat)b ;
- (CGFloat)min:(CGFloat)a :(CGFloat)b ;

- (UIColor *)colorRGBA:(CGFloat)r :(CGFloat)g :(CGFloat)b :(CGFloat)a;// Allow create color with RGB in range 0-255, alpha: 0-1
- (UIColor *)colorHex:(NSString *)hex ; // Allow create color from hex(ex: #FFFFFF, #ABFF00,...)

- (int)randomRange:(int)min :(int)max;

- (UIImage *)takeSnapshot:(UIView *)view; // Take screen shot of a UIView
- (UIColor *)colorForUserType:(NSString *)type;

- (NSDate *)dateFromUTCFormat:(NSString *)dateString;
@end
