//
//  BTSpecialBug.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 6/13/11.
//  Copyright 2011 New York University. All rights reserved.
//

#import "BTSpecialBug.h"
#import "BTIncludes.h"

@implementation BTSpecialBug

@synthesize effect, sparkleSprite, isExtraSpecial;

- (id) initFlyWithAnimation:(CCAnimation *)animation GameLayer:(BTGameLayer *) layer {
    if ((self = [super initWithFile:@"sick-1A.png" Position:CGPointMake(0, 0) IdleAnimation:animation ParentLayer:layer])){
        sparkleAnimation = [BTStorageManager animationWithString:@"BTSparkles" atInterval:0.05f Reversed:NO];
        sparkleSprite = [CCSprite spriteWithSpriteFrameName:@"sparkle1.png"];
        [sparkleSprite runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:sparkleAnimation]]];
        [self addChild:sparkleSprite];
    }
    return self;
}

+ (NSString *) color {
    return @"";
}

- (void) update:(ccTime)dt {
    [super update:dt];
    
}

- (void) reset {
    [super reset];
    [self setIsExtraSpecial:NO];
}

- (void) spawnToPosition:(CGPoint)position {
    [super spawnToPosition:position];
    if (isExtraSpecial){
        sparkleSprite.visible = YES;
    } else {
        sparkleSprite.visible = NO;
    }
}

- (void) bugWasZapped {

}

- (void) pauseSchedulerAndActions {
    [super pauseSchedulerAndActions];
    [sparkleSprite pauseSchedulerAndActions];
}

- (void) resumeSchedulerAndActions {
    [super resumeSchedulerAndActions];
    [sparkleSprite resumeSchedulerAndActions];
}

@end

@implementation BTGoodBug

- (void) bugWasZapped {
    [super bugWasZapped];
    [[SimpleAudioEngine sharedEngine] playEffect:@"ZapGood.m4a"];
    [[gameLayer scene] setMultiplier:(int)MAX(1, ceil([[gameLayer scene] multiplierInt]/2))];
}

@end

@implementation BTBadBug
- (void) bugWasZapped {
    [super bugWasZapped];
    [[SimpleAudioEngine sharedEngine] playEffect:@"ZapBad.m4a"];
}
@end
