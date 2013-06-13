//
//  BTMainMenuScene.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

#define kOnscreen ccp(0, 0)
#define kAboveScreen ccp(0, 320)
#define kBelowScreen ccp(0, -320)


@class AppDelegate, BTMainMenuLayer, BTOptionsMenuLayer, BTStatsMenuLayer, BTPlayerStatsMenuLayer;

@interface BTMainMenuScene : CCScene {
    AppDelegate *delegate;
    BTMainMenuLayer *mainMenuLayer_;
    BTOptionsMenuLayer *optionsMenuLayer_;
    BTStatsMenuLayer *statsMenuLayer_;
    BTPlayerStatsMenuLayer *playerStatsMenuLayer_;
    
    CCLayer *currentLayer_;
    NSMutableArray *layerStack_;
}

@property (nonatomic, retain) BTMainMenuLayer *mainMenuLayer;
@property (nonatomic, retain) BTOptionsMenuLayer *optionsMenuLayer;
@property (nonatomic, retain) BTStatsMenuLayer *statsMenuLayer;
@property (nonatomic, retain) BTPlayerStatsMenuLayer *playerStatsMenuLayer;

@property (nonatomic, assign) AppDelegate *delegate;

- (void) highscoreButtonPressed;
- (void) highscoreWindowClosed;

- (void) pushMenu:(CCLayer *) menu;
- (void) popMenu;

@end
