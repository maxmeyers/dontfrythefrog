//
//  BTHopshopDetails.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTHopshopDetails.h"

@implementation BTHopshopDetails

@synthesize bugUpgrades;

- (id) init {
    self = [super init];
    if (self){
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HopshopDetails" ofType:@"plist"]];
        self.bugUpgrades = [dictionary objectForKey:@"BugUpgrades"]; 
                                                                        
    }
    return self;
}

#pragma mark NSCoding
- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self){
        self.bugUpgrades = [aDecoder decodeObjectForKey:@"BugUpgrades"];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:bugUpgrades forKey:@"BugUpgrades"];
}

@end
