//
//  BTStorageManager.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTStorageManager.h"
#import "BTIncludes.h"

#import "SFHFKeychainUtils.h"

@implementation BTStorageManager

+ (void) reset {
    [self resetHighscores];
    [self resetHighFliesFried];
    [self resetHighMultiplier];
    [self setNumBugsZapped:0];
    [self resetUnlockedBugs];
    [self resetBackgroundsBeamsAndHats];
    [self setTimePlayed:0];
    [self setIsVeteran:NO];
    [self resetPopups];
    [[BTHopshopManager sharedHopshopManager] reset];
    [SHK logoutOfAll];
    
    [self setPlayerLevelSet:NO];
    [self setPlayerLevel:0];
    [[BTLeapManager sharedManager] reset];
    [[BTConfig sharedConfig] reset];
    [[BTStatsManager sharedManager] reset];
}

+ (NSString *) userID {
    NSError *error;
    NSString *userIDString = [SFHFKeychainUtils getPasswordForUsername:@"userID" andServiceName:kAppServicesString error:&error];
    if (!userIDString){
        userIDString = [[NSProcessInfo processInfo] globallyUniqueString];
        [SFHFKeychainUtils storeUsername:@"userID" andPassword:userIDString forServiceName:kAppServicesString updateExisting:YES error:&error];
    }
    return userIDString;
}

// The last version of the app that was installed.
+ (float) recentAppVersion {
    return [(NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"RecentAppVersion"] floatValue];
}

+ (void) setRecentAppVersion:(float) version {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:version] forKey:@"RecentAppVersion"];
}

#pragma mark -
#pragma mark High Scores
/** High Scores */
+ (void) addHighscore:(int) score {
    if (score > 0){
        NSMutableArray *highscoreList = [NSMutableArray arrayWithArray:[self highscoreList]];
        [highscoreList addObject:[NSNumber numberWithInt:score]];
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
        [highscoreList sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        [self setHighscoreList:highscoreList];
    }
}

+ (void) resetHighscores {
    [self setHighscoreList:[NSArray array]];
}

+ (int) highscore {
    NSArray *highscoreList = [self highscoreList];
    if ([highscoreList count] >= 1){
        return [(NSNumber *)[highscoreList objectAtIndex:0] intValue];
    }
    return 0;
}

+ (NSArray *) highscoreList {
    NSArray *highscoreList = [[NSUserDefaults standardUserDefaults] arrayForKey:kHighScoreListString];
    if (highscoreList == nil){
        highscoreList = [NSArray array];
        [self setHighscoreList:highscoreList];
    }
    return highscoreList;
}

+ (void) setHighscoreList:(NSArray *) highscoreList {
    [[NSUserDefaults standardUserDefaults] setValue:highscoreList forKey:kHighScoreListString];
}

+ (void) updateHighscoreListFromGC {
    NSArray *gcHighscores = [BTGameCenterManager getGKLocalPlayerScores];
    NSMutableArray *localHighscores = [NSMutableArray arrayWithArray:[BTStorageManager highscoreList]];
    for (int i = 0; i < [gcHighscores count]; i++){
        GKScore *gkScore = (GKScore *)[gcHighscores objectAtIndex:i];
        NSNumber *score = [NSNumber numberWithInt:[gkScore value]];
        if ([localHighscores indexOfObject:score] == NSNotFound){
            [BTStorageManager addHighscore:[score intValue]];
        }
    }
}

#pragma mark -
#pragma mark High Flies Fried
/** High Flies Fried */
+ (void) addFliesFried:(int) fliesFried {
    if (fliesFried > [self highFliesFried]){
        [[NSUserDefaults standardUserDefaults] setInteger:fliesFried forKey:kHighFliesFriedString];
    }
}

+ (int) highFliesFried {
    return [[NSUserDefaults standardUserDefaults] integerForKey:kHighFliesFriedString];
}

+ (void) resetHighFliesFried {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kHighFliesFriedString];
}

/** High Multiplier */
+ (void) addMultiplier:(int) multiplier {
    if (multiplier > [self highMultiplier]){
        [[NSUserDefaults standardUserDefaults] setInteger:multiplier forKey:kHighMultiplierString];
    }
}

+ (int) highMultiplier {
    return [[NSUserDefaults standardUserDefaults] integerForKey:kHighMultiplierString];
}

+ (void) resetHighMultiplier {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kHighMultiplierString];
}

#pragma mark -
#pragma mark Bug Stuff

+ (int) numBugsZapped {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"DFTF_NUM_BUGS_ZAPPED"];
}

+ (void) setNumBugsZapped: (int) num {
    [[NSUserDefaults standardUserDefaults] setInteger:num forKey:@"DFTF_NUM_BUGS_ZAPPED"];
}

+ (void) incrementBugsZapped {
    [self setNumBugsZapped:[self numBugsZapped]+1];
}

+ (NSArray *) unlockedBugs {
    NSArray *bugs = [[NSUserDefaults standardUserDefaults] arrayForKey:kUnlockedBugsString];
    if (bugs == nil){
        bugs = [NSMutableArray arrayWithObject:[BTFly description]]; // Drone comes pre-unlocked.
        [self setUnlockedBugs:bugs];
    }
    return bugs;
}

+ (void) resetUnlockedBugs {
    [self setUnlockedBugs:[NSArray arrayWithObject:[BTFly description]]];
    [self setJustUnlocked:NO ForTag:[[BTGreenFly class] description]];
    [self setJustUnlocked:NO ForTag:[[BTIceBug class] description]];
    [self setJustUnlocked:NO ForTag:[[BTFireBug class] description]];
    [self setJustUnlocked:NO ForTag:[[BTSickBug class] description]];

}

+ (void) setUnlockedBugs:(NSArray *) bugs {
    [[NSUserDefaults standardUserDefaults] setValue:bugs forKey:kUnlockedBugsString];
}

+ (void) unlockBug:(Class) c {
    NSMutableArray *bugs = [NSMutableArray arrayWithArray:[BTStorageManager unlockedBugs]];
    [bugs addObject:[c description]];
    [BTStorageManager setUnlockedBugs:bugs];
}

+ (bool) isUnlocked:(Class) c {
    NSArray *unlockedBugs = [self unlockedBugs];
    NSUInteger found = [unlockedBugs indexOfObject:[c description]];
    if (found == NSNotFound){
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark Misc Game Stuff
+ (bool) isVeteran {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVeteranString];
}

+ (void) setIsVeteran:(bool) b {
    [[NSUserDefaults standardUserDefaults] setBool:b forKey:kVeteranString];
    //    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (float) timePlayed {
    return [[NSUserDefaults standardUserDefaults] floatForKey:@"DFTF_CAREER_PLAYTIME"];
}

+ (void) setTimePlayed:(float) t {
    [[NSUserDefaults standardUserDefaults] setFloat:t forKey:@"DFTF_CAREER_PLAYTIME"];
}

+ (void) addTimePlayed:(float) t {
    [self setTimePlayed:[self timePlayed]+t];
}

#pragma mark -
#pragma mark Popups
/** Popups */
+ (void) sawPopupForClass: (Class) c {
    [BTStorageManager sawPopupForTag:[NSString stringWithFormat:@"%@", [c description]]];
}

+ (void) sawPopupForTag:(NSString *) s {
    NSMutableArray *popups = [NSMutableArray arrayWithArray:[BTStorageManager popupsSeen]];
    [popups addObject:s];
    [BTStorageManager setPopupsSeen:popups];
}

+ (void) resetPopups {
    [BTStorageManager setPopupsSeen:[NSArray array]];
}

+ (BOOL) hasSeenPopupForClass: (Class) c {
    return [BTStorageManager hasSeenPopupForTag:[NSString stringWithFormat:@"%@", [c description]]];
}

+ (bool) hasSeenPopupForTag:(NSString *) s {
    NSArray *popups = [BTStorageManager popupsSeen];
    NSUInteger found = [popups indexOfObject:s];
    if (found != NSNotFound){
        return YES;
    }
    return NO;
}

+ (NSArray *) popupsSeen {
    NSArray *popups = [[NSUserDefaults standardUserDefaults] arrayForKey:@"DFTF_POPUPS_LIST"];
    if (popups == nil){
        popups = [NSArray array];
        [self setHighscoreList:popups];
    }
    return popups; 
}
+ (void) setPopupsSeen: (NSArray *) a {
    [[NSUserDefaults standardUserDefaults] setValue:a forKey:@"DFTF_POPUPS_LIST"];
    //    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark -
#pragma mark Hopshop
/** Hopshop */
+ (int) hopshopTokens {    
    NSError *error;
    return [(NSString *)[SFHFKeychainUtils getPasswordForUsername:kHopShopTokensString andServiceName:kHopshopServiceString error:&error] intValue];
}

+ (void) setHopshopTokens:(int) t {
    [[NSUserDefaults standardUserDefaults] setInteger:t forKey:kHopShopTokensString];
    NSError *error;
    [SFHFKeychainUtils storeUsername:kHopShopTokensString andPassword:[NSString stringWithFormat:@"%d",t] forServiceName:kHopshopServiceString updateExisting:YES error:&error];
}

+ (void) addHopshopTokens:(int) t {
    [self setHopshopTokens:[self hopshopTokens] + t];
    [[BTStatsManager sharedManager] setFlyPenniesEarned:[[BTStatsManager sharedManager] flyPenniesEarned] + t];
}

+ (int) levelForTag:(NSString *) s {
    NSString *username = [NSString stringWithFormat:@"%@%@", kBugUpgradesString, s];
    NSError *error;
    return [(NSString *)[SFHFKeychainUtils getPasswordForUsername:username andServiceName:kHopshopServiceString error:&error] intValue];
}

+ (void) setLevel:(int) t ForTag:(NSString *) s{
    NSString *username = [NSString stringWithFormat:@"%@%@", kBugUpgradesString, s];
    NSError *error;
    [SFHFKeychainUtils storeUsername:username andPassword:[NSString stringWithFormat:@"%d",t] forServiceName:kHopshopServiceString updateExisting:YES error:&error];
    if (error){
        NSLog(@"Error: %@", error); 
    }
}

+ (bool) pennyPyramidOwned {
    if ([BTStorageManager levelForTag:@"PENNY.PYRAMID"] != 0){
        return YES;
    }
    return NO;
}

+ (bool) justUnlockedForTag:(NSString *) s {
    NSString *username = [NSString stringWithFormat:@"%@%@", kJustUnlockedString, s];
    NSError *error;
    return [(NSString *)[SFHFKeychainUtils getPasswordForUsername:username andServiceName:kHopshopServiceString error:&error] boolValue];
}

+ (void) setJustUnlocked:(bool) unlocked ForTag:(NSString *) s {
    NSString *username = [NSString stringWithFormat:@"%@%@", kJustUnlockedString, s];
    NSString *unlockedString = [NSString stringWithFormat:@"%d", unlocked];
    NSError *error;
    [SFHFKeychainUtils storeUsername:username andPassword:unlockedString forServiceName:kHopshopServiceString updateExisting:YES error:&error];
}

#pragma mark -
#pragma mark Levels & Leaps
/** LEVEL STUFF */
+ (int) playerLevel {
    NSError *error;
    int level;
    if ([BTStorageManager playerLevelSet]){
        level = [(NSString *)[SFHFKeychainUtils getPasswordForUsername:@"PlayerLevel" andServiceName:kLeapsAndLevelsServiceString error:&error] intValue];
        [self setPlayerLevelSet:YES];
    } else {
        level = 0;
        [self setPlayerLevel:level];
    }
    return level;
}

+ (void) setPlayerLevel:(int) level {
    level = MAX(0, MIN(level, 30));
    NSError *error;
    [SFHFKeychainUtils storeUsername:@"PlayerLevel" andPassword:[NSString stringWithFormat:@"%d", level] forServiceName:kLeapsAndLevelsServiceString updateExisting:YES error:&error];
    
    int padsToNextlevel = [[BTLeapManager sharedManager] padsRequiredForLevel:level+1];
    [BTStorageManager setPadsRemaining:padsToNextlevel];
    
    if (![self playerLevelSet]){
        [self setPlayerLevelSet:YES];
    }
}

+ (bool) playerLevelSet {
    NSError *error;
    NSString *setString = [SFHFKeychainUtils getPasswordForUsername:@"PlayerLevelSet" andServiceName:kLeapsAndLevelsServiceString error:&error];
    BOOL set = [setString isEqualToString:@"Yes"] ? YES : NO;
    
    return (set || [[NSUserDefaults standardUserDefaults] boolForKey:@"PlayerLevelSet"]); // second option in for backwards compatibility
}

+ (void) setPlayerLevelSet:(bool) set {
    NSString *setString = set ? @"Yes" : @"No";
    NSError *error;
    [SFHFKeychainUtils storeUsername:@"PlayerLevelSet" andPassword:setString forServiceName:kLeapsAndLevelsServiceString updateExisting:YES error:&error];
//    [[NSUserDefaults standardUserDefaults] setBool:set forKey:@"PlayerLevelSet"];
}

+ (int) padsRemaining {
    if (![BTStorageManager playerLevelSet]){
        [BTStorageManager setPlayerLevel:0];
    }
    NSError *error;
    return [(NSString *)[SFHFKeychainUtils getPasswordForUsername:@"PadsRemaining" andServiceName:kLeapsAndLevelsServiceString error:&error] intValue];
}

+ (void) setPadsRemaining:(int) pads {
    NSError *error;
    [SFHFKeychainUtils storeUsername:@"PadsRemaining" andPassword:[NSString stringWithFormat:@"%d", pads] forServiceName:kLeapsAndLevelsServiceString updateExisting:YES error:&error];
    
}
+ (void) earnPads:(int) pads {
    [BTStorageManager setPadsRemaining:[BTStorageManager padsRemaining] - pads];
}

/** CURRENT LEAPS */
// Returns an array of BTLeaps
+ (NSArray *) currentLeaps {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithFile:[NSString stringWithFormat:@"%@/CurrentLeaps.bin", documentsDirectory]];
}

// Set the currentLeaps. Each array member is a BTLeap
+ (void) setCurrentLeaps:(NSArray *) leaps {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    [NSKeyedArchiver archiveRootObject:leaps toFile:[NSString stringWithFormat:@"%@/CurrentLeaps.bin", documentsDirectory]];
}

/** ACHIEVING LEAPS */
// Return the set of achieved leaps (their names)
+ (NSArray *) achievedLeaps {
    NSError *error;
    NSString *achievedLeapsString = [SFHFKeychainUtils getPasswordForUsername:@"AchievedLeaps" andServiceName:kLeapsAndLevelsServiceString error:&error];
    return [achievedLeapsString componentsSeparatedByString:@":"];}

// Set the set of achieved leaps (their names)
+ (void) setAchievedLeaps:(NSArray *) leaps {
    NSString *achievedLeapsString = @"";
    if (leaps){
        achievedLeapsString = [leaps componentsJoinedByString:@":"];
    }
    NSError *error;
    [SFHFKeychainUtils storeUsername:@"AchievedLeaps" andPassword:achievedLeapsString forServiceName:kLeapsAndLevelsServiceString updateExisting:YES error:&error];
}

// Achieve any leap.
+ (void) achieveLeap:(NSString *) leapName {
    NSMutableArray *achievedLeaps = [NSMutableArray arrayWithArray:[self achievedLeaps]];
    [achievedLeaps addObject:leapName];
    [self setAchievedLeaps:achievedLeaps];
    
}

// Return whether or not player has achieved leap with name leapName
+ (bool) hasAchievedLeap:(NSString *) leapName {
    NSArray *achievedLeaps = [self achievedLeaps];
    for (NSString *leap in achievedLeaps){
        if ([leap isEqualToString:leapName]){
            return YES;
        }
    }
    return NO;
}

/** Background & Beam */
+ (BOOL) isObjectForUsername:(NSString *) username Service:(NSString *) service {
    NSError *error;
    NSString *ret = [SFHFKeychainUtils getPasswordForUsername:username andServiceName:service error:&error];
    if (ret && [ret isEqualToString:@"Unlocked"]){
        return YES;
    }
    return NO;
}

+ (NSString *) stringForUsername:(NSString *) username Service:(NSString *) service {
    NSError *error;
    NSString *string = [SFHFKeychainUtils getPasswordForUsername:username andServiceName:service error:&error];
    if (string){
        return string;
    }
    return @"";
}

+ (void) resetBackgroundsBeamsAndHats {
    [self setBackground:@"BTDefaultBackgroundLayer" Unlocked:YES];
    [self setCurrentBackground:@"BTDefaultBackgroundLayer"];
    
    [self setBackground:@"BTSpaceBackgroundLayer" Unlocked:NO];
    [self setBackground:@"BTDesertBackgroundLayer" Unlocked:NO];
    
    NSArray *hats = [[[[BTHopshopManager sharedHopshopManager] hopshopDetails] hats] allKeys];
    for (int i = 0; i < [hats count]; i++){
        [self setHat:[hats objectAtIndex:i] Unlocked:NO];
    }
}

// *****
// Backgrounds
// *****

+ (BOOL) backgroundUnlocked:(NSString *) backgroundName {
    return [self isObjectForUsername:backgroundName Service:kHopshopServiceString];
}

+ (void) setBackground:(NSString *) backgroundName Unlocked:(BOOL) b {
    NSError *error;
    NSString *lock = b ? @"Unlocked" : @"Locked";
    [SFHFKeychainUtils storeUsername:backgroundName andPassword:lock forServiceName:kHopshopServiceString updateExisting:YES error:&error];
}

+ (NSString *) currentBackground {
    NSString *ret = [self stringForUsername:@"CurrentBackground" Service:kHopshopServiceString];
    if ([ret isEqualToString:@""]){
        ret = @"BTDefaultBackgroundLayer";
        [self setCurrentBackground:ret];
    }
    return ret;
}

+ (void) setCurrentBackground:(NSString *) currentBackground {
    NSError *error;
    [SFHFKeychainUtils storeUsername:@"CurrentBackground" andPassword:currentBackground forServiceName:kHopshopServiceString updateExisting:YES error:&error];
}

// *****
// Hats
// *****

+ (BOOL) hatUnlocked:(NSString *) hatName {
    return [self isObjectForUsername:hatName Service:kHopshopServiceString];
}

+ (void) setHat:(NSString *) hatName Unlocked:(BOOL) b {
    NSError *error;
    NSString *lock = b ? @"Unlocked" : @"Locked";
    [SFHFKeychainUtils storeUsername:hatName andPassword:lock forServiceName:kHopshopServiceString updateExisting:YES error:&error];
}

+ (NSString *) currentHat {
    NSString *ret = [self stringForUsername:@"CurrentHat" Service:kHopshopServiceString];
    if ([ret isEqualToString:@""]){
        ret = @"";
        [self setCurrentHat:ret];
    }
    return ret;
}

+ (void) setCurrentHat:(NSString *) currentHat {
    NSError *error;
    [SFHFKeychainUtils storeUsername:@"CurrentHat" andPassword:currentHat forServiceName:kHopshopServiceString updateExisting:YES error:&error];
}


+ (BOOL) beamUnlocked:(NSString *) beamName {
    return [self isObjectForUsername:beamName Service:kHopshopServiceString];
}

+ (void) setBeam:(NSString *) beamName Unlocked:(BOOL) b {
    NSError *error;
    NSString *lock = b ? @"Unlocked" : @"Locked";
    [SFHFKeychainUtils storeUsername:beamName andPassword:lock forServiceName:kHopshopServiceString updateExisting:YES error:&error];
}

+ (NSString *) currentBeam {
    return [self stringForUsername:@"CurrentBeam" Service:kHopshopServiceString];
}

+ (void) setCurrentBeam:(NSString *) currentBeam {
    NSError *error;
    [SFHFKeychainUtils storeUsername:@"CurrentBeam" andPassword:currentBeam forServiceName:kHopshopServiceString updateExisting:YES error:&error];
}

+ (NSString *) news {
    NSString *newsString = [[NSUserDefaults standardUserDefaults] stringForKey:@"News"];
    if (!newsString){
        newsString = @"";
        [self setNews:newsString];
    }
    return newsString;
}

+ (void) setNews:(NSString *) news {
    [[NSUserDefaults standardUserDefaults] setValue:news forKey:@"News"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark -
#pragma mark Animations
/** Animations */
+ (CCAnimation *) animationWithString: (NSString *) string atInterval:(float) interval Reversed: (bool) reverse {
    return [BTStorageManager animationWithString:string atInterval:interval Reversed:reverse Suffix:@""];
}

+ (CCAnimation *) animationWithString:(NSString *)string atInterval:(float)interval Reversed:(bool)reverse Suffix:(NSString *) suffix {
    NSDictionary *sequence = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AnimationSequences" ofType:@"plist"]] objectForKey:string];
    NSArray *frameNames = [sequence objectForKey:@"Frames"];
    NSArray *sequenceIndices = [sequence objectForKey:@"Sequence"];
    
    NSMutableArray *frames = [NSMutableArray array];
    for (int i = 0; i < [frameNames count]; i++){
        CCSpriteFrame *tempFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@%@", [frameNames objectAtIndex:i], suffix]];
        
        if (tempFrame != nil){
            [frames addObject:tempFrame]; 
        }
    }
    
    NSMutableArray *sequencedFrames = [NSMutableArray array];
    for (int i = 0; i < [sequenceIndices count]; i++){
        int index = [(NSNumber *)[sequenceIndices objectAtIndex:i] intValue];
        [sequencedFrames addObject:[frames objectAtIndex:index]];
    }
    
    if (reverse) {
        NSMutableArray *reversedSequencedFrames = [NSMutableArray array];
        NSEnumerator *e = [sequencedFrames reverseObjectEnumerator];
        id frame;
        while ((frame = [e nextObject])){
            [reversedSequencedFrames addObject:frame];
        }
        sequencedFrames = reversedSequencedFrames;
    }
    
    return [CCAnimation animationWithFrames:sequencedFrames delay:interval];
}

@end