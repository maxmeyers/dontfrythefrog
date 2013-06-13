//
//  BTFrogAnimationsIce.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 10/18/11.
//  Copyright (c) 2011 New York University. All rights reserved.
//

#import "BTFrogAnimationsIce.h"
#import "BTIncludes.h"

@implementation BTFrogAnimationsIce

@synthesize start, end;

+ (id) animationsWithBase:(int) base Suffix:(NSString *) suffix {
    BTFrogAnimationsIce *temp = [[[BTFrogAnimationsIce alloc] initWithBase:base 
                                                               IdleAnimation: nil
                                                               OpenAnimation: nil 
                                                                EatAnimation: nil
                                                                ZapAnimation: nil 
                                                            ExplodeAnimation: nil
                                                                      Tongue: NO
                                                                         Jaw: nil
                                  ] autorelease];    
    [temp setStart:[BTStorageManager animationWithString:@"BTFrog-Ice-Start" atInterval:0.1 Reversed:NO Suffix:suffix]];
    [temp setEnd:[BTStorageManager animationWithString:@"BTFrog-Ice-End" atInterval:0.1 Reversed:NO Suffix:suffix]];    
    
    return temp;
}

@end
