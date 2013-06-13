//
//  BTObject.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTObject.h"
#import "BTIncludes.h"

@implementation BTObject

@synthesize sprite, idleAction, gameLayer;

-(id) init {
    if( (self=[super init])) {
        [self scheduleUpdate];
    }
    return self;
}

- (id) initWithFile:(NSString *) fileName Position:(CGPoint) position IdleAnimation:(CCAnimation *) animation ParentLayer:(BTGameLayer *)layer {

    if( (self=[super init])) {
        self.gameLayer = layer;
        self.position = position;
        idleAction = nil;
        
        [self scheduleUpdate];
        
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
//        [CCTexture2D setDefaultAlphaPixelFormat:kTexture2DPixelFormat_RGB5A1];
        if (fileName != nil){
            sprite = [[CCSprite alloc] initWithSpriteFrameName:fileName];
        }

        body = cpBodyNew(INFINITY, INFINITY);
        body->p.x = self.position.x; body->p.y = self.position.y;
        
        if (animation != nil) {
            idleAnimation = [animation retain];
            [self runIdleAction];
        }

    }
    return self;
}

-(void) update:(ccTime) dt {
    
    // Update members' positions
    body->p.x = self.position.x; body->p.y = self.position.y;
}

- (void) runIdleAction {
    if (idleAnimation != nil){
        [sprite stopAction:idleAction];
        idleAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames:[idleAnimation frames] delay:[idleAnimation delay]] restoreOriginalFrame:NO]];
        [sprite runAction:idleAction];
    }
}

- (void) stopIdleAction {
    if (idleAction != nil){
        [sprite stopAction:idleAction];
        idleAction = nil;
    }
}

- (void) reset {
    
}

-(cpShape *) getShape {
    return shape;
}

-(CGPoint) getPointFrom:(CGPoint) point WithMinimumRadius:(int) minimum MaximumRadius:(int) maximum {
    minimum = MAX(minimum, 1);
    
    [gameLayer seedRandom];
    
    int radius = RANDBT(minimum, maximum);
    int angle = RANDBT(0, 360);
    
//    [gameLayer seedRandom];
//    float x = RANDBT(-radius/2, radius/2);
//    [gameLayer seedRandom];
//    float y = RANDBT(-radius/2, radius/2);
    
    float angleRadians = CC_DEGREES_TO_RADIANS(angle);
    CGPoint newPoint = CGPointMake(cosf(angleRadians)*radius, sinf(angleRadians)*radius);
    
    newPoint.x = point.x + newPoint.x; 
    newPoint.y = point.y + newPoint.y;
    
    int border = 50;
    
    newPoint.x = MAX(border, MIN(newPoint.x, 480-border));
    newPoint.y = MAX(border, MIN(newPoint.y, 320-border));
    
    return newPoint;
}

-(CGPoint) getNewWanderPointWithMinimumRadius:(int) minimum MaximumRadius:(int) maximum {
    return [self getPointFrom:self.position WithMinimumRadius:minimum MaximumRadius:maximum];
}

-(void) dealloc {
    [sprite release];
    cpBodyFree(body);
    [super dealloc];
}

- (bool) isWithinDistanceFromACorner:(int) distance {
    int minDistanceFromCorner = INFINITY;
    
    if (DISTANCE(self.position, CGPointMake(0, 0)) < minDistanceFromCorner){
        minDistanceFromCorner = MIN(minDistanceFromCorner, DISTANCE(self.position, CGPointMake(0, 0)));
    } 
    if (DISTANCE(self.position, CGPointMake(480, 0)) < minDistanceFromCorner){
        minDistanceFromCorner = MIN(minDistanceFromCorner, DISTANCE(self.position, CGPointMake(480, 0)));
    } 
    if (DISTANCE(self.position, CGPointMake(0, 320)) < minDistanceFromCorner){
        minDistanceFromCorner = MIN(minDistanceFromCorner, DISTANCE(self.position, CGPointMake(0, 320)));
    } 
    if (DISTANCE(self.position, CGPointMake(480, 320)) < minDistanceFromCorner){
        minDistanceFromCorner = MIN(minDistanceFromCorner, DISTANCE(self.position, CGPointMake(480, 320)));
    } 
    
    if (minDistanceFromCorner < distance){
        return YES;
    }
    
    return NO;
}

@end
