//
//  BTFrogAnimations.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/11/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTFrogAnimations.h"
#import "BTIncludes.h"

@implementation BTFrogAnimations

@synthesize idleAnimation, openAnimation, eatAnimation, zapAnimation, explodeAnimation, jawSprite, tongue, base;

- (id) initWithBase:(int) i IdleAnimation:(CCAnimation *) idle OpenAnimation:(CCAnimation *) open EatAnimation:(CCAnimation *) eat ZapAnimation:(CCAnimation *) zap ExplodeAnimation:(CCAnimation *) explode Tongue:(bool) t Jaw:(CCSprite *) jaw {
    if ((self = [super init])){
        self.base = i;
        self.idleAnimation = idle;
        self.openAnimation = open;
        self.eatAnimation = eat;
        self.zapAnimation = zap;
        self.explodeAnimation = explode;
        self.tongue = t;
        self.jawSprite = jaw;
    }
    
    return self;
}

+ (id) animationsWithBase:(int) base Suffix:(NSString *) suffix {
    BTFrogAnimations *temp = [[[BTFrogAnimations alloc] initWithBase:base 
                                                      IdleAnimation: [BTStorageManager animationWithString:@"BTFrog" atInterval:0.1 Reversed:NO Suffix:suffix]
                                                      OpenAnimation:[BTStorageManager animationWithString:@"BTFrog-Open" atInterval:0.1 Reversed:NO Suffix:suffix] 
                                                       EatAnimation:[BTStorageManager animationWithString:@"BTFrog-Eat" atInterval:0.125 Reversed:NO Suffix:suffix]
                                                       ZapAnimation:[BTStorageManager animationWithString:@"BTFrog-Zap" atInterval:0.1 Reversed:NO Suffix:suffix] 
                                                   ExplodeAnimation:[BTStorageManager animationWithString:@"BTFrog-Explode" atInterval:0.1 Reversed:NO Suffix:suffix]
                                                             Tongue:YES
                                                                Jaw:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"Frog-walk-open-jaw%@", suffix]]
                               ] autorelease];
   
    return temp;
}

- (void) dealloc {
    if (idleAnimation){
        [idleAnimation release];
    }
    
    if (openAnimation){
        [openAnimation release];
    }
    
    if (eatAnimation){
        [eatAnimation release];
    }
    
    if (zapAnimation){
        [zapAnimation release];
    }
    
    if (explodeAnimation){
        [explodeAnimation release];
    }
    
    if (jawSprite){
        [jawSprite release];
    }
//    [super dealloc];
}

@end
