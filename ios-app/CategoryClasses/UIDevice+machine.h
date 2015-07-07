//
//  UIDevice+machine.h
//  ComparisionAap
//
//  Created by Nguyen Minh Tu on 12/30/14.
//  Copyright (c) 2014 Tanveer Ashraf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <sys/types.h>
#include <sys/sysctl.h>

int sysctlbyname(const char *name, void *oldp, size_t *oldlenp, void *newp, size_t newlen);

@interface UIDevice(machine)
- (NSString *)machine;
@end
