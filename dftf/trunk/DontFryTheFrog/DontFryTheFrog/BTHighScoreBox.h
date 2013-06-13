//
//  BTHighScoreBox.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/23/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "CCNode.h"
#import "GameKit/GameKit.h"
#import "Reachability.h"

#define kLoadingLabelTag 9
#define kLoginButtonTag 10
#define kLoginMenuTag 11

@class CCSprite;

typedef enum {
    kScoresRequestNotSent,
    kScoresRequestSent,
    kFriendsRequestNotSent,
    kFriendsRequestSent,
    kHasScoresAndFriends,
    kLoadingFinished
} tHighScoreBoxState;

@interface BTHighScoreBox : CCNode {
    CCSprite *boxBackground;
    tHighScoreBoxState state;
    NSArray *players;
    NSArray *scores;
    
    GKLeaderboardTimeScope timeScope;
    int lastScore;
    int startingIndex;
}

@property tHighScoreBoxState state;
@property (nonatomic, readonly) NSArray *players;
@property (nonatomic, readonly) NSArray *scores;

// If not initializing from a BTResultsLayer, set use score = 0
- (id) initWithTimeScope:(GKLeaderboardTimeScope) scope LastScore:(int) score;
- (void) setIsLoginButtonEnabled:(bool) b;

- (void) setPlayers:(NSArray *) array;
- (void) setScores:(NSArray *) array TimeScope:(GKLeaderboardTimeScope) scope;

- (bool) requestScores;
- (bool) requestFriends;

@end

typedef enum {
    kDoesNotHavePreviousScores,
    kNewScoreReportedAndWaitingForHighScoreBoxes,
    kHasSocialAchievement,
    kCompletelyLoaded
} tDrTimBoxState;

@class BTSocialAchievement;

// ONLY ADD THIS TO A RESULTSLAYER ATTACHED TO A GAMELAYER!
@interface BTDrTimBox : BTHighScoreBox {
    int allTimePrevious;
    int weeklyPrevious;
    int fliesFriedPrevious;
    int maxMultiplierPrevious;
    
    BTSocialAchievement *socialAchievement;
    
    BTHighScoreBox *allTimeHighScoreBox;
    BTHighScoreBox *weeklyHighScoreBox;
    
    tDrTimBoxState drState;
}

- (id) initWithLastScore:(int) score PlayTime:(ccTime) playTime AllTimeHighScoreBox:(BTHighScoreBox *) allTime WeeklyHighScoreBox:(BTHighScoreBox *) weekly;

@property (nonatomic, assign) BTSocialAchievement *socialAchievement;

@end
