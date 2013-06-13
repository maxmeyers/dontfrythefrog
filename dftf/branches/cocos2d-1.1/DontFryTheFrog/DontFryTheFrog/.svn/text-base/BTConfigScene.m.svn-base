//
//  BTConfigScene.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTConfigScene.h"
#import "BTIncludes.h"
#import "CCTouchDispatcher.h"

@implementation BTConfigScene


BTConfigLayer *configLayer;

-(id) init {
    if ((self = [super init])){        
        configLayer = [[BTConfigLayer alloc] initWithConfigScene:self];
        [self addChild:configLayer];
    }
    return self;
}

- (void) unPauseGame {
    [[CCDirector sharedDirector] popScene];
}

@end
