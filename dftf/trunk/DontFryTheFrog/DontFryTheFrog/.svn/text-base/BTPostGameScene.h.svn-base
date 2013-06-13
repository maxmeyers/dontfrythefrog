//
//  BTPostGameScene.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CCScene.h"
#import "CCTouchDelegateProtocol.h"

@class BTResultsLayer, BTGameScene;

@interface BTPostGameScene : CCScene {
    BTResultsLayer *resultsLayer_;
    BTGameScene *gameScene_;
    int initialLevel;
    NSString *destination_;
}

@property (nonatomic, retain) NSString *destination;
@property (nonatomic, assign) BTGameScene *gameScene;

- (id) initWithResultsLayer:(BTResultsLayer *) resultsLayer GameScene:(BTGameScene *) gameScene Destination:(NSString *) scene;
- (void) awardFlyPenniesUntilZero;
- (void) achieveOldLeapsAndGetNewLeaps;
- (void) refresh;
- (void) loadResults;

@end
