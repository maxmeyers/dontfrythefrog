#import "BTConfig.h"
#import "BTIncludes.h"

@implementation BTConfig

@synthesize debug, readFromPlist;
@synthesize flyMovementRate, flySpawnIntervalInitial, flySpawnIntervalDecrement, flySpawnIntervalMinimum, bugSprayMinimumLivingBugs;
@synthesize frogMaxFatLevel, frogEatingRadiusMinimum, frogEatingRadiusMaximum, frogGrowthRate, frogCatchInterval, frogCatchRate; 
@synthesize frogWeightlossInterval, frogWeightlossDecrement;
@synthesize frogMovementRate, frogWanderRadiusMinimum, frogWanderRadiusMaximum;
@synthesize playerMultiplierMaximum, playerLevelMaximum;

+ (BTConfig *) sharedConfig {
    static BTConfig *sharedConfig;
    @synchronized(self)
    {
        if (!sharedConfig) {
            sharedConfig = [[BTConfig alloc] init];
            [sharedConfig loadVolumes];
        }
        return sharedConfig;
    }
}

- (id) init {
    
    if ((self = [super init])){
        debug = NO;
        readFromPlist = YES;
        
        flyMovementRate = 75;
        flySpawnIntervalInitial = 2.0f;
        flySpawnIntervalDecrement = 0.25f;
        flySpawnIntervalMinimum = 0.5f;
        bugSprayMinimumLivingBugs = 10;
        
        frogMaxFatLevel = 8;
        frogEatingRadiusMinimum = 75;
        frogEatingRadiusMaximum = 240;
        frogGrowthRate = 0.25f;
        frogCatchInterval = kFrogCatchInterval;
        frogCatchRate = kFrogCatchRate;
        
        frogWeightlossInterval = 5.0f;
        frogWeightlossDecrement = 1;
        
        frogMovementRate = kFrogMovementRate;
        frogWanderRadiusMinimum = 300;
        frogWanderRadiusMaximum = 400;
        
        playerMultiplierMaximum = 25;
        playerLevelMaximum = 30;
        
        [CCMenuItemFont setFontName:@"soupofjustice"];
        [CCMenuItemFont setFontSize:32];
    }
    
    return self;
}

- (float) effectsVolume {
    return effectsVolume_;
}

- (void) setEffectsVolume:(float)effectsVolume {
    effectsVolume_ = effectsVolume;
    [[SimpleAudioEngine sharedEngine] setEffectsVolume:effectsVolume];
    [self saveVolumes];
}

- (float) musicVolume {
    return musicVolume_;    
}

- (void) setMusicVolume:(float)musicVolume {
    musicVolume_ = musicVolume;
    [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:musicVolume];
    [self saveVolumes];
}

- (void) saveVolumes {
    NSMutableDictionary *volumes = [NSMutableDictionary dictionary];
    [volumes setObject:[NSNumber numberWithFloat:effectsVolume_] forKey:@"effectsVolume"];
    [volumes setObject:[NSNumber numberWithFloat:musicVolume_] forKey:@"musicVolume"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    [NSKeyedArchiver archiveRootObject:volumes toFile:[NSString stringWithFormat:@"%@/Volumes.bin", documentsDirectory]];
}

- (void) loadVolumes {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/Volumes.bin", documentsDirectory];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        NSDictionary *volumes = (NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        self.effectsVolume = [(NSNumber *)[volumes objectForKey:@"effectsVolume"] floatValue];
        self.musicVolume = [(NSNumber *)[volumes objectForKey:@"musicVolume"] floatValue];
    } else {
        [self setEffectsVolume:1.0];
        [self setMusicVolume:1.0];
    }

}

- (void) reset {
    [self setEffectsVolume:1.0];
    [self setMusicVolume:1.0];
}

+ (NSString *)timeFormatted:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60; 
    int minutes = (totalSeconds / 60) % 60; 
    
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds]; 
}

+ (NSString *)timeWithHoursFormatted:(int)totalSeconds
{
    int seconds = totalSeconds % 60; 
    int minutes = (totalSeconds / 60) % 60; 
    int hours = totalSeconds / 3600; 
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds]; 
}

@end