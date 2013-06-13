//
//  BTFrogAnimationsFire.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/18/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTFrogAnimationsFire.h"
#import "BTIncludes.h"

@implementation BTFrogAnimationsFire

@synthesize start, end;

+ (id) animationsWithBase:(int) base Suffix:(NSString *) suffix {
    BTFrogAnimationsFire *temp = [[[BTFrogAnimationsFire alloc] initWithBase:base 
                                                       IdleAnimation: [BTStorageManager animationWithString:@"BTFrog-Fire-Walk" atInterval:0.1 Reversed:NO Suffix:suffix]
                                                       OpenAnimation: [BTStorageManager animationWithString:@"BTFrog-Fire-Open" atInterval:0.1 Reversed:NO Suffix:suffix] 
                                                        EatAnimation: nil                                   
                                                        ZapAnimation: [BTStorageManager animationWithString:@"BTFrog-Zap" atInterval:0.1 Reversed:NO Suffix:suffix] 
                                                    ExplodeAnimation: [BTStorageManager animationWithString:@"BTFrog-Explode" atInterval:0.1 Reversed:NO Suffix:suffix]
                                                              Tongue: YES
                                                                 Jaw:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"fire-Frog-eat-bottom-jaw%@", suffix]]
                                   ] autorelease];
    
    [temp setStart:[BTStorageManager animationWithString:@"BTFrog-Fire-Start" atInterval:0.1 Reversed:NO Suffix:suffix]];
    [temp setEnd:[BTStorageManager animationWithString:@"BTFrog-Fire-End" atInterval:0.1 Reversed:NO Suffix:suffix]];    
    
    return temp;
}

- (void) dealloc {
    [start release];
    [end release];
    [super dealloc];
}

@end
