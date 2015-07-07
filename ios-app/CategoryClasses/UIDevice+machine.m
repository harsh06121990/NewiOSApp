//
//  UIDevice+machine.m
//  ComparisionAap
//
//  Created by Nguyen Minh Tu on 12/30/14.
//  Copyright (c) 2014 Tanveer Ashraf. All rights reserved.
//

#import "UIDevice+machine.h"


@implementation UIDevice(machine)

- (NSString*)machine {
    size_t size;
    
    // Set 'oldp' parameter to NULL to get the size of the data
    // returned so we can allocate appropriate amount of space
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    // Allocate the space to store name
    char *name = malloc(size);
    
    // Get the platform name
    sysctlbyname("hw.machine", name, &size, NULL, 0);
    
    // Place name into a string
    NSString *machine = [NSString stringWithUTF8String:name];
    
    // Done with this
    free(name);
    
    return machine;
}

@end
