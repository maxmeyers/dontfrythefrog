//
//  BTWaterStreak.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BTWaterStreak.h"

@implementation BTWaterStreak

- (id) initWithPosition:(CGPoint)position {    
    self = [super initWithPosition:position FileName:@"water-streak.png"];
    if (self){
        self.rotation = ((arc4random() % 2) == 0) ? 0 : 180;
        [self drift:NO];
    }
    return self;
}

- (void) randomizeAesthetics {
    self.speed = 50;
}

@end
