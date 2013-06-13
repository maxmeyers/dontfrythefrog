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

- (id) init {
    if ((self = [super init])){                      
        [self addChild:[[[BTMainMenuLayer alloc] init] autorelease] z:2];
    }
    return self;
}

- (void) highscoreButtonPressed {
    [self addChild:[[[BTHighScoreLayer alloc] init] autorelease] z:3 tag:50];
    [delegate setMode:kModeHighScores];
}

- (void) highscoreWindowClosed {
    [self removeChildByTag:50 cleanup:YES];
    [delegate setMode:kModeMainMenu];
}

- (void) onEnter {
    [super onEnter];
    if ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"]){
        self.scale = 1024.0/480.0;
        self.position = ccp(579, 475);
    }
    
//    BTBackgroundLayer *bg = [[[BTBackgroundLayer alloc] init] autorelease];
//    [self addChild:bg z:1 tag:5];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"MenuTheme(NoVocals).m4a"];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTMenus.plist" textureFile:@"BTMenus.pvr.ccz"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTHopshop.plist" textureFile:@"BTHopshop.pvr.ccz"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BTHopshop-Flies.plist" textureFile:@"BTHopshop-Flies.pvr.ccz"];
}

- (void) onExit {
    [super onExit];
//    [self removeChild:[self getChildByTag:5] cleanup:YES];
}


@end
