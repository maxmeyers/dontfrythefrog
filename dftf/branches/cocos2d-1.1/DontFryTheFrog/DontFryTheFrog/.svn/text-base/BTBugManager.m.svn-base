//
//  BTFlyDelegate.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTBugManager.h"
#import "BTIncludes.h"

@implementation BTBugManager

@synthesize gameLayer, bugs, specialSequences, newbieSequence, introSequence, currentMetasequence;


CCSpriteBatchNode *flySheet;

CGPoint lastFryPosition;

- (id) initWithGameLayer:(BTGameLayer *) layer {
    if ((self = [super init])){
        [self scheduleUpdate];
        [self reset];
        
        gameLayer = layer;
               
        flySheet = [CCSpriteBatchNode batchNodeWithFile:@"BTBugs.pvr.ccz"];
        [self addChild:flySheet];        
                
        bugs = [[NSMutableSet alloc] initWithCapacity:45];
        
        [self loadAnimations];
        
        [self start];
        
    }
    return self;
}

- (void) loadAnimations {
    BTBug *bug;
    CCAnimation *flyAnimation = [BTFly animation];
    for (int i = 0; i < 25; i++){
        bug = [[BTFly alloc] initFlyWithAnimation:flyAnimation GameLayer:gameLayer];
        [bugs addObject:bug];
        [bug release];
    }
    
    
    flyAnimation = [BTSickBug animation];
    for (int i = 0; i < 5; i++){
        bug = [[BTSickBug alloc] initFlyWithAnimation:flyAnimation GameLayer:gameLayer];            
        [bugs addObject:bug];
        [bug release];
    }
    
    flyAnimation = [BTGreenFly animation];
    for (int i = 0; i < 5; i++){
        bug = [[BTGreenFly alloc] initFlyWithAnimation:flyAnimation GameLayer:gameLayer];            
        [bugs addObject:bug];
        [bug release];
    }
    
    flyAnimation = [BTIceBug animation];
    for (int i = 0; i < 5; i++){
        bug = [[BTIceBug alloc] initFlyWithAnimation:flyAnimation GameLayer:gameLayer];  
        [bugs addObject:bug];
        [bug release];
    }
    
    flyAnimation = [BTFireBug animation];
    for (int i = 0; i < 5; i++){
        bug = [[BTFireBug alloc] initFlyWithAnimation:flyAnimation GameLayer:gameLayer];
        [bugs addObject:bug];
        [bug release];
    }
    
    NSMutableDictionary *tempDicitonary = [[NSMutableDictionary alloc] init];
    [tempDicitonary setObject:[BTStorageManager animationWithString:@"BTFly-Zap" atInterval:0.05f Reversed:NO] forKey:@"BTFly"];
    [tempDicitonary setObject:[BTStorageManager animationWithString:@"BTGreenFly-Zap" atInterval:0.05f Reversed:NO] forKey:@"BTGreenFly"];
    [tempDicitonary setObject:[BTStorageManager animationWithString:@"BTSickBug-Zap" atInterval:0.05f Reversed:NO] forKey:@"BTSickBug"];
    [tempDicitonary setObject:[BTStorageManager animationWithString:@"BTFireBug-Zap" atInterval:0.05f Reversed:NO] forKey:@"BTFireBug"];
    [tempDicitonary setObject:[BTStorageManager animationWithString:@"BTIceBug-Zap" atInterval:0.05f Reversed:NO] forKey:@"BTIceBug"];
    bugZapAnimations = tempDicitonary;

}

-(void) update:(ccTime) dt {
    // Check Unlocks
    NSArray *currentOrders = nil;

    if ([[gameLayer scene] gameState] == kGameStateStarted){
        if ([introSequence state] == Started){
            currentOrders = [introSequence ordersForTime:[gameLayer playTime]];
        } else if ([introSequence state] == Finished){
            [introSequence setState:PostFinished];
            if ([gameLayer playBeamBonus]){
                [BTStorageManager sawPopupForTag:@"BTBonus"];
                BTAnimatedPopup *beamBonusPopup = [[[BTAnimatedPopup alloc] initWithAnimation:[BTStorageManager animationWithString:@"BTBonus" atInterval:0.35 Reversed:NO]] autorelease];
                [[gameLayer scene] addChild:beamBonusPopup z:kBTPopupLayer];
                [beamBonusPopup showPopup];

            }
        } else if ([introSequence state] == PostFinished) {
            tSequenceState currentState = [currentMetasequence state];
            if (currentState == NotStarted){
                [currentMetasequence start];
            } else if (currentState == Started){
                [self addOrders:[currentMetasequence ordersForTime:[gameLayer playTime]]];
            } else if (currentState == Finished){
                [currentMetasequence reset];
                currentMetasequence = [metasequences objectAtIndex:(arc4random()%[metasequences count])];
            }
        }
        

    } else if ([[gameLayer scene] gameState] == kGameStateNewbie){
        if ([newbieSequence state] != Finished){
            currentOrders = [newbieSequence ordersForTime:[gameLayer playTime]];
        }
    }
    
    if (currentOrders != nil && [currentOrders count] > 0){
        [self addOrders:currentOrders];
    }
}

- (void) start {   
    if ([[BTConfig sharedConfig] readFromPlist]){
    
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SpawnSequence" ofType:@"plist"];
        NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:path];
        NSArray *newbieSequenceRaw = [NSArray arrayWithObject:[root objectForKey:@"Newbie"]];
        NSArray *normalSequencesRaw = [root objectForKey:@"Normal Sequences"];
        NSArray *specialSequencesRaw = [root objectForKey:@"Special Sequences"];
        NSArray *metasequencesRaw = [root objectForKey:@"Metasequences"];
        NSArray *typesRaw = [root objectForKey:@"Probabilities"];
        

        NSMutableArray *tempTypes = [[NSMutableArray alloc] init];
        NSEnumerator *e = [typesRaw objectEnumerator];
        NSDictionary *tempDict;
        while ((tempDict = [e nextObject])){
            NSMutableDictionary *probabilities = [NSMutableDictionary dictionary];
            
            NSEnumerator *keys = [tempDict keyEnumerator];
            NSString *key;
            while ((key = [keys nextObject])){
                NSNumber *num = [tempDict objectForKey:key];
                [probabilities setObject:num forKey:key];
            }
            [tempTypes addObject:probabilities];
        }
        types = tempTypes;
        
        
        //
        // NORMAL SEQUENCES
        //
        newbieSequence = [[[self sequencesWithRawSequences:newbieSequenceRaw] objectAtIndex:0] retain];
        [NSKeyedArchiver archiveRootObject:newbieSequence toFile:@"/Users/mmeyers/Desktop/NewbieSequence.bin"];
        
        normalSequences = [[self sequencesWithRawSequences:normalSequencesRaw] retain];
        [NSKeyedArchiver archiveRootObject:normalSequences toFile:@"/Users/mmeyers/Desktop/NormalSequences.bin"];
        
        //
        // SPECIAL SEQUENCES    
        NSMutableArray *tempSpecialSequences = [NSMutableArray array];
        e = [specialSequencesRaw objectEnumerator];
        NSDictionary *specialSet;
        while ((specialSet = [e nextObject])) {
            NSString *name = [specialSet objectForKey:@"Name"];
            NSArray *tempSequences = [self sequencesWithRawSequences:[specialSet objectForKey:@"Sequences"]];
            NSArray *requiredBugs = [specialSet objectForKey:@"Required Bugs"];
            [tempSpecialSequences addObject:[[[BTSpecialSequence alloc] initWithSequences:tempSequences Name:name RequiredBugs:requiredBugs] autorelease]];
        }
        specialSequences = [tempSpecialSequences retain];
        [NSKeyedArchiver archiveRootObject:specialSequences toFile:@"/users/mmeyers/Desktop/SpecialSequences.bin"];
        
        NSMutableArray *metasequencesArray = [[NSMutableArray alloc] init];
        NSArray *metasequence;
        e = [metasequencesRaw objectEnumerator];
        
        while ((metasequence = [e nextObject])){
            NSMutableArray *subSequences = [NSMutableArray array];
            for (int i = 0; i < [metasequence count]; i++){
                NSDictionary *tempSequence = [metasequence objectAtIndex:i];
                NSString *type = [tempSequence objectForKey:@"Type"];
                if ([type isEqualToString:@"Normal"]){
                    int index = [(NSNumber *)[tempSequence objectForKey:@"Index"] intValue];
                    [subSequences addObject:[normalSequences objectAtIndex:index]];
                } else if ([type isEqualToString:@"Special"]){
                    [subSequences addObject:[[[BTSpecialSequence alloc] init] autorelease]];
                }
            }
            BTMetasequence *tempMetasequence = [[[BTMetasequence alloc] initWithSequences:subSequences] autorelease];
            [tempMetasequence setBugManager:self];
            [metasequencesArray addObject:tempMetasequence];
        }
        metasequences = metasequencesArray;
        
        [NSKeyedArchiver archiveRootObject:metasequences toFile:@"/users/mmeyers/Desktop/Metasequences.bin"];

    } else {
        newbieSequence = [[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"NewbieSequence" ofType:@"bin"]] retain];
        normalSequences = [[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"NormalSequences" ofType:@"bin"]] retain];
        specialSequences = [[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"SpecialSequences" ofType:@"bin"]] retain];
        metasequences = [[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"Metasequences" ofType:@"bin"]] retain];
        for (int i = 0; i < [metasequences count]; i++){
            [(BTMetasequence *)[metasequences objectAtIndex:i] setBugManager:self];
        }

    }

    [newbieSequence startAtTime:0];
    introSequence = [normalSequences objectAtIndex:0];
    [introSequence startAtTime:0];
    
}

- (NSArray *) sequencesWithRawSequences:(NSArray *) rawSequences {
    NSMutableArray *tempArray = [NSMutableArray array];
    
    NSDictionary *sequence;
    NSEnumerator *e = [rawSequences objectEnumerator];
    int i = -1;
    while ((sequence = [e nextObject])){
        i++;
        NSArray *ordersRaw = [sequence objectForKey:@"Orders"];
        NSEnumerator *orderEnumerator = [ordersRaw objectEnumerator];
        NSMutableArray *orders = [NSMutableArray array];
        NSDictionary *order;
        while ((order = [orderEnumerator nextObject])){
            Class class = NSClassFromString((NSString *)[order objectForKey:@"Type"]);
            int typeIndex = [(NSNumber *)[order objectForKey:@"Probabilities"] intValue];
            
            if (class == [BTOrder class]){
                [orders addObject:[[[BTOrder alloc] initWithDictionary:order] autorelease]];
            } else if (class == [BTRandomOrder class]){
                [orders addObject:[[[BTRandomOrder alloc] initWithDictionary:order Types:[types objectAtIndex:typeIndex]] autorelease]];
            }
        }
                
        Class class = NSClassFromString((NSString *)[sequence objectForKey:@"Type"]);
        if (class == [BTSpawnSequence class]){
            [tempArray addObject:[[[BTSpawnSequence alloc] initWithOrders:orders Name:[sequence objectForKey:@"Name"]] autorelease]];
        }
    }
    return tempArray;
}

- (void) stop {
    NSEnumerator *e = [bugs objectEnumerator];
    BTBug *fly;
    while ((fly = [e nextObject])){
        if (![fly dead]){
            [self killBug:fly];
        }
    }
//    for (CCSprite *node in [flySheet children]){
//        [flySheet removeChild:node cleanup:YES];
//    }
    [flySheet removeAllChildrenWithCleanup:YES];
    [self reset];
}

- (void) reset {
    NSEnumerator *e = [metasequences objectEnumerator];
    BTMetasequence *metasequence;
    while ((metasequence = [e nextObject])){
        [metasequence reset];
    }
    
    [newbieSequence reset];
    [introSequence reset];
//    [introSequence startAtTime:0];
    
    lastFryPosition = CGPointMake(0, 0);
    currentMetasequence = [metasequences objectAtIndex:0];
}

- (void) pauseSchedulerAndActions {
    [super pauseSchedulerAndActions];
    NSEnumerator *e = [bugs objectEnumerator];
    BTBug *bug;
    while ((bug = [e nextObject])){
        if (bug){
            [bug.sprite pauseSchedulerAndActions];
            [bug pauseSchedulerAndActions];
        }
    }
}

- (void) resumeSchedulerAndActions {
    [super resumeSchedulerAndActions];
    NSEnumerator *e = [bugs objectEnumerator];
    BTBug *fly;
    while ((fly = [e nextObject])){
        if (fly){
            [fly.sprite resumeSchedulerAndActions];
            [fly resumeSchedulerAndActions];
        }
    }
}

- (void) addOrders:(NSArray *) orders {
    for (int i = 0; i < [orders count]; i++){
        BTOrder *order = [orders objectAtIndex:i];
        int quantity = [order quantity]; // Putting this in the for loop might change it each time
        for (int i = 0; i < quantity; i++){
            Class type = [order bugType];
            if (type != nil){
                [self addBugsOfClass:type WithQuantity:1];
            }
        }
    }
}

/**
 * Adds n flies to the game. If n < 1, one fly will still
 * be added.
 */

const int border = 30;

- (void) addBugsOfClass:(Class) class WithQuantity: (int) n {
    do {      
        [gameLayer seedRandom];
        
        CGSize size = CGSizeMake(480, 320);
        
        int x, y;
        
        if ([[gameLayer player] beamActive]){
            CGPoint point0 = [self convertTouchToNodeSpace:[[gameLayer player] touch0]];
            CGPoint point1 = [self convertTouchToNodeSpace:[[gameLayer player] touch1]];
            BOOL foundPoint = NO;
            while (!foundPoint){
                x = RANDBT(border, (int)size.width - border);
                y = RANDBT(border, (int)size.height - border);
                int quadrant = QUADRANT_FOR_POINT(CGPointMake(x, y));
                if (quadrant != QUADRANT_FOR_POINT(point0) && quadrant != QUADRANT_FOR_POINT(point1)){
                    foundPoint = YES;
                }
            }
        } else if ([[gameLayer player] getNumTouches] == 1){
            CGPoint point0 = [self convertTouchToNodeSpace:[[gameLayer player] touch0]];
            BOOL foundPoint = NO;
            while (!foundPoint){
                x = RANDBT(border, (int)size.width - border);
                y = RANDBT(border, (int)size.height - border);
                int quadrant = QUADRANT_FOR_POINT(CGPointMake(x, y));
                if (quadrant != QUADRANT_FOR_POINT(point0)){
                    foundPoint = YES;
                }
            }
        } else {
            x = RANDBT(border, (int)size.width - border);
            y = RANDBT(border, (int)size.height - border);
        }
        
        [self addBugOfClass:class atPoint:CGPointMake(x, y) instantly:NO];
        
    } while (--n > 0);
}

- (void) addBugOfClass:(Class)class atPoint:(CGPoint) point instantly:(BOOL) instant {
    id bug;
    bool foundDead = NO;
    NSEnumerator *e = [bugs objectEnumerator];
    while (!foundDead){
        bug = [e nextObject];
        if (bug == nil){
            break;
        }
        if ([bug dead] && [bug free] && [bug isMemberOfClass:class]){
            foundDead = YES;
        }
    }
    if (!foundDead) {
        return;
    }
    
    BTBug *b = (BTBug *)bug;
    [b reset];

    if ([b isKindOfClass:[BTSpecialBug class]]){
        BTHopshopDetails *hopshopDetails;
        if ([[BTConfig sharedConfig] readFromPlist]){
            hopshopDetails = [[[BTHopshopDetails alloc] init] autorelease];
        } else {
            hopshopDetails = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"HopshopDetails" ofType:@"bin"]];
        }
        
        int bugLevel = [[BTHopshopManager sharedHopshopManager] levelForBug:[bug class]];
        float probability = 0;
        if (bugLevel <= 4){
            if ([[hopshopDetails bugUpgrades] objectForKey:[[bug class] description]] != nil){
                NSArray *bugLevels = (NSArray *)[[hopshopDetails bugUpgrades] objectForKey:[[bug class] description]];
                if (bugLevel < [bugLevels count]){
                    NSDictionary *levelInfo = [bugLevels objectAtIndex:bugLevel];
                    if ([levelInfo objectForKey:@"Rate"] != nil){
                        probability = [(NSNumber *)[levelInfo objectForKey:@"Rate"] floatValue];
                    }
                }
           }
        } else {
            probability = 1;
        }
        
        if ([BTStorageManager justUnlockedForTag:[class description]]){
            probability = 1;
            [BTStorageManager setJustUnlocked:NO ForTag:[class description]];
        }
        
        float key  = arc4random() % 100;
        if (probability != 0.0f && key < 100 * probability) {
            [(BTSpecialBug *)b setIsExtraSpecial:YES];
            [[SimpleAudioEngine sharedEngine] playEffect:@"SparkleFlySpawn.m4a"];
        }
    }
    
    cpSpaceAddShape( [[gameLayer chipmunkManager] space], [b getShape] );
    [self addChild:b];
    [flySheet addChild:[b sprite]];
    
    if (instant){
        [b setPosition:point];
    } else {
        [b spawnToPosition:CGPointMake(point.x, point.y)];
    }
    
    if ([[gameLayer scene] gameState] == kGameStateStarted && [class conformsToProtocol:@protocol(BTPopupable)] && ![BTStorageManager hasSeenPopupForClass:class] && class != [BTFly class]){
        [BTStorageManager sawPopupForClass:class];
        BTPopup *popup = [class popup];
        [[gameLayer scene] addChild:popup z:15];
        [popup showPopup];
    }
}

/**
 * Kills a fly.
 */
- (void) killBug:(BTBug *) bug {  
    if ([bug predator] == nil){
        // Poof it!
        CCAnimation *originalAnimation = [bugZapAnimations objectForKey:[NSString stringWithFormat:@"%@", [bug class]]];
        CCAnimation *animationCopy = [CCAnimation animationWithFrames:[originalAnimation frames] delay:[originalAnimation delay]];
        
        CCSprite *poof = [CCSprite node];
        poof.position = bug.position;
        [self addChild:poof];
        [poof runAction:[CCSequence actions:[CCAnimate actionWithAnimation:animationCopy restoreOriginalFrame:NO], [CCCallFunc actionWithTarget:poof selector:@selector(removeFromParent)], nil]];
    }

    if ([bug iceCube] != nil){
        [[bug iceCube] removeFromParentAndCleanup:YES];
        [bug setIceCube:nil];
    }
    
    [bug setDead:YES]; 
    [bug setFree:YES];
    [bug setPredator:nil];
    [bug stopAction:[bug wanderSequence]];	
    cpSpaceRemoveShape([[gameLayer chipmunkManager] space], [bug getShape]);
    [flySheet removeChild:bug.sprite cleanup:NO];
    [self removeChild:bug cleanup:NO];
    
}

- (CCSprite *) addIceCubeAtPosition:(CGPoint) point ForTime:(ccTime) time {
    CCSprite *iceCube = [CCSprite spriteWithSpriteFrameName:@"ice-cube-overlay.png"];
    iceCube.position = point;
    [flySheet addChild:iceCube z:0];
    [iceCube runAction:[CCSequence actions:[CCDelayTime actionWithDuration:time], [CCCallFunc actionWithTarget:iceCube selector:@selector(removeFromParent)], nil]];
    return iceCube;
}

- (void) checkForUnlocks {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Milestones" ofType:@"plist"];
    NSDictionary *milestones = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"Bugs"];
    NSEnumerator *e = [milestones keyEnumerator];
    NSString *key;
        
    while ((key = [e nextObject])){
        NSDictionary *milestone = [milestones objectForKey:key];
        Class c = NSClassFromString(key);
        if ([BTStorageManager isUnlocked:c]){
            continue;
        }
        
        NSString *type = [milestone objectForKey:@"Type"];
        NSNumber *number = [milestone objectForKey:@"Number"];
        
        if ([type isEqualToString:@"ZapMilestone"]){
            if ([BTStorageManager numBugsZapped] > [number intValue]){
                NSLog(@"Unlocking %@", [c description]);
                [BTStorageManager unlockBug:c];
            }
        } else if ([type isEqualToString:@"TimeMilestone"]){
            if ([BTStorageManager timePlayed] > [number floatValue]){
                [BTStorageManager unlockBug:c];
            }
        }
    }
}

#pragma mark -
#pragma mark Misc. Functions
//***************************************************
// MISC. FUNCTIONS
//***************************************************

/**
 * Returns a set of living bugs within the radius of a certain point
 */

- (NSArray *) bugsWithinRadius:(int) radius OfPoint:(CGPoint) point {
    NSMutableArray *tempArray = [NSMutableArray array];
    NSEnumerator *e = [bugs objectEnumerator];
    BTBug *bug;
    while ((bug = [e nextObject])){
        if (![bug dead] && DISTANCE(point, [bug position]) <= radius){
            [tempArray addObject:bug];
        }
    }
    return [NSArray arrayWithArray:tempArray];
}

/**
 * Checks whether or not a fly pointer still exists
 */

- (BOOL) isBugInLayer:(BTBug *) bug {
    NSEnumerator *bugEnumerator = [bugs objectEnumerator];
    BTBug *tempBug;
    while ((tempBug = [bugEnumerator nextObject])){
        if (tempBug == bug){
            return YES;
        }
    }
    return NO;
}

/**
 * Returns a fly pointer that contains shape, or nil if such 
 * a fly does not exist.
 */

- (BTBug *) bugByShape:(cpShape *) shape {
    BTBug *fly;
    NSEnumerator *e = [bugs objectEnumerator];
    while ((fly = [e nextObject])){
        if (shape == [fly getShape]){
            return fly;
        }
    }
    return nil;
}

- (int) numLivingBugs {
    int num = 0;
    BTBug *fly;
    NSEnumerator *e = [bugs objectEnumerator];
    while ((fly = [e nextObject])){
        if (![fly dead]){
            num++;
        }
    }
    return num;
}

- (NSArray *) livingBugs {
    NSMutableArray *tempArray = [NSMutableArray array];
    BTBug *fly;
    NSEnumerator *e = [bugs objectEnumerator];
    while ((fly = [e nextObject])){
        if (![fly dead]){
            [tempArray addObject:fly];
        }
    }
    return [NSArray arrayWithArray:tempArray];
}

- (void) dealloc {
    [newbieSequence release];
    [normalSequences release];
    [specialSequences release];
    [metasequences release];
    [bugs release];
    [bugZapAnimations release];
    [super dealloc];
}

@end
