//
//  BTFrogMilestone.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 9/13/11.
//  Copyright 2011 New York University. All rights reserved.
//

#import "BTFrogMilestone.h"
#import "BTIncludes.h"

#define kMilestoneTime @"Time"
#define kMilestoneZaps @"Zaps"
#define kMilestoneCatchInterval @"CatchInterval"
#define kMilestoneSpeed @"Speed"
#define kMilestoneDelay @"Delay"

@implementation BTFrogMilestone

@synthesize time, zaps;
@synthesize catchInterval, speed, animationDelay;

- (id)initWithTime:(int) t CatchInterval:(float) c Speed:(float) s AnimationDelay:(float) a {
    if ((self = [super init])) {
        time = t;
        catchInterval = c;
        speed = s;
        animationDelay = a;
    }
    
    return self;
}

- (void) apply {

    if (speed != -1){
        [[BTConfig sharedConfig] setFrogMovementRate:kFrogMovementRate*speed];
        [[BTConfig sharedConfig] setFrogCatchRate:kFrogCatchRate*speed];
    }
    
    if (catchInterval != -1){
        [[BTConfig sharedConfig] setFrogCatchInterval:kFrogCatchInterval*catchInterval];
    }
    
    if (animationDelay != -1){
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if ([delegate isMemberOfClass:[AppDelegate class]]){
            BTFrog *frog = [[[delegate gameScene] gameLayer] frog];
            [frog setAnimationDelay:animationDelay];
        }
    }
}

- (NSString *) description {
    return [NSString stringWithFormat:@"Time: %d, Zaps: %d, Catch Interval: %f, Speed: %f, Delay: %f", time, zaps, catchInterval, speed, animationDelay];
}

#pragma mark NSCoding

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:time forKey:kMilestoneTime];
    [aCoder encodeInt:zaps forKey:kMilestoneZaps];
    [aCoder encodeFloat:catchInterval forKey:kMilestoneCatchInterval];
    [aCoder encodeFloat:speed forKey:kMilestoneSpeed];
    [aCoder encodeFloat:animationDelay forKey:kMilestoneDelay];
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [self initWithTime:[aDecoder decodeIntForKey:kMilestoneTime] CatchInterval:[aDecoder decodeFloatForKey:kMilestoneCatchInterval] Speed:[aDecoder decodeFloatForKey:kMilestoneSpeed] AnimationDelay:[aDecoder decodeFloatForKey:kMilestoneDelay]];
    if (self){
        
    }
    
    return self;
}

@end
