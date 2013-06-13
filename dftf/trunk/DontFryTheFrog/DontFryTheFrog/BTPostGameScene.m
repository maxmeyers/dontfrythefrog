//
//  BTPostGameScene.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTPostGameScene.h"
#import "BTIncludes.h"
#import "Appirater.h"

#define kLevelingLayerTag 1
#define kLeapBoxTag 2
#define kResultsLayerTag 3

@implementation BTPostGameScene

@synthesize destination = destination_;
@synthesize gameScene = gameScene_;

- (id) initWithResultsLayer:(BTResultsLayer *) resultsLayer GameScene:(BTGameScene *) gameScene Destination:(NSString *) scene {
    self = [super init];
    if (self){
        self.destination = scene;
        resultsLayer_ = [resultsLayer retain];
        gameScene_ = gameScene;
        initialLevel = [BTStorageManager playerLevel];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTFrogLevels.plist" textureFile:@"BTFrogLevels.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTBugTutorials.plist" textureFile:@"BTBugTutorials.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTBackground.plist" textureFile:@"BTBackground.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTUIElements.plist" textureFile:@"BTUIElements.pvr.ccz"];
    }
    
    return self;
}

- (void) refresh {
    if ([self getChildByTag:kLevelingLayerTag]){
        [(BTLevelingLayer *)[self getChildByTag:kLevelingLayerTag] refresh];
    }
    
    if ([self getChildByTag:kLeapBoxTag]){
        [(BTLeapBox *)[self getChildByTag:kLeapBoxTag] refresh];
    }
}

- (void) onEnter {
    [super onEnter];
        
    Class bgClass = NSClassFromString([BTStorageManager currentBackground]);
    BTBackgroundLayer *bg;
    if ([bgClass isSubclassOfClass:[BTBackgroundLayer class]]){
        bg = [[[bgClass alloc] init] autorelease];
    } else {
        bg = [[[BTDefaultBackgroundLayer alloc] init] autorelease];
    }
    [self addChild:bg z:0 tag:5];
    
    BTLevelingLayer *levelingLayer = [BTLevelingLayer node];
    [self addChild:levelingLayer z:1 tag:kLevelingLayerTag];

    // THIS IS FOR TESTING PURPOSES ONLYYYYY
//    BTLeap *leap = [[[BTLeapManager sharedManager] currentLeaps] objectAtIndex:0];
//    [leap setReward:6];
//    [leap setProgress:[leap quantity]];
    
    BTLeapBox *leapBox = [[[BTLeapBox alloc] initWithState:kLevelingScreen] autorelease];
    leapBox.state = kLevelingScreen;
    [self addChild:leapBox z:2 tag:kLeapBoxTag];
    
    if (![BTStorageManager hasSeenPopupForTag:@"BTPostGameScene"]){
        [BTStorageManager sawPopupForTag:@"BTPostGameScene"];
        BTMessageLayer *messageLayer = [[[BTMessageLayer alloc] initWithMessage:@"Complete Leap Missions to increase your Frog Level and earn prizes and extra Fly Pennies."] autorelease];
        [self addChild:messageLayer z:3];

    } else {
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0], [CCCallFunc actionWithTarget:self selector:@selector(awardFlyPenniesUntilZero)], nil]];
    }
}



- (void) awardFlyPenniesUntilZero {    
    NSMutableArray *actions = [NSMutableArray array];
    BTLeapBox *leapBox = (BTLeapBox *)[self getChildByTag:kLeapBoxTag];
    
    [self removeChildByTag:kLevelingLayerTag cleanup:YES];
    BTLevelingLayer *levelingLayer = [BTLevelingLayer node];
    [self addChild:levelingLayer z:1 tag:kLevelingLayerTag];
    
    [actions addObject:[CCDelayTime actionWithDuration:1.0]];    

    initialLevel = [BTStorageManager playerLevel];
    
    // If there are pads remaining to be awarded
    if ([leapBox lilyPadsRemaining] > 0){
        // Schedule x pads, where x is the # of pads remaining
        int padsRemaining = [BTStorageManager padsRemaining];

        
        // Transfer points for all completed leaps
        for (int i = 0; i < [[leapBox singleLeaps] count] && padsRemaining > 0; i++){
            BTSingleLeap *singleLeap = (BTSingleLeap *)[[leapBox singleLeaps] objectAtIndex:i];
            
            if ([singleLeap completed]){ 
                int padsLeftOnSingleLeap = [singleLeap lilyPadsRemaining];
                for (int i = kLilyPad6Tag; i >= kLilyPad1Tag && padsRemaining > 0; i--){
                    if ([singleLeap getChildByTag:i]){
                        CCSprite *lilyPad = (CCSprite *)[singleLeap getChildByTag:i];
                        
                        CCCallBlock *moveLilyPad = [CCCallBlock actionWithBlock:^(void) {
                            CCMoveTo *moveLilyTo = [CCMoveTo actionWithDuration:0.5f position:[levelingLayer getChildByTag:kPadsRemainingTag].position];                            
                            CCCallBlock *earnPads = [CCCallBlock actionWithBlock:^(void) {
                                [BTStorageManager earnPads:1];
                                NSLog(@"Earned a pad");
                                [self refresh];
                            }];      
                            [lilyPad runAction:[CCSequence actions:moveLilyTo, earnPads, [CCCallFunc actionWithTarget:lilyPad selector:@selector(removeFromParent)], nil]];
                        }];
                        padsRemaining--;
                        padsLeftOnSingleLeap--;
                        [actions addObject:moveLilyPad];
                        [actions addObject:[CCDelayTime actionWithDuration:0.5f]];
                    }
                }
                
                if (padsLeftOnSingleLeap == 0 && [singleLeap lilyPadsRemaining] != 0){
                    CCDelayTime *waitForRewardsToMoveAction = [CCDelayTime actionWithDuration:0.5f];
                    CCCallBlock *fadeOutCompletedLeap = [CCCallBlock actionWithBlock:^(void) {
                        CCFadeOut *fadeOutAction = [CCFadeOut actionWithDuration:0.25];
                        [singleLeap runAction:fadeOutAction];
                    }];
                    [actions addObject:waitForRewardsToMoveAction];
                    [actions addObject:fadeOutCompletedLeap];
                }
                
                CCDelayTime *waitAction = [CCDelayTime actionWithDuration:1.0f];
                [actions addObject:waitAction];
            }
        }
    }
    
    // If we levelled up, show the new current level
    CCCallBlock *levelUpAction = [CCCallBlock actionWithBlock:^(void){
        if ([BTStorageManager padsRemaining] == 0){
            [BTStorageManager setPlayerLevel:[BTStorageManager playerLevel]+1];
            [FlurryAnalytics logEvent:@"Level Up"];
        }
        
        int currentLevel = [BTStorageManager playerLevel];
        if (currentLevel != initialLevel){
            for (int i = kPadsRemainingTitleTag; i <= kCurrentNameTag; i++){
                if ([levelingLayer getChildByTag:i]){
                    [levelingLayer removeChildByTag:i cleanup:YES];
                }
            }
            
            CCLabelTTF *levelUp = [CCLabelTTF labelWithString:@"Level up!" fontName:@"soupofjustice" fontSize:42];
            levelUp.position = ccp(87, 280);
            [levelingLayer addChild:levelUp];
            
            CCLabelTTF *newLevel = [CCLabelTTF labelWithString:@"New Level" fontName:@"soupofjustice" fontSize:30];
            newLevel.position = ccp(87, 218);
            [levelingLayer addChild:newLevel];
            
            CCSprite *newSprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"level-%d.png", currentLevel]];
            newSprite.position = ccp(36, 177);
            [levelingLayer addChild:newSprite];
            
            NSString *levelInfoString = [NSString stringWithFormat:@"Level %d\n%@", currentLevel, [[BTLeapManager sharedManager] nameForLevel:currentLevel]];
            CCLabelTTF *levelInfo = [CCLabelTTF labelWithString:levelInfoString dimensions:CGSizeMake(95, 100) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:16];
            levelInfo.position = ccp(117, 156);
            levelInfo.color = ccGREEN;
            [levelingLayer addChild:levelInfo];
            
            CCLabelTTF *rewards = [CCLabelTTF labelWithString:@"Reward" fontName:@"soupofjustice" fontSize:30];
            rewards.position = ccp(87, 130);
            [levelingLayer addChild:rewards];
            
            NSString *rewardsString = [[BTLeapManager sharedManager] rewardForLevel:currentLevel];
            int rewardsFontSize = 20;
            if ([rewardsString intValue] != 0){
                NSNumber *flyPennies = [NSNumber numberWithInt:[rewardsString intValue]];
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
                numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
                [[BTHopshopManager sharedHopshopManager] addFlyTokens:[rewardsString intValue]];
                rewardsString = [NSString stringWithFormat:@"%@ Fly Pennies", [numberFormatter stringFromNumber:flyPennies]];
            } else if ([rewardsString isEqualToString:@"BTFoilHat"]){
                rewardsString = [NSString stringWithFormat:@"Foil Hat"];
                [[BTHopshopManager sharedHopshopManager] addConsumable:[BTFoilHat class]];
            } else if ([rewardsString isEqualToString:@"BTPennyFrenzy"]){
                rewardsString = [NSString stringWithFormat:@"Penny Frenzy"];
                [[BTHopshopManager sharedHopshopManager] addConsumable:[BTPennyFrenzy class]];
            } else if ([rewardsString isEqualToString:@"BTBugSpray"]){
                rewardsString = [NSString stringWithFormat:@"Bug Spray"];
                [[BTHopshopManager sharedHopshopManager] addConsumable:[BTBugSpray class]];
            } else if ([rewardsString rangeOfString:@"BackgroundLayer"].location != NSNotFound){
                Class bgClass = NSClassFromString(rewardsString);
                int cost = 0;
                @try {
                    NSDictionary *background = [[[[BTHopshopManager sharedHopshopManager] hopshopDetails] backgrounds] objectForKey:rewardsString];
                    cost = [[background objectForKey:@"Cost"] intValue];
                }
                @catch (NSException *exception) {}
                
                if (cost == 0){
                    rewardsString = [NSString stringWithFormat:@"Unlocked %@!", [bgClass name]];
                    [BTStorageManager setBackground:rewardsString Unlocked:YES];
                } else {
                    rewardsString = [NSString stringWithFormat:@"%@ now available!", [bgClass name]];
                }
                rewardsFontSize = 15;

            }
            
            CCLabelTTF *rewardsInfo = [CCLabelTTF labelWithString:rewardsString dimensions:CGSizeMake(160, 50) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:rewardsFontSize];
            rewardsInfo.position = ccp(87, 90);
            rewardsInfo.color = ccGREEN;
            [levelingLayer addChild:rewardsInfo];
        }
    }];
    [actions addObject:levelUpAction];
    
    if ([leapBox hasComplete]){
        [actions addObject:[CCCallFunc actionWithTarget:self selector:@selector(achieveOldLeapsAndGetNewLeaps)]];
    }
    
    // Load the play-continue-button, which does:
    CCCallBlock *loadContinueButton = [CCCallBlock actionWithBlock:^(void) {
        CCMenuItemSprite *playButtonMenuItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"next-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"next-pressed.png"] block:^(id sender){
            if ([leapBox lilyPadsRemaining] > 0){
                [self awardFlyPenniesUntilZero];
            } else {
                [self loadResults];
            }
        }];
        playButtonMenuItem.position = ccp(87, 42); 
        playButtonMenuItem.isEnabled = YES;
        [playButtonMenuItem runAction:[CCSequence actions:[CCDelayTime actionWithDuration:2.0], [CCCallBlock actionWithBlock:^(void) { [playButtonMenuItem setIsEnabled:YES]; }], nil]];
        CCMenu *menu = [CCMenu menuWithItems:playButtonMenuItem, nil];
        menu.position = ccp(0, 0);
        [levelingLayer addChild:menu];
    }];
    
    [actions addObject:loadContinueButton];

    [self runAction:[CCSequence actionsWithArray:actions]];
}

- (void) achieveOldLeapsAndGetNewLeaps {
    BTLeapBox *leapBox = (BTLeapBox *)[self getChildByTag:kLeapBoxTag];
    for (int i = 0; i < [[leapBox singleLeaps] count]; i++) {
        BTSingleLeap *singleLeap = (BTSingleLeap *)[[leapBox singleLeaps] objectAtIndex:i];
        if ([singleLeap completed] && [singleLeap lilyPadsRemaining] == 0){
            [[BTLeapManager sharedManager] leapAchieved:[singleLeap leap]];
            [FlurryAnalytics logEvent:@"Leap Achieved" withParameters:[NSDictionary dictionaryWithObject:[[singleLeap leap] name] forKey:@"Leap Name"]];
            int index = [[leapBox singleLeaps] indexOfObject:singleLeap];
            BTSingleLeap *newSingleLeap = [[[BTSingleLeap alloc] initWithLeap:[[[BTLeapManager sharedManager] currentLeaps] objectAtIndex:index] AtIndex:index+1 WithPosition:singleLeap.location] autorelease];
            newSingleLeap.opacity = 0;
            [newSingleLeap refresh];
            
            [[leapBox singleLeaps] replaceObjectAtIndex:index withObject:newSingleLeap];
            [leapBox addChild:newSingleLeap z:1];
            [leapBox removeChild:singleLeap cleanup:YES];
            
            CCFadeIn *fadeNewLeapIn = [CCFadeIn actionWithDuration:0.25];
            [newSingleLeap runAction:fadeNewLeapIn];
        }
    }
    
}

- (void) loadResults {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    if (resultsLayer_){
        [Appirater userDidSignificantEvent:YES];
        [self removeChildByTag:kLevelingLayerTag cleanup:YES];
        [self removeChildByTag:kLeapBoxTag cleanup:YES];
        [self addChild:resultsLayer_ z:1 tag:kResultsLayerTag];
    } else if (![destination_ isEqualToString:@""]) {
        if ([destination_ isEqualToString:@"BTGameScene"]){
            [delegate exitToMainMenu];
            [delegate startGame];
        } else if ([destination_ isEqualToString:@"BTMainMenuScene"]){
            [delegate exitToMainMenu];
        }
    } else {
        [delegate exitToMainMenu];
    }
}

- (void) onExit {
    [super onExit];
    [self removeChild:[self getChildByTag:5] cleanup:YES];
}

- (void) dealloc {
    [resultsLayer_ release];
    [super dealloc];
}

@end
