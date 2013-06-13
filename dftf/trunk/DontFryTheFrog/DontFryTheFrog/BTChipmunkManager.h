//
//  BTChipmunk.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "chipmunk.h"

@class BTGameLayer;

@interface BTChipmunkManager : CCNode {
    cpSpace *space;
    BTGameLayer *gameLayer;
}

@property (nonatomic, assign) cpSpace *space;
@property (nonatomic, assign) BTGameLayer *gameLayer;

- (id) initWithGameLayer:(BTGameLayer *)layer;

//***************************************************
// COLLISION FUNCTIONS
//***************************************************

void playerKilledFlyPostStep (cpSpace *space, void *key, void *data);
void playerKilledAsteroidPostStep (cpSpace *space, void *key, void *data);

void frogZappedPostStep (cpSpace *space, void *key, void *data);
void frogTongueZappedPostStep (cpSpace *space, void *key, void *data);
void frogTouchedPuddlePostStep (cpSpace *space, void *key, void *data);

/**
 * A collision function for when nothing should happen.
 */
static int boringCollision (cpArbiter *arb, struct cpSpace *space, void *data);

/**
 * Fly collides with player. When this occurs, a poststep callback 
 * will be added to kill the fly. Also, player score increases by one.
 */
int flyBeganToCollideWithLine (cpArbiter *arb, struct cpSpace *space, void *data);

int flyBeganToCollideWithFrog (cpArbiter *arb, struct cpSpace *space, void *data);

/**
 * Player collides with frog. Add a poststep callback to mark a gameover.
 */
int lineBeganToCollideWithFrog (cpArbiter *arb, struct cpSpace *space, void *data);
int lineBeganToCollideWithFrogTongue (cpArbiter *arb, struct cpSpace *space, void *data);
int lineBeganToCollideWithAsteroid (cpArbiter *arb, struct cpSpace *space, void *data);

int frogBeganToCollideWithPuddle (cpArbiter *arb, struct cpSpace *space, void *data);

@end
