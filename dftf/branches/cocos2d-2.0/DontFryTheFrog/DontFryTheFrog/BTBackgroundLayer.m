//
//  BTBackgroundLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/20/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTBackgroundLayer.h"
#import "BTIncludes.h"

@implementation BTBackgroundLayer

- (id) init {
    self = [super init];
    if (self){
        CCSprite *layer1 = [CCSprite spriteWithSpriteFrameName:@"background-layer1.png"];
        layer1.position = ccp(240, 160);
        CCSprite *layer6 = [CCSprite spriteWithSpriteFrameName:@"background-layer6.png"];
        layer6.position = ccp(240, 160);
        [self addChild:layer1 z:1];
        [self addChild:layer6 z:6];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        BTBackgroundSubLayer *subLayer2 = [[[BTBackgroundSubLayer alloc] initWithSpriteFrameName:@"background-layer2.png" Width:510 Duration:56] autorelease];
        [tempArray addObject:subLayer2];
        [self addChild:subLayer2 z:2];
        
        BTBackgroundSubLayer *subLayer3 = [[[BTBackgroundSubLayer alloc] initWithSpriteFrameName:@"background-layer3.png" Width:510 Duration:52] autorelease];
        [tempArray addObject:subLayer3];
        [self addChild:subLayer3 z:3];
        
        BTBackgroundSubLayer *subLayer4 = [[[BTBackgroundSubLayer alloc] initWithSpriteFrameName:@"background-layer4.png" Width:512 Duration:50] autorelease];
        [tempArray addObject:subLayer4];
        [self addChild:subLayer4 z:4];
        
        BTBackgroundSubLayer *subLayer5 = [[[BTBackgroundSubLayer alloc] initWithSpriteFrameName:@"background-layer5.png" Width:512 Duration:45] autorelease];
        [tempArray addObject:subLayer5];
        [self addChild:subLayer5 z:5];
        
        layers = [[NSArray alloc] initWithArray:tempArray];
        
        [self scheduleUpdate];
    }
    return self;
}

- (void) update:(ccTime)dt {

}

- (void) pauseSchedulerAndActions { 
    [super pauseSchedulerAndActions];
    for (int i = 0; i < [layers count]; i++){
        [(BTBackgroundSubLayer *)[layers objectAtIndex:i] pauseSchedulerAndActions];
    }
}

- (void) resumeSchedulerAndActions {
    [super resumeSchedulerAndActions];
    for (int i = 0; i < [layers count]; i++){
        [(BTBackgroundSubLayer *)[layers objectAtIndex:i] resumeSchedulerAndActions];
    }
}

- (void) dealloc {
    [layers release];
    [super dealloc];
}

@end
