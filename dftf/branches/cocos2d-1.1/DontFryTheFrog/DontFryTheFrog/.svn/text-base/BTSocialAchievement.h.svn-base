//
//  BTSocialAchievement.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameKit/GameKit.h"

@interface BTSocialAchievement : NSObject {
    bool _achieved;
    
    // The string to present to the user if achieved
    NSString *_string;
    
    // The string the user can post on social networks
    NSString *_socialString;
}

@property (nonatomic, copy, getter = string) NSString *string;
@property (nonatomic, copy, getter = socialString) NSString *socialString;

+ (BTSocialAchievement *) bestSocialAchievementForTimePlayed:(int) timePlayed Score:(int) score PreviousAllTimeHighScore:(int) previousAllTimeHighScore PreviousWeeklyHighScore:(int) previousWeeklyHighScore FliesFried:(int) fliesFried PreviousHighFliesFried:(int) previousHighFliesFried AllTimeScores:(NSArray *) allTimeScores AllTimePlayers:(NSArray *) allTimePlayers WeeklyScores:(NSArray *) weeklyScores WeeklyPlayers:(NSArray *) weeklyPlayers;

+ (BTSocialAchievement *) bestSocialAchievementLocalForScore:(int) score HighScore:(int) highScore FliesFried:(int) fliesFried HighFliesFried:(int) highFliesFried TimePlayed:(int) playTime;

- (id) initWithTimePlayed:(int) timePlayed Score:(int) score PreviousAllTimeHighScore:(int) previousAllTimeHighScore PreviousWeeklyHighScore:(int) previousWeeklyHighScore FliesFried:(int) fliesFried PreviousHighFliesFried:(int) previousHighFliesFried AllTimeScores:(NSArray *) allTimeScores AllTimePlayers:(NSArray *) allTimePlayers WeeklyScores:(NSArray *) weeklyScores WeeklyPlayers:(NSArray *) weeklyPlayers;

- (NSString *) string;
- (NSString *) socialString;

// Whether or not the user achieved it.
- (bool) achieved;

@end

// Just an abstract class for all "Beat Friend Score" achievements.
@interface BTSocialAchievementBeatScoreFriend : BTSocialAchievement
- (bool) achievedForTimeScope:(GKLeaderboardTimeScope) scope Scores:(NSArray *) scores Players:(NSArray *) players Score:(int) score PreviousScore:(int) previousScore;
@end

// Player beat a friend's all time score
@interface BTSocialAchievementBeatScoreFriendAllTime : BTSocialAchievementBeatScoreFriend
@end

// Player beat a friend's weekly score
@interface BTSocialAchievementBeatScoreFriendWeekly : BTSocialAchievementBeatScoreFriend
@end

// An abstract class for all "Beat Self Score" achievements
@interface BTSocialAchievementBeatSelf : BTSocialAchievement 
- (bool) achievedForScore:(int) score PreviousScore:(int) previousScore;
@end

// Player beat own alltime high score
@interface BTSocialAchievementBeatSelfAllTime : BTSocialAchievementBeatSelf
@end

// Player beat own weekly high score
@interface BTSocialAchievementBeatSelfWeekly : BTSocialAchievementBeatSelf
@end

@interface BTSocialAchievementLocal : BTSocialAchievement
- (id) initWithScore:(int) score HighScore:(int) highScore FliesFried:(int) fliesFried HighFliesFried:(int) highFliesFried TimePlayed:(int) playTime;
@end

@interface BTSocialAchievementBeatLocalScore : BTSocialAchievementLocal
@end

// Player beat own high flies fried score
@interface BTSocialAchievementBeatFliesFriedSelf : BTSocialAchievementLocal
@end

// Weakest - just listing how long the player survived
@interface BTSocialAchivementTimePlayed : BTSocialAchievementLocal
@end