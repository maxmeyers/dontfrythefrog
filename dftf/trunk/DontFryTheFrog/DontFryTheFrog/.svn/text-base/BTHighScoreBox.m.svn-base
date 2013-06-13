//
//  BTHighScoreBox.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/23/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTHighScoreBox.h"
#import "BTIncludes.h"

@implementation BTHighScoreBox

@synthesize players, scores, state;

- (id) initWithTimeScope:(GKLeaderboardTimeScope) scope LastScore:(int) score {
    self = [super init];
    if (self){
        timeScope = scope;
        lastScore = score;
        state = kScoresRequestNotSent;

        boxBackground = [CCSprite spriteWithSpriteFrameName:@"high-score-box.png"];
        [self addChild:boxBackground z:0];
        
        NSString *titleString = @"";
        if (scope == GKLeaderboardTimeScopeAllTime){
            titleString = @"alltime-results.png";
        } else if (scope == GKLeaderboardTimeScopeWeek){
            titleString = @"weekly-results.png";
        } else if (scope == GKLeaderboardTimeScopeToday){ // cheating
            titleString = @"Dr-Tim-results.png";
        }
        
//        CCLabelTTF *titleLabel =  [CCLabelTTF labelWithString:titleString dimensions:CGSizeMake(240, 65) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:fontSize];
        CCSprite *titleSprite = [CCSprite spriteWithSpriteFrameName:titleString];
        titleSprite.position = ccp(0, 50);
//        titleLabel.color = ccc3(45, 85, 5);
        [self addChild:titleSprite z:1];
        
        CCLabelTTF *loadingLabel = [CCLabelTTF labelWithString:@"Loading..." fontName:@"soupofjustice" fontSize:32];
        loadingLabel.color = ccc3(0, 0, 255);
        loadingLabel.visible = NO;
        [self addChild:loadingLabel z:1 tag:kLoadingLabelTag];
        
        CCLabelTTF *loginLabel = [CCLabelTTF labelWithString:@"Log in to Game Center." dimensions:CGSizeMake(175, 60) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:18];
        loginLabel.color = ccc3(255, 0, 0);
        
        CCMenuItemLabel *loginButton = [CCMenuItemLabel itemWithLabel:loginLabel block:^(id sender){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"gamecenter:/me/"]]; 
        }];
        loginButton.tag = kLoginButtonTag;
        CCMenu *menu = [CCMenu menuWithItems:loginButton, nil];
        menu.position = ccp(0, -30);
        [self addChild:menu z:1 tag:kLoginMenuTag];
        [self setIsLoginButtonEnabled:NO];
        
        [self scheduleUpdate];
        
    }
    
    return self;
}

- (void) setIsLoginButtonEnabled:(bool) b {
    CCMenuItemLabel *button = (CCMenuItemLabel *)[[self getChildByTag:kLoginMenuTag] getChildByTag:kLoginButtonTag];
    button.visible = b;
    button.isEnabled = b;
}

- (void) update:(ccTime) dt {
    if (state == kScoresRequestNotSent) {
        if ([self requestScores]){
            [self setIsLoginButtonEnabled:NO];
            state = kScoresRequestSent;
        } else {
            [self setIsLoginButtonEnabled:YES];
        }
    } else if (state == kScoresRequestSent) {
        [self getChildByTag:kLoadingLabelTag].visible = YES;
    } else if (state == kFriendsRequestNotSent){
        if ([self requestFriends]){
            state = kFriendsRequestSent;
            [self getChildByTag:kLoadingLabelTag].visible = YES;
        }
    } else if (state == kFriendsRequestSent){
        [self getChildByTag:kLoadingLabelTag].visible = YES;
    } else if (state == kHasScoresAndFriends){
        [self getChildByTag:kLoadingLabelTag].visible = NO;
        NSString *str = @"";
        for (int i = startingIndex; i < MIN([scores count], startingIndex + 3); i++){
            GKScore *score = [scores objectAtIndex:i];
            str = [str stringByAppendingFormat:@"%d. %@: %d\n", score.rank, [BTGameCenterManager aliasForPlayerID:score.playerID Players:players], score.value];
        }
        CCLabelTTF *highScores = [CCLabelTTF labelWithString:str dimensions:CGSizeMake(230, 150) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeClip fontName:@"soupofjustice" fontSize:22];
        highScores.position = ccp(0, -45);
        [self addChild:highScores z:1];
        
        state = kLoadingFinished;
    }
}

- (void) setPlayers:(NSArray *) array {
    players = [array retain];
    state = kHasScoresAndFriends;
}

- (void) setScores:(NSArray *) array TimeScope:(GKLeaderboardTimeScope) scope {
    // In case this score wasn't reported fast enough and it is higher than the game center's
    // recorded score, we need to keep requesting scores until we get the right one.
    bool scoresValid = YES;
    int myIndex;
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:array];
    for (int i = 0; i < [tempArray count]; i++){
        GKScore *score = (GKScore *)[tempArray objectAtIndex:i];
        if ([score.playerID isEqualToString:[GKLocalPlayer localPlayer].playerID]) {
            if (lastScore > (int)score.value){
                scoresValid = NO;
            } else {
                myIndex = i;
            }
        }
    }
    
    if ([tempArray count] == 0){
        scoresValid = NO;
    }
    
    if (scoresValid) {
        scores = [[NSArray alloc] initWithArray:tempArray];
        // Figure out where we're going to start listing
        
        // If we're #1, start at #1
        if (myIndex == 0) {
            startingIndex = myIndex;
        } 
        // If we're #2+ but not last, start at one before us
        else if (myIndex > 0 && myIndex < [scores count] - 1){
            startingIndex = myIndex - 1;
        }
        // If we're last...
        else if (myIndex == [scores count] - 1 && [scores count] >= 2){
            // ...and there are only 2 people on the list, start at the one before us
            if ([scores count] == 2){
                startingIndex = myIndex - 1;
            } 
            // ...and there are more than 2 people on the list, start at 2 before us
            else if ([scores count] > 2){
                startingIndex = myIndex - 2;
            }
        } 
        // Just in case there's something I missed (there shouldn't be!)
        else {
            startingIndex = 0;
        }
        
        state = kFriendsRequestNotSent;
    } else {
        NSLog(@"Scores aren't valid yet! Trying again!");
        state = kScoresRequestNotSent;
    }

}

- (bool) requestScores {
    if ([GKLocalPlayer localPlayer].isAuthenticated){
        [BTGameCenterManager scoresForFriendsWithinTimeScope:timeScope HighScoreBox:self];
        return YES;
    }
    return  NO;
}
      
- (bool) requestFriends {
    if ([GKLocalPlayer localPlayer].authenticated && scores != nil){
        if ([scores count] > 0){
            NSMutableArray *identifiers = [NSMutableArray array];
            for (int i = 0; i < [scores count]; i++){
                [identifiers addObject:[(GKScore *)[scores objectAtIndex:i] playerID]];
            }
            [BTGameCenterManager playersForIdentifiers:identifiers HighScoreBox:self];
            return YES;
        } else {
            state = kHasScoresAndFriends;
        }
    }
    return NO;
}

@end

@implementation BTDrTimBox

@synthesize socialAchievement;

- (id) initWithLastScore:(int) score PlayTime:(ccTime) playTime AllTimeHighScoreBox:(BTHighScoreBox *) allTime WeeklyHighScoreBox:(BTHighScoreBox *) weekly {
    self = [super initWithTimeScope:GKLeaderboardTimeScopeToday LastScore:score];
    if (self) {        
        allTimePrevious = -1;
        weeklyPrevious = -1;
        
        allTimeHighScoreBox = allTime;
        weeklyHighScoreBox = weekly;
        
        Reachability *internetConnection = [Reachability reachabilityForInternetConnection];
    
        if ([GKLocalPlayer localPlayer].isAuthenticated && [internetConnection currentReachabilityStatus] != NotReachable){
            [BTGameCenterManager scoresForFriendsWithinTimeScope:GKLeaderboardTimeScopeAllTime HighScoreBox:self];
            [BTGameCenterManager scoresForFriendsWithinTimeScope:GKLeaderboardTimeScopeWeek HighScoreBox:self];
            drState = kDoesNotHavePreviousScores;
        } else {
            // Steal important info from scene
            BTGameScene *scene =  [(BTPostGameScene *)[(BTResultsLayer *)[self parent] parent] gameScene];
            
            fliesFriedPrevious = [BTStorageManager highFliesFried];
            maxMultiplierPrevious = [BTStorageManager highMultiplier];
//            
//            float playTime = 200;
//            if ([scene gameLayer] != nil){
//                playTime = [[scene gameLayer] playTime];
//            }
            self.socialAchievement = [BTSocialAchievement bestSocialAchievementLocalForScore:score HighScore:[BTStorageManager highscore] FliesFried:[scene fliesFried] HighFliesFried:fliesFriedPrevious TimePlayed:playTime];
            if (self.socialAchievement){
                [self.socialAchievement retain];
            }
            
            drState = kHasSocialAchievement;
            
        }
    }
    return self;
    
}

- (void) update:(ccTime) dt {
    if (drState == kDoesNotHavePreviousScores){
        [self getChildByTag:kLoadingLabelTag].visible = YES;
    } else if (drState == kNewScoreReportedAndWaitingForHighScoreBoxes){
        [self getChildByTag:kLoadingLabelTag].visible = YES;
        if ([allTimeHighScoreBox state] == kLoadingFinished && [weeklyHighScoreBox state] == kLoadingFinished){
            if ([[self parent] isMemberOfClass:[BTResultsLayer class]] && [[[self parent] parent] isMemberOfClass:[BTPostGameScene class]]){
                // Steal important info from scene
                BTGameScene *scene =  [(BTPostGameScene *)[(BTResultsLayer *)[self parent] parent] gameScene];
                
                fliesFriedPrevious = [BTStorageManager highFliesFried];
                maxMultiplierPrevious = [BTStorageManager highMultiplier];
                
                float playTime = 200;
                if ([scene gameLayer] != nil){
                    playTime = [[scene gameLayer] playTime];
                }
                
                self.socialAchievement = [BTSocialAchievement bestSocialAchievementForTimePlayed:playTime Score:[scene score] PreviousAllTimeHighScore:allTimePrevious PreviousWeeklyHighScore:weeklyPrevious FliesFried:[scene fliesFried] PreviousHighFliesFried:fliesFriedPrevious AllTimeScores:[allTimeHighScoreBox scores] AllTimePlayers:[allTimeHighScoreBox players] WeeklyScores:[weeklyHighScoreBox scores] WeeklyPlayers:[weeklyHighScoreBox players]];
                if (self.socialAchievement){
                    [self.socialAchievement retain];
                }
                
                // See comment in [BTGameScene stopGame]
                [BTStorageManager addHighscore:[scene score]]; 
                [BTStorageManager addMultiplier:[scene maxMultiplier]];
                [BTStorageManager addFliesFried:[scene fliesFried]];
                drState = kHasSocialAchievement;

            }
        }
    } else if (drState == kHasSocialAchievement){
        CCLabelTTF *achievementLabel;
        if (self.socialAchievement){
            achievementLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"\"%@\"", [socialAchievement string]] dimensions:CGSizeMake(230, 150) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:24];
        } else {
            achievementLabel = [CCLabelTTF labelWithString:@"Nothing." dimensions:CGSizeMake(230, 150) alignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap fontName:@"soupofjustice" fontSize:24];
        }
        achievementLabel.position = ccp(0, -45);
        [self addChild:achievementLabel z:1];
        [self getChildByTag:kLoadingLabelTag].visible = NO;

        drState = kCompletelyLoaded;
    } else if (drState == kCompletelyLoaded){
        
    }
}

- (void) setScores:(NSArray *)array TimeScope:(GKLeaderboardTimeScope)scope {
    for (int i = 0; i < [array count]; i++) {
        GKScore *score = (GKScore *)[array objectAtIndex:i];
        if ([[GKLocalPlayer localPlayer].playerID isEqualToString:score.playerID]){
            if (scope == GKLeaderboardTimeScopeAllTime){
                allTimePrevious = score.value;
            } else if (scope == GKLeaderboardTimeScopeWeek) {
                weeklyPrevious = score.value;
            }
        }
    }
    
    // If we're not listed for some reason, set to infinity so that we never beat our previous.
    if (scope == GKLeaderboardTimeScopeAllTime && allTimePrevious == -1){
        allTimePrevious = INFINITY;
    } else if (scope == GKLeaderboardTimeScopeWeek && weeklyPrevious == -1){
        weeklyPrevious = INFINITY;
    }
    
    if (allTimePrevious != -1 && weeklyPrevious != -1){
        drState = kNewScoreReportedAndWaitingForHighScoreBoxes;
        [BTGameCenterManager reportScore:lastScore forCategory:@"2000"];
    }
}

@end
