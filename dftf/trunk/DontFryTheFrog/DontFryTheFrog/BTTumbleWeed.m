//
//  BTTumbleWeed.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BTTumbleWeed.h"
#import "BTIncludes.h"

@implementation BTTumbleWeed

- (id) init {
    return [self initWithPosition:CGPointMake(100, 50) FileName:@"tumbleweed.png"];
}

- (id) initWithPosition:(CGPoint)point FileName:(NSString *)filename {
    self = [super initWithPosition:point FileName:filename];
    if (self){
        [self runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:5 angle:360]]];
        self.speed = 40;
        [self drift:NO];
    }
    return self;
}

- (void) randomizeAesthetics {
    [super randomizeAesthetics];
    self.verticalPosition = RANDBT(50, 270);
    self.pauseTime = RANDBT(1, 4);
}

@end
