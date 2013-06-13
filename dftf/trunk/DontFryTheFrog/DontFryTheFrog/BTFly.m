//
//  BTFly.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTFly.h"
#import "BTIncludes.h"

@implementation BTFly

- (id) initFlyWithAnimation:(CCAnimation *)animation GameLayer:(BTGameLayer *) layer{
    if ((self = [super initWithFile:@"drone-1a.png" Position:CGPointMake(0, 0) IdleAnimation:animation ParentLayer:layer])){
        self.value = 10;
        CGPoint points[] = { CGPointMake(-12, 16), CGPointMake(12, 16), CGPointMake(12, -20), CGPointMake(-12,-20) };
        shape = cpPolyShapeNew(body, 4, points, cpvzero);
    }
    
    return self;
}

- (void) draw {
    if ([[BTConfig sharedConfig] debug]){
        glLineWidth(1);
        glColor4f(255, 0, 0, 255);
        CGPoint points[] = { CGPointMake(-12, 16), CGPointMake(13, 16), CGPointMake(13, -20), CGPointMake(-12,-20) };
        ccDrawPoly(points, 4, YES);
    }
}

- (void) bugWasZapped {
    [[SimpleAudioEngine sharedEngine] playEffect:@"ZapDrone.m4a"];
    [[BTStatsManager sharedManager] setGreyFliesFried:[[BTStatsManager sharedManager] greyFliesFried] + 1];    
}

@end
