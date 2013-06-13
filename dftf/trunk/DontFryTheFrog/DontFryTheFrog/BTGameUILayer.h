//
//  StartStopLayer.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

#define kHUDMenuTag 10

@class BTGameScene, BTLifeCounter;

@interface BTGameUILayer : CCLayer {
    BTGameScene *scene;
    CCProgressTimer *energyBar;
    CCMenuItemSprite *pauseButton;
    CCMenuItemSprite *bugSprayButton;
    BTLifeCounter *lifeCounter;
    CCLabelTTF *playTimeLabel;
}

@property (nonatomic, assign) BTGameScene *scene;
@property (nonatomic, assign) CCProgressTimer *energyBar;

@property (nonatomic, assign) CCMenuItemSprite *pauseButton;
@property (nonatomic, assign) CCMenuItemSprite *bugSprayButton;
@property (nonatomic, assign) BTLifeCounter *lifeCounter;

@end
