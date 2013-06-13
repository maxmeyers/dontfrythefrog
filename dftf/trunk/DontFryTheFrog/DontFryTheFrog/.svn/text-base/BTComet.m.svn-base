//
//  BTComet.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BTComet.h"
#import "BTIncludes.h"

@implementation BTComet

- (id) init {
    self = [super initWithPosition:CGPointMake(0, 0) FileName:@"comet.png"];
    if (self){
        self.speed = 250;
        self.rotation = ROTATION_FOR_TWO_POINTS(initialPoint, finalPoint) + 90;
        [self drift:NO];
    }
    return self;
}

@end
