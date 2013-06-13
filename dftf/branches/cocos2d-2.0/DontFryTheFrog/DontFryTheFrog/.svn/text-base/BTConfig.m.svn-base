#import "BTConfig.h"
#import "BTIncludes.h"

@implementation BTConfig

@synthesize debug, readFromPlist;
@synthesize flyMovementRate, flySpawnIntervalInitial, flySpawnIntervalDecrement, flySpawnIntervalMinimum;;
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
    }
    
    return self;
}

@end