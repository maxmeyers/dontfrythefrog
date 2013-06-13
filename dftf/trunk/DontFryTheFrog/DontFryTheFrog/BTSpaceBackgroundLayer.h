//
//  BTSpaceBackgroundLayer.h
//  DontFryTheFrog
//
//  Created by Max Meyers on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BTBackgroundLayer.h"

@class CCTimer, BTAsteroid;

@interface BTSpaceBackgroundLayer : BTBackgroundLayer {

}

@property (nonatomic, retain) CCTimer *asteroidTimer;
@property (nonatomic, retain) CCTimer *cometTimer;

- (void) fireAsteroid;
- (void) fireComet;

- (void) killAsteroid:(BTAsteroid *) asteroid;

@end
