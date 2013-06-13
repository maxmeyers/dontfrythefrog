//
//  BTGreenFly.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 5/28/11.
//  Copyright 2011 New York University. All rights reserved.
//

#import "BTGreenFly.h"
#import "BTIncludes.h"

@implementation BTGreenFly

- (id) initFlyWithAnimation:(CCAnimation *)animation GameLayer:(BTGameLayer *) layer {
    if ((self = [super initFlyWithAnimation:animation GameLayer:layer])){
        self.value = 0;
        self.weight = 0;
        shape = cpCircleShapeNew(body, 18, cpv(1.5, -2.66));
        effect = nil;
    }
    
    return self;
}

+ (NSString *) color {
    return @"green";
}

- (void) draw {
    [super draw];
    if ([[BTConfig sharedConfig] debug]){
        glLineWidth(1);
        glColor4f(255, 0, 0, 255);
        ccDrawCircle(CGPointMake(1.5, -2.66), 18, 360, 64, NO);
    }
}

- (void) bugWasEaten {
    [[gameLayer frog] setFatLevel:2];
    if ([[gameLayer frog] onFire]){
        [[gameLayer frog] stopEffect];
    }
    
    if ([self isExtraSpecial]){
        [[gameLayer scene] addToMultiplier:10];

        if ([[BTHopshopManager sharedHopshopManager] levelForBug:[self class]] >= 4){
            [[[[gameLayer scene] gameUILayer] lifeCounter] setLives:[[[[gameLayer scene] gameUILayer] lifeCounter] lives] + 1];
        }
    }
    
    [[BTStatsManager sharedManager] setGreenFliesEaten:[[BTStatsManager sharedManager] greenFliesEaten] + 1];    
}

@end
