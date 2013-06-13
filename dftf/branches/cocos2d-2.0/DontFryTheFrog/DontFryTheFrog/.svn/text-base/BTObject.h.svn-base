//
//  BTObject.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/**
 * Every subclass of BTObject should instantiate the shape in its init method.
 *
 */

#import "cocos2d.h"
#import "chipmunk.h"

@class BTGameLayer;

@interface BTObject : CCNode {
    cpBody *body;
    cpShape *shape;
    CCSprite *sprite;
    CCAnimation *idleAnimation;
    
    CCAction *idleAction;
    
    CCAction *currentIdleAction;

    BTGameLayer *gameLayer;
}

- (id) initWithFile:(NSString *) fileName Position:(CGPoint) position IdleAnimation:(CCAnimation *) animation ParentLayer:(BTGameLayer *)layer;
- (void) update:(ccTime) dt;
- (void) runIdleAction;
- (void) stopIdleAction;
- (void) reset;

- (cpShape *) getShape;
- (CGPoint) getPointFrom:(CGPoint) point WithMinimumRadius:(int) minimum MaximumRadius:(int) maximum;
- (CGPoint) getNewWanderPointWithMinimumRadius:(int) minimum MaximumRadius:(int) maximum;
- (bool) isWithinDistanceFromACorner:(int) distance;

@property (nonatomic, retain) CCSprite *sprite;
@property (nonatomic, assign) CCAction *idleAction;
@property (nonatomic, assign) BTGameLayer *gameLayer;

@end
