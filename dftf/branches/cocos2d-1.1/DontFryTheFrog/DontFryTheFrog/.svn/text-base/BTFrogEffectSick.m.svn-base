//
//  BTFrogEffectSick.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/18/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTFrogEffectSick.h"
#import "BTIncludes.h"

@implementation BTFrogEffectSick

- (void) apply {
    [super apply];
    
    if (![[frog wanderAction] isDone]){
        [[frog wanderAction] stop];
    }
    
    [frog stopIdleAction];
    [frog setCurrentAnimationArray:[frog sickAnimations]];
    CCAnimate *startAnimate = [CCAnimate actionWithAnimation:[(BTFrogAnimationsSick *)[frog currentAnimations] start] restoreOriginalFrame:NO];
    [startAnimate setTag:283749];
    [[frog sprite] runAction:startAnimate];
}

- (void) stop {
    [super stop];
    if ([frog sick]){
        CCAnimate *endAnimate = [CCAnimate actionWithAnimation:[(BTFrogAnimationsSick *)[frog currentAnimations] end] restoreOriginalFrame:NO];
        CCSequence *endTransitionSequence = [CCSequence actions:endAnimate, [CCCallFunc actionWithTarget:self selector:@selector(remove)], nil];
        [endTransitionSequence setTag:283749];
        [[frog sprite] runAction:endTransitionSequence];
    }
}

- (void) remove {
    [super remove];
    [[frog sprite] stopActionByTag:283749];
    [frog setCurrentAnimationArray:[frog normalAnimations]];
    [frog setAnimations:[frog fatLevel]];
    
    [frog setFatLevel:[[BTConfig sharedConfig] frogMaxFatLevel]];
}

@end
