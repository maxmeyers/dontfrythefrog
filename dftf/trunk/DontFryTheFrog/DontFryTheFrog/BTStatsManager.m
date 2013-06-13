//
//  BTStatsManager.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTStatsManager.h"
#import "BTIncludes.h"
@implementation BTStatsManager

+ (BTStatsManager *) sharedManager {
    static BTStatsManager *sharedManager;
    @synchronized(self)
    {
        if (!sharedManager) {
            sharedManager = [[BTStatsManager alloc] init];
        }
        return sharedManager;
    }
}

- (id) init {
    self = [super init];
    if (self){
        [self load];
    }
    
    return self;
}

- (int) intForKey:(NSString *) key{
    if ([statistics_ objectForKey:key]){
        return [(NSNumber *)[statistics_ objectForKey:key] intValue];
    } 
    return 0;
}

- (void) setInt:(int) i ForKey:(NSString *) key{
    [statistics_ setObject:[NSNumber numberWithInt:i] forKey:key];
    [self save];
}

- (float) floatForKey:(NSString *) key{
    if ([statistics_ objectForKey:key]){
        return [(NSNumber *)[statistics_ objectForKey:key] floatValue];
    }
    return 0;
}

- (void) setFloat:(float) f ForKey:(NSString *) key{
    [statistics_ setObject:[NSNumber numberWithFloat:f] forKey:key];
    [self save];
}

// Property functions

- (float) maxBeamBonusTime {
    return [self floatForKey:kMaxBeamBonusTime];
}

- (void) setMaxBeamBonusTime:(float)maxBeamBonusTime {
    [self setFloat:maxBeamBonusTime ForKey:kMaxBeamBonusTime];
}

- (int) flyPenniesEarned {
    return [self intForKey:kFlyPenniesEarned];
}

- (void) setFlyPenniesEarned:(int)flyPenniesEarned {
    [self setInt:flyPenniesEarned ForKey:kFlyPenniesEarned];  
}

- (int) flyPenniesSpent {
    return [self intForKey:kFlyPenniesSpent];
}

- (void) setFlyPenniesSpent:(int)flyPenniesSpent{
    [self setInt:flyPenniesSpent ForKey:kFlyPenniesSpent];   
}

- (int) totalFliesFried {
    return [self intForKey:kTotalFliesFried];
}

- (void) setTotalFliesFried:(int)totalFliesFried {
    [self setInt:totalFliesFried ForKey:kTotalFliesFried];
}

- (int) greyFliesFried {
    return [self intForKey:kGreyFliesFried];
}

- (void) setGreyFliesFried:(int)greyFliesFried {
    [self setInt:greyFliesFried ForKey:kGreyFliesFried];
}

- (int) redFliesFried {
    return [self intForKey:kRedFliesFried];
}

- (void) setRedFliesFried:(int)redFliesFried {
    [self setInt:redFliesFried ForKey:kRedFliesFried];
}

- (int) yellowFliesFried {
    return [self intForKey:kYellowFliesFried];
}

- (void) setYellowFliesFried:(int)yellowFliesFried {
    [self setInt:yellowFliesFried ForKey:kYellowFliesFried];
}

- (int) greenFliesEaten {
    return [self intForKey:kGreenFliesEaten];
}

- (void) setGreenFliesEaten:(int)greenFliesEaten {
    [self setInt:greenFliesEaten ForKey:kGreenFliesEaten];
}

- (int) blueFliesEaten {
    return [self intForKey:kBluesFliesEaten];
}

- (void) setBlueFliesEaten:(int)blueFliesEaten {
    [self setInt:blueFliesEaten ForKey:kBluesFliesEaten];
}

- (float) totalPlayTime {
    return [self floatForKey:kTotalPlayTime];
}

- (void) setTotalPlayTime:(float)totalPlayTime {
    [self setFloat:totalPlayTime ForKey:kTotalPlayTime];
}

- (int) gamesPlayed {
    return [self intForKey:kGamesPlayed];
}

- (void) setGamesPlayed:(int)gamesPlayed {
    [self setInt:gamesPlayed ForKey:kGamesPlayed];
}

- (int) averageScore {
    return [self intForKey:kAverageScore];
}

- (void) setAverageScore:(int)averageScore {
    [self setInt:averageScore ForKey:kAverageScore];
}

- (void) addScore:(int) score {
    int totalPoints = [self averageScore] * [self gamesPlayed];
    totalPoints += score;
    [self setGamesPlayed:[self gamesPlayed] + 1];
    [self setAverageScore:floor(totalPoints/[self gamesPlayed])];
}

- (int) averageFliesFried {
    return [self intForKey:kAverageFliesFried];
}

- (void) setAverageFliesFried:(int)averageFliesFried {
    [self setInt:averageFliesFried ForKey:kAverageFliesFried];
}

// This function has to be called AFTER [BTStatsManager addScore:int]
- (void) addFliesFried:(int)flies {
    int totalFlies = [self averageFliesFried] * ([self gamesPlayed] - 1);
    totalFlies += flies;
    [self setAverageFliesFried:floor(totalFlies/[self gamesPlayed])];
}

- (int) frogsFried {
    return [self intForKey:kFrogsFried];
}

- (void) setFrogsFried:(int)frogsFried {
    [self setInt:frogsFried ForKey:kFrogsFried];
}

- (int) frogsExploded {
    return [self intForKey:kFrogsExploded];
}

- (void) setFrogsExploded:(int)frogsExploded {
    [self setInt:frogsExploded ForKey:kFrogsExploded];
}

- (void) save {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    [NSKeyedArchiver archiveRootObject:statistics_ toFile:[NSString stringWithFormat:@"%@/Stats.bin", documentsDirectory]];
}

- (void) load {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/Stats.bin", documentsDirectory];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        statistics_ = [[NSKeyedUnarchiver unarchiveObjectWithFile:filePath] retain];
    } else {
        statistics_ = [[NSMutableDictionary dictionary] retain];
    }
}

- (void) reset {
    [statistics_ release];
    statistics_ = [[NSMutableDictionary dictionary] retain];
    [self save];
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self){
        statistics_ = [[aDecoder decodeObjectForKey:@"statistics"] retain]; 
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:statistics_ forKey:@"statistics"];
}

- (void) dealloc {
    [statistics_ release];
    [super dealloc];
}

@end
