//
//  BTGameLengthLeap.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTGameLengthLeap.h"

@implementation BTGameLengthLeap

- (void) gamePlayedForTime:(ccTime)time {
    [self addTimeToProgress:time];
}

@end