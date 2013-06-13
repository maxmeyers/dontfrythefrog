//
//  BTResultsLayer.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/22/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "CCLayer.h"
#import "SHK.h"
#import "SHKTwitter.h"
#import "SHKFacebook.h"

#define kAllTimeHighScoreBoxTag 3 
#define kWeeklyHighScoreBoxTag 4
#define kDrTimBoxTag 5

#define kBoxOffScreen ccp(-240, -240)
#define kBoxOnScreen ccp(159, 120)

@class BTGameScene, CCSprite, CCMenuItem, BTHighScoreBox;

@interface BTResultsLayer : CCLayer {    
    BTGameScene *gameScene;
    
    CCSprite *mainSprite;
    CCMenuItem *hopshopMenuItem;
    CCMenuItem *leftArrowMenuItem;
    CCMenuItem *rightArrowMenuItem;
    CCMenuItem *menuButtonMenuItem;
    CCMenuItem *playButtonMenuItem;
    CCMenuItem *facebookMenuItem;
    CCMenuItem *twitterMenuItem;
    CCMenuItem *gcMenuItem;
    
    NSArray *highscoreBoxes;
    BTHighScoreBox *currentHighScoreBox;
}

@property (nonatomic, assign) BTGameScene *gameScene;

- (id) initWithScore:(int) score AllTimeScore:(int) allTimeScore FliesFried:(int) fliesFried AllTimeFliesFried:(int) allTimeFliesFried FlyPennies:(int) flyPennies Multiplier:(int) multiplier AllTimeMultiplier:(int) alltimeMultiplier Bank:(int) bank PlayTime:(ccTime) playTime;
- (void) playButtonPressed;
- (void) menuButtonPressed;
- (void) hopshopButtonPressed;
- (void) facebookButtonPressed;
- (void) twitterButtonPressed;
- (void) gcButtonpressed;
- (void) leftArrowPressed;
- (void) rightArrowPressed;
- (void) showSocialButtons:(bool)show;

@end
