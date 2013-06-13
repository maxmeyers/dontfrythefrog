//
//  HelloWorldLayer.m
//  Untitled
//
//  Created by Max Meyers on 3/30/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "BTGameLayer.h"
#import "CCTouchDispatcher.h"
#import "BTIncludes.h"
#import "AppDelegate.h"

#import "TestFlight.h"

#define kMilestoneBinaryDataFile @"~/Desktop/FrogMilestones.bin"

// BTGameLayer implementation
@implementation BTGameLayer

@synthesize totalTime, playTime;
@synthesize player, frog;
@synthesize bugManager, chipmunkManager, seed;
@synthesize space, scene;
@synthesize playBeamBonus;

ccTime waitPeriod = 2;
ccTime openTime;
ccTime cooldown;

CCTimer *milestoneTimer;

#pragma mark -
#pragma mark Setup Methods
//***************************************************
// SETUP METHODS
//***************************************************

- (void) load {
    loadCount = 1;
    
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_PVRTC2]; // add this line at the very beginning

    loadCount++; [[CCTextureCache sharedTextureCache] addImageAsync:@"BTBackground.pvr.ccz" target:self selector:@selector(imageLoaded)]; 
    loadCount++; [[CCTextureCache sharedTextureCache] addImageAsync:@"BTBackground2.pvr.ccz" target:self selector:@selector(imageLoaded)]; 
    loadCount++; [[CCTextureCache sharedTextureCache] addImageAsync:@"BTBugs.pvr.ccz" target:self selector:@selector(imageLoaded)]; 
    
    loadCount++; [[CCTextureCache sharedTextureCache] addImageAsync:@"BTFrog-Walk.pvr.ccz" target:self selector:@selector(imageLoaded)];
    loadCount++; [[CCTextureCache sharedTextureCache] addImageAsync:@"BTFrog-Fire.pvr.ccz" target:self selector:@selector(imageLoaded)];
    loadCount++; [[CCTextureCache sharedTextureCache] addImageAsync:@"BTFrog-Fire-Transitions.pvr.ccz" target:self selector:@selector(imageLoaded)];
    
    loadCount++; [[CCTextureCache sharedTextureCache] addImageAsync:@"BTFrog-Ice-1-12.pvr.ccz" target:self selector:@selector(imageLoaded)];
    loadCount++; [[CCTextureCache sharedTextureCache] addImageAsync:@"BTFrog-Ice-13-20.pvr.ccz" target:self selector:@selector(imageLoaded)];
    loadCount++; [[CCTextureCache sharedTextureCache] addImageAsync:@"BTFrog-Ice-21-24.pvr.ccz" target:self selector:@selector(imageLoaded)];

    loadCount++; [[CCTextureCache sharedTextureCache] addImageAsync:@"BTFrog-Hurt.pvr.ccz" target:self selector:@selector(imageLoaded)];
    loadCount++; [[CCTextureCache sharedTextureCache] addImageAsync:@"BTFrog-Explode.pvr.ccz" target:self selector:@selector(imageLoaded)];     
    loadCount++; [[CCTextureCache sharedTextureCache] addImageAsync:@"BTBugTutorials.pvr.ccz" target:self selector:@selector(imageLoaded)];
    
    loadCount++; [[CCTextureCache sharedTextureCache] addImageAsync:@"BTMenus.pvr.ccz" target:self selector:@selector(imageLoaded)];
    loadCount++; [[CCTextureCache sharedTextureCache] addImageAsync:@"BTStart.pvr.ccz" target:self selector:@selector(imageLoaded)];
    loadCount++; [[CCTextureCache sharedTextureCache] addImageAsync:@"BTBonus.pvr.ccz" target:self selector:@selector(imageLoaded)];
    loadCount++; [[CCTextureCache sharedTextureCache] addImageAsync:@"BTUIElements.pvr.ccz" target:self selector:@selector(imageLoaded)];

    // Change this to NO to read from binary data    
    if ([[BTConfig sharedConfig] readFromPlist]){
        NSArray *milestoneDictionaries = (NSArray *)[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Milestones" ofType:@"plist"]] objectForKey:@"Frog"];
        NSMutableArray *tempArray = [NSMutableArray array];

        for (int i = 0; i < [milestoneDictionaries count]; i++){
            NSDictionary *dictionary = (NSDictionary *)[milestoneDictionaries objectAtIndex:i];
            float animationDelay = -1;
            if ([dictionary objectForKey:@"Animation"]){
                animationDelay = [(NSNumber *)[dictionary objectForKey:@"Animation"] floatValue];
            }
            float catchInterval = -1;
            if ([dictionary objectForKey:@"Interval"]){
                catchInterval = [(NSNumber *)[dictionary objectForKey:@"Interval"] floatValue];
            }
            float speed = -1;
            if ([dictionary objectForKey:@"Speed"]){
                speed = [(NSNumber *)[dictionary objectForKey:@"Speed"] floatValue];
            }
            
            BTFrogMilestone *milestone = [[BTFrogMilestone alloc] 
                                           initWithTime:[(NSNumber *)[dictionary objectForKey:@"Time"] intValue] 
                                           CatchInterval:catchInterval  
                                           Speed:speed
                                          AnimationDelay:animationDelay
                                           ];
            [tempArray addObject:milestone];
            [milestone release];
        }
        baseMilestones = [[NSArray alloc] initWithArray:tempArray];
        [NSKeyedArchiver archiveRootObject:baseMilestones toFile:@"/Users/mmeyers/Desktop/FrogMilestones.bin"];
    } else {
        baseMilestones = [[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"FrogMilestones" ofType:@"bin"]] retain];
    }
    frogMilestones = [[NSMutableArray alloc] init];
    
    // Get loadCount down to 0
    [self imageLoaded];
}

- (void) imageLoaded
{
    loadCount--;
    if (loadCount == 0){
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTBackground.plist" textureFile:@"BTBackground.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTBackground2.plist" textureFile:@"BTBackground2.pvr.ccz"];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTBugs.plist" textureFile:@"BTBugs.pvr.ccz"];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTFrog-Walk.plist" textureFile:@"BTFrog-Walk.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTFrog-Fire.plist" textureFile:@"BTFrog-Fire.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTFrog-Fire-Transitions.plist" textureFile:@"BTFrog-Fire-Transitions.pvr.ccz"];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTFrog-Ice-1-12.plist" textureFile:@"BTFrog-Ice-1-12.pvr.ccz"];    
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTFrog-Ice-13-20.plist" textureFile:@"BTFrog-Ice-13-20.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTFrog-Ice-21-24.plist" textureFile:@"BTFrog-Ice-21-24.pvr.ccz"];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTFrog-Hurt.plist" textureFile:@"BTFrog-Hurt.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTFrog-Explode.plist" textureFile:@"BTFrog-Explode.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTBugTutorials.plist" textureFile:@"BTBugTutorials.pvr.ccz"];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTMenus.plist" textureFile:@"BTMenus.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTStart.plist" textureFile:@"BTStart.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTBonus.plist" textureFile:@"BTBonus.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTUIElements.plist" textureFile:@"BTUIElements.pvr.ccz"];

        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"InGameSlow.m4a"];
        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"InGameMedium.m4a"];
        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"InGameFast.m4a"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"FrogOnFire.m4a"];
        
        chipmunkManager = [[BTChipmunkManager alloc] initWithGameLayer:self];
        bugManager = [[BTBugManager alloc] initWithGameLayer:self];
        player = [[BTPlayer alloc] initWithFile:@"beam-1.png" Position:CGPointMake(0, 0) IdleAnimation:nil ParentLayer:self];
        frog = [[BTFrog alloc] initWithFile:@"Frog-walk-1-Small.png" IdleAnimation:[BTFrog animation] ParentLayer:self];
        puddleEffect = [[BTFrogEffectPuddled alloc] initWithFrog:frog Duration:3];
        foilEffect = [[BTFrogEffectFoilHat alloc] initWithFrog:frog Duration:5];
        
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] gameLayerLoaded];
    }
}

- (void) onEnter {
    [super onEnter];
}

/**
 * Initializes the game.
 */
-(id) init
{    
	if( (self=[super init])) {
        self.isTouchEnabled = YES;
        totalTime = 0;
        playTime = 0;
        cooldown = 0;
        openTime = -waitPeriod;
        milestoneTimer = [[CCTimer timerWithTarget:self selector:@selector(milestoneCheck) interval:1.0] retain];
        killDictionary = [[NSMutableDictionary dictionary] retain];
        
        NSMutableDictionary *fries = [NSMutableDictionary dictionary];
        [killDictionary setObject:fries forKey:@"Fries"];
        
        NSMutableDictionary *eats = [NSMutableDictionary dictionary];
        [killDictionary setObject:eats forKey:@"Eats"];
     
        [self scheduleUpdate];
	}
	return self;
}

- (void) update:(ccTime) dt {      
    totalTime += dt;
    [player update:dt];
    [self gustCheck];
    
    if ([scene gameState] == kGameStateLoaded){
        if (![[self children] containsObject:chipmunkManager]){
            [self addChild:chipmunkManager];
        }

        if (![[self children] containsObject:bugManager]){
            [self addChild:bugManager z:6];  
        }
        
        if (![[self children] containsObject:player]){
            [self addChild:player z:5];
        }
        if (![[self children] containsObject:frog]){
            [self addChild:frog z:5];
        }
        
        [scene resetGame];
    }
    
    else if ([scene gameState] == kGameStateReady){

    }
    else if ([scene gameState] == kGameStateGameOver){

    }
    
    else if ([scene gameState] == kGameStateStarted) {
        playTime += dt;
        [milestoneTimer update:dt];
    }
    
    else if ([scene gameState] == kGameStateNewbie) {
        playTime += dt;
        if ([[bugManager newbieSequence] state] == Finished && [bugManager numLivingBugs] == 0){
            frog.sprite.visible = YES;
            frog.tongueSprite.visible = YES;
            [scene setGameState:kGameStateWaddle];
            [frog openingWaddle];
        }
    }
}

- (void) milestoneCheck {
    [BTStorageManager addTimePlayed:1.0];
    [[BTLeapManager sharedManager] gamePlayedForTime:1.0]; 
    [bugManager checkForUnlocks];
    
    if ([frogMilestones count] > 0 && [frog currentEffect] == nil){
        BTFrogMilestone *currentMilestone = (BTFrogMilestone *)[frogMilestones objectAtIndex:0];
        if (playTime >= [currentMilestone time]){
            [currentMilestone apply];
            NSLog(@"Apply Milestone. Time: %d, Interval: %f, Speed: %f", [currentMilestone time], [currentMilestone catchInterval], [currentMilestone speed]);
            [frogMilestones removeObjectAtIndex:0];
        }
    }
    
    if ([scene multiplierInt] >= [[BTConfig sharedConfig] playerMultiplierMaximum]){
        [[BTLeapManager sharedManager] beamBonusFullForTime:1.0];
    }
    
    if ([player beamActive]){
        [[BTLeapManager sharedManager] fingersDownForTime:1.0];
    }
}

- (void) gustCheck {
    if ([scene gameState] == kGameStateStarted && [scene getChildByTag:kGustOfWindTag] != nil && [bugManager numLivingBugs] >= 25){
//        [[[scene gameUILayer] gustButton] setVisible:YES];
//        [[[scene gameUILayer] gustButton] setIsEnabled:YES];
    } else {
        [[[scene gameUILayer] gustButton] setVisible:NO];
        [[[scene gameUILayer] gustButton] setIsEnabled:NO];
    }
}

- (void) draw {
    if ([[BTConfig sharedConfig] debug]){
        glLineWidth(1);
        glColor4f(0, 255, 0, 255);
        ccDrawCircle([frog position], kFrogRadius*[frog frogScale]*1.25, 360, 128, NO);
        glColor4f(255, 0, 0, 255);
        ccDrawCircle(CGPointMake(frog.position.x, frog.position.y-3), kFrogRadius*[frog frogScale], 360, 128, NO);
    }
}

#pragma mark -
#pragma mark Game Controls
//***************************************************
// GAME CONTROLS
//***************************************************

-(void) start {
    [self reset];
    [self milestoneCheck];
        
    if (![BTStorageManager hasSeenPopupForTag:@"BTBonus"] && [BTStorageManager isUnlocked:[BTIceBug class]]){
        playBeamBonus = YES;
    }

    playTime = 0;
    [frog openingWaddle];
    
    [[BTLeapManager sharedManager] gameStarted];
}

- (void) startNewbieMode {
    [self reset];
    [self milestoneCheck];
    [[bugManager newbieSequence] startAtTime:0];
    playTime = 0;
    
    [[BTLeapManager sharedManager] gameStarted];

}

- (void) waddlingDidFinish {
    if ([scene gameState] == kGameStateWaddle) { // things may have changed
        // These two (state change and dftf sign) must come before the animated popup otherwise bad stuff will happen
        CCSprite *dftfSign = [CCSprite spriteWithFile:@"title-swing-4.png"];
        dftfSign.position = ccp(240, 384);
        dftfSign.tag = kSoftPauseTag;
        [scene addChild:dftfSign z:kBTPopupLayer];
        
        CCEaseIn *dropAction = [CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:0.5f position:ccp(240, 271)] rate:4];
        CCDelayTime *waitAction = [CCDelayTime actionWithDuration:1.5f];
        CCMoveTo *exitAction = [CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:1.0f position:ccp(240, 384)] rate:4];
        [dftfSign runAction:[CCSequence actions:dropAction, waitAction, exitAction, [CCCallFunc actionWithTarget:self selector:@selector(signDidFall)], [CCCallFunc actionWithTarget:dftfSign selector:@selector(removeFromParent)], nil]];
        
        if (![BTStorageManager isVeteran]){
            BTAnimatedPopup *popup = [[[BTAnimatedPopup alloc] initWithAnimation:[CCAnimation animationWithFrames:[NSArray arrayWithObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"Dr-Tim-start.png"]] delay:0.0f]] autorelease];
            [scene addChild:popup z:kBTPopupLayer];
            [popup showPopup];
        }
        
        [BTStorageManager setIsVeteran:YES];
        [frog stopIdleAction];
    }
}

- (void) signDidFall {
    [frog runIdleAction];
    [scene setGameState:kGameStateStarted];
    playTime = 0;
    [[bugManager introSequence] startAtTime:playTime];
}

- (void) stopWithState:(tGameState) state {
    NSLog(@"Kill Dictionary:");
    NSLog(@"FRIES:");
    for (NSString *key in [(NSDictionary *)[killDictionary objectForKey:@"Fries"] allKeys]){
        NSNumber *number = [(NSDictionary *)[killDictionary objectForKey:@"Fries"] objectForKey:key];
        NSLog(@"%@: %d", key, [number intValue]);
    }
    
    NSLog(@"EATS:");
    for (NSString *key in [(NSDictionary *)[killDictionary objectForKey:@"Eats"] allKeys]){
        NSNumber *number = [(NSDictionary *)[killDictionary objectForKey:@"Eats"] objectForKey:key];
        NSLog(@"%@: %d", key, [number intValue]);
    }
    
    NSLog(@"Career Playtime = %f", [BTStorageManager timePlayed]);
    
    [[BTLeapManager sharedManager] gameEndedWithKillDictionary:killDictionary];
    
    [[player sprite] setOpacity:0];
    [frog setVisible:NO];
    
    [bugManager stop];

    openTime = totalTime;
    [scene setGameState:state];
    [scene stopGame];
}

- (void) reset {
    if ([self getChildByTag:kSoftPauseTag] != nil){
        [self removeChildByTag:kSoftPauseTag cleanup:YES];
    }
    
    if ([self getChildByTag:kSputterNotificationTag]){
        [self removeChildByTag:kSputterNotificationTag cleanup:YES];
    }
    
    if ([[scene children] containsObject:introPopup]){
        [introPopup dismissPopup];
    }
    
    [(NSMutableDictionary *)[killDictionary objectForKey:@"Fries"] removeAllObjects];
    [(NSMutableDictionary *)[killDictionary objectForKey:@"Eats"] removeAllObjects];
    
    [frogMilestones removeAllObjects];
    for (int i = 0; i < [baseMilestones count]; i++){
        [frogMilestones addObject:[baseMilestones objectAtIndex:i]];
    }
//    [self milestoneCheck];
    
    while ([self getChildByTag:kPuddleTag] != nil){
        BTPuddle *puddle = (BTPuddle *)[self getChildByTag:kPuddleTag];
        [self removeChild:puddle cleanup:YES];
    }
    
    while ([self getChildByTag:kBTPopupLayer] != nil){
        BTAnimatedPopup *popup = (BTAnimatedPopup *)[self getChildByTag:kBTPopupLayer];
        [popup dismissPopup];
    }
    
    [bugManager reset];
    [player reset];
    [frog reset];
    
    playBeamBonus = NO;
}

- (void) loadIntro {    
    [[frog wanderAction] stop];
    [frog setPosition:CGPointMake(240, 370)];
    [frog setRotation:0];
    
    [bugManager addBugOfClass:[BTFly class] atPoint:CGPointMake(240, 160) instantly:YES];
    
    if ([scene getChildByTag:351438] == nil){
        introPopup = [BTGameLayer popup];
        [scene addChild:introPopup z:kBTPopupLayer tag:351438];
        [introPopup showPopup];
    } else {
        introPopup = (BTPopup *)[scene getChildByTag:351438];
    }
}

- (void) flyZapped: (BTBug *) bug {
    if (([scene gameState] == kGameStateReady || [scene gameState] == kGameStateStarted || [scene gameState] == kGameStateNewbie) 
        && ![bug dead]
        ){
        if ([[scene children] containsObject:introPopup]){
            [introPopup dismissPopup];
            if ([scene gameState] == kGameStateReady){
                [scene startGame];
            }
        }
        
        if ([bug predator] != nil){
            [[BTLeapManager sharedManager] stuckBugFriedOfClass:[bug class]];
        }
        
        [self AddToKillDictionaryBugClass:[[bug class] description] Method:@"Fries"];
        
        if ([bug isKindOfClass:[BTGoodBug class]]){
            [player sputter];
            [scene addToMultiplier:-3];
        }
        
        [[BTLeapManager sharedManager] bugFriedOfClass:[bug class]];
        
        [bugManager killBug:bug];
        [bug bugWasZapped];
        
        [BTStorageManager incrementBugsZapped];
        if ([BTStorageManager numBugsZapped] % 10 == 0){
            NSLog(@"Total Bugs Zapped: %d", [BTStorageManager numBugsZapped]);
        }
        
        int points = [bug value] * [scene multiplierInt];
        
        NSString *pointString = [NSString stringWithFormat:@"%d", points];
        ccColor3B pointsColor = ccc3(255, 255, 255);
        int fontSize = 32;
        if ([bug isKindOfClass:[BTGreenFly class]]){
            pointString = @"Don't Fry\nGreen Flies!";
            pointsColor = ccc3(255, 0, 0);
            fontSize = 24;
        } else if ([bug isKindOfClass:[BTIceBug class]]){
            pointString = @"Don't Fry\nBlue Flies!";
            pointsColor = ccc3(255, 0, 0);
            fontSize = 24;
        }
        
        CCLabelTTF *pointsLabel = [CCLabelTTF labelWithString:pointString dimensions:CGSizeMake(150, 60) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:fontSize];
        pointsLabel.color = pointsColor;
        pointsLabel.position = bug.position;
        [self addChild:pointsLabel z:7];
        [pointsLabel runAction:[CCSequence actions:[CCSpawn actions:[CCEaseOut actionWithAction:[CCMoveBy actionWithDuration:0.75f position:CGPointMake(0, 25)] rate:2], [CCFadeOut actionWithDuration:1.1f], nil], [CCCallFuncND actionWithTarget:pointsLabel selector:@selector(removeFromParentAndCleanup:) data:[NSNumber numberWithInt:1]], nil]];
        
        // TODO: TEST THIS CONDITIONAL
        if (![bug isKindOfClass:[BTGoodBug class]]){
            [scene setFliesFried:[scene fliesFried]+1];
        }
        [scene setScore:[scene score] + points];
        if (bug.value > 0){
            [scene addToMultiplier:0.2];
        }
    }
}


- (void) frogZapped {
    if ([scene gameState] == kGameStateStarted && [frog isZappable]){
        [player sputter];
        [[BTLeapManager sharedManager] frogFriedAtTime:[self playTime]];
        if ([scene getChildByTag:kFoilHatTag] == nil){
            [frog wasZapped];
        } else {
            [scene removeChildByTag:kFoilHatTag cleanup:YES];
            [foilEffect apply];
        }
    }
}

- (void) frogTouchedPuddle:(BTPuddle *) puddle {
    if (![frog sick] && ![frog inRespawn]){
        [puddleEffect apply];
        if (puddle != nil){
            [puddle evaporate];
        }
    }
}

- (void) frogFinishedExploding {
    [self frogLifeLost];
    if ([[[scene gameUILayer] lifeCounter] lives] == 0){ // If both of these if statements are true, the animated popup above will take care of stopping the game.
        [self stopWithState:kGameStateGameOver];
    }
}

- (void) frogFinishedZapping {
    [self frogLifeLost];
    if ([[[scene gameUILayer] lifeCounter] lives] == 0){
        [self stopWithState:kGameStateGameOver];
    } 
}

- (void) frogLifeLost {
    if ([scene gameState] == kGameStateStarted){
        [scene setMultiplier:1];
        [[[scene gameUILayer] lifeCounter] setLives:[[[scene gameUILayer] lifeCounter] lives] - 1];
        if ([[[scene gameUILayer] lifeCounter] lives] > 0){
            [frog respawnWaddle];
        }
    }
}

- (BTPuddle *) puddleByShape:(cpShape *) shape {
    for (CCNode *node in children_){
        if ([node isMemberOfClass:[BTPuddle class]] && [(BTPuddle *)node getShape] == shape){
            return (BTPuddle *)node;
        }
    }
    return nil;
}

- (void) AddToKillDictionaryBugClass:(NSString *) bugClass Method:(NSString *)method {
    NSMutableDictionary *methodDictionary = [killDictionary objectForKey:method];
    if ([methodDictionary objectForKey:bugClass]){
        int num = [(NSNumber *)[methodDictionary objectForKey:bugClass] intValue];
        [methodDictionary setObject:[NSNumber numberWithInt:num+1] forKey:bugClass];
    } else {
        NSNumber *number = [NSNumber numberWithInt:1];
        [methodDictionary setObject:number forKey:bugClass];
    }
}

#pragma mark -
#pragma mark Touch Methods
//***************************************************
// TOUCH METHODS
//***************************************************

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:10 swallowsTouches:YES];    
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    if ([scene gameState] >= kGameStateReady){
        [player addTouch:touch];
    }
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    [player removeTouch:touch];
}

- (void) pauseSchedulerAndActions {
    [super pauseSchedulerAndActions];
    for (CCNode *node in [self children]){
        [node pauseSchedulerAndActions];
    }
}

- (void) resumeSchedulerAndActions {
    [super resumeSchedulerAndActions];
    for (CCNode *node in [self children]){
        [node resumeSchedulerAndActions];
    }

}

-(void) seedRandom {
    srandom(time(NULL) + seed++);
}

- (BOOL) loadingUsesOpenGL {
    return NO;
}

+ (BTPopup *) popup {
    BTPopup *tempPopup = [[[BTAnimatedPopupClean alloc] initWithAnimation:[BTStorageManager animationWithString:@"BTStart" atInterval:0.25f Reversed:NO]] autorelease];
    return tempPopup;
}

#pragma mark -
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{   
    [baseMilestones release];
    [frog release];
    [player release];
    [chipmunkManager release];
    [bugManager release];
    [milestoneTimer release];
    [killDictionary release];
    
	// don't forget to call "super dealloc"
    [super dealloc];
}


@end