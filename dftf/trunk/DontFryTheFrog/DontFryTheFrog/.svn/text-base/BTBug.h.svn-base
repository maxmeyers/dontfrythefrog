//
//  BTFly.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/**
 * Represents a mother f'in fly. 
 *
 @param fileName the name of the starting image of the fly's sprite.
 *
 @param position the starting position of the fly
 *
 @param animation an animation for the fly
 *
 */

#import "BTObject.h"
#import "BTPopup.h"

@class BTFrog;

@interface BTBug : BTObject <BTPopupable> {
    CCSequence *wanderSequence;
    
    ccTime spawnTime;
    bool escaping;
    bool hasArrived; // true: the bug has arrived at his first spawn location
    bool readyToEat;
    bool dead;

    bool free;
    BTFrog *predator;
    
    int directionAngle;
    float speed;
    int value;
    int weight; // how much to increase the fat level
    
    CCSprite *iceCube;
    bool isFrozen;
    ccTime timeFrozen;
    ccTime freezeDuration;
    
    CFUUIDRef UUID;
    
}

@property (nonatomic, assign) CCSequence *wanderSequence;

@property bool hasArrived;
@property bool readyToEat;
@property bool dead;
@property bool isFrozen;

@property (nonatomic, assign) BTFrog *predator;
@property bool free;

@property int directionAngle;
@property float speed;
@property int value;
@property int weight;

@property CFUUIDRef UUID;

@property (nonatomic, assign) CCSprite *iceCube;


- (id) initWithFile:(NSString *)fileName Position:(CGPoint)position IdleAnimation:(CCAnimation *)animation ParentLayer:(BTGameLayer *)layer;

- (void) spawnToPosition:(CGPoint) position;
- (void) escape;

- (void) wander;
- (void) wanderWithAngle:(float) angle;
- (void) wanderToPoint: (CGPoint) point;
- (void) wanderToPoint: (CGPoint) point withSpeed: (float) speed;

- (void) didFinishMoving;

- (void) freezeForTime:(ccTime) time;
- (void) freeze;
- (void) thaw;

- (void) stop;
- (void) latch:(BTFrog *)node;
- (void) goFree;
- (void) bugWasZapped; 
- (void) bugWasEaten;

+ (CCAnimation *) animation;

@end

#import "BTPopup.h"

@interface BTBugPopup : BTPopup {
    
}
- (id) initWithClass:(Class) bugClass;

@end
