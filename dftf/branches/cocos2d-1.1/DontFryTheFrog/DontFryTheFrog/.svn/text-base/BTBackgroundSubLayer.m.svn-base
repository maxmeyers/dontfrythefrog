//
//  BTBackgroundSubLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/20/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTBackgroundSubLayer.h"
#import "BTIncludes.h"

@implementation BTBackgroundSubLayer

@synthesize layer1, layer2;

- (id) initWithSpriteFrameName:(NSString *) string Width:(float) w Duration:(ccTime) dur {
    self = [super init];
    if (self){
        layer1 = [CCSprite spriteWithSpriteFrameName:string];
        [self addChild:layer1 z:0];
        layer2 = [CCSprite spriteWithSpriteFrameName:string];
        [self addChild:layer2 z:0];
        width = w;
        duration = dur;
        layer1.position = ccp(240, 160);
        layer2.position = ccp(-(int)(width/2), 160);
        
        currentLayer = layer1;
        float lastBit = (480.0/(width+480.0));
        [currentLayer runAction:[CCSequence actions:[CCMoveTo actionWithDuration:duration*(width/2-240)/(width+480.0) position:ccp(width/2, 160)], [CCCallFunc actionWithTarget:self selector:@selector(switchLayers)], [CCMoveTo actionWithDuration:duration*lastBit position:ccp((int)(width/2)+480, 160)], nil]];
    }
    return self;
}

- (void) switchLayers {
    if (currentLayer == layer1){
        currentLayer = layer2;
    } else if (currentLayer == layer2 || currentLayer == nil){
        currentLayer = layer1;
    }
    
    float totalDistance = width + 480.0;
    float lastBitPortion = 480.0f / totalDistance;
    float firstBitPortion = 1 - lastBitPortion;
        
    [currentLayer runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0 position:ccp(-(int)(width/2), 160)], [CCMoveTo actionWithDuration:duration*firstBitPortion position:ccp((int)(width/2), 160)], [CCCallFunc actionWithTarget:self selector:@selector(switchLayers)], [CCMoveTo actionWithDuration:duration*lastBitPortion position:ccp((int)(width/2)+480, 160)], nil]];
}

- (void) pauseSchedulerAndActions {
    [super pauseSchedulerAndActions];
    [layer1 pauseSchedulerAndActions];
    [layer2 pauseSchedulerAndActions];
}

- (void) resumeSchedulerAndActions {
    [super resumeSchedulerAndActions];
    [layer1 resumeSchedulerAndActions];
    [layer2 resumeSchedulerAndActions];    
}


@end
