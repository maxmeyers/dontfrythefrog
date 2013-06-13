//
//  BTFrogEffectExplode.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/17/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTFrogEffectExplode.h"
#import "BTIncludes.h"

@implementation BTFrogEffectExplode

- (void) apply {
    [super apply];
    [[frog tongueSprite] runAction:[CCScaleTo actionWithDuration:0 scaleX:1 scaleY:0.15]];
    [frog tongueSprite].visible = NO;
    [frog stopIdleAction];
    
    float timeToRotate = fmod(fabs([frog rotation]), 360) / 400;
    
    [frog runAction:[CCSequence actions:[CCRotateTo actionWithDuration:timeToRotate angle:0], [CCCallFunc actionWithTarget:self selector:@selector(explode)], nil]];
}

- (void) explode {
    [[SimpleAudioEngine sharedEngine] playEffect:@"FrogExplode.m4a"];
    [frog setCurrentAnimationArray:[frog normalAnimations]];
    [[frog sprite] runAction:[CCSequence actions:[CCAnimate actionWithAnimation:[[frog currentAnimations] explodeAnimation] restoreOriginalFrame:NO], [CCCallFunc actionWithTarget:self selector:@selector(remove)], nil]];
}

- (void) stop {
    [self remove];
}

- (void) remove {
    [[frog gameLayer] frogFinishedExploding]; 
    [frog setFatLevel:2];
    [super remove];
}

@end
