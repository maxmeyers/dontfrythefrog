//
//  BTFrogEffect.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/16/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTFrogEffect.h"
#import "BTIncludes.h"

@implementation BTFrogEffect

@synthesize frog, timer;

- (id) initWithFrog:(BTFrog *) f Duration:(ccTime) d {
    if ((self = [super init])){
        frog = f;
        duration = d;
    }
    
    return self;
}

- (void) apply {
    timer = [[CCTimer timerWithTarget:self selector:@selector(stop) interval:duration] retain];
    if ([frog currentEffect] != nil) {
        [[frog currentEffect] remove];
    }
    [frog setCurrentEffect:self];
}

- (void) stop {
    [timer release];
    timer = nil;
}

- (void) remove {
    if (timer != nil){
        [timer release];
        timer = nil;
    }
    if ([frog currentEffect] == self){
        [frog setCurrentEffect:nil];
    }
}

- (void) dealloc {
    [super dealloc];
}

@end
