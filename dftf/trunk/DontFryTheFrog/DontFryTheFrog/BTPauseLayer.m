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

#define kLeapBoxTag 2983
#define kHelpScreenTag 2984
#define kHelpScreenBackTag 2985

- (id) init {
    if ((self = [super init])){                
        CCSprite *pauseBackground = [CCSprite spriteWithSpriteFrameName:@"pause-box.png"];
        pauseBackground.position = ccp(92, 160);
        [self addChild:pauseBackground z:0];
        
        playButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"play-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"play-pressed.png"] target:self selector:@selector(resumeButtonPressed)];
        playButton.position = ccp(90, 210);

        restartButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"restart-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"restart-pressed.png"] target:self selector:@selector(restartButtonPressed)];
        restartButton.position = ccp(45, 130);
        
        CCMenuItemSprite *audioButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"mute-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"mute-pressed.png"] block:^(id sender){
            [(CCMenu *)[self getChildByTag:kMainMenuTag] setIsTouchEnabled:NO];
            BTSoundMenuLayer *soundMenuLayer = [BTSoundMenuLayer node];
            [self addChild:soundMenuLayer z:2];
        }];
        audioButton.position = ccp(45, 50);
        
        helpButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"help-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"help-pressed.png"] target:self selector:@selector(resetDataButtonPressed)];
        helpButton.position = ccp(135, 130);
        
        homeButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"home-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"home-pressed.png"] target:self selector:@selector(quitButtonPressed)]; 
        homeButton.position = ccp(135, 50);
    
        CCMenu *menu = [CCMenu menuWithItems:playButton, restartButton, homeButton, helpButton, audioButton, nil];
        menu.position = ccp(0,0);
        [self addChild:menu z:1 tag:kMainMenuTag];
        
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
    [FlurryAnalytics logEvent:@"Restart Button Pressed"];
    [scene unPauseGame];
    [scene resetGame];
}

- (void) quitButtonPressed {
    if ([scene prePauseState] == kGameStateStarted){
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Are you sure you want to quit?" message:@"All progress made during this game will be lost." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Quit", nil] autorelease];
        [alertView show];        
    } else {
        [self alertView:nil didDismissWithButtonIndex:1];
    }

}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1){
        [scene unPauseGameInstantly:YES];
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] exitToMainMenu];        
    }
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
}

- (void) unMuteButtonPressed {
    [[SimpleAudioEngine sharedEngine] setMute:NO]; 
    [[BTConfig sharedConfig] setDebug:NO];
}

- (void) resetDataButtonPressed {
    CCLayerColor *layerColor = [CCLayerColor layerWithColor:ccc4(79, 82, 83, 200)];
    [self addChild:layerColor z:4 tag:kHelpScreenBackTag];
    
    CCSprite *helpScreen = [CCSprite spriteWithSpriteFrameName:@"simplehelp.png"];
    helpScreen.position = ccp(240, 160);
    [self addChild:helpScreen z:5 tag:kHelpScreenTag];
    
    [(CCMenu *)[self getChildByTag:kMainMenuTag] setIsTouchEnabled:NO];
    CCMenu *helpMenu = [CCMenu menuWithItems:nil];
    helpMenu.position = ccp(0,0);
    CCMenuItemSprite *backButton = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithSpriteFrameName:@"back-unpressed.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"back-pressed.png"] block:^(id sender){
        [helpScreen removeFromParentAndCleanup:YES];
        [layerColor removeFromParentAndCleanup:YES];
        [helpMenu removeFromParentAndCleanup:YES];
        [(CCMenu *)[self getChildByTag:kMainMenuTag] setIsTouchEnabled:YES];
        
    }];
    backButton.position = ccp(50, 25);
    [helpMenu addChild:backButton];
    [self addChild:helpMenu z:6];
    [(CCMenu *)[self getChildByTag:kMainMenuTag] setIsTouchEnabled:NO];
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
