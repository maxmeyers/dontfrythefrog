//
//  BTFrogAnimationsSick.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/18/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTFrogAnimationsSick.h"
#import "BTIncludes.h"

@implementation BTFrogAnimationsSick

@synthesize start, end;

+ (id) animationsWithBase:(int) base Suffix:(NSString *) suffix {
    BTFrogAnimationsSick *temp = [[[BTFrogAnimationsSick alloc] initWithBase:base 
                                                             IdleAnimation: nil
                                                             OpenAnimation: nil 
                                                              EatAnimation: nil
                                                              ZapAnimation: nil 
                                                          ExplodeAnimation: nil
                                                                    Tongue: NO
                                                                       Jaw: nil
                                   ] autorelease];    
    [temp setStart:[BTStorageManager animationWithString:@"BTFrog-Sick-Start" atInterval:0.1 Reversed:NO Suffix:suffix]];
    [temp setEnd:[BTStorageManager animationWithString:@"BTFrog-Sick-End" atInterval:0.1 Reversed:NO Suffix:suffix]];    
    
    return temp;
}

@end
