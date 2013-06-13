//
//  BTStatsManager.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTStatsManager : NSObject <NSCoding> {
    NSMutableDictionary *statistics_;
}

+ (BTStatsManager *) sharedManager;

#define kMaxBeamBonusTime @"MaxBeamBonusTime"
@property float maxBeamBonusTime;

#define kFlyPenniesEarned @"FlyPenniesEarned"
@property int flyPenniesEarned;

#define kFlyPenniesSpent @"FlyPenniesSpent"
@property int flyPenniesSpent;


#define kTotalFliesFried @"TotalFliesFried"
@property int totalFliesFried;

#define kGreyFliesFried @"GreyFliesFried"
@property int greyFliesFried;

#define kYellowFliesFried @"YellowFliesFried"
@property int yellowFliesFried;

#define kRedFliesFried @"RedFliesFried"
@property int redFliesFried;


#define kGreenFliesEaten @"GreenFliesEaten"
@property int greenFliesEaten;

#define kBluesFliesEaten @"BlueFliesEaten"
@property int blueFliesEaten;

#define kTotalPlayTime @"TotalPlayTime"
@property float totalPlayTime;

#define kGamesPlayed @"GamesPlayed"
@property int gamesPlayed;

#define kAverageScore @"AverageScore"
@property int averageScore;

#define kAverageFliesFried @"AverageFliesFried"
@property int averageFliesFried;

#define kFrogsFried @"FrogsFried"
@property int frogsFried;

#define kFrogsExploded @"FrogsExploded"
@property int frogsExploded;

- (void) addScore:(int) score;
- (void) addFliesFried:(int) flies;
- (void) save;
- (void) load;
- (void) reset;

@end
