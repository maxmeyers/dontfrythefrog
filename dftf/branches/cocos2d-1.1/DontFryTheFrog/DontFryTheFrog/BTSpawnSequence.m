//
//  BTBugSpawn.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 7/9/11.
//  Copyright 2011 New York University. All rights reserved.
//

#import "BTSpawnSequence.h"
#import "BTIncludes.h"

#define kSequenceName @"Name"
#define kSequenceOrders @"Orders"

@implementation BTSpawnSequence

@synthesize startingTime, state, orders, name;

- (id) initWithOrders:(NSArray *) Orders Name:(NSString *) str {
    if ((self = [super init])){
        self.orders = [[NSMutableArray alloc] initWithArray:Orders]; 
        self.name = str;
        self.state = NotStarted;
        [self reset];
    }
    
    return self;
}

- (void) startAtTime:(ccTime) time {
    [self reset];
    startingTime = time;
    state = Started;
}

- (NSArray *) ordersForTime:(ccTime) time {
    if (state == Started){
        NSMutableArray *currentOrders = [[[NSMutableArray alloc] init] autorelease];
        
        for (int i = 0; i < [orders count]; i++) {
            BTOrder *order = [orders objectAtIndex:i];
            if (time > startingTime + order.time && !order.received) {
                order.received = YES;
                [currentOrders addObject: order];
            }
        }    
        
        // Checks if there's anything left to do
        if ([currentOrders count] > 0){
            bool tempActive = NO;
            for (int i = 0; i < [orders count]; i++) {
                BTOrder *order = [orders objectAtIndex:i];
                if (!order.received) {
                    tempActive = YES;
                }
            }    
            if (!tempActive){
                [self finish];
            }
        }

            
        return currentOrders;
    }
    return [NSArray array];
}

- (void) finish {
    state = Finished;
}

- (void) reset {
    state = NotStarted;
    for (int i = 0; i < [orders count]; i++){
        [(BTOrder *)[orders objectAtIndex:i] setReceived:NO];
    }
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    NSString *tempName = @"Undecoded Name";
    if ([aDecoder decodeObjectForKey:kSequenceName] != nil){
        tempName = [aDecoder decodeObjectForKey:kSequenceName];
    }
    
    NSArray *tempOrders = [NSArray array];
    if ([aDecoder decodeObjectForKey:kSequenceOrders] != nil){
        tempOrders = [aDecoder decodeObjectForKey:kSequenceOrders];
    }
    
    self = [self initWithOrders:tempOrders Name:tempName];
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:name forKey:kSequenceName];
    [aCoder encodeObject:orders forKey:kSequenceOrders];
}

- (void) dealloc {
    [orders release];
    [name release];
    [super dealloc];
}

@end

#define kSpecialSequenceSequences @"Sequences"
#define kSpecialSequenceRequiredBugs @"Required Bugs"

@implementation BTSpecialSequence

@synthesize sequences, name;

- (id) initWithSequences:(NSArray *) seq Name:(NSString *) str RequiredBugs:(NSArray *) bugs {
    self = [super init];
    if (self){
        [self setSequences:seq];
        [self setName:str];
        requiredBugs = [bugs retain];
    }
    return self;
}

- (bool) isUnlocked {
    NSEnumerator *e = [requiredBugs objectEnumerator];
    NSString *requiredBug;
    while ((requiredBug = [e nextObject])){
        if (![BTStorageManager isUnlocked:NSClassFromString(requiredBug)]){
            return NO;
        }
    }
    return YES;
}

- (void) reset {
    
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    NSString *tempName = @"Undecoded Name";
    if ([aDecoder decodeObjectForKey:kSequenceName] != nil){
        tempName = [aDecoder decodeObjectForKey:kSequenceName];
    }
    
    NSArray *tempSequences = [NSArray array];
    if ([aDecoder decodeObjectForKey:kSpecialSequenceSequences] != nil){
        tempSequences = [aDecoder decodeObjectForKey:kSpecialSequenceSequences];
    }
    
    NSArray *tempRequiredBugs = [NSArray array];
    if ([aDecoder decodeObjectForKey:kSpecialSequenceRequiredBugs] != nil){
        tempRequiredBugs = [aDecoder decodeObjectForKey:kSpecialSequenceRequiredBugs];
    }    
    self = [self initWithSequences:tempSequences Name:tempName RequiredBugs:tempRequiredBugs];
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:name forKey:kSequenceName];
    [aCoder encodeObject:sequences forKey:kSpecialSequenceSequences];
    [aCoder encodeObject:requiredBugs forKey:kSpecialSequenceRequiredBugs];
}


- (void) dealloc {
    [requiredBugs release];
    [sequences release];
    [super dealloc];
}

@end