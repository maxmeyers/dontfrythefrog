//
//  BTLeapManager.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class BTLeap;

@interface BTLeapManager : NSObject {
    NSMutableArray *currentLeaps;
    NSDictionary *leaps;
    NSArray *levels;
}

+ (BTLeapManager *) sharedManager;

- (void) loadLeaps;
- (void) loadLevels;
- (NSArray *) currentLeaps;
- (void) reset;
- (void) resetProgress;

- (NSString *) nameForCurrentLevel;
- (NSString *) nameForLevel:(int) level;
- (NSString *) rewardForCurrentLevel;
- (NSString *) rewardForLevel:(int) level;
- (int) padsRequiredForCurrentLevel;
- (int) padsRequiredForLevel:(int) level;

- (void) gameStarted;
- (void) gameEnded;

- (void) bugFriedOfClass:(Class) bugClass;
- (void) stuckBugFriedOfClass:(Class) bugClass;
- (void) bugEatenOfClass:(Class) bugClass;
- (void) frogFriedAtTime:(ccTime) time;
- (void) frogExplodedAtTime:(ccTime) time;
- (void) beamBonusFullForTime:(ccTime) time;
- (void) fingersDownForTime:(ccTime) time;
- (void) gamePlayedForTime:(ccTime) time;
- (void) gameEndedWithKillDictionary:(NSDictionary *) dictionary;
- (void) itemPurchasedWithIdentifier:(NSString *) identifier PenniesSpent:(int) penniesSpent;

- (void) notifyCompletionOfLeap:(BTLeap *) leap;
- (void) leapAchieved:(BTLeap *) leap;
- (BTLeap *) newLeap;
- (void) save;

@end
