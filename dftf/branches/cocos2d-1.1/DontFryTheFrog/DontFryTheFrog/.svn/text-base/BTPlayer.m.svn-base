//
//  BTPlayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTPlayer.h"
#import "BTIncludes.h"
#import "SimpleAudioEngine.h"

@implementation BTPlayer

@synthesize touch0, touch1;

CCTimer *decayTimer;

- (id) initWithFile:(NSString *) fileName Position:(CGPoint) position IdleAnimation:(CCAnimation *) animation ParentLayer:(BTGameLayer *)layer {
    sputtered_ = NO;
    sputtering_ = NO;
    touchesRemoved_ = 0;
    touch0 = nil;
    touch1 = nil;
    
    NSMutableArray *lightningFrames = [NSMutableArray arrayWithCapacity:4];
    for (int i = 1; i <=4; i++){
        [lightningFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"beam-%d.png", i]]];
    }
    CCAnimation *lightningAnimation = [CCAnimation animationWithFrames:lightningFrames delay:0.07f];
    
    if ( (self=[super initWithFile:fileName Position:position IdleAnimation:lightningAnimation ParentLayer:layer])) { 
        [self unscheduleUpdate];
        [self reset];
        
//        decayTimer = [[CCTimer alloc] initWithTarget:self selector:@selector(decay) interval:0.2];
        decayTimer = [[CCTimer timerWithTarget:self selector:@selector(decay) interval:0.2] retain];
        sprite.opacity = 0;
//		touches = [[NSMutableArray arrayWithCapacity:10] retain]; 
        
        shape = cpSegmentShapeNew( body, cpv(-1000,-1000), cpv(-1000,-1000), 2);
        shape->collision_type = kCollisionTypePlayer;
        cpSpaceAddShape( [[gameLayer chipmunkManager] space], shape );
        
        [self addChild:sprite];
    }
    return self;
}

- (void) sputter {
    sputtered_ = NO;
    sputtering_ = YES;
    timeSinceSputtered_ = 0;
    touchesRemoved_ = 0;
    
    CCBlink *sputterOut = [CCEaseOut actionWithAction:[CCBlink actionWithDuration:0.5 blinks:5] rate:2];
    CCCallBlock *stopSputtering = [CCCallBlock actionWithBlock:^(void) {
        sputtering_ = NO;
        sputtered_ = YES;
    }];
    
    CCSequence *sputterSequence = [CCSequence actions:sputterOut, stopSputtering, nil];
    sputterSequence.tag = kSputterSequenceTag;
    [sprite runAction:sputterSequence];
    
    CCLabelTTF *notification = [CCLabelTTF labelWithString:@"Beam disabled!" fontName:@"soupofjustice" fontSize:26];
    notification.position = ccp(240, -22);
    notification.color = ccRED;
    [gameLayer addChild:notification z:3 tag:kSputterNotificationTag];
    [notification runAction:[CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:0.25 position:ccp(240, 22)] rate:2]];
}

- (void) unSputter {
    [sprite stopActionByTag:kSputterSequenceTag];

    if ([gameLayer getChildByTag:kSputterNotificationTag]){
        CCLabelTTF *notification = (CCLabelTTF *)[gameLayer getChildByTag:kSputterNotificationTag];
        CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:0.25];
        CCCallFunc *remove = [CCCallFunc actionWithTarget:notification selector:@selector(removeFromParent)];
        [notification runAction:[CCSequence actionOne:fadeOut two:remove]];
    }
    
    sprite.visible = YES;
    sputtered_ = NO;
    sputtering_ = NO;
}

- (void) decay {
    [[gameLayer scene] addToMultiplier:-0.2];
}

- (void) update:(ccTime) dt {
    bool active = NO;
    
    if (sputtered_){
        timeSinceSputtered_ += dt;
        if (touchesRemoved_ >= 2 && timeSinceSputtered_ >= 0.5){
            [self unSputter];
        }
    }
    
    if ([self getNumTouches] >= 2 && (!sputtered_ || sputtering_)){
        UITouch *origin = touch0;
        UITouch *destination = touch1;
        
        CGPoint bottom = [self convertTouchToNodeSpace: origin];
        CGPoint top = [self convertTouchToNodeSpace: destination];
        float distance = DISTANCE(bottom, top);

        // use this to add a minimum distance for the beam
        if (distance > 0){
            active = YES;
            cpSegmentShapeSetEndpoints(shape, cpv(top.x, top.y), cpv(bottom.x, bottom.y));
            
            sprite.rotation = ROTATION_FOR_TWO_POINTS(bottom, top);
            sprite.position = cpv((bottom.x+top.x)/2, (bottom.y+top.y)/2);
            sprite.scaleY = distance/348;
        }
        
    } else {
        [decayTimer update:dt];
    }
    
    if (active) {          
        sprite.opacity = 255;
    } else {
        sprite.opacity = 0;
    }
}

- (void) draw {
    if ([self beamActive] && [[BTConfig sharedConfig] debug]){
        glLineWidth(1);
        glColor4f(255, 0, 0, 255);

        UITouch *origin = touch0;
        UITouch *destination = touch1;	
        
        CGPoint bottom = [self convertTouchToNodeSpace: origin];
        CGPoint top = [self convertTouchToNodeSpace: destination];
        ccDrawLine(bottom, top);
    }
}

- (void) reset {
    [super reset];
}

- (bool) beamActive {
    return ([self getNumTouches] >=2 && !sputtered_ && !sputtering_);
}

-(void) addTouch:(UITouch *) touch {
    if (touch0 == nil){
        touch0 = touch;
    } else if (touch1 == nil){
        touch1 = touch;
    }
}

-(void) removeTouch:(UITouch *) touch {
    if (touch0 == touch){
        touch0 = nil;
    } else if (touch1 == touch){
        touch1 = nil;
    }
    
    if (sputtered_ || sputtering_){
        touchesRemoved_++;
    }
}

-(int) getNumTouches {
    int count = 0;
    if (touch0 != nil){ count++; }
    if (touch1 != nil){ count++; }
    
    return count;
}

-(cpShape *) getShape {
    return shape;
}

float prePauseVisibility = 255;

- (void) pauseSchedulerAndActions {
    [super pauseSchedulerAndActions];
    prePauseVisibility = sprite.opacity;
    sprite.opacity = 0;
}

- (void) resumeSchedulerAndActions {
    [super resumeSchedulerAndActions];
    sprite.opacity = prePauseVisibility;
}

- (void) dealloc {
    [decayTimer release];
    cpShapeFree(shape);
    [super dealloc];
}

@end
