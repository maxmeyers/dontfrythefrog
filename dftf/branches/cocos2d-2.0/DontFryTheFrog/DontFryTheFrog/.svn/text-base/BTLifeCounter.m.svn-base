//
//  BTLifeCounter.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BTLifeCounter.h"
#import "BTIncludes.h"

@implementation BTLifeCounter

NSMutableArray *strikes;

CGPoint hiding;
CGPoint showing;

- (id) init {
    if ((self = [super init])){
        
//        hiding = CGPointMake(181, 320);
        hiding = CGPointMake(181, 302);
        showing = CGPointMake(181, 302);
        
        self.position = hiding;
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"LivesBG.png"];
        background.position = CGPointMake(52, 0);
        [self addChild:background z:1];
        
        
        strikes = [[NSMutableArray alloc] initWithCapacity:3];
        // Frog Counters
        int x = 6;
        for (int i = 0; i < 3; i++){
            CGPoint location = CGPointMake(x, 1);
            x += 46;
            
            CCSprite *frogCounter = [[CCSprite alloc] initWithSpriteFrameName:@"LiveFrog.png"];
            frogCounter.position = location;
            [self addChild:frogCounter z:3];
            [frogCounter release];
            
            CCSprite *strike = [[CCSprite alloc] initWithSpriteFrameName:@"StrikeThrough.png"];
            strike.position = location;
            strike.opacity = 0;
            [strikes addObject:strike];
            [self addChild:strike z:4];
            [strike release];
        }
    }
    return self;
}

- (int) lives {
    return lives;
}

- (void) setLives:(int) n {
    
    for (int i = 0; i < 3; i++){
        CCSprite *strikeThrough = (CCSprite *)[strikes objectAtIndex:i];

        if (i < 3-n){
            strikeThrough.opacity = 255;
        } else {
            strikeThrough.opacity = 0;
        }
    }
    
    if (n == 3 && lives != 3){
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"InGameSlow.m4a"];
    } else if (n == 2 && lives != 2){
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"InGameMedium.m4a"];
    } else if (n == 1 && lives != 1){
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"InGameFast.m4a"];
    } 
    lives = MIN(3, MAX(0, n));

    [self showWithTime:2];
    
}

CCSequence *showSequence;

- (void) showWithTime:(ccTime) time {
    [showSequence release];
    
    CCMoveTo *down = [CCMoveTo actionWithDuration:0.25f position:showing];
    CCDelayTime *wait = [CCDelayTime actionWithDuration:time];
    CCMoveTo *up = [CCMoveTo actionWithDuration:0.25f position:hiding];
    
    showSequence = [[CCSequence actions:down, wait, up, nil] retain];
    
    [self runAction:showSequence];
}

- (void) dealloc {
    [strikes release];
    [super dealloc];
}

@end
