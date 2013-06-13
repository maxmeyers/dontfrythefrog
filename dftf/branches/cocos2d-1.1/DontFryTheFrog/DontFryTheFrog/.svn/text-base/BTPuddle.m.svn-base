//
//  BTPuddle.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/1/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTPuddle.h"
#import "BTIncludes.h"

@implementation BTPuddle

- (id) initWithFile:(NSString *)fileName Position:(CGPoint)position IdleAnimation:(CCAnimation *)animation ParentLayer:(BTGameLayer *)layer Size:(CGSize) s {
    self = [super initWithFile:fileName Position:position IdleAnimation:animation ParentLayer:layer];
    if (self) {
        puddleState = kBubblingUp;
        size = s;
        CGPoint points[] = { CGPointMake(-size.width/2, -size.height/2), CGPointMake(-size.width/2, size.height/2), CGPointMake(size.width/2, size.height/2), CGPointMake(size.width/2,-size.height/2) };
        shape = cpPolyShapeNew(body, 4, points, cpv(0, 0));
        shape->collision_type = kCollisionTypePuddle;
        cpSpaceAddShape( [[gameLayer chipmunkManager] space], shape );
        
        CCAnimation *bubbleUp = [BTStorageManager animationWithString:@"BTSickPuddle" atInterval:0.1 Reversed:NO];
        CCAnimation *stayThere = [CCAnimation animationWithFrames:[NSArray arrayWithObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"sick-puddle7.png"]] delay:100];
        CCSequence *puddleSequence = [CCSequence actions:[CCCallBlock actionWithBlock:^(void){
            puddleState = kBubbled;
        }], [CCAnimate actionWithAnimation:stayThere restoreOriginalFrame:NO], nil];
        
        CCSprite *puddleSprite = [CCSprite spriteWithSpriteFrameName:@"sick-puddle1.png"];
        [self addChild:puddleSprite z:0 tag:1];
                
        [puddleSprite runAction:[CCSequence actions:[CCAnimate actionWithAnimation:bubbleUp restoreOriginalFrame:NO], [CCSpawn actions:[CCCallBlock actionWithBlock:^(void) {
            CCMoveBy *movePuddle = [CCMoveBy actionWithDuration:10 position:CGPointMake(480+size.width/2, 0)];
            [self runAction:movePuddle];
        }], puddleSequence, nil], nil]];
        
        timer = [[CCTimer timerWithTarget:self selector:@selector(evaporate) interval:10] retain];
    }
    
    return self;
}

- (void) update:(ccTime)dt {
    [super update:dt];
    if (puddleState != kEvaporating){
        [timer update:dt];
    }
}

- (void) draw {
    if ([[BTConfig sharedConfig] debug]){
        glLineWidth(2);
        glColor4f(255, 255, 0, 255);

        if (self.scale == 1.0){
            CGPoint points[] = { CGPointMake(-size.width/2, -size.height/2), CGPointMake(-size.width/2, size.height/2), CGPointMake(size.width/2, size.height/2), CGPointMake(size.width/2, -size.height/2) };
            ccDrawPoly(points, 4, YES);
            
        } else if (self.scale == 0.5){
            CGPoint points[] = { CGPointMake(-size.width, -size.height), CGPointMake(-size.width, size.height), CGPointMake(size.width, size.height), CGPointMake(size.width, -size.height) };
            ccDrawPoly(points, 4, YES);
        }
    }
}
                 
- (void) evaporate {
    if (puddleState == kBubbled){
        CCSprite *puddleSprite = (CCSprite *)[self getChildByTag:1];
        [puddleSprite runAction:[CCSequence actions:[CCFadeOut actionWithDuration:2.0], 
                           [CCCallBlock actionWithBlock:^(void){
            [[puddleSprite parent] removeFromParentAndCleanup:YES];
        }], 
                           nil]];
        puddleState = kEvaporating;
    } else {
        [timer setInterval:0.1];
    }
}

- (void) pauseSchedulerAndActions {
    [super pauseSchedulerAndActions];
    CCSprite *puddleSprite = (CCSprite *)[self getChildByTag:1];
    if (puddleSprite){
        [puddleSprite pauseSchedulerAndActions];
    }
}

- (void) resumeSchedulerAndActions {
    [super resumeSchedulerAndActions];
    CCSprite *puddleSprite = (CCSprite *)[self getChildByTag:1];
    if (puddleSprite){
        [puddleSprite resumeSchedulerAndActions];
    }
}

- (void) dealloc {
    [timer release];
    cpSpaceRemoveShape([[gameLayer chipmunkManager] space], shape);
    cpShapeFree(shape);
    [super dealloc];
}

@end
