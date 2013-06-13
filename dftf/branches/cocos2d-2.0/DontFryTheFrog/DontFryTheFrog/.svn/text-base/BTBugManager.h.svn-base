//
//  BTFlyDelegate.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "chipmunk.h"

@class BTBug, BTGameLayer, BTSpawnSequence, BTMetasequence, BTRepeatingSpawnSequence;

@interface BTBugManager : CCNode {
    NSMutableSet *bugs;
    NSDictionary *bugZapAnimations; // Keys - bug classes, Values - CCAnimations for their untimely demise
    BTGameLayer *gameLayer;
    
    BTSpawnSequence *newbieSequence;
    BTSpawnSequence *introSequence;
    BTMetasequence *currentMetasequence;
    NSArray *types;
    NSArray *normalSequences;
    NSArray *specialSequences;
    NSArray *metasequences;
}

@property (readonly, assign) BTGameLayer *gameLayer;
@property (nonatomic, assign) NSMutableSet *bugs;
@property (nonatomic, assign) NSArray *specialSequences;

@property (nonatomic, assign) BTSpawnSequence *newbieSequence;
@property (nonatomic, assign) BTSpawnSequence *introSequence;
@property (nonatomic, assign) BTMetasequence *currentMetasequence;

- (id) initWithGameLayer:(BTGameLayer *) layer;
- (void) loadAnimations;

- (void) start;
- (void) stop;
- (void) reset;

- (NSArray *) sequencesWithRawSequences:(NSArray *) rawSequences;

- (void) addOrders:(NSArray *) orders;
- (void) addBugsOfClass:(Class) class WithQuantity: (int) n;
- (void) addBugOfClass:(Class)class atPoint:(CGPoint) point instantly:(BOOL) instant;
- (void) killBug: (BTBug *) bug;
- (CCSprite *) addIceCubeAtPosition:(CGPoint) point ForTime:(ccTime) time;

- (void) checkForUnlocks;

- (NSArray *) bugsWithinRadius:(int) radius OfPoint:(CGPoint) point;
- (BOOL) isBugInLayer:(BTBug *) fly;
- (BTBug *) bugByShape:(cpShape *) shape;
- (int) numLivingBugs;
- (NSArray *) livingBugs;

@end
