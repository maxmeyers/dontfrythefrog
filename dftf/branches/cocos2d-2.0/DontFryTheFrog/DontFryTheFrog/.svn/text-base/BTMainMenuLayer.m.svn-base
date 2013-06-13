//
//  BTMainMenuLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 5/26/11.
//  Copyright 2011 New York University. All rights reserved.
//

#import "BTMainMenuLayer.h"
#import "BTIncludes.h"

@implementation BTMainMenuLayer

BTConfigScene *configScene;

- (id) init {
    if ((self = [super init])){
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        configScene = [[BTConfigScene alloc] init];
        
//        CCMenuItemLabel *startGameButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Play" fontName:@"soupofjustice" fontSize:32] block:^(id sender){
//            [self buttonPressed];
//            [delegate startGame];
//        }];
//        CCMenuItemLabel *highscoreButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Top Scores" fontName:@"soupofjustice" fontSize:32] target:self selector:@selector(highscoreButtonPressed)];
//        CCMenuItemLabel *leaderboardButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Leaderboards" fontName:@"soupofjustice" fontSize:32] target:self selector:@selector(leaderboardButtonPressed)];
//        CCMenuItemLabel *configButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Developer Config" fontName:@"soupofjustice" fontSize:32] target:self selector:@selector(configButtonPressed)];
//        CCMenuItemLabel *hopshopButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Hopshop" fontName:@"soupofjustice" fontSize:32] target:self selector:@selector(hopshopButtonPressed)];
//        CCMenuItemLabel *optionsButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Options" fontName:@"soupofjustice" fontSize:32] block:^(id sender){
//            [(CCMenu *)[self getChildByTag:9] setIsTouchEnabled:NO];
//            CCLayerColor *optionsLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 230) width:460 height:300];
//            optionsLayer.position = ccp(10, 10);
//            CCMenuItemLabel *resetData = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Reset Data" fontName:@"soupofjustice" fontSize:36] block:^(id sender){
//                [BTStorageManager reset];
//            }];
//            
//            CCMenuItemLabel *resetLeaps = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Reset Leaps" fontName:@"soupofjustice" fontSize:36] block:^(id sender){
//                [BTStorageManager setCurrentLeaps:[NSArray array]];
//                [[BTLeapManager sharedManager] reset];
//            }];
//            
//            CCMenuItemLabel *completeLeaps = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Complete Leaps" fontName:@"soupofjustice" fontSize:36] block:^(id sender){
//                for (BTLeap *leap in [[BTLeapManager sharedManager] currentLeaps]){
//                    [leap setProgress:[leap quantity]];
//                }
//            }];
//            
//            CCMenuItemLabel *muteButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Mute" fontName:@"soupofjustice" fontSize:36]];
//            CCMenuItemLabel *unMuteButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Unmute" fontName:@"soupofjustice" fontSize:36]];
//            CCMenuItemToggle *muteToggle;
//            
//            void (^MuteToggled)(id) = ^(id sender) {
//                if ([[SimpleAudioEngine sharedEngine] mute]){
//                    [[SimpleAudioEngine sharedEngine] setMute:NO];
//                } else {
//                    [[SimpleAudioEngine sharedEngine] setMute:YES]; 
//                }
//            };
//            
//            if ([[SimpleAudioEngine sharedEngine] mute]){
//                muteToggle = [CCMenuItemToggle itemWithBlock:MuteToggled items:unMuteButton, muteButton, nil];
//            } else {
//                muteToggle = [CCMenuItemToggle itemWithBlock:MuteToggled items:muteButton, unMuteButton, nil];
//            }
//            
//            CCMenuItemLabel *back = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Back" fontName:@"soupofjustice" fontSize:28] block:^(id sender){
//                [self removeChild:optionsLayer cleanup:YES];
//                [(CCMenu *)[self getChildByTag:9] setIsTouchEnabled:YES];
//            }];
//            
//            CCMenu *optionsMenu = [CCMenu menuWithItems:resetData, resetLeaps, completeLeaps, muteToggle, back, nil];
//            [optionsMenu alignItemsVerticallyWithPadding:20];
//            optionsMenu.position = ccp(240, 160);
//            back.position = ccp(back.position.x, back.position.y-25);
//            [optionsLayer addChild:optionsMenu];
//            [self addChild:optionsLayer z:1];
//        }];
//        
//        CCMenu *menu = [CCMenu menuWithItems:startGameButton, highscoreButton, leaderboardButton, hopshopButton, optionsButton, configButton, nil];
//        CCMenu *menu = [CCMenu menuWithItems:startGameButton, nil];
//
//        menu.position = ccp(240, 160);
//        [menu alignItemsVerticallyWithPadding:10];
//        [self addChild:menu z:5 tag:9];        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTStartMenu.plist" textureFile:@"BTStartMenu.pvr.ccz"];
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"water.png"];
        background.position = ccp(240, 160);
        [self addChild:background z:0];
        
        CCSprite *grass = [CCSprite spriteWithSpriteFrameName:@"grass-overlay.png"];
        grass.position = ccp(240, 51);
        [self addChild:grass z:15];
        
        CCSprite *sign = [CCSprite spriteWithSpriteFrameName:@"title-swing-1.png"];
        sign.position = ccp(240, 256);
        [self addChild:sign z:2];
        
        CCAnimate *swingForward = [CCAnimate actionWithAnimation:[BTStorageManager animationWithString:@"BTStartSign" atInterval:0.2 Reversed:NO] restoreOriginalFrame:NO];
        [sign runAction:[CCRepeatForever actionWithAction:swingForward]];
        
        CCAnimate *startRipplesAnimate = [CCAnimate actionWithAnimation:[BTStorageManager animationWithString:@"BTRipples" atInterval:0.2 Reversed:NO] restoreOriginalFrame:NO];
        CCSprite *startButton = [CCSprite spriteWithSpriteFrameName:@"start-lilypad.png"];
        CCSprite *startRipples = [CCSprite spriteWithSpriteFrameName:@"ripple-1.png"];
        startRipples.position = ccp(-15, -5);
        CCSprite *startButtonPressed = [CCSprite spriteWithSpriteFrameName:@"start-lilypad.png"];
        startButtonPressed.position = ccp(15, 5);
        startButtonPressed.isRelativeAnchorPoint = NO;
        [startRipples addChild:startButtonPressed z:1];
        [startRipples runAction:[CCRepeatForever actionWithAction:startRipplesAnimate]];
        
        CCMenuItemSprite *startButtonMenuItem = [CCMenuItemSprite itemFromNormalSprite:startButton selectedSprite:startRipples block:^(id sender){
            [self buttonPressed];
            [delegate startGame];       
        }];
        startButtonMenuItem.position = ccp(240, 125);
        
        CCAnimate *optionsRipplesAnimate = [CCAnimate actionWithAnimation:[BTStorageManager animationWithString:@"BTRipples" atInterval:0.2 Reversed:NO] restoreOriginalFrame:NO];
        CCSprite *optionsButton = [CCSprite spriteWithSpriteFrameName:@"option-lilypad.png"];
        CCSprite *optionsRipples = [CCSprite spriteWithSpriteFrameName:@"ripple-1.png"];
        optionsRipples.position = ccp(-20, -25);
        CCSprite *optionsButtonPressed = [CCSprite spriteWithSpriteFrameName:@"option-lilypad.png"];
        optionsButtonPressed.position = ccp(20, 25);
        optionsButtonPressed.isRelativeAnchorPoint = NO;
        [optionsRipples addChild:optionsButtonPressed z:1];
        [optionsRipples runAction:[CCRepeatForever actionWithAction:optionsRipplesAnimate]];
        
        CCMenuItemSprite *optionsButtonMenuItem = [CCMenuItemSprite itemFromNormalSprite:optionsButton selectedSprite:optionsRipples block:^(id sender){
            [self buttonPressed];
            [(CCMenu *)[self getChildByTag:9] setIsTouchEnabled:NO];
            CCLayerColor *optionsLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 230) width:460 height:300];
            optionsLayer.position = ccp(10, 10);
            CCMenuItemLabel *resetData = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Reset Data" fontName:@"soupofjustice" fontSize:36] block:^(id sender){
                [BTStorageManager reset];
            }];
            
            CCMenuItemLabel *resetLeaps = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Reset Leaps" fontName:@"soupofjustice" fontSize:36] block:^(id sender){
                [BTStorageManager setCurrentLeaps:[NSArray array]];
                [[BTLeapManager sharedManager] reset];
            }];
            
            CCMenuItemLabel *completeLeaps = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Complete Leaps" fontName:@"soupofjustice" fontSize:36] block:^(id sender){
                for (BTLeap *leap in [[BTLeapManager sharedManager] currentLeaps]){
                    [leap setProgress:[leap quantity]];
                }
            }];
            
            CCMenuItemLabel *muteButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Mute" fontName:@"soupofjustice" fontSize:36]];
            CCMenuItemLabel *unMuteButton = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Unmute" fontName:@"soupofjustice" fontSize:36]];
            CCMenuItemToggle *muteToggle;
            
            void (^MuteToggled)(id) = ^(id sender) {
                if ([[SimpleAudioEngine sharedEngine] mute]){
                    [[SimpleAudioEngine sharedEngine] setMute:NO];
                } else {
                    [[SimpleAudioEngine sharedEngine] setMute:YES]; 
                }
            };
            
            if ([[SimpleAudioEngine sharedEngine] mute]){
                muteToggle = [CCMenuItemToggle itemWithBlock:MuteToggled items:unMuteButton, muteButton, nil];
            } else {
                muteToggle = [CCMenuItemToggle itemWithBlock:MuteToggled items:muteButton, unMuteButton, nil];
            }
            
            CCMenuItemLabel *back = [CCMenuItemLabel itemWithLabel:[CCLabelTTF labelWithString:@"Back" fontName:@"soupofjustice" fontSize:28] block:^(id sender){
                [self removeChild:optionsLayer cleanup:YES];
                [(CCMenu *)[self getChildByTag:9] setIsTouchEnabled:YES];
            }];
            
            CCMenu *optionsMenu = [CCMenu menuWithItems:resetData, resetLeaps, completeLeaps, muteToggle, back, nil];
            [optionsMenu alignItemsVerticallyWithPadding:20];
            optionsMenu.position = ccp(240, 160);
            back.position = ccp(back.position.x, back.position.y-25);
            [optionsLayer addChild:optionsMenu];
            [self addChild:optionsLayer z:6];

        }];
        optionsButtonMenuItem.position = ccp(85, 50);
        
        CCAnimate *statsRipplesAnimate = [CCAnimate actionWithAnimation:[BTStorageManager animationWithString:@"BTRipples" atInterval:0.2 Reversed:NO] restoreOriginalFrame:NO];
        CCSprite *statsButton = [CCSprite spriteWithSpriteFrameName:@"stats-lilypad.png"];
        CCSprite *statsRipples = [CCSprite spriteWithSpriteFrameName:@"ripple-1.png"];
        statsRipples.position = ccp(-20, -25);
        CCSprite *statsButtonPressed = [CCSprite spriteWithSpriteFrameName:@"stats-lilypad.png"];
        statsButtonPressed.position =ccp(20, 25);
        statsButtonPressed.isRelativeAnchorPoint = NO;
        [statsRipples addChild:statsButtonPressed z:1];
        [statsRipples runAction:[CCRepeatForever actionWithAction:statsRipplesAnimate]];
        
        CCMenuItemSprite *statsButtonMenuItem = [CCMenuItemSprite itemFromNormalSprite:statsButton selectedSprite:statsRipples block:^(id sender){
            [self highscoreButtonPressed];
        }];
        statsButtonMenuItem.position = ccp(410, 50);
        
        CCMenuItemSprite *hopshopButtonMenuItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"hopshop-light-off.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"hopshop-light-on.png"] target:self selector:@selector(hopshopButtonPressed)];
        hopshopButtonMenuItem.position = ccp(250, 36);
        
        CCMenu *menu = [CCMenu menuWithItems:startButtonMenuItem, optionsButtonMenuItem, statsButtonMenuItem, hopshopButtonMenuItem, nil];
        menu.position = ccp(0,0);
        [self addChild:menu z:1];
        
        CCLabelTTF *noticeLabel = [CCLabelTTF labelWithString:@"BETA Build belonging to Blacktorch Games LLC.\nWIP: Not representative of final game." dimensions:CGSizeMake(290, 32) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"Marker Felt" fontSize:14];
        noticeLabel.position = ccp(240, 307);
        noticeLabel.color = ccc3(255, 0, 0);
//        [self addChild:noticeLabel z:5];
    }
    return self;
}

- (void) buttonPressed {
    [[SimpleAudioEngine sharedEngine] playEffect:@"MenuSelect.m4a"];
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
}

- (void) highscoreButtonPressed {
    [self buttonPressed];
    CCScene *highscoreScene = [CCScene node];
    [highscoreScene addChild:[BTHighScoreLayer node]];
    [[CCDirector sharedDirector] pushScene:highscoreScene];
    if ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"]){
        highscoreScene.scale = 1024.0/480.0;
        highscoreScene.position = ccp(579, 475);
    }
}

- (void) leaderboardButtonPressed {
    [self buttonPressed];

    if ([GKLocalPlayer localPlayer].authenticated){
        [[BTGameCenterManager sharedManager] showLeaderboard];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Must be logged into Game Center." delegate:nil cancelButtonTitle:@"Oh, okay..." otherButtonTitles: nil];
        [alertView show];
        [alertView release];
        [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
    }
}

- (void) configButtonPressed {
    [self buttonPressed];
        BTGameScene *scene = [[[BTGameScene alloc] init] autorelease];
        scene.score = 1680;
        scene.fliesFried = 50;
        scene.maxMultiplier = 2;
        [scene unscheduleUpdate];
        
        BTResultsLayer *resultsLayer = [[[BTResultsLayer alloc] initWithScore:0 AllTimeScore:12345 FliesFried:12345 AllTimeFliesFried:0 FlyPennies:0 Multiplier:25 AllTimeMultiplier:0 Bank:0] autorelease];
        [scene addChild:resultsLayer z:1]; 
    
    BTPostGameScene *postGameScene = [[[BTPostGameScene alloc] initWithResultsLayer:nil Destination:@""] autorelease];
    
    [[CCDirector sharedDirector] pushScene:[CCTransitionSlideInR transitionWithDuration:0.25 scene:postGameScene]];
}

- (void) hopshopButtonPressed {
    [self buttonPressed];

    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate openHopshop];
}

@end
