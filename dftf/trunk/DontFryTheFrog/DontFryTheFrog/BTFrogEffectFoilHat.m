//
//  BTFrogEffectFoilHat.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/8/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTFrogEffectFoilHat.h"
#import "BTIncludes.h"

#define kFoilBlinkTag 5

@implementation BTFrogEffectFoilHat

- (void) apply {
    [super apply];
    CCEaseIn *blinkIn = [CCEaseIn actionWithAction:[CCBlink actionWithDuration:duration blinks:duration/.2] rate:1.2];
    blinkIn.tag = kFoilBlinkTag;
    [frog runAction:blinkIn];
    
    BTGameLayer *gameLayer = [frog gameLayer];
    CCSprite *foilHat = [frog foilHat];
    [foilHat removeFromParentAndCleanup:YES];
    [gameLayer addChild:foilHat z:5];
    foilHat.position = frog.position;
    foilHat.rotation = 0;
    foilHat.scale = 1;
    
    ccBezierConfig bezierConfig;
    bezierConfig.controlPoint_1 = ccp(frog.position.x + 25, frog.position.y +40);
    bezierConfig.controlPoint_2 = bezierConfig.controlPoint_1;
    bezierConfig.endPosition = ccp(frog.position.x + 25, -60);
    
    CCEaseIn *popAction = [CCEaseIn actionWithAction:[CCBezierTo actionWithDuration:0.75 bezier:bezierConfig] rate:1.5];
    popAction.tag = kFoilHatPopActionTag;
    
    [foilHat runAction:popAction];
}

- (void) stop {

    [self remove];
}

- (void) remove {
    [super remove];
    [[[frog gameLayer] scene] removeChildByTag:kFoilHatTag cleanup:YES];
    
    [frog stopActionByTag:kFoilBlinkTag];
    
    frog.visible = YES;
}

@end
