//
//  BTFullMultiplierLeap.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTMultiplierLeap.h"

@implementation BTMultiplierLeap

- (void) beamBonusAtLevel:(int)level ForTime:(ccTime)time {
    int minLevel = [bugClass intValue];
    if (level >= minLevel){
        [self addTimeToProgress:time];  
    }
}

@end
