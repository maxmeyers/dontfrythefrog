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


CGPoint hiding;
CGPoint showing;

- (id) init {
    if ((self = [super init])){
        
//        hiding = CGPointMake(181, 320);
        hiding = CGPointMake(240, 305);
        showing = CGPointMake(240, 305);
        
        self.position = hiding;
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"LivesBG.png"];
        [self addChild:background z:1];
        
        
        strikes = [[NSMutableArray alloc] initWithCapacity:3];
        counters = [[NSMutableArray alloc] init];
        // Frog Counters
        for (int i = 0; i < 3; i++){
            CGPoint location = ccp((i-1)*40, 1);
            
            CCSprite *frogCounter = [[CCSprite alloc] initWithSpriteFrameName:@"LiveFrog.png"];
            frogCounter.position = location;
            [self addChild:frogCounter z:3];
            [counters addObject:frogCounter];
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

- (void) loseLife {
    self.lives = MAX(0, self.lives-1);

    
    CCSprite *liveFrog = [counters objectAtIndex:abs(lives - 2)];
    CCAnimate *die = [CCAnimate actionWithAnimation:[BTStorageManager animationWithString:@"BTFrogLifeCounterDeath" atInterval:0.1 Reversed:NO] restoreOriginalFrame:NO];
    [liveFrog runAction:[CCSequence actions:die, [CCCallFunc actionWithTarget:self selector:@selector(refresh)], nil]];
}

- (void) refresh {
    for (int i = 0; i < 3; i++){
        CCSprite *frogCounter = (CCSprite *)[counters objectAtIndex:i];
        if (lives >= abs(i - 3)){
            CCSprite *newCounter = [CCSprite spriteWithSpriteFrameName:@"LiveFrog.png"];
            newCounter.position = frogCounter.position;
            [counters replaceObjectAtIndex:i withObject:newCounter];
            [self addChild:newCounter z:3];
            [frogCounter removeFromParent];
        }
        
        CCSprite *strikeThrough = (CCSprite *)[strikes objectAtIndex:i];
        
        if (i < 3-lives){
            strikeThrough.opacity = 255;
        } else {
            strikeThrough.opacity = 0;
        }
    }
}

- (void) setLives:(int)n {
    int previous = lives;
    
    lives = MAX(0, MIN(3, n));
    [self refresh];
    
    if (lives == 3){
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"InGameSlow.m4a"];
    } else if (lives == 2 && previous != 2){
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"InGameMedium.m4a"];
    } else if (lives == 1 && previous != 1){
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"InGameFast.m4a"];
    } 
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
