//
//  BTPauseLayer.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@class BTGameScene, CCMenuItemSprite;

@interface BTPauseLayer : CCLayer {
    BTGameScene *scene;
    
    CCMenuItemSprite *playButton;
    CCMenuItemSprite *restartButton;
    CCMenuItemSprite *homeButton;
    CCMenuItemSprite *helpButton;
}

@property (nonatomic, assign) BTGameScene *scene;

- (void) resumeButtonPressed;
- (void) restartButtonPressed;
- (void) quitButtonPressed;
- (void) muteButtonPressed;
- (void) unMuteButtonPressed;
- (void) resetDataButtonPressed;

@end
