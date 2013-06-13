//
//  BTRedfly.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTSickBug.h"
#import "BTIncludes.h"

@implementation BTSickBug

- (id) initFlyWithAnimation:(CCAnimation *)animation GameLayer:(BTGameLayer *) layer{
    if ((self = [super initFlyWithAnimation:animation GameLayer:layer])){
        self.speed = [[BTConfig sharedConfig] flyMovementRate] / 2.0;
        self.value = 50;
//        self.weight = 3;
        self.weight = 0;
        CGPoint points[] = { CGPointMake(-25, 24), CGPointMake(25, 24), CGPointMake(25, -31), CGPointMake(-25,-31) };
        shape = cpPolyShapeNew(body, 4, points, cpvzero);
        effect = [[BTFrogEffectSick alloc] initWithFrog:[gameLayer frog] Duration:0.5];
    }
    
    return self;
}

+ (NSString *) color {
    return @"yellow";
}

- (void) draw {
    [super draw];
    if ([[BTConfig sharedConfig] debug]){
        glLineWidth(1);
        glColor4f(255, 0, 0, 255);
        CGPoint points[] = { CGPointMake(-25, 24), CGPointMake(25, 24), CGPointMake(25, -31), CGPointMake(-25,-31) };
        ccDrawPoly(points, 4, YES);
    }
}

- (void) update:(ccTime)dt {
    [super update:dt];
}

- (void) bugWasEaten {
    [effect setFrog:[gameLayer frog]];
    [effect apply];
}

- (void) bugWasZapped {
    [super bugWasZapped];
    if (isExtraSpecial){
        CGSize size = CGSizeMake(121, 82);
        float puddleScale = 0.5;
        if ([[BTHopshopManager sharedHopshopManager] levelForBug:[self class]] >= 4){
            size = CGSizeMake(242, 164);
            puddleScale = 1.0; 
        }
        BTPuddle *puddle = [[[BTPuddle alloc] initWithFile:nil Position:self.position IdleAnimation:nil ParentLayer:gameLayer Size:size] autorelease];
        puddle.scale = puddleScale;
        [gameLayer addChild:puddle z:4 tag:kPuddleTag];
    }
}

@end
