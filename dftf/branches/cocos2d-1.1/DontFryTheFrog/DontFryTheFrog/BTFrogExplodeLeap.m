//
//  BTFrogExplodeLeap.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTFrogExplodeLeap.h"

@implementation BTFrogExplodeLeap

- (void) frogExplodedAtTime:(ccTime)time {
    self.progress = MIN(quantity, self.progress+1);
}

@end
