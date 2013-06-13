//
//  BTFly.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTBug.h"

#import "BTIncludes.h"

@implementation BTBug

@synthesize wanderSequence;
@synthesize predator, free, hasArrived, readyToEat, dead, isFrozen;
@synthesize speed, value, weight;
@synthesize UUID;
@synthesize iceCube;

- (id) initWithFile:(NSString *)fileName Position:(CGPoint)position IdleAnimation:(CCAnimation *)animation ParentLayer:(BTGameLayer *)layer {
    
    if( (self=[super initWithFile:fileName Position:position IdleAnimation:animation ParentLayer:layer])) {           
        cpVect square[] = { cpv(0, 0), cpv(0, 25), cpv(25, 25), cpv(25, 0) };
        speed = [[BTConfig sharedConfig] flyMovementRate];
        
        shape = cpPolyShapeNew( body, 4, square, cpvzero);
        shape->collision_type = kCollisionTypeFly;
        
        [self setDead:YES];
        [self setFree:YES];
        escaping = NO;
        weight = 1;
        speed = [[BTConfig sharedConfig] flyMovementRate];
        
        freezeDuration = 5;
        
	}
	return self;
}

- (void) update: (ccTime) dt {
    
    [super update:dt];
    
    if (![self dead] && ([[gameLayer scene] gameState] == kGameStateStarted || [[gameLayer scene] gameState] == kGameStateNewbie)){
        if (free) {
            if ([wanderSequence isDone]){
                if (escaping){
                    escaping = NO;
                }
                [self wander];
            } else {
                float distanceToFrog = DISTANCE(self.position, [[gameLayer frog] position]);
                if (hasArrived && !escaping && distanceToFrog < kFrogRadius * [[gameLayer frog] frogScale] && !CGPointEqualToPoint(self.position, CGPointMake(0, 0))){
                    [self escape];
                } 
                
            }
        } else if (isFrozen){
            if ([gameLayer playTime] - timeFrozen > freezeDuration){
                [self thaw];
            }
        } else if (predator != nil) {
            self.position = [predator tongueTip];
        }
        
        if (![self readyToEat] && [gameLayer playTime] - spawnTime > 1.25){
            [self setReadyToEat:YES];
            if ([[BTConfig sharedConfig] debug]){
                CCLabelTTF *readyToEatLabel = [CCLabelTTF labelWithString:@"\"Eat me!\"" fontName:@"soupofjustice" fontSize:12];
                readyToEatLabel.position = self.position;
                [gameLayer addChild:readyToEatLabel z:7 tag:kPuddleTag];
                [readyToEatLabel runAction:[CCSequence actions:[CCSpawn actions:[CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:0.75f position:CGPointMake(0, 25)] rate:2], [CCFadeOut actionWithDuration:1.1f], nil], [CCCallFunc actionWithTarget:readyToEatLabel selector:@selector(removeFromParent)], nil]];    
            }
        }
    }
    sprite.position = self.position;
}

- (void) reset {
    spawnTime = INFINITY; // so that currentTime - spawnTime is tiny
    [super reset];
    [self runIdleAction];
    [gameLayer seedRandom];
    directionAngle = RANDBT(0, 359);
    
    UUID = CFUUIDCreate(kCFAllocatorDefault);
    [self setIsFrozen:NO];
    [self setDead:NO];
    [self setFree:YES];
    [self setReadyToEat:NO];
    [self setPredator:nil];
    [self setHasArrived:NO];
    escaping = NO;
}

- (void) wander {
    [gameLayer seedRandom];
    if ([self isWithinDistanceFromACorner:65]){
        [self wanderWithAngle:ROTATION_FOR_TWO_POINTS(self.position, CGPointMake(240, 160))];
    } else {
        [self wanderWithAngle:directionAngle+RANDBT(0, 360)];
    }
}

- (void) wanderWithAngle:(float) angle {
    [self setDirectionAngle:angle];

    BOOL goodPointFound = NO;
    int attempts = 50; // Don't get stuck, that would suck.
    CGPoint point;
    while (!goodPointFound && attempts > 0) {
        [gameLayer seedRandom];
        int distance = RANDBT(50, 80);
        
        point = OFFSET_FOR_ROTATION_AND_DISTANCE(directionAngle, distance);
        int distanceToFrog = DISTANCE(point, [[gameLayer frog] position]);
        // Is the spot too close to the frog? Why would you go there?
        if (distanceToFrog < kFrogRadius * [[gameLayer frog] frogScale]){
            goodPointFound = YES;
        }
        
        attempts--;
    }
    
    [self wanderToPoint:CGPointMake(self.position.x+point.x, self.position.y+point.y)];
}

- (void) wanderToPoint: (CGPoint) point {
    [self wanderToPoint:point withSpeed:speed];
}

- (void) wanderToPoint: (CGPoint) point withSpeed: (float) wanderSpeed {
    if (![wanderSequence isDone]) {
        [self stopAction:wanderSequence];
    }
    
    if (escaping) {
        wanderSpeed *= 10;
    }
    
    [wanderSequence release];
    
    int border = 30;
    
    point.x = MAX(border, MIN(point.x, 480 - border));
    point.y = MAX(border, MIN(point.y, 320 - border));
    
    CGPoint midpoint = MIDPOINT(self.position, point);
    
    ccBezierConfig bezierConfig;
    bezierConfig.controlPoint_1 = [self getPointFrom:midpoint WithMinimumRadius:30 MaximumRadius:45];
    bezierConfig.controlPoint_2 = bezierConfig.controlPoint_1;
    bezierConfig.endPosition = point;
    
    float distance = DISTANCE(self.position, bezierConfig.controlPoint_1) + DISTANCE(bezierConfig.controlPoint_1, bezierConfig.controlPoint_2) + DISTANCE(bezierConfig.controlPoint_2, point);
    float timeToTake = distance / (wanderSpeed);
    
    if (!hasArrived && timeToTake < 0.3){
        NSLog(@"too fast");
    }
    
    CCBezierTo *moveAction = [CCBezierTo actionWithDuration:timeToTake bezier:bezierConfig];
    CCCallFunc *postMove = [CCCallFunc actionWithTarget:self selector:@selector(didFinishMoving)];
    
    wanderSequence = [[CCSequence actionOne:moveAction two:postMove] retain];    
    
    [self runAction:wanderSequence];
}


- (void) didFinishMoving {
    if (!hasArrived){
        hasArrived = YES;
    }
}

- (void) spawnToPosition:(CGPoint) p {    

//    CGPoint spawnPoints[] = {
//        CGPointMake(-40, -40), CGPointMake(-40, 10), CGPointMake(-40, 60), CGPointMake(-40, 110), CGPointMake(-40, 160), CGPointMake(-40, 210), CGPointMake(-40, 260), CGPointMake(-40, 310), CGPointMake(-40, 360), 
//        CGPointMake(30, -40), CGPointMake(100, -40), CGPointMake(170, -40), CGPointMake(240, -40), CGPointMake(310, -40), CGPointMake(380, -40), CGPointMake(450, -40), CGPointMake(520, -40), 
//        CGPointMake(30, 360), CGPointMake(100, 360), CGPointMake(170, 360), CGPointMake(240, 360), CGPointMake(310, 360), CGPointMake(380, 360), CGPointMake(450, 360), CGPointMake(520, 360),
//        CGPointMake(520, 10), CGPointMake(520, 60), CGPointMake(520, 110), CGPointMake(520, 160), CGPointMake(520, 210), CGPointMake(520, 260), CGPointMake(520, 310) };
//    int count = 32;
    
    CGPoint spawnPoints[] = {
        CGPointMake(-40, 160),
        CGPointMake(240, -40),
        CGPointMake(240, 360),
        CGPointMake(520, 160) };
    int count = 4;
    
    float minDist = INFINITY;
    CGPoint *spawnPoint;
    for (int i = 0; i < count; i++){
        float distance = DISTANCE(p, spawnPoints[i]);
        if (distance < minDist){
            minDist = distance;
            spawnPoint = &spawnPoints[i];
        }
    }
    CGPoint spawn = CGPointMake(spawnPoint->x, spawnPoint->y);
    spawnTime = [gameLayer playTime];
    [self setReadyToEat:NO];
    directionAngle = ROTATION_FOR_TWO_POINTS(spawn, p);
    self.position = spawn;
    [self wanderToPoint:p withSpeed:200];
}

- (void) escape {
    int angleToFrog = ROTATION_FOR_TWO_POINTS(self.position, [[gameLayer frog] position]);
    [self wanderWithAngle:angleToFrog + 180];
    escaping = YES;
}
        
- (int) directionAngle {
    return directionAngle;
}

- (void) setDirectionAngle:(int)angle {
    directionAngle = angle;
    while (directionAngle < 0){
        directionAngle += 360;
    }
    directionAngle = directionAngle % 360;
}

/**
 * This is called when the frog picks the bug to be eaten
 */
- (void) stop {
    [wanderSequence stop];
    [self setFree:NO];
}


/**
 * This is called when a special blue bug is eaten
 */
- (void) freezeForTime:(ccTime) time {
    freezeDuration = time;
    
    [self stop];
    [self stopIdleAction];
    
    isFrozen = YES;
    [self setFree:NO];
    timeFrozen = [gameLayer playTime];
    if ([self parent] != nil && [[self parent] isMemberOfClass:[BTBugManager class]]){
        iceCube = [(BTBugManager *)[self parent] addIceCubeAtPosition:self.position ForTime:time];
    }
}

- (void) freeze {
    [self freezeForTime:5.0];
}

- (void) thaw {
    [self setFree:YES];
    isFrozen = NO;
    iceCube = nil;
    [self runIdleAction];
}

-(void) latch:(BTFrog *)frog {
    predator = frog;
}

- (void) goFree {
    [self setFree:YES];
    predator = nil;
}

- (void) bugWasZapped {
    
}

- (void) bugWasEaten {
    
}

+ (CCAnimation *) animation {
    NSDictionary *sequence = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AnimationSequences" ofType:@"plist"]] objectForKey:[[self class] description]];
    NSArray *frameNames = [sequence objectForKey:@"Frames"];
    NSArray *sequenceIndices = [sequence objectForKey:@"Sequence"];
    
    NSMutableArray *frames = [NSMutableArray array];
    for (int i = 0; i < [frameNames count]; i++){
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[frameNames objectAtIndex:i]]]; 
    }
    
    NSMutableArray *sequencedFrames = [NSMutableArray array];
    for (int i = 0; i < [sequenceIndices count]; i++){
        int index = [(NSNumber *)[sequenceIndices objectAtIndex:i] intValue];
        [sequencedFrames addObject:[frames objectAtIndex:index]];
    }
    
    return [CCAnimation animationWithFrames:sequencedFrames delay:0.1f];
}

-(void) dealloc {
    [wanderSequence release];
    cpShapeFree(shape);
    
    [super dealloc];
}

+ (BTPopup *) popup {
    return [[[BTBugPopup alloc] initWithClass:[self class]] autorelease];
}

@end

@implementation BTBugPopup

- (id) initWithClass:(Class) bugClass { 
    self = [super init];
    if (self) {
        CCLayerColor *backgroundLayer = [CCLayerColor layerWithColor:ccc4(86, 86, 86, 242) width:416 height:264];
        backgroundLayer.position = ccp(32, 28);
        [self addChild:backgroundLayer z:0];
        
        CCSprite *image = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@.png", [bugClass description]]];
        image.position = ccp(300, 170);
        [self addChild:image z:2];

        NSString *drTimFile;
        NSString *titleString;
        NSString *descriptionString;
        ccColor3B color;
        if ([bugClass isSubclassOfClass:[BTBadBug class]]){
            drTimFile = @"timsad.png";
            titleString = @"Unhealthy Fly";
            color = ccc3(255, 0, 0);
            descriptionString = [NSString stringWithFormat:@"Fry the %@ flies", [bugClass color]];
        } else if ([bugClass isSubclassOfClass:[BTGoodBug class]]){
            drTimFile = @"timhappy.png";
            titleString = @"Healthy Fly";
            color = ccc3(54, 199, 10);
            descriptionString = [NSString stringWithFormat:@"Don't fry\nthe %@ flies", [bugClass color]];
        }
        
        if (drTimFile){
            CCSprite *drTim = [CCSprite spriteWithSpriteFrameName:drTimFile];
            drTim.position = ccp(117, 114);
            [self addChild:drTim z:2];
        }
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:titleString fontName:@"soupofjustice" fontSize:60];
        title.position = ccp(240, 260);
        title.color = color;
        [self addChild:title z:2];
        
        CCLabelTTF *description = [CCLabelTTF labelWithString:descriptionString dimensions:CGSizeMake(220, 65) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:30];
        description.position = ccp(265, 60);
        description.color = color;
        [self addChild:description z:2];
     
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:2.0], [CCCallFunc actionWithTarget:self selector:@selector(enableDismiss)], nil]];
        
    }
    return self;
}

@end
