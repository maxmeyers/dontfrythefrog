//
//  BTSocialAchievement.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTSocialAchievement.h"
#import "BTIncludes.h"

@implementation BTSocialAchievement

@synthesize string = _string, socialString = _socialString;

+ (BTSocialAchievement *) bestSocialAchievementForTimePlayed:(int) timePlayed Score:(int) score PreviousAllTimeHighScore:(int) previousAllTimeHighScore PreviousWeeklyHighScore:(int) previousWeeklyHighScore FliesFried:(int) fliesFried PreviousHighFliesFried:(int) previousHighFliesFried AllTimeScores:(NSArray *) allTimeScores AllTimePlayers:(NSArray *) allTimePlayers WeeklyScores:(NSArray *) weeklyScores WeeklyPlayers:(NSArray *) weeklyPlayers {
    
    NSArray *achievements = [NSArray arrayWithObjects:[BTSocialAchievementBeatScoreFriendAllTime class], [BTSocialAchievementBeatScoreFriendWeekly class], [BTSocialAchievementBeatSelfAllTime class], [BTSocialAchievementBeatSelfWeekly class], [BTSocialAchievementBeatLocalScore class], [BTSocialAchievementBeatFliesFriedSelf class], [BTSocialAchivementTimePlayed class], nil];
    
    bool foundAchievement = NO;
    BTSocialAchievement *theAchievement;
    for (int i = 0; i < [achievements count] && !foundAchievement; i++){
        Class achievement = [achievements objectAtIndex:i];
        
        id testObject = [[[achievement alloc] init] autorelease];
        BTSocialAchievement *achievementInstance;
        if ([testObject isKindOfClass:[BTSocialAchievementLocal class]]){
            achievementInstance = [[(BTSocialAchievementLocal *)[achievement alloc] initWithScore:score HighScore:[BTStorageManager highscore] FliesFried:fliesFried HighFliesFried:previousHighFliesFried TimePlayed:timePlayed] autorelease];
        } else {
            achievementInstance = [[(BTSocialAchievement *)[achievement alloc] initWithTimePlayed:timePlayed Score:score PreviousAllTimeHighScore:previousAllTimeHighScore PreviousWeeklyHighScore:previousWeeklyHighScore FliesFried:fliesFried PreviousHighFliesFried:previousHighFliesFried AllTimeScores:allTimeScores AllTimePlayers:allTimePlayers WeeklyScores:weeklyScores WeeklyPlayers:weeklyPlayers] autorelease];
        }

        if ([achievementInstance achieved]){
            theAchievement = achievementInstance;
            foundAchievement = YES;
        }
    }
    
    if (theAchievement){
        return theAchievement;
    }
    
    return nil;
}

+ (BTSocialAchievement *) bestSocialAchievementLocalForScore:(int) score HighScore:(int) highScore FliesFried:(int) fliesFried HighFliesFried:(int) highFliesFried TimePlayed:(int) playTime {
    NSArray *achievements = [NSArray arrayWithObjects:[BTSocialAchievementBeatLocalScore class], [BTSocialAchievementBeatFliesFriedSelf class], [BTSocialAchivementTimePlayed class], nil];
    
    bool foundAchievement = NO;
    BTSocialAchievement *theAchievement;
    for (int i = 0; i < [achievements count] && !foundAchievement; i++){
        Class achievement = [achievements objectAtIndex:i];
        
        BTSocialAchievement *achievementInstance = [[(BTSocialAchievementLocal *)[achievement alloc] initWithScore:score HighScore:[BTStorageManager highscore] FliesFried:fliesFried HighFliesFried:highFliesFried TimePlayed:playTime] autorelease];
        
        if ([achievementInstance achieved]){
            theAchievement = achievementInstance;
            foundAchievement = YES;
        }
    }
    
    if (theAchievement){
        return theAchievement;
    }
    
    return nil;
}



- (id) initWithTimePlayed:(int) timePlayed Score:(int) score PreviousAllTimeHighScore:(int) previousAllTimeHighScore PreviousWeeklyHighScore:(int) previousWeeklyHighScore FliesFried:(int) fliesFried PreviousHighFliesFried:(int) previousHighFliesFried AllTimeScores:(NSArray *) allTimeScores AllTimePlayers:(NSArray *) allTimePlayers WeeklyScores:(NSArray *) weeklyScores WeeklyPlayers:(NSArray *) weeklyPlayers {
    self = [super init];
    if (self){
        _achieved = NO;
    }
    
    return self;
}

- (NSString *) string {
    if (_string){
        return _string;
    }
    return @"";
}
- (NSString *) socialString {
    if (_socialString) {
        return _socialString;
    }
    return @"";
}

- (bool) achieved {
    return _achieved;
}

@end

@implementation BTSocialAchievementBeatScoreFriend

- (bool) achievedForTimeScope:(GKLeaderboardTimeScope) scope Scores:(NSArray *) scores Players:(NSArray *) players Score:(int) score PreviousScore:(int) previousScore {
    // Can't check score if not authenticated
    if ([GKLocalPlayer localPlayer].authenticated){
        int myIndex = -1;
        int friendIndex = -1;
        for (int i = 0; i < [scores count]; i++){
            GKScore *thisScore = (GKScore *)[scores objectAtIndex:i];
            
            // This is my score and it's not the final score
            if ([[GKLocalPlayer localPlayer].playerID isEqualToString:thisScore.playerID] && i < [scores count] - 1){
                myIndex = i;
                friendIndex = i + 1;
            }
        }
        
        // My score is listed and it's not the final score 
        // (if it is the final score, I couldn't have beaten anyone)
        if (myIndex != -1 && friendIndex != -1){
            GKScore *myScore = (GKScore *)[scores objectAtIndex:myIndex];
            GKScore *friendScore = (GKScore *)[scores objectAtIndex:friendIndex];
            // Make sure that we weren't already ahead
            if (previousScore < friendScore.value && score == myScore.value){
                NSString *timePeriod = @"";
                if (scope == GKLeaderboardTimeScopeAllTime){
                    timePeriod = @"All-Time";
                } else if (scope == GKLeaderboardTimeScopeWeek){
                    timePeriod = @"Weekly";
                }
                           
                self.string = [NSString stringWithFormat:@"You beat %@'s %@ High Score with your score of %d!", [BTGameCenterManager aliasForPlayerID:friendScore.playerID Players:players], timePeriod, myScore.value];
                self.socialString = [NSString stringWithFormat:@"I beat my friend's %@ High Score in Don't Fry the Frog!"];
                return YES;
            }
        }
        
    }
    return NO;
}

@end

@implementation BTSocialAchievementBeatScoreFriendAllTime

- (id) initWithTimePlayed:(int) timePlayed Score:(int) score PreviousAllTimeHighScore:(int) previousAllTimeHighScore PreviousWeeklyHighScore:(int) previousWeeklyHighScore FliesFried:(int) fliesFried PreviousHighFliesFried:(int) previousHighFliesFried AllTimeScores:(NSArray *) allTimeScores AllTimePlayers:(NSArray *) allTimePlayers WeeklyScores:(NSArray *) weeklyScores WeeklyPlayers:(NSArray *) weeklyPlayers {
    
    self = [super initWithTimePlayed:timePlayed Score:score PreviousAllTimeHighScore:previousAllTimeHighScore PreviousWeeklyHighScore:previousWeeklyHighScore FliesFried:fliesFried PreviousHighFliesFried:previousHighFliesFried AllTimeScores:allTimeScores AllTimePlayers:allTimePlayers WeeklyScores:weeklyScores WeeklyPlayers:weeklyPlayers];
    if (self){
        _achieved = [self achievedForTimeScope:GKLeaderboardTimeScopeAllTime Scores:allTimeScores Players:allTimePlayers Score:score PreviousScore:previousAllTimeHighScore];
    }
    
    return self;
}

@end

@implementation BTSocialAchievementBeatScoreFriendWeekly

- (id) initWithTimePlayed:(int) timePlayed Score:(int) score PreviousAllTimeHighScore:(int) previousAllTimeHighScore PreviousWeeklyHighScore:(int) previousWeeklyHighScore FliesFried:(int) fliesFried PreviousHighFliesFried:(int) previousHighFliesFried AllTimeScores:(NSArray *) allTimeScores AllTimePlayers:(NSArray *) allTimePlayers WeeklyScores:(NSArray *) weeklyScores WeeklyPlayers:(NSArray *) weeklyPlayers {
    
    self = [super initWithTimePlayed:timePlayed Score:score PreviousAllTimeHighScore:previousAllTimeHighScore PreviousWeeklyHighScore:previousWeeklyHighScore FliesFried:fliesFried PreviousHighFliesFried:previousHighFliesFried AllTimeScores:allTimeScores AllTimePlayers:allTimePlayers WeeklyScores:weeklyScores WeeklyPlayers:weeklyPlayers];
    if (self){
        _achieved = [self achievedForTimeScope:GKLeaderboardTimeScopeWeek Scores:weeklyScores Players:weeklyPlayers Score:score PreviousScore:previousWeeklyHighScore];
    }
    
    return self;
}

@end

@implementation BTSocialAchievementBeatSelf

- (bool) achievedForScore:(int)score PreviousScore:(int)previousScore {
    if (score > previousScore){
        return YES;
    }
    return NO;
}

@end

@implementation BTSocialAchievementBeatSelfAllTime

- (id) initWithTimePlayed:(int) timePlayed Score:(int) score PreviousAllTimeHighScore:(int) previousAllTimeHighScore PreviousWeeklyHighScore:(int) previousWeeklyHighScore FliesFried:(int) fliesFried PreviousHighFliesFried:(int) previousHighFliesFried AllTimeScores:(NSArray *) allTimeScores AllTimePlayers:(NSArray *) allTimePlayers WeeklyScores:(NSArray *) weeklyScores WeeklyPlayers:(NSArray *) weeklyPlayers {
    
    self = [super initWithTimePlayed:timePlayed Score:score PreviousAllTimeHighScore:previousAllTimeHighScore PreviousWeeklyHighScore:previousWeeklyHighScore FliesFried:fliesFried PreviousHighFliesFried:previousHighFliesFried AllTimeScores:allTimeScores AllTimePlayers:allTimePlayers WeeklyScores:weeklyScores WeeklyPlayers:weeklyPlayers];
    if (self){
        _achieved = [self achievedForScore:score PreviousScore:previousAllTimeHighScore];
        if (_achieved) {
            self.string = [NSString stringWithFormat:@"You set a new All-Time Personal Best Score of %d!", score];
            self.socialString = [NSString stringWithFormat:@"I beat my All-Time Best Score in Don't Fry the Frog!"];
        }
    }
    
    return self;
}

@end

@implementation BTSocialAchievementBeatSelfWeekly

- (id) initWithTimePlayed:(int) timePlayed Score:(int) score PreviousAllTimeHighScore:(int) previousAllTimeHighScore PreviousWeeklyHighScore:(int) previousWeeklyHighScore FliesFried:(int) fliesFried PreviousHighFliesFried:(int) previousHighFliesFried AllTimeScores:(NSArray *) allTimeScores AllTimePlayers:(NSArray *) allTimePlayers WeeklyScores:(NSArray *) weeklyScores WeeklyPlayers:(NSArray *) weeklyPlayers {
    
    self = [super initWithTimePlayed:timePlayed Score:score PreviousAllTimeHighScore:previousAllTimeHighScore PreviousWeeklyHighScore:previousWeeklyHighScore FliesFried:fliesFried PreviousHighFliesFried:previousHighFliesFried AllTimeScores:allTimeScores AllTimePlayers:allTimePlayers WeeklyScores:weeklyScores WeeklyPlayers:weeklyPlayers];
    if (self){
        _achieved = [self achievedForScore:score PreviousScore:previousWeeklyHighScore];
        if (_achieved) {
            self.string = [NSString stringWithFormat:@"You set a new Weekly Personal Best Score of %d!", score];
            self.socialString = [NSString stringWithFormat:@"I beat my Weekly Best Score in Don't Fry the Frog!"];
        }
    }
    
    return self;
}

@end

@implementation BTSocialAchievementLocal

- (id) initWithScore:(int)score HighScore:(int)highScore FliesFried:(int)fliesFried HighFliesFried:(int)highFliesFried TimePlayed:(int)playTime {
    self = [super init];
    if (self){
        _achieved = NO;
    }
    return self;
}

@end

@implementation BTSocialAchievementBeatLocalScore

- (id) initWithScore:(int)score HighScore:(int)highScore FliesFried:(int)fliesFried HighFliesFried:(int)highFliesFried TimePlayed:(int)playTime {
    self = [super initWithScore:score HighScore:highScore FliesFried:fliesFried HighFliesFried:highFliesFried TimePlayed:playTime];
    if (self){
        if (score > highScore){
            _achieved = YES;
            self.string = [NSString stringWithFormat:@"You set a new Best Score of %d!", score];
            self.socialString = [NSString stringWithFormat:@"I beat my Best Score in Don't Fry the Frog!"];
        }
    }
    return self;
}

@end

@implementation BTSocialAchievementBeatFliesFriedSelf

- (id) initWithScore:(int)score HighScore:(int)highScore FliesFried:(int)fliesFried HighFliesFried:(int)highFliesFried TimePlayed:(int)playTime {
    self = [super initWithScore:score HighScore:highScore FliesFried:fliesFried HighFliesFried:highFliesFried TimePlayed:playTime];
    if (self){
        if (fliesFried > highFliesFried){
            _achieved = YES;
            self.string = [NSString stringWithFormat:@"You set a new Most Flies Fried score of %d!", fliesFried];
            self.socialString = [NSString stringWithFormat:@"I just scored %d in Don't Fry the Frog!", score];
        }
    }
    return self;
}

@end

@implementation BTSocialAchivementTimePlayed

- (id) initWithScore:(int)score HighScore:(int)highScore FliesFried:(int)fliesFried HighFliesFried:(int)highFliesFried TimePlayed:(int)playTime {
    self = [super initWithScore:score HighScore:highScore FliesFried:fliesFried HighFliesFried:highFliesFried TimePlayed:playTime];
    if (self){
        _achieved = YES;
        self.string = [NSString stringWithFormat:@"You kept the frog alive for %d seconds!", playTime];
        self.socialString = [NSString stringWithFormat:@"I just scored %d in Don't Fry the Frog!", score];
    }
    return self;
}

@end
