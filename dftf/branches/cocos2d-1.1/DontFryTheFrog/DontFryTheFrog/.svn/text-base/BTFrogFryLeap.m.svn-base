//
//  BTFrogFryLeap.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTFrogFryLeap.h"

@implementation BTFrogFryLeap

- (void) frogFriedAtTime:(ccTime)time {
    int timePeriodInt = [[self timePeriod] intValue];
    if (timePeriodInt != 0){
        if (time < timePeriodInt){
            self.progress = MIN(quantity, self.progress+1);
        }
    } else {
        self.progress = MIN(quantity, self.progress+1);
    }
}

@end
