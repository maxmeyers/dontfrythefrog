//
//  BTFrogEffectFire.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/16/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTFrogEffectFire.h"
#import "BTIncludes.h"

@implementation BTFrogEffectFire

@synthesize soundEffect;

- (void) apply {
    [super apply];
    
    [frog stopIdleAction];
    [frog setInTransition:YES];
    [frog setCurrentAnimationArray:[frog fireAnimations]];

    float timeToRotate = fmod(fabs([frog rotation]), 360) / 400;
    
    CCSequence *rotateSequence = [CCSequence actions:[CCRotateTo actionWithDuration:timeToRotate angle:0], [CCCallFunc actionWithTarget:self selector:@selector(startTransition)], nil];
    [rotateSequence setTag:354127];
    [frog runAction:rotateSequence];
    
    originalInterval = [[BTConfig sharedConfig] frogCatchInterval];
    [[BTConfig sharedConfig] setFrogCatchInterval:(originalInterval / 2)];

    originalSpeed = [[BTConfig sharedConfig] frogMovementRate];
    [[BTConfig sharedConfig] setFrogMovementRate:(originalSpeed * 2)];
}

- (void) startTransition {
    if ([frog onFire]){ // might've been zapped
        soundEffect = [[SimpleAudioEngine sharedEngine] playEffect:@"FrogOnFire.m4a" pitch:1.0 pan:0 gain:1.0 looping:true];
        
        CCAnimate *startAnimate = [CCAnimate actionWithAnimation:[(BTFrogAnimationsFire *)[frog currentAnimations] start]];
        CCSequence *transitionSequence = [CCSequence actions:startAnimate, [CCCallFunc actionWithTarget:self selector:@selector(move)], nil];
        [transitionSequence setTag:354127];
        [[frog sprite] runAction:transitionSequence];
    }
}

- (void) move {
    [frog setInTransition:NO];
    [frog setAnimations:[frog fatLevel]];
}

- (void) increaseTimerBy:(ccTime) seconds {
    ccTime newTime = (duration - [timer elapsed]) + seconds;
    NSLog(@"Add %f seconds. %f seconds remain", seconds, newTime );
    
    [timer release];
//    timer = [[CCTimer alloc] initWithTarget:self selector:@selector(stop) interval:newTime];
    timer = [[CCTimer timerWithTarget:self selector:@selector(stop) interval:newTime] retain];
}

- (void) stop {
    if (![frog inCatchSequence]){
        [[SimpleAudioEngine sharedEngine] stopEffect:soundEffect];
        [[SimpleAudioEngine sharedEngine] playEffect:@"FrogFireOut.m4a"];
        [frog setInTransition:YES];
        CCAnimate *endAnimate = [CCAnimate actionWithAnimation:[(BTFrogAnimationsFire *)[frog currentAnimations] end]];
        CCSequence *endTransitionSequence = [CCSequence actions:endAnimate, [CCCallFunc actionWithTarget:self selector:@selector(remove)], nil];
        [endTransitionSequence setTag:354127];
        [[frog sprite] runAction:endTransitionSequence];
    } else { 
        [timer release];
        timer = [[CCTimer timerWithTarget:self selector:@selector(stop) interval:0.1] retain];    
    }
}

- (void) remove {
    [[SimpleAudioEngine sharedEngine] stopEffect:soundEffect];
    [[frog sprite] stopActionByTag:354127];
    [frog setInTransition:NO];
    [[BTConfig sharedConfig] setFrogCatchInterval:originalInterval];
    [[BTConfig sharedConfig] setFrogMovementRate:originalSpeed];
    
    
    if ([[frog currentAnimations] jawSprite] != nil){
        [[frog currentAnimations] jawSprite].visible = NO;
    }   
    [frog setCurrentAnimationArray:[frog normalAnimations]];
    [frog setAnimations:[frog fatLevel]];

    [super remove];
}



@end
