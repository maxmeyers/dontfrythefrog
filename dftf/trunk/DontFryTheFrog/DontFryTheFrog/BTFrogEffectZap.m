//
//  BTFrogEffectZap.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/17/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTFrogEffectZap.h"
#import "BTIncludes.h"

@implementation BTFrogEffectZap

- (void) apply {
    [super apply];
    [[SimpleAudioEngine sharedEngine] playEffect:@"ZapFrog.m4a"];
    [[frog tongueSprite] runAction:[CCScaleTo actionWithDuration:0 scaleX:1 scaleY:0.15]];
    [frog tongueSprite].visible = NO;
    [frog stopIdleAction];
    
    [[frog sprite] runAction:[CCSequence actions:[CCAnimate actionWithAnimation:[[frog currentAnimations] zapAnimation] restoreOriginalFrame:NO], [CCCallFunc actionWithTarget:self selector:@selector(remove)] , nil]];
}

- (void) stop {
    [self remove];
}

- (void) remove {
    [[frog gameLayer] frogFinishedZapping];
    [frog setFatLevel:2];
    [frog runIdleAction];
    [super remove];
}

@end
