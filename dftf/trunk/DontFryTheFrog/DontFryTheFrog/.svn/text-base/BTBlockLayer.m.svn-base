//
//  BTBlockLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BTBlockLayer.h"
#import "BTIncludes.h"

@implementation BTBlockLayer

- (id) init {
    self = [super init];
    if (self){
        CCLayerColor *leftBlock = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 255) width:480 height:320];
        leftBlock.position = ccp(-480, 0);
        [self addChild:leftBlock];
        
        CCLayerColor *rightBlock = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 255) width:480 height:320];
        rightBlock.position = ccp(480, 0);
        [self addChild:rightBlock];
        
        CCLayerColor *topBlock = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 255) width:1440 height:50];
        topBlock.position = ccp(-480, 320);
        [self addChild:topBlock];
        
        CCLayerColor *bottomBlock = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 255) width:1440 height:50];
        bottomBlock.position = ccp(-480, -50);
        [self addChild:bottomBlock];

    }
    return self;
}

@end
