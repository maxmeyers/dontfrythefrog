//
//  BTLilypad.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BTLilypad.h"
#import "BTIncludes.h"

@implementation BTLilypad

@synthesize size = _size;

- (id) init {
    tLilyPadSize size = arc4random() % (kLarge + 1);
    
    self = [self initWithSize:size Position:ccp(-50, 160)];
    if (self){
    }
    return self;
}

- (id) initWithSize:(tLilyPadSize) size Position:(CGPoint) position {
    NSString *fileName = (size == kLarge) ? @"big-lilypad.png" : @"small-lilypad.png";

    self = [super initWithPosition:position FileName:fileName];
    if (self){
        self.size = size;
        [self drift:NO];
    }
    return self;
}

- (void) randomize {
    self.verticalPosition = RANDBT(40, 280);
    [super randomize];
}

- (void) randomizeAesthetics {
    self.rotation = RANDBT(-20, 20);
    self.speed = RANDBT(40, 60);
}

@end
