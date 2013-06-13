//
//  BTStorageManager.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define kHighScoreListString    @"DFTF_HIGHSCORE_LIST"
#define kHighFliesFriedString   @"DFTF_HIGHFLIESFRIED"
#define kHighMultiplierString   @"DFTF_HIGHMULTIPLIER"
#define kUnlockedBugsString     @"DFTF_UNLOCKED_BUGS"
#define kVeteranString          @"DFTF_VETERAN"


// These will be store in the keychain so they need to start with the bundle id
#define kHopShopTokensString    @"com.blacktorchgames.dftf.tokens"
#define kBugUpgradesString      @"com.blacktorchgames.dftf.bugupgrade"
#define kJustUnlockedString     @"com.blacktorchgames.dftf.justunlocked"

#import "SHK.h"

@class CCAnimation;

@interface BTStorageManager : NSObject {

}

+ (void) reset;

/** High Score Stuff */
+ (void) addHighscore:(int) score;
+ (void) resetHighscores;

+ (int) highscore;
+ (NSArray *) highscoreList;
+ (void) setHighscoreList:(NSArray *) highscoreList;
+ (void) updateHighscoreListFromGC;

/** High Flies Fried */
+ (void) addFliesFried:(int) fliesFried;
+ (int) highFliesFried;
+ (void) resetHighFliesFried;

/** High Multiplier */
+ (void) addMultiplier:(int) multiplier;
+ (int) highMultiplier;
+ (void) resetHighMultiplier;

/** Bug Stuff */
+ (int) numBugsZapped;
+ (void) setNumBugsZapped: (int) num;
+ (void) incrementBugsZapped;

+ (NSArray *) unlockedBugs;
+ (void) resetUnlockedBugs;
+ (void) setUnlockedBugs:(NSArray *) bugs;
+ (void) unlockBug:(Class) c;
+ (bool) isUnlocked:(Class) c;

/** Misc Game Stuff */
+ (bool) isVeteran;
+ (void) setIsVeteran:(bool) b;
+ (float) timePlayed;
+ (void) setTimePlayed:(float) t;
+ (void) addTimePlayed:(float) t;

/** Popups */
+ (void) sawPopupForClass: (Class) c;
+ (void) sawPopupForTag:(NSString *) s;
+ (void) resetPopups;

+ (BOOL) hasSeenPopupForClass: (Class) c;
+ (bool) hasSeenPopupForTag:(NSString *) s;
+ (NSArray *) popupsSeen;
+ (void) setPopupsSeen: (NSArray *) a;

/** Hopshop */
+ (int) hopshopTokens;
+ (void) setHopshopTokens:(int) t;
+ (void) addHopshopTokens:(int) t;
+ (int) levelForTag:(NSString *) s;
+ (void) setLevel:(int) t ForTag:(NSString *) s;
+ (bool) justUnlockedForTag:(NSString *) s;
+ (void) setJustUnlocked:(bool) unlocked ForTag:(NSString *) s;

/** Leaps & Levels */
+ (int) playerLevel;
+ (void) setPlayerLevel:(int) level;
+ (bool) playerLevelSet;
+ (void) setPlayerLevelSet:(bool) set;
   
+ (int) padsRemaining;
+ (void) setPadsRemaining:(int) pads;
+ (void) earnPads:(int) pads;

// Returns an array of BTLeaps
+ (NSArray *) currentLeaps;
// Set the currentLeaps. Each array member is a BTLeap
+ (void) setCurrentLeaps:(NSArray *) leaps;

// Return the set of achieved leaps (their names)
+ (NSArray *) achievedLeaps;
// Set the set of achieved leaps (their names)
+ (void) setAchievedLeaps:(NSArray *) leaps;
// Achieve any leap. If it's in the currentLeaps, remove it and get a new one.
+ (void) achieveLeap:(NSString *) leapName;
// Return whether or not player has achieved leap with name leapName
+ (bool) hasAchievedLeap:(NSString *) leapName;
// Return the float value representing the progress for the leap, 0 if not found
+ (float) progressForLeap:(NSString *) leapName;
// Set the float value representing progress for the leap
+ (void) setProgress:(float) progress ForLeap:(NSString *) leapName;
    
/** Animations */
+ (CCAnimation *) animationWithString: (NSString *) string atInterval:(float) interval Reversed:(bool) reverse;
+ (CCAnimation *) animationWithString:(NSString *)string atInterval:(float)interval Reversed:(bool)reverse Suffix:(NSString *) suffix;

@end