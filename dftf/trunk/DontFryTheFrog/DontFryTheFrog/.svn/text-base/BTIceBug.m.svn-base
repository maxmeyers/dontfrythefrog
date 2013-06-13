//
//  BTIceBug.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 7/13/11.
//  Copyright 2011 New York University. All rights reserved.
//

#import "BTIceBug.h"
#import "BTIncludes.h"

@implementation BTIceBug

- (id) initFlyWithAnimation:(CCAnimation *)animation GameLayer:(BTGameLayer *) layer {
    if ((self = [super initFlyWithAnimation:animation GameLayer:layer])){
        self.weight = 0;
        shape = cpCircleShapeNew(body, 20, cpv(-1, 5));
        effect = [[BTFrogEffectIce alloc] initWithFrog:[gameLayer frog] Duration:5];
    }
    return self;
}

+ (NSString *) color {
    return @"blue";
}

- (void) draw {
    [super draw];
    if ([[BTConfig sharedConfig] debug]){
        glLineWidth(1);
        glColor4f(255, 0, 0, 255);
        ccDrawCircle(CGPointMake(-1,5), 20, 360, 64, NO);
    }
}

- (void) bugWasEaten {   
    [effect setFrog:[gameLayer frog]];
    [effect apply];
    
    if (isExtraSpecial){
        CCAnimation *iceBurstAnimation = [BTStorageManager animationWithString:@"BTIceBurst" atInterval:0.1 Reversed:NO];
        int radius = 160;
        if ([[BTHopshopManager sharedHopshopManager] levelForBug:[self class]] >= 4){
            radius = 9999;
            // Stop at the 9th frame
            for (int i = 9; i < [[iceBurstAnimation frames] count]; i++){
                [[iceBurstAnimation frames] removeObjectAtIndex:i];
            }
        }
        
        CCSprite *burst = [CCSprite spriteWithSpriteFrameName:@"ice-burst1.png"];
        burst.position = self.position;
        [gameLayer addChild:burst z:6];
        CCAnimate *burstAnimate = [CCAnimate actionWithAnimation:iceBurstAnimation restoreOriginalFrame:NO];
        CCCallBlock *freezeBugs = [CCCallBlock actionWithBlock:^(void) { [self freezeBugsWithinRadius:radius]; }];
        
        CCCallBlock *fullscreenExplosion = [CCCallBlock actionWithBlock:^(void){
            CCLayerColor *layerColor = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
            [gameLayer addChild:layerColor z:6];
            [layerColor runAction:[CCSequence actions:[CCFadeOut actionWithDuration:0.333], [CCCallFunc actionWithTarget:layerColor selector:@selector(removeFromParent)], nil]];
        }];
        if ([[BTHopshopManager sharedHopshopManager] levelForBug:[self class]] >= 4){
            [burst runAction:[CCSequence actions:burstAnimate, freezeBugs, [CCCallFunc actionWithTarget:burst selector:@selector(removeFromParent)], fullscreenExplosion, nil]];
        } else {
            [burst runAction:[CCSequence actions:burstAnimate, freezeBugs, [CCCallFunc actionWithTarget:burst selector:@selector(removeFromParent)], nil]];            
        }
    }
    
    [[BTStatsManager sharedManager] setBlueFliesEaten:[[BTStatsManager sharedManager] blueFliesEaten] + 1];    
}

- (void) freezeBugsWithinRadius:(int) radius {
    NSArray *bugs = [[gameLayer bugManager] bugsWithinRadius:radius OfPoint:self.position];
    NSEnumerator *e = [bugs objectEnumerator];
    BTBug *bug;
    while ((bug = [e nextObject])){
        [bug freeze];
    }
}
 
- (void) dealloc {
    [effect release];
    [super dealloc];
}

@end
