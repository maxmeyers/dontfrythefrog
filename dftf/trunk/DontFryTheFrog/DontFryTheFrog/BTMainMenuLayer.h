//
//  BTMainMenuLayer.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 5/26/11.
//  Copyright 2011 New York University. All rights reserved.
//

#import "cocos2d.h"

#define kMainMenuTag 10
#define kNewslogTag 11

@interface BTMainMenuLayer : CCLayer {
    
}

- (void) buttonPressed;
- (void) highscoreButtonPressed;
- (void) leaderboardButtonPressed;
- (void) configButtonPressed;
- (void) hopshopButtonPressed;

@end
