//
//  BTPauseLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTPauseLayer.h"
#import "BTIncludes.h"
#import "CCTouchDispatcher.h"

@implementation BTPauseLayer

@synthesize scene;

CCMenuItemToggle *muteToggle;

#define kLeapBoxTag 10

- (id) init {
    if ((self = [super init])){                
        CCSprite *pauseBackground = [CCSprite spriteWithSpriteFrameName:@"pause-box.png"];
        pauseBackground.position = ccp(92, 160);
        [self addChild:pauseBackground z:0];
        
        playButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"play-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"play-pressed.png"] target:self selector:@selector(resumeButtonPressed)];
        playButton.position = ccp(90, 210);

        restartButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"restart-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"restart-pressed.png"] target:self selector:@selector(restartButtonPressed)];
        restartButton.position = ccp(45, 130);
        
        CCMenuItemSprite *muteButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"mute-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"mute-pressed.png"]];
        CCMenuItemSprite *unMuteButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"mute-muted.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"mute-pressed.png"]];
        if ([[SimpleAudioEngine sharedEngine] mute]){
            muteToggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(muteToggled) items:unMuteButton, muteButton, nil];
        } else {
            muteToggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(muteToggled) items:muteButton, unMuteButton, nil];
        }
        muteToggle.position = ccp(45, 50);
        
        helpButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"help-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"help-pressed.png"] target:self selector:@selector(resetDataButtonPressed)];
        helpButton.position = ccp(135, 130);
        
        homeButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"home-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"home-pressed.png"] target:self selector:@selector(quitButtonPressed)]; 
        homeButton.position = ccp(135, 50);
    
        CCMenu *menu = [CCMenu menuWithItems:playButton, restartButton, homeButton, helpButton, muteToggle, nil];
        menu.position = ccp(0,0);
        [self addChild:menu z:1];
        
        BTLeapBox *leapBox = [[[BTLeapBox alloc] initWithState:kPauseScreen] autorelease];
        leapBox.state = kPauseScreen;
        [self addChild:leapBox z:1 tag:kLeapBoxTag];
    
    }
    
    return self;
}
 
- (void) resumeButtonPressed {
    [scene unPauseGame];
}

- (void) restartButtonPressed {
    [scene unPauseGame];
    [scene resetGame];
}

- (void) quitButtonPressed {
//    [self removeFromParentAndCleanup:YES];
//    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
//    [scene softResume];
//    [scene resetGame];

    [scene unPauseGameInstantly:YES];
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] exitToMainMenu];
}

- (void) muteToggled {
    if ([[SimpleAudioEngine sharedEngine] mute]){
        [self unMuteButtonPressed];
    } else {
        [self muteButtonPressed];
    }
}

- (void) debugToggled {
    if (![[BTConfig sharedConfig] debug]){
        [[BTConfig sharedConfig] setDebug:YES];
    } else {
        [[BTConfig sharedConfig] setDebug:NO];
    }
}

- (void) muteButtonPressed {
    [[SimpleAudioEngine sharedEngine] setMute:YES];
    [[BTConfig sharedConfig] setDebug:YES];

//    [BTStorageManager unlockBug:[BTGreenFly class]];
//    [BTStorageManager unlockBug:[BTSickBug class]];
//    [BTStorageManager unlockBug:[BTIceBug class]];
//    [BTStorageManager unlockBug:[BTFireBug class]];
}

- (void) unMuteButtonPressed {
    [[SimpleAudioEngine sharedEngine] setMute:NO]; 
    [[BTConfig sharedConfig] setDebug:NO];
}

- (void) resetDataButtonPressed {
    [BTStorageManager resetPopups];
    [BTStorageManager setIsVeteran:NO];
    [BTStorageManager reset]; // TOTAL RESET. REMOVE FOR RELEASE
    BTAlertView *alertView = [[[BTAlertView alloc] initWithTitle:@"Tutorials Reset!" message:@"" delegate:nil cancelButtonTitle:@"Okay." otherButtonTitles:nil] autorelease];
    [alertView show];
}

- (void) onEnter {
    [super onEnter];
    if ([self getChildByTag:kLeapBoxTag]){
        [(BTLeapBox *)[self getChildByTag:kLeapBoxTag] refresh];
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void) dealloc {
    [super dealloc];
}

@end
