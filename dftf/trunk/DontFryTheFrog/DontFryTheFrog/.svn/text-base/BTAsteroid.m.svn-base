	//
//  BTAsteroid.m
//  DontFryTheFrog
//
//  Created by Max Meyers on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BTAsteroid.h"
#import "BTIncludes.h"

@implementation BTAsteroid

- (id) init {
    self = [super initWithPosition:CGPointMake(0, 0) FileName:@"asteroid.png"];
    if (self){
        self.speed = RANDBT(40, 60);
        [self runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:4 angle:360]]];
        [self drift:NO];
        
        [self enableDestructionWithRadius:50];
    }
    return self;
}

- (void) update:(ccTime) dt {
    if (self.body){
        self.body->p.x = self.position.x; self.body->p.y = self.position.y;
    }
}

- (void) dealloc {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([appDelegate mode] == kModeGame && [appDelegate gameScene] != nil){
        BTChipmunkManager *chipmunkManager = [[[appDelegate gameScene] gameLayer] chipmunkManager];
        cpSpaceRemoveShape([chipmunkManager space], self.shape);
        cpShapeFree(self.shape);
        cpBodyFree(self.body);
    }

    [super dealloc];
}

@end
