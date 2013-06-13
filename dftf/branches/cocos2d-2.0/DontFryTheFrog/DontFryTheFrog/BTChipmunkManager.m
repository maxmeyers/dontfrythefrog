//
//  BTChipmunk.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTChipmunkManager.h"
#import "BTIncludes.h"

@implementation BTChipmunkManager

@synthesize space, gameLayer;

BTChipmunkManager *refToSelf;

- (id) initWithGameLayer:(BTGameLayer *)layer {
    if ((self = [super init])){
        [self scheduleUpdate];
        [self setGameLayer:layer];
        
        refToSelf = self;
            
        cpInitChipmunk();
        space = cpSpaceNew();
        space->gravity = ccp(0,0);
        space->iterations = 0; 
        
        // Fly Collisions
        cpSpaceAddCollisionHandler( space, kCollisionTypeFly, kCollisionTypeFly, &boringCollision, NULL, NULL, NULL, NULL);
        cpSpaceAddCollisionHandler( space, kCollisionTypeFly, kCollisionTypePlayer, &flyBeganToCollideWithLine, NULL, NULL, NULL, NULL);
        cpSpaceAddCollisionHandler( space, kCollisionTypeFly, kCollisionTypeFrogRadius, &flyBeganToCollideWithFrog, NULL, NULL, NULL, NULL);
        cpSpaceAddCollisionHandler( space, kCollisionTypeFly, kCollisionTypeFrogTongue, &boringCollision, NULL, NULL, NULL, NULL);
        cpSpaceAddCollisionHandler( space, kCollisionTypeFly, kCollisionTypePuddle, &boringCollision, NULL, NULL, NULL, NULL);
        
        // Player Collisions
        cpSpaceAddCollisionHandler( space, kCollisionTypePlayer, kCollisionTypeFrogRadius, &lineBeganToCollideWithFrog, NULL, NULL, NULL, NULL);
        cpSpaceAddCollisionHandler( space, kCollisionTypePlayer, kCollisionTypeFrogTongue, &lineBeganToCollideWithFrog, NULL, NULL, NULL, NULL);
        cpSpaceAddCollisionHandler( space, kCollisionTypePlayer, kCollisionTypePuddle, &boringCollision, NULL, NULL, NULL, NULL);

        
        // Frog Collisions
        cpSpaceAddCollisionHandler( space, kCollisionTypeFrogRadius, kCollisionTypeFrogTongue, &boringCollision, NULL, NULL, NULL, NULL);
        cpSpaceAddCollisionHandler( space, kCollisionTypeFrogRadius, kCollisionTypePuddle, &frogBeganToCollideWithPuddle, NULL, NULL, NULL, NULL);

        cpSpaceAddCollisionHandler(space, kCollisionTypePuddle, kCollisionTypeFrogTongue, &boringCollision, NULL, NULL, NULL, NULL);
        cpSpaceAddCollisionHandler(space, kCollisionTypePuddle, kCollisionTypePuddle, &boringCollision, NULL, NULL, NULL, NULL);

    }
    return self;
}

- (void) update: (ccTime) dt {
    // MOVE CHIPMUNK FORWARD
    int steps = 1;
    cpFloat delta = dt/(cpFloat)steps;
    
    for(int i=0; i<steps; i++){
        cpSpaceStep(space, delta);
    }
}

void playerKilledFlyPostStep (cpSpace *space, void *key, void *data) {
    BTBug *fly = (BTBug *) key;
    [[refToSelf gameLayer] flyZapped:fly];
}

void frogZappedPostStep (cpSpace *space, void *key, void *data) {
    [[refToSelf gameLayer] frogZapped];
}

void frogTouchedPuddlePostStep (cpSpace *space, void *key, void *data) {
    NSLog(@"Frog Hit Puddle");
    BTPuddle *puddle = (BTPuddle *)key;
    [[refToSelf gameLayer] frogTouchedPuddle:puddle];
}

/**
 * A collision function for when nothing should happen.
 */
int boringCollision (cpArbiter *arb, struct cpSpace *space, void *data) {
    return 0;
}

/**
 * Fly collides with player. When this occurs, a poststep callback 
 * will be added to kill the fly. Also, player score increases by one.
 */
int flyBeganToCollideWithLine (cpArbiter *arb, struct cpSpace *space, void *data) {
    if ([[[refToSelf gameLayer] player] beamActive]){
        cpShape *a, *b; cpArbiterGetShapes(arb, &a, &b);
        cpSpaceAddPostStepCallback( space, &playerKilledFlyPostStep, [[[refToSelf gameLayer] bugManager] bugByShape:a], NULL);
    }
    return 0;
}

int flyBeganToCollideWithFrog (cpArbiter *arb, struct cpSpace *space, void *data) {
    cpShape *a, *b; cpArbiterGetShapes(arb, &a, &b);
    // NOTHING HAPPENS
    return 0;
}

/**
 * Player collides with frog. Add a poststep callback to mark a gameover.
 */
int lineBeganToCollideWithFrog (cpArbiter *arb, struct cpSpace *space, void *data) {
    if ([[[refToSelf gameLayer] player] beamActive]){
        cpSpaceAddPostStepCallback( space, &frogZappedPostStep, NULL, NULL);
    }
    return 0;
}

int frogBeganToCollideWithPuddle (cpArbiter *arb, struct cpSpace *space, void *data) {
    cpShape *a, *b; cpArbiterGetShapes(arb, &a, &b);
    BTPuddle *puddle = [[refToSelf gameLayer] puddleByShape:b];
    cpSpaceAddPostStepCallback(space, &frogTouchedPuddlePostStep, puddle, NULL);
    return 0;
}
- (void) dealloc {
    cpSpaceFree(space);
    [super dealloc];
}

@end
