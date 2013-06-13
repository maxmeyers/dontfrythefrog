//
//  BTGameCenterManager.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 5/26/11.
//  Copyright 2011 New York University. All rights reserved.
//

#import "BTGameCenterManager.h"
#import "BTIncludes.h"
#import "GameKit/GameKit.h"

@implementation BTGameCenterManager


+ (BTGameCenterManager *) sharedManager {
    static BTGameCenterManager *sharedManager;
    @synchronized(self)
    {
        if (!sharedManager) {
            sharedManager = [[BTGameCenterManager alloc] init];
        }
        return sharedManager;
    }
}

- (id) init {
    if ((self = [super init])){

    }
    
    return self;
}

+ (void) authenticateLocalPlayer {
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    [localPlayer authenticateWithCompletionHandler:^(NSError *error) {
        if (localPlayer.isAuthenticated)
        {
            // Perform additional tasks for the authenticated player.
        }
    }];
}

+ (void) reportScore: (int64_t) score forCategory: (NSString*) category {
    GKScore *scoreReporter = [[GKScore alloc] initWithCategory:category];
    scoreReporter.value = score;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error!: %@", [error description]);
        } else {
            NSLog(@"Reported score: %d", (int)score);
        }
    }];
}

+ (NSArray *) getGKLocalPlayerScores {
    __block NSArray *array;
    if ([GKLocalPlayer localPlayer].authenticated){
        GKLeaderboard *leaderboardRequest = [[GKLeaderboard alloc] initWithPlayerIDs:[NSArray arrayWithObject:[GKLocalPlayer localPlayer].playerID]];
        if (leaderboardRequest != nil) {
            leaderboardRequest.timeScope = GKLeaderboardTimeScopeAllTime;
            [leaderboardRequest loadScoresWithCompletionHandler: ^(NSArray *scores, NSError *error) {
                if (error != nil) {
                    
                }
                
                if (scores != nil) {
                    array = scores;
                }
            }];
        }
    }
    
    if (array == nil){
        array = [NSArray array];
    }
    
    return array;
}

+ (void) scoresForFriendsWithinTimeScope:(GKLeaderboardTimeScope) scope HighScoreBox:(BTHighScoreBox *) box {
    if ([GKLocalPlayer localPlayer].isAuthenticated){
        GKLeaderboard *leaderboard = [[[GKLeaderboard alloc] init] autorelease];
        leaderboard.playerScope = GKLeaderboardPlayerScopeFriendsOnly;
        leaderboard.timeScope = scope;
        [leaderboard loadScoresWithCompletionHandler:^(NSArray *scores, NSError *error){
            if (error != nil){
                NSLog(@"Error Loading Scores of Scope %d: %@", scope, [error description]);
            } 
            
            if (scores != nil){
                [box setScores:scores TimeScope:scope];
            } else {
                [box setScores:[NSArray array] TimeScope:scope];
            }
        }];
    }
}

+ (void) playersForIdentifiers:(NSArray *) identifiers HighScoreBox:(BTHighScoreBox *) box {
    if ([GKLocalPlayer localPlayer].authenticated){
        [GKPlayer loadPlayersForIdentifiers:identifiers withCompletionHandler:^(NSArray *players, NSError *error){
            if (error != nil){
                NSLog(@"GKPlayer Request Error!: %@", [error description]);
            }
            
            if (players != nil){
                [box setPlayers:players];
            }
        }];
    }
}

+ (bool) localPlayerFriendIdentifiersForHighscoreBox:(BTHighScoreBox *) box {
    GKLocalPlayer *lp = [GKLocalPlayer localPlayer];
    if (lp.authenticated){
        [lp loadFriendsWithCompletionHandler:^(NSArray *friends, NSError *error) {
            if (friends != nil){
                [box setPlayers:friends];
            }
        }];
        return YES;
    }
    return NO;
}

- (void) showLeaderboard {
    viewController = [UIViewController new];
    [[[CCDirector sharedDirector] openGLView].window addSubview:viewController.view];
    GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
    if (leaderboardController != nil)
    {
        leaderboardController.leaderboardDelegate = self;
        [viewController presentModalViewController:leaderboardController animated:YES];
    }
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *) controller {
    [controller dismissModalViewControllerAnimated:YES];
    [controller release];
    [viewController.view.superview removeFromSuperview];
    [viewController release];
}

+ (NSString *) aliasForPlayerID:(NSString *) str Players:(NSArray *) players {
    if (players != nil){
        for (int i = 0; i < [players count]; i++){
            GKPlayer *player = (GKPlayer *)[players objectAtIndex:i];
            if ([[player playerID] isEqualToString:str]){
                return [player alias];
            }
        }
    }
    return @"Player";
}

- (void) dealloc {
    [super dealloc];

}

@end
