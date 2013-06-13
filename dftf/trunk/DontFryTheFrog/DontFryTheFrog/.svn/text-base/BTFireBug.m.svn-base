//
//  BTFireBug.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 7/14/11.
//  Copyright 2011 New York University. All rights reserved.
//

#import "BTFireBug.h"
#import "BTIncludes.h"

@implementation BTFireBug


- (id) initFlyWithAnimation:(CCAnimation *)animation GameLayer:(BTGameLayer *) layer {
    if ((self = [super initFlyWithAnimation:animation GameLayer:layer])){
        self.speed = [[BTConfig sharedConfig] flyMovementRate] * 2.0;
        self.value = 50;
        self.weight = 0;
        CGPoint points[] = { CGPointMake(-18, 30), CGPointMake(16, 30), CGPointMake(16, -18), CGPointMake(-18,-18) };
        shape = cpPolyShapeNew(body, 4, points, cpvzero);
        effect = [[BTFrogEffectFire alloc] initWithFrog:nil Duration:5];
    }
    
    return self;
}

+ (NSString *) color {
    return @"red";
}

- (void) draw {
    [super draw];
    if ([[BTConfig sharedConfig] debug]){
        CGPoint points[] = { CGPointMake(-18, 30), CGPointMake(16, 30), CGPointMake(16, -18), CGPointMake(-18,-18) };
        ccDrawPoly(points, 4, YES);
    }
}

- (void) bugWasZapped {
    [super bugWasZapped];
    if (isExtraSpecial){
        
        int radius = 0;
        if ([[BTHopshopManager sharedHopshopManager] levelForBug:[BTFireBug class]] < 4){
            radius = 160;
            [[SimpleAudioEngine sharedEngine] playEffect:@"FireFlySmall.m4a"];
        } else if ([[BTHopshopManager sharedHopshopManager] levelForBug:[BTFireBug class]] >= 4){
            radius = 9999;
            [[SimpleAudioEngine sharedEngine] playEffect:@"FireFlyBig.m4a"];
        }
        
        CCSprite *explosion = [CCSprite spriteWithSpriteFrameName:@"fire-burst1.png"];
        explosion.position = self.position;
        [gameLayer addChild:explosion z:6];
        CCAnimate *explosionAnimate = [CCAnimate actionWithAnimation:[BTStorageManager animationWithString:@"BTFireBurst" atInterval:0.1 Reversed:NO] restoreOriginalFrame:NO];
        CCCallBlock *killBugs = [CCCallBlock actionWithBlock:^(void) { [self zapBugsWithinRadius:radius]; }];
        
        CCCallBlock *fullscreenExplosion = [CCCallBlock actionWithBlock:^(void){
            CCLayerColor *layerColor = [CCLayerColor layerWithColor:ccc4(253, 188, 97, 255)];
            [gameLayer addChild:layerColor z:6];
            [layerColor runAction:[CCSequence actions:[CCFadeOut actionWithDuration:0.333], [CCCallFunc actionWithTarget:layerColor selector:@selector(removeFromParent)], nil]];
        }];
        if ([[BTHopshopManager sharedHopshopManager] levelForBug:[BTFireBug class]] >= 4){
            [explosion runAction:[CCSequence actions:explosionAnimate, killBugs, [CCCallFunc actionWithTarget:explosion selector:@selector(removeFromParent)], fullscreenExplosion, nil]];
        } else {
            [explosion runAction:[CCSequence actions:explosionAnimate, killBugs, [CCCallFunc actionWithTarget:explosion selector:@selector(removeFromParent)], nil]];            
        }
    }
    
    [[BTStatsManager sharedManager] setRedFliesFried:[[BTStatsManager sharedManager] redFliesFried] + 1];    
}

- (void) zapBugsWithinRadius:(int) r {
    NSArray *bugs = [[gameLayer bugManager] bugsWithinRadius:r OfPoint:self.position];
    NSEnumerator *e = [bugs objectEnumerator];
    BTBug *bug;
    while ((bug = [e nextObject])){
        if (![bug isKindOfClass:[BTGoodBug class]]){
            [gameLayer flyZapped:bug];
        }
    }
}

- (void) bugWasEaten {
    if (![[gameLayer frog] onFire]) {
        [effect setFrog:[gameLayer frog]];
        [effect apply];
    } else {
        [(BTFrogEffectFire *)[[gameLayer frog] currentEffect] increaseTimerBy:5.0];
    }
}

- (void) dealloc {
    [effect release];
    [super dealloc];
}

@end
