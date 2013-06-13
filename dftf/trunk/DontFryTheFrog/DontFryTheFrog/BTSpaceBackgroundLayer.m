//
//  BTSpaceBackgroundLayer.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BTSpaceBackgroundLayer.h"
#import "BTRandomDirectionObject.h"
#import "BTPlanet.h"
#import "BTIncludes.h"

@implementation BTSpaceBackgroundLayer

@synthesize asteroidTimer = _asteroidTimer, cometTimer = _cometTimer;

- (id) init {
    self = [super init];
    if (self){
        CCLayerColor *bg = [CCLayerColor layerWithColor:ccc4(10, 27, 51, 255)];
        [self addChild:bg];        
        
        const int pairsOfPlanets = 3;
        BTPlanet *planet;
        for (int i = 0; i < pairsOfPlanets; i++){
            planet = [[[BTPlanet alloc] initWithPosition:CGPointMake(RANDBT(-20, 500), RANDBT(140, 310)) FileName:nil] autorelease];
            planet.speed = RANDBT(15, 50);
            [planet drift:NO];
            [self addChild:planet z:RANDBT(4, 6)];
            
            planet = [[[BTPlanet alloc] initWithPosition:CGPointMake(RANDBT(-20, 500), RANDBT(10, 180)) FileName:nil] autorelease];
            planet.speed = RANDBT(15, 50);
            [planet drift:NO];
            [self addChild:planet z:RANDBT(4, 6)];
        }
        
        BTMovableBackgroundObject *object;
        const int numStars = 6;
        int counter = -1;
        for (int i = 0; i < numStars; i++){
            object = [[[BTMovableBackgroundObject alloc] initWithPosition:CGPointMake(counter*125, 240) FileName:@"stars.png"] autorelease];
            object.speed = 10;
            object.rotation = (arc4random() % 2 == 0) ? 0 : 180;
            [object drift:NO];
            [self addChild:object z:3];
            
            object = [[[BTMovableBackgroundObject alloc] initWithPosition:CGPointMake(counter*125, 80) FileName:@"stars.png"] autorelease];
            object.speed = 10;
            object.rotation = (arc4random() % 2 == 0) ? 0 : 180;
            [object drift:NO];
            [self addChild:object z:3];
            
            counter++;
        }
        
        self.asteroidTimer = [CCTimer timerWithTarget:self selector:@selector(fireAsteroid) interval:15];
        [self.asteroidTimer update:12];
        
        self.cometTimer = [CCTimer timerWithTarget:self selector:@selector(fireComet) interval:20];
        [self.cometTimer update:15];
        
    }
    return self;
}

- (void) update:(ccTime) dt {
    [self.asteroidTimer update:dt];
    [self.cometTimer update:dt];
}

- (void) fireAsteroid {   
    [self addChild:[BTAsteroid node] z:7];
}

- (void) fireComet {
    [self addChild:[BTComet node] z:4];
}

- (void) killAsteroid:(BTAsteroid *) asteroid {
    if ([[self children] containsObject:asteroid]){

        
        CCAnimation *burstAnimation = [BTStorageManager animationWithString:@"BTGenericCloud" atInterval:0.05f Reversed:NO];
        
        CCSprite *sprite = [CCSprite spriteWithSpriteFrame:[[burstAnimation frames] objectAtIndex:0]];
        sprite.position = asteroid.position;
        [self addChild:sprite z:asteroid.zOrder];
        
        [self removeChild:asteroid cleanup:YES];
        
        [sprite runAction:[CCSequence actions:[CCAnimate actionWithAnimation:burstAnimation restoreOriginalFrame:NO], [CCCallBlock actionWithBlock:^(void){
            [sprite removeFromParentAndCleanup:YES];
        }], nil]];
        
    }
}

+ (NSString *) name {
    return @"Space Background";
}

+ (NSString *) shortName {
    return @"Space";
}

+ (ccColor3B) textColor {
    return ccWHITE;
}

@end
