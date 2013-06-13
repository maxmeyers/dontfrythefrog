//
//  BTFrog.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTObject.h"

@class BTBug, BTFrogAnimations, BTFrogEffect;

@interface BTFrog : BTObject {
    CCAction *wanderAction;
    CCSequence *preCatchSequence;
    CCSequence *catchSequence;
    CCSprite *tongueSprite;
    
    NSArray *currentAnimationArray;
    BTFrogAnimations *currentAnimations;
    float animationDelay;
    
    NSArray *normalAnimations;
    NSArray *fireAnimations;    
    NSArray *iceAnimations;
    NSArray *sickAnimations;
    NSArray *tongueSprites;
    
    CGPoint tongueTip;
    ccTime catchInterval;
    ccTime lastCatch;
    float frogSpeed;
    
    int fatLevel;
    BOOL inCatchSequence;
    bool inTransition;
    bool inRespawn;
    BTBug *currentBug;
    
    BTFrogEffect *currentEffect;
    
    cpShape *tongueShape;
}

#define kWanderActionDoNotInterrupt 1
#define kWanderActionOkayToInterrupt 2
#define kBlinkTag 3

@property (nonatomic, retain) CCAction *wanderAction;
@property (nonatomic, assign) CCSequence *preCatchSequence;
@property (nonatomic, assign) CCSequence *catchSequence;
@property (nonatomic, assign) CCSprite *tongueSprite;

@property (nonatomic, assign) NSArray *currentAnimationArray;
@property (nonatomic, assign) BTFrogAnimations *currentAnimations;

@property (nonatomic, retain) NSArray *normalAnimations;
@property (nonatomic, retain) NSArray *fireAnimations;
@property (nonatomic, retain) NSArray *iceAnimations;
@property (nonatomic, retain) NSArray *sickAnimations;

@property CGPoint tongueTip;
@property ccTime catchInterval;
@property float frogSpeed;

@property int fatLevel;
@property BOOL inCatchSequence;
@property bool inTransition;
@property bool inRespawn;

@property (nonatomic, assign) BTFrogEffect *currentEffect;
@property (nonatomic, assign) cpShape *tongueShape;


-(id) initWithFile:(NSString *) fileName IdleAnimation:(CCAnimation *) animation ParentLayer:layer;
- (void) updateTongueTip;
- (float) frogScale;

- (void) setAnimationDelay:(float) delay;
- (void) setAnimations:(int) level;
- (void) stopEffect;
- (void) removeEffect;

- (bool) isZappable;
- (bool) isMovable;

- (void) wasZapped;
- (void) didExplode;

- (bool) frozen;
- (bool) sick;
- (bool) puddled;
- (bool) onFire;
- (bool) beingZapped;
- (bool) exploding;
- (bool) takingOffHat;
- (bool) hasEffect:(id) effect;

- (bool) checkBug:(BTBug *)bug;
- (void) catchFlyWithTongue;
- (void) catchFly:(BTBug *)fly;

- (void) openingWaddle;
- (void) respawnWaddle;

- (void) wander;
- (void) wanderToPoint:(CGPoint) point;
- (void) wanderToPoint:(CGPoint) point Time:(float) time WithTag:(int) tag;

- (void) latch:(id)node data:(BTBug *)fly;
- (void) openMouth;
- (void) eat:(id)node data:(BTBug *)fly;
- (void) finishedEating:(id) node data:(BTBug *)bug;

+ (int) indexForLevel:(int) level;
+ (CCAnimation *) animation;

@end