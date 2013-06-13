//
//  BTFrog.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTFrog.h"
#import "BTIncludes.h"

@implementation BTFrog

@synthesize wanderAction, preCatchSequence, catchSequence, tongueSprite;
@synthesize currentAnimationArray, currentAnimations;
@synthesize normalAnimations, fireAnimations, iceAnimations, sickAnimations;
@synthesize tongueTip, inCatchSequence, inTransition, inRespawn;
@synthesize tongueShape;
@synthesize currentEffect;
@synthesize catchInterval, frogSpeed;

BTFrogEffectZap *zapEffect;
BTFrogEffectExplode *explodeEffect;

CGPoint neutralTonguePosition;
CGRect neutralTongueRect;

-(id) initWithFile:(NSString *) fileName IdleAnimation:(CCAnimation *) animation ParentLayer:layer{

    if ( (self=[super initWithFile:fileName Position:CGPointMake(440, 80) IdleAnimation:animation ParentLayer:layer])) { 
    
        shape = cpCircleShapeNew( body, kFrogRadius, cpv(0, -3));
        shape->collision_type = kCollisionTypeFrogRadius;
        cpSpaceAddShape( [[gameLayer chipmunkManager] space], shape );
        
        cpVect line[] = { cpv(0, 0), cpv(0,0) };
        tongueShape = cpPolyShapeNew( body, 2, line, cpvzero);
        tongueShape->collision_type = kCollisionTypeFrogTongue;
        cpSpaceAddShape( [[gameLayer chipmunkManager] space], tongueShape );

        zapEffect = [[BTFrogEffectZap alloc] initWithFrog:self Duration:INFINITY];
        explodeEffect = [[BTFrogEffectExplode alloc] initWithFrog:self Duration:INFINITY];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObject:[BTFrogAnimations animationsWithBase:1 Suffix:@"-Small.png"]];
        [tempArray addObject:[BTFrogAnimations animationsWithBase:4 Suffix:@"-Medium.png"]];
        [tempArray addObject:[BTFrogAnimations animationsWithBase:7 Suffix:@"-Large.png"]];
        [self setNormalAnimations:[NSArray arrayWithArray:tempArray]];
        for (int i = 0; i < 3; i++){
            CCSprite *jawSprite = [(BTFrogAnimations *)[normalAnimations objectAtIndex:i] jawSprite];
            [jawSprite setVisible:NO];
            [self addChild:jawSprite z:0];
        }
        
        NSMutableArray *tempFireArray = [NSMutableArray array];
        [tempFireArray addObject:[BTFrogAnimationsFire animationsWithBase:1 Suffix:@"-Small.png"]];
        [tempFireArray addObject:[BTFrogAnimationsFire animationsWithBase:4 Suffix:@"-Medium.png"]];
        [tempFireArray addObject:[BTFrogAnimationsFire animationsWithBase:7 Suffix:@"-Large.png"]];
        [self setFireAnimations:[NSArray arrayWithArray:tempFireArray]];
        for (int i = 0; i < 3; i++){
            CCSprite *jawSprite = [(BTFrogAnimations *)[fireAnimations objectAtIndex:i] jawSprite];
            [jawSprite setVisible:NO];
            [self addChild:jawSprite z:0];
        }
        
        NSMutableArray *tempIceArray = [NSMutableArray array];
        [tempIceArray addObject:[BTFrogAnimationsIce animationsWithBase:1 Suffix:@"-Small.png"]];
        [tempIceArray addObject:[BTFrogAnimationsIce animationsWithBase:4 Suffix:@"-Medium.png"]];
        [tempIceArray addObject:[BTFrogAnimationsIce animationsWithBase:7 Suffix:@"-Large.png"]];
        [self setIceAnimations:[NSArray arrayWithArray:tempIceArray]];
        
        NSMutableArray *tempSickArray = [NSMutableArray array];
        [tempSickArray addObject:[BTFrogAnimationsSick animationsWithBase:1 Suffix:@"-Small.png"]];
        [tempSickArray addObject:[BTFrogAnimationsSick animationsWithBase:4 Suffix:@"-Medium.png"]];
        [tempSickArray addObject:[BTFrogAnimationsSick animationsWithBase:7 Suffix:@"-Large.png"]];
        [self setSickAnimations:[NSArray arrayWithArray:tempSickArray]];
        
        NSMutableArray *tempTongueArray = [NSMutableArray array];
        [tempTongueArray addObject:[CCSprite spriteWithSpriteFrameName:@"tongue-stretch-Small.png"]];
        [tempTongueArray addObject:[CCSprite spriteWithSpriteFrameName:@"tongue-stretch-Medium.png"]];
        [tempTongueArray addObject:[CCSprite spriteWithSpriteFrameName:@"tongue-stretch-Large.png"]];
        [self addChild:[tempTongueArray objectAtIndex:0] z:1]; [[tempTongueArray objectAtIndex:0] setVisible:NO];
        [self addChild:[tempTongueArray objectAtIndex:1] z:1]; [[tempTongueArray objectAtIndex:1] setVisible:NO];
        [self addChild:[tempTongueArray objectAtIndex:2] z:1]; [[tempTongueArray objectAtIndex:2] setVisible:NO];
        tongueSprites = [[NSArray alloc] initWithArray:tempTongueArray];
        tongueSprite = [tongueSprites objectAtIndex:0];

        [self reset];
        [self addChild:sprite z:2];
        
        [self wander];
        [wanderAction stop];
        
    }
    return self;
}


-(void) update:(ccTime)dt {
    [super update:dt];
//    self.position = ccp(999,999); // if you really want to get rid of the frog
    if ( [[gameLayer scene] gameState] == kGameStateStarted ){
        if (currentEffect != nil && [currentEffect timer] != nil && ![self inTransition]){
            [[currentEffect timer] update:dt];
        }
        
        if ([wanderAction isDone] && ![self inCatchSequence] && [self isMovable] ){
            inRespawn = NO;
            [self wander];
        }
        
        if ([gameLayer playTime] - lastCatch > 2.25 && ![self inCatchSequence] && [self isMovable]){
            [self catchFlyWithTongue];
        }
        [self updateTongueTip];
    }
    
}

- (bool) isZappable {
    return (![self beingZapped]) && (![self exploding]) && (![self takingOffHat]) && (![self inRespawn]);
}

- (bool) isMovable {
    return (![self frozen]) && (![self beingZapped]) && (![self exploding]) && (![self sick]) && (![self puddled]) && (![self inTransition]);
}

- (bool) sick {
    return [self hasEffect:[BTFrogEffectSick class]];
}

- (bool) puddled {
    return [self hasEffect:[BTFrogEffectPuddled class]];
}

- (bool) frozen {
    return [self hasEffect:[BTFrogEffectIce class]];
}

- (bool) onFire {
    return [self hasEffect:[BTFrogEffectFire class]];
}

- (bool) beingZapped {
    return [self hasEffect:[BTFrogEffectZap class]];
}
        
- (bool) exploding {
    return [self hasEffect:[BTFrogEffectExplode class]];
}

- (bool) takingOffHat {
    return [self hasEffect:[BTFrogEffectFoilHat class]];
}

- (bool) hasEffect:(id) effect {
    if (currentEffect != nil && [currentEffect class] == effect){
        return YES;
    }
    return NO;
}

- (void) stopEffect {
    if (currentEffect != nil){
        [currentEffect stop];
    }
}

- (void) removeEffect {
    if (currentEffect != nil){
        [currentEffect remove];
    }
}

- (void) wasZapped {
    [zapEffect apply];
    
    if (inCatchSequence){
        [tongueSprite stopAction:preCatchSequence];
        [tongueSprite stopAction:catchSequence];
        if ([currentAnimations jawSprite] != nil){
            [currentAnimations jawSprite].visible = NO;
        }
        [self setInCatchSequence:NO];
    }
    
    if (![wanderAction isDone]){
        [wanderAction stop];
    }
    
    if (currentBug != nil){
        [currentBug goFree];
        currentBug = nil;
        lastCatch = [gameLayer playTime];
    }
}

- (void) didExplode {
    [explodeEffect apply];
    [[BTLeapManager sharedManager] frogExplodedAtTime:[gameLayer playTime]];
}

- (void) reset {
    inRespawn = NO;
    [super reset];
    [self stopActionByTag:2837492];
    if ([self getActionByTag:kBlinkTag]){
        [self stopActionByTag:kBlinkTag];
    }
    [self setFatLevel:2];
    [[self tongueSprite] setVisible:NO];
    [self setInCatchSequence:NO];
    [self setInTransition:NO];
    [self setCurrentAnimationArray:normalAnimations];
    
    [self removeEffect];
    lastCatch = 0;
    
}

- (void) updateTongueTip {    
    int x, y;
    if (![catchSequence isDone]) { 
        tongueSprite.visible = YES;
        tongueSprite.position = CGPointMake(0, -(tongueSprite.textureRect.size.height*tongueSprite.scaleY/2));
        
        float hypotenuse = tongueSprite.textureRect.size.height * tongueSprite.scaleY * self.scale;
        CGPoint point = OFFSET_FOR_ROTATION_AND_DISTANCE(self.rotation+180, hypotenuse);
        x = point.x; y = point.y;
        tongueTip = CGPointMake(self.position.x + x, self.position.y + y);

    } else {
        tongueSprite.visible = NO;
        x = 0; y = 0;
    }
    cpVect line[] = { cpv(0,0), cpv(x,y) };
    cpPolyShapeSetVerts(tongueShape, 2, line, cpvzero);
}

- (void) openingWaddle {
    self.visible = YES;
    tongueSprite.visible = NO;
    CGPoint point = ccp(240, 160);
    float timeToTake = 3.0f;
    self.rotation = ROTATION_FOR_TWO_POINTS(self.position, point) - 180;
    
    CCMoveTo *tempMoveTo = [CCMoveTo actionWithDuration:timeToTake position:point];
    CCSequence *sequence = [CCSequence actions:tempMoveTo, [CCCallFunc actionWithTarget:gameLayer selector:@selector(waddlingDidFinish)], nil];
    sequence.tag = 2837492;
    [self runAction:sequence];
}

- (void) respawnWaddle {
    CGPoint point = ccp(240, 160);
    float timeToTake = 3.0f;
    self.position = ccp(240, 370);
    inRespawn = YES;
    [self wanderToPoint:point Time:timeToTake WithTag:kWanderActionDoNotInterrupt];
    CCEaseIn *blinkIn = [CCEaseIn actionWithAction:[CCBlink actionWithDuration:timeToTake-.05 blinks:timeToTake/.2] rate:2];
    blinkIn.tag = kBlinkTag;
    [self runAction:blinkIn];
}

-(void) wander {
    CGPoint newPoint = [self getNewWanderPointWithMinimumRadius:[[BTConfig sharedConfig] frogWanderRadiusMinimum] MaximumRadius:[[BTConfig sharedConfig] frogWanderRadiusMaximum]];
//    newPoint = CGPointMake(240, 20);
    // Froggy seems to disappear if he wanders to his current position
    // Don't worry, we'll get another point at next tick.
    if (!CGPointEqualToPoint(newPoint, self.position)){
        [self wanderToPoint:newPoint];
    }
}

- (void) wanderToPoint:(CGPoint) point {
    float timeToTake = DISTANCE(self.position, point) / [[BTConfig sharedConfig] frogMovementRate]; 
    [self wanderToPoint:point Time:timeToTake WithTag:kWanderActionOkayToInterrupt];
}

- (void) wanderToPoint:(CGPoint) point Time:(float) time WithTag:(int) tag {
    [wanderAction release];
    
    self.rotation = ROTATION_FOR_TWO_POINTS(self.position, point) - 180;
    
    wanderAction = [[CCMoveTo alloc] initWithDuration:time position:point];
    wanderAction.tag = tag;
    [self runAction:wanderAction];
}

#pragma mark -
#pragma mark Tongue Stuff
//***************************************************
// Tongue Stuff
//***************************************************

- (bool) checkBug:(BTBug *) bug {
    int distance = DISTANCE(self.position, [bug position]);
    if (   [bug free] 
        && ![bug dead] 
        && [bug readyToEat]
        && distance > kFrogRadius*1.25*[self frogScale]
        ) {
        return YES;
    }
    return NO;
}

CFUUIDRef bugUUID; // The UUID of the bug that we're trying to catch.

/**
 * Picks a fly, and tells the frog to try to catch it
 */
-(void) catchFlyWithTongue {
    lastCatch = [gameLayer playTime];
    
    if (![wanderAction isDone] && wanderAction.tag == kWanderActionDoNotInterrupt){
        return;
    }
    
    BTBug *bug = nil;
    
    NSEnumerator *e = [[[gameLayer bugManager] bugs] objectEnumerator];
    NSMutableArray *badBugs = [NSMutableArray array];
    NSMutableArray *goodBugs = [NSMutableArray array];
    NSMutableArray *drones = [NSMutableArray array];
    
    while ((bug = [e nextObject])){
        if ([bug isKindOfClass:[BTBadBug class]] && [self checkBug:bug]){
            [badBugs addObject:bug];
        } else if ([bug isKindOfClass:[BTGoodBug class]] && [self checkBug:bug]){
            [goodBugs addObject:bug];
        } else if ([bug isMemberOfClass:[BTFly class]] && [self checkBug:bug]){
            [drones addObject:bug];
        }
    }
    
    bool bugFound = NO;
    float minDistance = INFINITY;
    BTBug *minBug = nil;
    if ([badBugs count] > 0){
        // TODO: Pick a random fly instead of the first one
//        [badBugs shuffle];
        e = [badBugs objectEnumerator];
        while (!bugFound && (( bug = [e nextObject]))){
            float distance = DISTANCE(self.position, bug.position);
            if (distance < minDistance){
                minDistance = distance;
                minBug = bug;
            }
        }
    }
    
    if (minBug != nil){
        bugFound = YES;
    }
    
    if (!bugFound && [goodBugs count] > 0){
        // TODO: Pick a random fly instead of the first one
        [goodBugs shuffle];
        e = [goodBugs objectEnumerator];
        while (!bugFound && (( bug = [e nextObject]))){
            float distance = DISTANCE(self.position, bug.position);
            if (distance < minDistance){
                minDistance = distance;
                minBug = bug;
            }        
        }
    }
    
    if (minBug != nil){
        bugFound = YES;
    }
    
    if (!bugFound && [drones count] > 0){
        [drones shuffle];
        e = [drones objectEnumerator];
        while (!bugFound && (( bug = [e nextObject]))){
            float distance = DISTANCE(self.position, bug.position);
            if (distance < minDistance){
                minDistance = distance;
                minBug = bug;
            }
        }
    }
    
    if (minBug != nil){
        bugFound = YES;
    }
    
    if (!bugFound){
        minBug = nil;
    }
    
    if (minBug != nil){
        bugUUID = [minBug UUID];
        currentBug = minBug;
        [self catchFly:minBug];
    }
    
//    NSArray *livingBugs = [[gameLayer bugManager] livingBugs];
//    e = [livingBugs objectEnumerator];
//    while ((bug = [e nextObject])){
//        if ([bug hasArrived]){
//            [bug setReadyToEat:YES];
//        }
//    }
}

/**
 * Helper method for catchFlyWithTongue
 */
- (void) catchFly:(BTBug *) bug {
    if (!inCatchSequence){
        [preCatchSequence release];
        [wanderAction stop];
        [self setInCatchSequence:YES];

        
        float newRotation = ROTATION_FOR_TWO_POINTS(self.position, [bug position]) + 180;
        float timeToRotate = fmod(fabs(self.rotation - newRotation), 360) / 400;

        CCCallFunc *stopBugAction = [CCCallFunc actionWithTarget:bug selector:@selector(stop)];
        CCRotateTo *rotateFrogAction = [CCRotateTo actionWithDuration:timeToRotate angle:newRotation];
        CCCallFunc *openMouthAction = [CCCallFunc actionWithTarget:self selector:@selector(openMouth)];
        CCCallFuncND *tongueGrabAction = [CCCallFuncND actionWithTarget:self selector:@selector(tongueGrab:Bug:) data:bug];

        preCatchSequence = [[CCSequence actions:stopBugAction, rotateFrogAction, openMouthAction, tongueGrabAction, nil] retain];
        
        [self runAction:preCatchSequence];
    }
}
                                         
- (void) openMouth {
    if ([currentAnimations jawSprite] != nil){
        [currentAnimations jawSprite].visible = YES;
    }
    CCAction *openMouth = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[currentAnimations openAnimation] restoreOriginalFrame:NO]];
    [openMouth setTag:2389410];
    [sprite runAction:openMouth];
}

- (void) tongueGrab:(id)sender Bug:(BTBug *)bug {
    [catchSequence release];

    [self stopIdleAction];
    
    float distance = DISTANCE([bug position], self.position);
    float timeToTongue = distance / [[BTConfig sharedConfig] frogCatchRate];
    
    CCScaleTo *stretchAction = [CCScaleTo actionWithDuration:timeToTongue scaleX:1 scaleY:distance/tongueSprite.textureRect.size
                                .height/self.scale];
    CCCallFuncND *latchAction = [CCCallFuncND actionWithTarget:self selector:@selector(latch:data:) data:bug];
    CCSequence *grabSequence = [CCSequence actions:stretchAction, latchAction, nil];
    
    CCScaleTo *unstretchAction = [CCScaleTo actionWithDuration:timeToTongue scaleX:1 scaleY:.15];
    CCCallFuncND *killBugAction = [CCCallFuncND actionWithTarget:self selector:@selector(eat:data:) data:bug];
    CCSequence *eatSequence = [CCSequence actions:unstretchAction, killBugAction, nil];
    
    catchSequence = [[CCSequence actions:grabSequence, eatSequence, nil] retain];
    
    [tongueSprite runAction:catchSequence];
}

-(void) latch:(id)node data:(BTBug *)bug {
    if (![bug dead] && [bug UUID] == bugUUID){
        [bug latch:self];
    }
}

-(void) eat:(id)node data:(BTBug *)bug {
    [sprite stopActionByTag:2389410];
    if (![bug dead] && [bug UUID] == bugUUID){
        [[gameLayer scene] setFliesEaten:[[gameLayer scene] fliesEaten]+1];
        [gameLayer AddToKillDictionaryBugClass:[[bug class] description] Method:@"Eats"];
        [[gameLayer bugManager] killBug:bug];
        

        if ([currentAnimations jawSprite] != nil){
            [currentAnimations jawSprite].visible = NO;
        }
        
        if ([currentAnimations eatAnimation] != nil) {
            [sprite runAction:[CCSequence actions:
                               [CCAnimate actionWithAnimation:[currentAnimations eatAnimation] restoreOriginalFrame:NO], 
                               [CCCallFuncND actionWithTarget:self selector:@selector(finishedEating:data:) data:bug], 
                               nil]
             ];
        } else {
            if ([currentAnimations jawSprite] != nil){
                [currentAnimations jawSprite].visible = NO;
            }
            [self setInCatchSequence:NO];
            [self finishedEating:self data:bug];
        }
    } else {
        if ([currentAnimations jawSprite] != nil){
            [currentAnimations jawSprite].visible = NO;
        }
        
        [self setInCatchSequence:NO];
        if (currentEffect == nil){
            [self runIdleAction];
        }
    }
    lastCatch = [gameLayer playTime];    
    bugUUID = nil;
}

- (void) finishedEating:(id) node data:(BTBug *)bug {
    
    [[BTLeapManager sharedManager] bugEatenOfClass:[bug class]];
    
    if (fatLevel < [[BTConfig sharedConfig] frogMaxFatLevel] && ([bug weight] > 0 || ([self onFire] && [bug isMemberOfClass:[BTFireBug class]]))){
        int additionalLevels = [bug weight];
        if ([bug isMemberOfClass:[BTFireBug class]]){
            additionalLevels = 1;
        }
        [self setFatLevel:fatLevel + additionalLevels];
        [[SimpleAudioEngine sharedEngine] playEffect:@"FrogGrow.m4a"];
    }
    
    if (![self exploding] && ![self beingZapped]){
        [bug bugWasEaten];
    }
    
    [self setInCatchSequence:NO];
    if ((currentEffect == nil || (currentEffect != nil && [currentEffect class] == [BTFrogEffectFire class])) && ![self inTransition]){
        [self runIdleAction];
    }
}

#pragma mark -
#pragma mark Getters and Setters
//***************************************************
// Getters and Setters
//***************************************************


-(void) setScale:(float)scale {
    [super setScale:scale];
    cpCircleShapeSetRadius(shape, kFrogRadius*[self frogScale]);
}

// Scale compared to fatLevel = 0.
- (float) frogScale {
    // I apologize for the meaninglessness of this code. Oh well.
    int base = 0;
    if ([currentAnimations base] == 1){
        base = 59;
    } else if ([currentAnimations base] == 4){
        base = 100;
    } else if ([currentAnimations base] == 7){
        base = 168;
    }
    
    return (base*self.scale)/50;
}

+ (int) indexForLevel:(int) level {
    if (level >= 0 && level <= 0){
        return 0;
    } else if (level >= 1 && level <= 3){
        return 1;
    } else if (level >= 4){
        return 2;
    }
    
    return -1;
}

- (void) setCurrentAnimationArray:(NSArray *)array { 
    currentAnimationArray = array;
    currentAnimations = [currentAnimationArray objectAtIndex:[BTFrog indexForLevel:fatLevel]];
}

- (void) setAnimationDelay:(float) delay {
    [self stopIdleAction];
    animationDelay = delay;
    [idleAnimation setDelay:animationDelay];
    [self runIdleAction];
}

- (void) setAnimations:(int) level {
    [self stopIdleAction];
    
    currentAnimations = [currentAnimationArray objectAtIndex:[BTFrog indexForLevel:level]];
    
    tongueSprite.visible = NO; // old tongueSprite
    if ([currentAnimations idleAnimation] != nil){
        idleAnimation = [currentAnimations idleAnimation];
    }
     
    if ([currentAnimations tongue]){
        [self setTongueSprite:[tongueSprites objectAtIndex:[BTFrog indexForLevel:level]]];
        if ([[gameLayer scene] gameState] == kGameStateStarted){
            tongueSprite.visible = YES; // new tongueSprite
        }
        tongueSprite.scaleY = 0.15f;
    }
    
    if ([currentAnimations jawSprite] != nil){
        [currentAnimations jawSprite].visible = NO;
    }
        
    int difference = [currentAnimations base] - level;
    if (difference == 0) {
        [self setScale:1.0f];
    }else if (difference == 1){
        [self setScale:0.84089641525371f];
    } else if (difference == 2){
        [self setScale:0.70710678118655f];
    } else if (difference == 3){
        [self setScale:0.59460355750136f];
    } else if (difference == -1){
        [self setScale:1.18920711500272f];
    }
    
    if (![self sick]){
        [idleAnimation setDelay:animationDelay];
        [self runIdleAction];
    }
}

- (int) fatLevel {
    return fatLevel;
}

- (void) setFatLevel:(int) f {  
    f = MIN(f, [[BTConfig sharedConfig] frogMaxFatLevel] );
    
    // The following is a very very cheap and bad way of doing:
    // "Frog starts @ growth size 2, grows to 4, grows to 7, explodes."
    // I'd rather not get rid of all the work done on 8 separate fat levels, so there. Also, I'm lazy.
    // It assumes the only bug that will ever cause the frog to gain weight has a weight of 1.
    if (fatLevel == 2 && f == 3){
        f = 4;
    } else if (fatLevel == 4 && f == 5){
        f = 7;
    } else if (fatLevel == 7 && f == 8){
        f = 8;
    } else if (f < fatLevel){
        f = 2;
    }
    fatLevel = f;

    [self setAnimations:fatLevel];
    
    if (fatLevel == [[BTConfig sharedConfig] frogMaxFatLevel]) {
        [self didExplode]; 
    }
    
    if (![catchSequence isDone]){
        [sprite stopActionByTag:2389410];
        [catchSequence stop];
    }
}

- (void) pauseSchedulerAndActions {
    [super pauseSchedulerAndActions];
    [sprite pauseSchedulerAndActions];
    [tongueSprite pauseSchedulerAndActions];
}

- (void) resumeSchedulerAndActions {
    [super resumeSchedulerAndActions];
    [sprite resumeSchedulerAndActions];
    [tongueSprite resumeSchedulerAndActions];
}

- (void) dealloc {
    [wanderAction release];
    [catchSequence release];
    [normalAnimations release];
    [fireAnimations release];
    [sickAnimations release];
    [tongueSprites release];
    cpShapeFree(shape);
    cpShapeFree(tongueShape);
    [super dealloc];
}

+ (CCAnimation *) animation {
    return [BTStorageManager animationWithString:@"BTFrog" atInterval:0.1 Reversed:NO Suffix:@"-Small.png"];
}

@end