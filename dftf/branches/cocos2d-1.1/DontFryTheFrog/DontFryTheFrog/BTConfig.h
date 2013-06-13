//
//  BTConfig.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// Collision Constants
#define kCollisionTypeFly 0
#define kCollisionTypePlayer 1
#define kCollisionTypeFrog 2
#define kCollisionTypeFrogRadius 3
#define kCollisionTypeFrogTongue 4
#define kCollisionTypePuddle 5

/**
 * FROG CONFIG
 *
 */

#define kFrogRadius 22

#define kFrogTongueExtendTime 0.5f
#define kFrogTongueRetractTime 0.5f

#define kFrogMovementRate 100
#define kFrogCatchInterval 1.25f
#define kFrogCatchRate 300

/**
 * FLY CONFIG
 */
#define kFlySpawnRadiusAroundLastDeadFly 80

@interface BTConfig : NSObject {
    bool debug;
    bool readFromPlist;
    
    float flyMovementRate;
    float flySpawnIntervalInitial;
    float flySpawnIntervalDecrement;
    float flySpawnIntervalMinimum;
    
    int frogMaxFatLevel;
    int frogEatingRadiusMinimum;
    int frogEatingRadiusMaximum;
    float frogGrowthRate;
    float frogCatchInterval;
    float frogCatchRate;
    
    float frogWeightlossInterval;
    float frogWeightlossDecrement;
    
    float frogMovementRate;
    int frogWanderRadiusMinimum;
    int frogWanderRadiusMaximum;
    
    int playerMultiplierMaximum;
    int playerLevelMaximum;
}

@property bool debug;
@property bool readFromPlist;

@property float flyMovementRate;
@property float flySpawnIntervalInitial;
@property float flySpawnIntervalDecrement;
@property float flySpawnIntervalMinimum;

@property int frogMaxFatLevel;
@property int frogEatingRadiusMinimum;
@property int frogEatingRadiusMaximum;
@property float frogGrowthRate;
@property float frogCatchInterval;
@property float frogCatchRate;

@property float frogWeightlossInterval;
@property float frogWeightlossDecrement;

@property float frogMovementRate;
@property int frogWanderRadiusMinimum;
@property int frogWanderRadiusMaximum;

@property int playerMultiplierMaximum;
@property int playerLevelMaximum;

+ (BTConfig *) sharedConfig;

@end
