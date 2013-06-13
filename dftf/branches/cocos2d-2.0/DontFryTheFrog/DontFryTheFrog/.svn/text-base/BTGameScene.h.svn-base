//
//  BTGameScene.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// Importing Chipmunk headers
#import "chipmunk.h"

typedef enum {
    kGameStateLoaded,
    kGameStateReady,
    kGameStateNewbie,
    kGameStateWaddle,
    kGameStateStarted,
    kGameStatePaused,
    kGameStatePopup,
    kGameStateGameOver,
    kGameStateFrogFried,
    kGameStateFrogFull,
} tGameState;


@class BTGameLayer, BTGameUILayer, BTPauseLayer;
@class BTLifeCounter;

@interface BTGameScene : CCScene {
    BTGameLayer *gameLayer;
    BTGameUILayer *gameUILayer;
    BTPauseLayer *pauseLayer;
    tGameState gameState;
    tGameState prePauseState;
    
    int pauseCount;
    
    int score;
    int highscore;

    float multiplier;
    
    int fliesFried;
    int fliesEaten;
    int maxMultiplier;

    CCMenuItemLabel *foilHatMenuItem;
    CCMenuItemLabel *pennyFrenzyMenuItem;
}

@property (nonatomic, assign) BTGameLayer *gameLayer;
@property (nonatomic, assign) BTGameUILayer *gameUILayer;
@property (nonatomic, assign) BTPauseLayer *pauseLayer;
@property tGameState gameState;

@property int score;

@property float multiplier;

@property int fliesFried;
@property int fliesEaten;
@property int maxMultiplier;


- (id) initWithGameLayer:(BTGameLayer *) layer;

- (void) startGame;
- (void) stopGame;
- (void) resetGame; // Resets the entire game
- (void) reset; // Resets just game variables
- (void) loadConsumablesMenu;

- (void) activateFoilHat;
- (void) activatePennyFrenzy;
- (void) activateGustOfWind;

- (void) addToMultiplier:(float) addition;
- (int)  multiplierInt;

- (void) pauseGame;
- (void) pauseGameWithState:(tGameState) state;
- (void) unPauseGame;
- (void) unPauseGameInstantly:(bool) instantly;

#define kSoftPauseTag 2093857 // The first child with this tag will be paused during the soft pause.
- (void) softPause;
- (void) softResume;

@end

