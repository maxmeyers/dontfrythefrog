//
//  BTGameScene.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTGameScene.h"
#import "BTIncludes.h"
#import "CCTouchDispatcher.h"

#define kResultsTag 937582
#define kBackgroundTag 92374
#define kConsumablesMenuTag 92375
#define kFoilHatMenuTag 923751
#define kPennyFrenzyMenuTag 923752

@implementation BTGameScene

@synthesize gameLayer, gameUILayer, pauseLayer;
@synthesize gameState;

@synthesize fliesFried, fliesEaten, maxMultiplier;

- (id) initWithGameLayer:(BTGameLayer *) layer {
    self = [super init];
    if (self){
        gameState = kGameStateLoaded;
        
        NSLog(@"%@", [[UIDevice currentDevice] model]);
        if ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"]){
            self.scale = 1024.0/480.0;
            self.position = ccp(579, 475);
//            self.position = ccp(290, 238);
        }
        
        self.gameUILayer = [[[BTGameUILayer alloc] init] autorelease];
        [gameUILayer setScene:self];
        [self addChild:gameUILayer z:3];
        
        self.gameLayer = layer;
        [gameLayer setScene:self];
        [self addChild:gameLayer z:2];
        
        pauseCount = 0;
        
        [self reset];
    }
    
    return self;
}

- (void) onEnter {
    [super onEnter];    
    pauseLayer = [[BTPauseLayer alloc] init];
    [pauseLayer setScene:self];
    
    BTBackgroundLayer *bg = [[[BTBackgroundLayer alloc] init] autorelease];
    [self addChild:bg z:1 tag:kBackgroundTag];
}

- (void) onExit {
    [super onExit];
    [pauseLayer release];
    [self removeChildByTag:kBackgroundTag cleanup:YES];
}

- (void) startGame {
    if (gameState >= kGameStateReady) {
        if ([self getChildByTag:kConsumablesMenuTag] != nil){
            [self removeChildByTag:kConsumablesMenuTag cleanup:NO];
        }
        
        if ([BTStorageManager isVeteran]){
            gameState = kGameStateWaddle;
            [gameLayer start];
        } else {
            gameState = kGameStateNewbie;
            [gameLayer startNewbieMode];
        }
    }
}

- (void) stopGame {
    if (gameState == kGameStateGameOver){
        [[gameUILayer pauseButton] setIsEnabled:NO];
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[SimpleAudioEngine sharedEngine] playEffect:@"GameOver.m4a"];
        int newHighScore = [BTStorageManager highscore];
        if (score > newHighScore){
            newHighScore = score;
        }
        
        int newFliesFried = [BTStorageManager highFliesFried];
        if (fliesFried > newFliesFried){
            newFliesFried = fliesFried;
        }

        int newMultiplier = [BTStorageManager highMultiplier];
        if (maxMultiplier > newMultiplier){
            newMultiplier = maxMultiplier;
        }
        
        int newTokens = [[BTHopshopManager sharedHopshopManager] tokensForFliesFried:fliesFried] + floor(score/1000);
        if ([self getChildByTag:kPennyFrenzyTag] != nil){
            [self removeChildByTag:kPennyFrenzyTag cleanup:YES];
            newTokens = newTokens * 2;
        }
        [BTStorageManager addHopshopTokens:newTokens];

        CCCallBlock *postGamePush = [CCCallBlock actionWithBlock:^(void) {
            BTResultsLayer *resultsLayer = [[[BTResultsLayer alloc] initWithScore:score AllTimeScore:newHighScore FliesFried:fliesFried AllTimeFliesFried:newFliesFried FlyPennies:newTokens Multiplier:maxMultiplier AllTimeMultiplier:newMultiplier Bank:[BTStorageManager hopshopTokens]] autorelease];
            [resultsLayer setGameScene:self];
            //        [self addChild:resultsLayer z:3 tag:kResultsTag];
            
            BTPostGameScene *postgameScene = [[[BTPostGameScene alloc] initWithResultsLayer:resultsLayer Destination:@""] autorelease];
            [[CCDirector sharedDirector] pushScene:postgameScene];
        }];
        
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0], postGamePush, nil]];
        
        if (![GKLocalPlayer localPlayer].authenticated){
            // We add the new high here because we need the old one for the LOCAL social achievement
            // We can do it here because local stuff happens instantly. When it's game center social achievements,
            // we have to do it after the Dr. Tim box is populated.
            [BTStorageManager addHighscore:score]; 
            [BTStorageManager addMultiplier:maxMultiplier];
            [BTStorageManager addFliesFried:fliesFried];
        }
    }
}

- (void) resetGame {
    [self setGameState:kGameStateReady];
    [[gameLayer bugManager] stop];
    [self reset];
    [[BTLeapManager sharedManager] resetProgress];
    
    [gameLayer loadIntro];
//    [self loadConsumablesMenu];
    [[gameUILayer pauseButton] setIsEnabled:YES];
}

- (void) reset {
    if ([self getChildByTag:kResultsTag] != nil){
        [self removeChild:[self getChildByTag:kResultsTag] cleanup:YES];
    }

    if ([self getChildByTag:kConsumablesMenuTag] != nil){
        [self removeChildByTag:kConsumablesMenuTag cleanup:NO];
    }
        
    // Reset game variables
    [self setScore:0];
    [self setFliesFried:0];
    [self setFliesEaten:0];
    [self setMultiplier:1];
    [self setMaxMultiplier:0];
    
    [[gameUILayer lifeCounter] setLives:3];
    [gameLayer reset];
    
    // Remove consumables
    for (int i = 0; i < [[self children] count]; i++){
        id child = [[self children] objectAtIndex:i];
        if ([child isKindOfClass:[BTTool class]]){
            [self removeChild:child cleanup:YES];
        }
    }
}

- (void) loadConsumablesMenu {
    
    NSArray *tools = [[BTHopshopManager sharedHopshopManager] consumables];
    NSMutableDictionary *toolCounts = [NSMutableDictionary dictionary];
    
    // Get counts of tools, store into toolCounts. Keys = [class description]'s, values = NSNumber's
    NSEnumerator *e = [tools objectEnumerator];
    BTTool *tool;
    while ((tool = [e nextObject])){
        NSString *classString = [[tool class] description];
        if ([toolCounts objectForKey:classString] == nil){
            // Add first instance
            NSNumber *number = [NSNumber numberWithInt:1];
            [toolCounts setObject:number forKey:classString];
        } else {
            // Increment
            NSNumber *number = [toolCounts objectForKey:classString];
            [toolCounts setObject:[NSNumber numberWithInt:[number intValue]+1] forKey:classString];
        }
    }
    
    foilHatMenuItem = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Foil Hat" fontName:@"Marker Felt" fontSize:20] target:self selector:@selector(activateFoilHat)];
    foilHatMenuItem.tag = kFoilHatMenuTag;
    foilHatMenuItem.position = ccp(-999, -999);
    int foilHats = 0;
    if ([toolCounts objectForKey:[[BTFoilHat class] description]]){
        foilHats = [(NSNumber *)[toolCounts objectForKey:[[BTFoilHat class] description]] intValue];
        foilHatMenuItem.position = ccp(120, 30);
    }

    pennyFrenzyMenuItem = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Penny Frenzy" fontName:@"Marker Felt" fontSize:20] target:self selector:@selector(activatePennyFrenzy)];
    pennyFrenzyMenuItem.tag = kPennyFrenzyMenuTag;
    pennyFrenzyMenuItem.position = ccp(-999, -999);
    int pennyFrenzys = 0;
    if ([toolCounts objectForKey:[[BTPennyFrenzy class] description]]){
        pennyFrenzys = [(NSNumber *)[toolCounts objectForKey:[[BTPennyFrenzy class] description]] intValue];
        pennyFrenzyMenuItem.position = ccp(120, -30);
    }
    
    CCMenu *menu = [CCMenu menuWithItems:foilHatMenuItem, pennyFrenzyMenuItem, nil];
    [self addChild:menu z:4 tag:kConsumablesMenuTag];
    
    int gustsOfWind = 0; 
    if ([toolCounts objectForKey:[[BTGustOfWind class] description]]){
        gustsOfWind = [(NSNumber *)[toolCounts objectForKey:[[BTGustOfWind class] description]] intValue];
    }
    if (gustsOfWind > 0){
//        [self addChild:[BTGustOfWind node] z:1 tag:kGustOfWindTag];
    }
}
                                       
- (void) activateFoilHat {
    [[self getChildByTag:kConsumablesMenuTag] getChildByTag:kFoilHatMenuTag].visible = NO;
    [(CCMenuItemLabel *)[[self getChildByTag:kConsumablesMenuTag] getChildByTag:kFoilHatMenuTag] setIsEnabled:NO];    
    
    BTFoilHat *foilHat = [BTFoilHat node];
    [foilHat consume];
    [self addChild:foilHat z:1 tag:kFoilHatTag];
}

- (void) activatePennyFrenzy {
    [[self getChildByTag:kConsumablesMenuTag] getChildByTag:kPennyFrenzyMenuTag].visible = NO;
    [(CCMenuItemLabel *)[[self getChildByTag:kConsumablesMenuTag] getChildByTag:kPennyFrenzyMenuTag] setIsEnabled:NO];
    
    BTPennyFrenzy *pennyFrenzy = [BTPennyFrenzy node];
    [pennyFrenzy consume];
    [self addChild:pennyFrenzy z:1 tag:kPennyFrenzyTag];
}

- (void) activateGustOfWind {
    if ([self getChildByTag:kGustOfWindTag] != nil){
        
        // Kill all living bugs
        NSEnumerator *e = [[[gameLayer bugManager] bugs] objectEnumerator];
        BTBug *bug;
        while ((bug = [e nextObject])){
            if (![bug dead]){
                [[gameLayer bugManager] killBug:bug];
            }
        }
        
        BTGustOfWind *gustOfWind = (BTGustOfWind *)[self getChildByTag:kGustOfWindTag];
        [gustOfWind consume];
        [self removeChild:gustOfWind cleanup:YES];
    }
}

- (void) pauseGame {
    [self pauseGameWithState:kGameStatePaused];
}

- (void) pauseGameWithState:(tGameState) state {
    if ([self gameState] != kGameStatePaused && pauseCount <= 0){
        [[gameUILayer pauseButton] setIsEnabled:NO];
        [self softPause];
        
        if (state == kGameStatePaused) {
            [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
            if ([[gameLayer frog] onFire]){
                BTFrogEffectFire *effect = (BTFrogEffectFire *)[[gameLayer frog] currentEffect];
                [[SimpleAudioEngine sharedEngine] stopEffect:[effect soundEffect]];
            }
            
            @try {
                [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:pauseLayer priority:0 swallowsTouches:YES];

                pauseLayer.position = ccp(-190, 0);
                [self addChild:pauseLayer z:kBTPopupLayer+1];

                [pauseLayer runAction:[CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:0.25f position:ccp(0, 0)] rate:5]];
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
        } 
        
        if (gameState != kGameStatePaused){
            prePauseState = gameState;
        }
        gameState = state;
    }
}

- (void) unPauseGame {
    [self unPauseGameInstantly:NO];
}

- (void) unPauseGameInstantly:(bool) instantly {
    if (gameState == kGameStatePaused){
        [self softResume];
        [[gameUILayer pauseButton] setIsEnabled:YES];
        
        if (instantly){
            [pauseLayer removeFromParentAndCleanup:YES];
        } else {
            if ([[self children] containsObject:pauseLayer]){
                CCEaseIn *goAway = [CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:0.25f position:ccp(-190, 0)] rate:5];
                [pauseLayer runAction:[CCSequence actions:goAway, [CCCallFunc actionWithTarget:pauseLayer selector:@selector(removeFromParent)], nil]];
            }
        }
        [[CCTouchDispatcher sharedDispatcher] removeDelegate:pauseLayer];
        [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
        
        if ([[gameLayer frog] onFire]){
            [(BTFrogEffectFire *)[[gameLayer frog] currentEffect] setSoundEffect:[[SimpleAudioEngine sharedEngine] playEffect:@"FrogOnFire.m4a" pitch:1.0 pan:0.0 gain:1.0 looping:true]];
        }
        
        gameState = prePauseState;
    }
}

- (void) softPause {
    [[gameUILayer pauseButton] setIsEnabled:NO];
    pauseCount++;
    prePauseState = gameState;
    gameState = kGameStatePaused;
    [gameLayer pauseSchedulerAndActions];
    [[self getChildByTag:kBackgroundTag] pauseSchedulerAndActions];
    [[self getChildByTag:kSoftPauseTag] pauseSchedulerAndActions];
    
}

- (void) softResume {
    if (--pauseCount <= 0){
        [[gameUILayer pauseButton] setIsEnabled:YES];
        gameState = prePauseState;
        [gameLayer resumeSchedulerAndActions];
        [[self getChildByTag:kBackgroundTag] resumeSchedulerAndActions];
        [[self getChildByTag:kSoftPauseTag] resumeSchedulerAndActions];
    }
}

- (int) score {
    return score;
}

- (void) setScore:(int)s {
    score = s;
}


- (void) addToMultiplier:(float) addition {
    float previousMultiplier = multiplier;
    [self setMultiplier:multiplier+addition];
    
    ccTime duration = 0.2;
    if (previousMultiplier != multiplier){
        float previousPercent = 100*fmod(previousMultiplier, 1);
        float newPercent = 100*fmod(multiplier, 1);
        if (multiplier == [[BTConfig sharedConfig] playerMultiplierMaximum]){
            previousPercent = 100;
            newPercent = 100;
        }
        
        float percentage = multiplier;
        while (percentage - 1.0 > 0.0){
            percentage = percentage - 1.0;
        }
        
        if (multiplier > 1 && fabs(percentage - 0) < 0.00001){ // My way of saying == 0
            newPercent = 100;
            if (addition < 0){
                duration = 0;
            }
        }
        
        if (multiplier > 1 && fabs(percentage - 0.8) < 0.000001 && addition < 0){
            previousPercent = 100;
        }
        
        if (multiplier > 1 && fabs(percentage - 0.2) < 0.000001 && addition > 0){
            duration = 0;
        }
                
        [[gameUILayer energyBar] runAction:[CCProgressFromTo actionWithDuration:duration from:previousPercent to:newPercent]];
    }

}

- (int)  multiplierInt {
    float percentage = multiplier;
    while (percentage - 1.0 > 0.0){
        percentage = percentage - 1.0;
    }
    if (multiplier > 1 && fabs(percentage - 0) < 0.00001){
        return floor(multiplier)-1;
    }
    
    return floor(multiplier);
}

- (float) multiplier {
    return multiplier;
}

- (void) setMultiplier:(float)m {
    multiplier = MAX(1, MIN(m, [[BTConfig sharedConfig] playerMultiplierMaximum]));
    if (multiplier > maxMultiplier){
        maxMultiplier = multiplier;
    }
}

@end

