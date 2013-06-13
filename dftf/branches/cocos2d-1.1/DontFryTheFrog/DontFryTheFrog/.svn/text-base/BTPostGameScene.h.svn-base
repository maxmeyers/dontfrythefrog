//
//  BTPostGameScene.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CCScene.h"

@class BTResultsLayer;

@interface BTPostGameScene : CCScene {
    BTResultsLayer *resultsLayer_;
    int initialLevel;
    NSString *destination_;
}

@property (nonatomic, retain) NSString *destination;

- (id) initWithResultsLayer:(BTResultsLayer *) resultsLayer Destination:(NSString *) scene;
- (void) awardFlyPenniesUntilZero;
- (void) achieveOldLeapsAndGetNewLeaps;
- (void) refresh;
- (void) loadResults;

@end
