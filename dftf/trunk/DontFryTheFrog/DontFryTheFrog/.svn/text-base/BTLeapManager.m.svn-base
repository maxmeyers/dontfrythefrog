//
//  BTLeapManager.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTLeapManager.h"
#import "BTIncludes.h"

@implementation BTLeapManager

+ (BTLeapManager *) sharedManager {
    static BTLeapManager *sharedManager;
    @synchronized(self)
    {
        if (!sharedManager) {
            sharedManager = [[BTLeapManager alloc] init];
        }
        return sharedManager;
    }
}

- (id) init {
    self = [super init];
    if (self) {
        [self loadLeaps];
        [self loadLevels];
        currentLeaps = [[NSMutableArray alloc] initWithArray:[BTStorageManager currentLeaps]];
        if ([currentLeaps count] == 0 && [[BTStorageManager achievedLeaps] count] <= 1){
            [self reset];
        } else if ([currentLeaps count] == 0){
            [self fillCurrentLeaps];
        }
    }
    
    return self;
}

- (void) loadLevels {
    if ([[BTConfig sharedConfig] readFromPlist]){
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Levels" ofType:@"plist"]];
        if ([dictionary objectForKey:@"Levels"]){
            levels = (NSArray *)[[dictionary objectForKey:@"Levels"] retain];
            [NSKeyedArchiver archiveRootObject:levels toFile:@"/Users/mmeyers/Desktop/Levels.bin"];
        }
    } else {
        levels = (NSArray *)[[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"Levels" ofType:@"bin"]] retain];
    }
}

- (void) loadLeaps {
    if ([[BTConfig sharedConfig] readFromPlist]){
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Leaps" ofType:@"plist"]];
        NSMutableDictionary *leapCategories = [NSMutableDictionary dictionary];
        for (NSString *key in [dictionary allKeys]){
            Class leapClass = NSClassFromString(key);
            id testObject = [leapClass new];
            if ([testObject isKindOfClass:[BTLeap class]]){
                
                NSDictionary *rawLeaps = [dictionary objectForKey:key];
                NSMutableDictionary *leapObjects = [NSMutableDictionary dictionary];
                for (NSString *rawLeapName in rawLeaps){
                    NSDictionary *leapDictionary = [rawLeaps objectForKey:rawLeapName];
                    
                    int quantity = [(NSNumber *)[leapDictionary objectForKey:@"Quantity"] intValue];
                    NSString *bugClass = (NSString *)[leapDictionary objectForKey:@"Class"];
                    NSString *timePeriod = (NSString *)[leapDictionary objectForKey:@"TimePeriod"];
                    bool dictionaryNeeded = [(NSNumber *)[leapDictionary objectForKey:@"Dictionary"] boolValue];
                    NSString *identifier = (NSString *)[leapDictionary objectForKey:@"Identifier"];
                    int reward = [(NSNumber *)[leapDictionary objectForKey:@"Reward"] intValue];
                    NSString *description = (NSString *)[leapDictionary objectForKey:@"Description"];

                    id tempLeap = [[[leapClass alloc] initWithQuantity:quantity BugClass:bugClass TimePeriod:timePeriod DictionaryNeeded:dictionaryNeeded Identifier:identifier Reward:reward Description:description] autorelease];
                    [tempLeap setName:rawLeapName];
                                        
                    if ([leapDictionary objectForKey:@"OtherClass"] != nil){
                        [tempLeap setOtherClass:(NSString *)[leapDictionary objectForKey:@"OtherClass"]];
                    }
                    [leapObjects setObject:tempLeap forKey:rawLeapName];
                }
                [leapCategories setObject:leapObjects forKey:key];
            }
        }
        leaps = [[NSDictionary alloc] initWithDictionary:leapCategories];
        [NSKeyedArchiver archiveRootObject:leaps toFile:@"/Users/mmeyers/Desktop/Leaps.bin"];
    } else {
        leaps = [[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"Leaps" ofType:@"bin"]] retain];
    }
}

- (NSMutableArray *) currentLeaps {
    return currentLeaps;
}

- (void) reset {
    [BTStorageManager setCurrentLeaps:[NSArray array]];
    [BTStorageManager setAchievedLeaps:[NSArray array]];
    
    if (currentLeaps){
        [currentLeaps release];
    }
    currentLeaps = [[NSMutableArray alloc] init];
    [self fillCurrentLeaps];
    [BTStorageManager setCurrentLeaps:currentLeaps];
}

- (void) fillCurrentLeaps {
    while ([currentLeaps count] < 3){
        
        BTLeap *newLeap;
        if (true){
            if (![BTStorageManager hasAchievedLeap:@"play1"] && [currentLeaps count] == 0){
                newLeap = (BTLeap *)[(NSDictionary *)[leaps objectForKey:@"BTGameCompleteLeap"] objectForKey:@"play1"];
            } else {
                newLeap = [self newLeap];
            } 
        } else {
            if ([currentLeaps count] == 0){
                newLeap = (BTLeap *)[(NSDictionary *)[leaps objectForKey:@"BTMultiplierLeap"] objectForKey:@"10multiplier20"];
            } else {
                newLeap = [self newLeap];
            } 
        }
        
        if (newLeap != nil){
            [currentLeaps addObject:newLeap];
            [newLeap resetProgress];
        } else {
            break;
        }
    }

}

- (void) resetProgress {
    for (BTLeap *leap in currentLeaps){
        if ([[leap timePeriod] isEqualToString:@"One"] || [[leap timePeriod] intValue] != 0){
            [leap resetProgress];
        }
    }
}

- (NSString *) nameForCurrentLevel {
    return [self nameForLevel:[BTStorageManager playerLevel]];
}
- (NSString *) nameForLevel:(int) level {
    if (levels){
        return [(NSDictionary *)[levels objectAtIndex:level] objectForKey:@"Name"];
    }
    
    return @"";
}

- (NSString *) rewardForCurrentLevel {
    return [self rewardForLevel:[BTStorageManager playerLevel]];
}
- (NSString *) rewardForLevel:(int) level {
    if (levels){
        return [(NSDictionary *)[levels objectAtIndex:level] objectForKey:@"Reward"];
    }
    return @"";
}

- (int) padsRequiredForCurrentLevel {
    return [self padsRequiredForLevel:[BTStorageManager playerLevel]];
}
- (int) padsRequiredForLevel:(int) level {
    if (levels){
        return [(NSNumber *)[(NSDictionary *)[levels objectAtIndex:level] objectForKey:@"Pads Required"] intValue];
    }
    return -1;
}


- (void) gameStarted {
    [self resetProgress];
    [self save];
}

- (void) gameEnded {
    // Check if any current leaps have been achieved
    // If so, call leapAchieved on them
    
    [BTStorageManager setCurrentLeaps:currentLeaps];
}

- (void) bugFriedOfClass:(Class) bugClass {
    for (BTLeap *leap in currentLeaps){
        [leap bugFriedOfClass:bugClass];
    }
}
         
- (void) stuckBugFriedOfClass:(Class) bugClass {
    for (BTLeap *leap in currentLeaps){
        [leap stuckBugFriedOfClass:bugClass];
    }
}

- (void) bugEatenOfClass:(Class) bugClass {
    for (BTLeap *leap in currentLeaps){
        [leap bugEatenOfClass:bugClass];
    }
}

- (void) frogFriedAtTime:(ccTime) time {
    for (BTLeap *leap in currentLeaps){
        [leap frogFriedAtTime:time];
    }
}

- (void) frogExplodedAtTime:(ccTime) time {
    for (BTLeap *leap in currentLeaps){
        [leap frogExplodedAtTime:time];
    }
}

- (void) beamBonusAtLevel:(int) level ForTime:(ccTime) time {
    for (BTLeap *leap in currentLeaps){
        [leap beamBonusAtLevel:level ForTime:time];
    }
}

- (void) beamBonusFullForTime:(ccTime) time {
    for (BTLeap *leap in currentLeaps){
        [leap beamBonusFullForTime:time];
    }
}
- (void) fingersDownForTime:(ccTime) time {
    for (BTLeap *leap in currentLeaps){
        [leap fingersDownForTime:time];
    }
}

- (void) gamePlayedForTime:(ccTime) time {
    for (BTLeap *leap in currentLeaps){
        [leap gamePlayedForTime:time];
    }
}

- (void) gameEndedWithKillDictionary:(NSDictionary *) dictionary {
    for (BTLeap *leap in currentLeaps){
        [leap gameEndedWithKillDictionary:dictionary];
    }
}
- (void) itemPurchasedWithIdentifier:(NSString *) identifier PenniesSpent:(int) penniesSpent {
    for (BTLeap *leap in currentLeaps){
        [leap itemPurchasedWithIdentifier:identifier PenniesSpent:penniesSpent];
    }
}

- (void) notifyCompletionOfLeap:(BTLeap *) leap {
    CCNode *notificaitonParent = nil;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([delegate mode] == kModeGame){
        BTGameScene *gameScene = (BTGameScene *)[[CCDirector sharedDirector] runningScene];
        notificaitonParent = [gameScene gameLayer];
    } else if ([delegate mode] == kModeHopShop) {
        BTHopshopScene *hopshopScene = (BTHopshopScene *)[[CCDirector sharedDirector] runningScene];
        notificaitonParent = [hopshopScene getChildByTag:1];
    }
                                            
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"SparkleFlySpawn.m4a"];

    if (notificaitonParent){        
        int index = [currentLeaps indexOfObject:leap];
        if (index != NSNotFound && index < 3){
            CCSprite *notification = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"LM%dcomplete.png", index+1]];
            notification.position = ccp(240, -25);
            [notificaitonParent addChild:notification z:10];
            [notification runAction:[CCSequence actions:[CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:0.5 position:CGPointMake(240, 30)] rate:2.0], [CCDelayTime actionWithDuration:1.25], [CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:0.5 position:ccp(240, -25)] rate:2.0], [CCCallFunc actionWithTarget:notification selector:@selector(removeFromParent)], nil]];
        }    
    }
    
    if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] mode] == kModeHopShop){
        BTHopshopScene *hopshopScene = (BTHopshopScene *)[[CCDirector sharedDirector] runningScene];
        if ([hopshopScene respondsToSelector:@selector(setHasCompletedMission:)]){
            [hopshopScene setHasCompletedMission:YES];
        }
    }
}

- (void) leapAchieved:(BTLeap *) leap {
    if ([currentLeaps containsObject:leap]){
        if ([leap name]){
            NSLog(@"Achieving Leap: %@", [leap name]);
            [BTStorageManager achieveLeap:[leap name]];
        } else {
            NSLog(@"NO NAME?");
            NSLog(@"Why?");
        }
        
        BTLeap *newLeap;
        if ([[leap name] isEqualToString:@"play1"]){
            newLeap = (BTLeap *)[(NSDictionary *)[leaps objectForKey:@"BTGameCompleteLeap"] objectForKey:@"play3"];
        } else {
            newLeap = [self newLeap];
        }
        
        int index = [currentLeaps indexOfObject:leap];

        [newLeap resetProgress];
        [currentLeaps replaceObjectAtIndex:index withObject:newLeap];
        [self save];
    }
}

- (bool) string:(NSString *) str isInArray:(NSArray *) array {
    for (NSString *string in array){
        if ([string isEqualToString:str]){
            return YES;
        }
    }
    return NO;
}

- (BTLeap *) newLeap {
    
    // Get a list of current leap categories
    NSMutableArray *currentCategories = [NSMutableArray array];
    for (BTLeap *leap in currentLeaps){
        [currentCategories addObject:[[leap class] description]];
    }
    
    // From the list of all categories, add only those that aren't in use to availableCategories.
    NSMutableArray *availableCategories = [NSMutableArray array];
    for (NSString *key in [leaps allKeys]){
        bool beingUsed = NO;
        for (NSString *category in currentCategories){
            if ([key isEqualToString:category]){
                beingUsed = YES;
            }
        }
        if (!beingUsed){
            [availableCategories addObject:key];
        }
    }
    
    if ([availableCategories count] == 0){
        availableCategories = currentCategories;
    }
    
    if ([availableCategories count] == 0){
        return nil;
    } else {
        NSArray *achievedLeaps = [BTStorageManager achievedLeaps];
        // 1. Find minimum level for each category
        int minimumLevel = INFINITY;
        NSMutableDictionary *minimumLevels = [NSMutableDictionary dictionary];
        for (NSString *categoryString in availableCategories){
            NSDictionary *category = (NSDictionary *)[leaps objectForKey:categoryString];
            int minimumLevelForCategory = INFINITY;
            for (BTLeap *leap in [category allValues]){
                if (![self string:[leap name] isInArray:achievedLeaps] && [leap reward] < minimumLevelForCategory){

                    minimumLevelForCategory = [leap reward];
                }
            }
            if (minimumLevelForCategory < minimumLevel){
                minimumLevel = minimumLevelForCategory;
            }
            [minimumLevels setObject:[NSNumber numberWithInt:minimumLevelForCategory] forKey:categoryString];
        }
        
        // 2. Eliminate all categories with a minimum level higher than the minimum level
        for (NSString *categoryString in [minimumLevels allKeys]){
            int minimumLevelForCategory = [(NSNumber *)[minimumLevels objectForKey:categoryString] intValue];
            if (minimumLevelForCategory > minimumLevel){
                [minimumLevels removeObjectForKey:categoryString];
            }
        }
        
        // 3. Pick a category from the remaining categories
        if ([minimumLevels count] > 0){
            NSMutableArray *remainingCategories = [NSMutableArray arrayWithArray:[minimumLevels allKeys]];
            [remainingCategories shuffle];
            NSString *categoryString = [remainingCategories objectAtIndex:0];
            NSDictionary *selectedCategory = [leaps objectForKey:categoryString];
            // 4. Find the leaps with the minimum level
            int minimumLevelForCategory = [(NSNumber *)[minimumLevels objectForKey:categoryString] intValue];
            NSMutableArray *availableLeaps = [NSMutableArray array];
            for (BTLeap *leap in [selectedCategory allValues]){
                if ([leap reward] <= minimumLevelForCategory && ![self string:[leap name] isInArray:achievedLeaps] && ![currentLeaps containsObject:leap]){
                    [availableLeaps addObject:leap];
                }
            }
            // 5. Pick one at random and return it!
            [availableLeaps shuffle];
            return [availableLeaps objectAtIndex:0];
            
        } else {
            return nil;
        }
    }
}

- (void) save {
    [BTStorageManager setCurrentLeaps:currentLeaps];
}

- (void) dealloc {
    [currentLeaps release];
    [leaps release];
    [levels release];
    [super dealloc];
}

@end
