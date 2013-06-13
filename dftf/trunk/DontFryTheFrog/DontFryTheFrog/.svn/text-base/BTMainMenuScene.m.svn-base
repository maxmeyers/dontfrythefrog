//
//  BTMainMenuScene.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTMainMenuScene.h"
#import "BTIncludes.h"

@implementation BTMainMenuScene

@synthesize delegate;
@synthesize mainMenuLayer = mainMenuLayer_;
@synthesize optionsMenuLayer = optionsMenuLayer_;
@synthesize statsMenuLayer = statsMenuLayer_;
@synthesize playerStatsMenuLayer = playerStatsMenuLayer_;

- (id) init {
    if ((self = [super init])){  
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTStartMenu.plist" textureFile:@"BTStartMenu.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTFrogLevels.plist" textureFile:@"BTFrogLevels.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTSocialButtons.plist" textureFile:@"BTSocialButtons.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTDftfSign.plist" textureFile:@"BTDftfSign.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTHopshop.plist" textureFile:@"BTHopshop.pvr.ccz"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTHopshop-Flies.plist" textureFile:@"BTHopshop-Flies.pvr.ccz"];
        
        layerStack_ = [NSMutableArray new];
        
        self.mainMenuLayer = [[[BTMainMenuLayer alloc] init] autorelease];
        mainMenuLayer_.position = kOnscreen;
        [self addChild:mainMenuLayer_ z:2];
        currentLayer_ = mainMenuLayer_;
        
        self.optionsMenuLayer = [[[BTOptionsMenuLayer alloc] init] autorelease];
        optionsMenuLayer_.position = kBelowScreen;
        [self addChild:optionsMenuLayer_ z:2];
        
        self.statsMenuLayer = [[[BTStatsMenuLayer alloc] init] autorelease];
        statsMenuLayer_.position = kBelowScreen;
        [self addChild:statsMenuLayer_ z:2];
        
        self.playerStatsMenuLayer = [[[BTPlayerStatsMenuLayer alloc] init] autorelease];
        playerStatsMenuLayer_.position = kBelowScreen;
        [self addChild:playerStatsMenuLayer_ z:2];
        
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"water.png"];
        background.position = ccp(240, 160);
        [self addChild:background z:0];
        
        CCSprite *grassLeft = [CCSprite spriteWithSpriteFrameName:@"grass-overlay-L.png"];
        grassLeft.position = ccp(34, 50);
        [self addChild:grassLeft z:15];
        
        CCSprite *grassRight = [CCSprite spriteWithSpriteFrameName:@"grass-overlay-R.png"];
        grassRight.position = ccp(460, 46);
        [self addChild:grassRight z:15];
    }
    return self;
}

- (void) onEnter {
    [super onEnter];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTStartMenu.plist" textureFile:@"BTStartMenu.pvr.ccz"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTStart.plist" textureFile:@"BTStart.pvr.ccz"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTFrogLevels.plist" textureFile:@"BTFrogLevels.pvr.ccz"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTSocialButtons.plist" textureFile:@"BTSocialButtons.pvr.ccz"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTDftfSign.plist" textureFile:@"BTDftfSign.pvr.ccz"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTUIElements.plist" textureFile:@"BTUIElements.pvr.ccz"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTHats.plist" textureFile:@"BTHats.pvr.ccz"];
    
    if ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"]){
//        self.scale = 1024.0/480.0;
//        self.position = ccp(579, 475);
    }
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"MenuTheme(NoVocals).m4a"];
}

- (void) onExit {
    [super onExit];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"BTSocialButtons.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"BTDftfSign.plist"];
}

- (void) highscoreButtonPressed {
    [self addChild:[[[BTHighScoreLayer alloc] init] autorelease] z:3 tag:50];
    [delegate setMode:kModeHighScores];
}

- (void) highscoreWindowClosed {
    [self removeChildByTag:50 cleanup:YES];
    [delegate setMode:kModeMainMenu];
}

- (void) pushMenu:(CCLayer *) menu {
    if ([[self children] containsObject:menu] && currentLayer_){
        
        CCEaseIn *removeCurrentMenu = [CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:0.35 position:kAboveScreen] rate:2];
        CCEaseIn *addSubmenu = [CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:0.35 position:kOnscreen] rate:2];
        
        [currentLayer_ runAction:removeCurrentMenu];        
        [menu runAction:addSubmenu];
        
        [layerStack_ addObject:currentLayer_];
        currentLayer_ = menu;
    }
}

- (void) popMenu {
    if (currentLayer_){
        CCEaseIn *reAddPreviousMenu = [CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:0.35 position:kOnscreen] rate:2];
        CCEaseIn *removeSubmenu = [CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:0.35 position:kBelowScreen] rate:2];
        
        CCLayer *previousLayer = [layerStack_ objectAtIndex:[layerStack_ count]-1];
        [layerStack_ removeLastObject];
        
        [previousLayer runAction:reAddPreviousMenu];
        [currentLayer_ runAction:removeSubmenu];
        
        currentLayer_ = previousLayer;

    }   

}

@end
