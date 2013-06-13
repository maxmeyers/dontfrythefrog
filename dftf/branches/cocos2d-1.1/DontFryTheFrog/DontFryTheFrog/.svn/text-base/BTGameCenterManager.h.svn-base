//
//  BTGameCenterManager.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 5/26/11.
//  Copyright 2011 New York University. All rights reserved.
//

#import "GameKit/GameKit.h"

@class BTHighScoreBox;

@interface BTGameCenterManager : NSObject <GKLeaderboardViewControllerDelegate> {
    UIViewController *viewController;
}

+ (BTGameCenterManager *) sharedManager;

+ (void) authenticateLocalPlayer;
+ (void) reportScore: (int64_t) score forCategory: (NSString*) category;
+ (NSArray *) getGKLocalPlayerScores;

// Returns YES if  authenticated, NO otherwise
+ (void) scoresForFriendsWithinTimeScope:(GKLeaderboardTimeScope) scope HighScoreBox:(BTHighScoreBox *) box;
+ (void) playersForIdentifiers:(NSArray *) identifiers HighScoreBox:(BTHighScoreBox *) box;

// Returns YES if  authenticated, NO otherwise
+ (bool) localPlayerFriendIdentifiersForHighscoreBox:(BTHighScoreBox *) box;
- (void) showLeaderboard;

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController;

+ (NSString *) aliasForPlayerID:(NSString *) str Players:(NSArray *) players;

@end
