//
//  BTHopshopDetails.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTHopshopDetails.h"

@implementation BTHopshopDetails

@synthesize bugUpgrades, tools, backgrounds, hats = _hats;

- (id) init {
    self = [super init];
    if (self){
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HopshopDetails" ofType:@"plist"]];
        self.bugUpgrades = [dictionary objectForKey:@"BugUpgrades"]; 
        self.tools = [dictionary objectForKey:@"Tools"];
        self.backgrounds = [dictionary objectForKey:@"Backgrounds"];
        self.hats = [dictionary objectForKey:@"Hats"];        
    }
    return self;
}

#pragma mark NSCoding
- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self){
        self.bugUpgrades = [aDecoder decodeObjectForKey:@"BugUpgrades"];
        self.tools = [aDecoder decodeObjectForKey:@"Tools"];
        self.backgrounds = [aDecoder decodeObjectForKey:@"Backgrounds"];
        self.hats = [aDecoder decodeObjectForKey:@"Hats"];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.bugUpgrades forKey:@"BugUpgrades"];
    [aCoder encodeObject:self.tools forKey:@"Tools"];
    [aCoder encodeObject:self.backgrounds forKey:@"Backgrounds"];
    [aCoder encodeObject:self.hats forKey:@"Hats"];
}

@end
