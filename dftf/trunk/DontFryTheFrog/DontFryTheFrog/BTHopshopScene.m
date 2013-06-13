//
//  BTHopshopScene.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/8/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTHopshopScene.h"
#import "BTIncludes.h"

@implementation BTHopshopScene 

@synthesize hasCompletedMission = hasCompletedMission_;

- (id) init {
    self = [super init];
    if (self){        
        if ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"]){
//            self.scale = 1024.0/480.0;
//            self.position = ccp(579, 475);
        }
        hasCompletedMission_ = NO;
        
        BTHopshopLayer *hopshop = [[[BTHopshopLayer alloc] init] autorelease];
        hopshop.hopshopScene = self;
        [self addChild:hopshop z:0 tag:1];
    }
    return self;
}

@end
