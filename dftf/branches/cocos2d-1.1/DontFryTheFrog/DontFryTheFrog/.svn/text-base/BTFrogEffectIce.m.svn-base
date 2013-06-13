//
//  BTFrogEffectIce.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/16/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTFrogEffectIce.h"
#import "BTIncludes.h"

@implementation BTFrogEffectIce

- (void) apply {
    [super apply];

    if (![[frog wanderAction] isDone]){
        [[frog wanderAction] stop];
    }
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"FrogFreeze.m4a"];
    
    [frog stopIdleAction];
    [frog setCurrentAnimationArray:[frog iceAnimations]];
    
    CCAnimate *startAnimate = [CCAnimate actionWithAnimation:[(BTFrogAnimationsIce *)[frog currentAnimations] start] restoreOriginalFrame:NO];
    [startAnimate setTag:872834];
    [[frog sprite] runAction:startAnimate];
}

- (void) stop {
    [super stop];
    CCAnimate *endAnimate = [CCAnimate actionWithAnimation:[(BTFrogAnimationsIce *)[frog currentAnimations] end]];
    CCSequence *endTransitionSequence = [CCSequence actions:endAnimate, [CCCallFunc actionWithTarget:self selector:@selector(remove)], nil];
    [endTransitionSequence setTag:872834];
    [[frog sprite] runAction:endTransitionSequence];
    [[SimpleAudioEngine sharedEngine] playEffect:@"FrogUnfreeze.m4a"];

}

- (void) remove {
    [[frog sprite] stopActionByTag:872834];
    [frog setCurrentAnimationArray:[frog normalAnimations]];
    [frog setAnimations:[frog fatLevel]];
    
    [super remove];
}

@end
